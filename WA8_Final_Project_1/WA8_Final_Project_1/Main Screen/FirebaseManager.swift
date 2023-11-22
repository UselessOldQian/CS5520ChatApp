//
//  FirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/20.
//

import Foundation
import FirebaseFirestore

extension ViewController {
    
    func fetchAllReleventChats(userEmail: String) {
        let db = Firestore.firestore()
        let chatsCollection = db.collection("chats")

        let dispatchGroup = DispatchGroup()

//        chatsCollection.whereField("friends", arrayContains: userEmail).getDocuments { (snapshot, error) in
        chatsCollection.whereField("friends", arrayContains: userEmail).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching chats: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.chats.removeAll()

            for document in documents {
                var chat = try? document.data(as: Chat.self)
                if let friendEmail = chat?.friends.first(where: { $0 != userEmail }) {
                    dispatchGroup.enter()  // Enter for messages

                    // Fetch messages for this chat
                    document.reference.collection("messages").getDocuments { (messageSnapshot, messageError) in
                        if let messageDocuments = messageSnapshot?.documents, !messageDocuments.isEmpty {
                            chat?.messages = messageDocuments.compactMap { doc in
                                try? doc.data(as: Message.self)
                            }
                        } else {
                            chat?.messages = []
                        }
                        dispatchGroup.leave()  // Leave for messages
                    }

                    dispatchGroup.enter()  // Enter for friend's name

                    // Fetch friend's name
                    db.collection("users").document(friendEmail).getDocument { (userDoc, error) in
                        chat?.friendName = (userDoc?.data()?["name"] as? String) ?? "Unknown"
                        dispatchGroup.leave()  // Leave for friend's name
                    }
                }

                // Wait for both async operations to complete
                dispatchGroup.notify(queue: .main) {
                    if let chat = chat {
                        self.chats.append(chat)
                    }
                    // Reload the tableView here if needed
                     self.mainScreen.tableViewChats.reloadData()
                }
            }
        }
    }

}
