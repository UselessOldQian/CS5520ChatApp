//
//  FirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/20.
//

import Foundation
import FirebaseFirestore

extension ViewController {
//    func fetchAllReleventChats(userEmail: String) {
//        self.chats.removeAll()
//        let db = Firestore.firestore()
//        let chatsCollection = db.collection("chats")
//        
//        // DispatchGroup to track Firestore queries
//        let dispatchGroup = DispatchGroup()
//
//        // Create a query to check if a chat with these two users exists
//        let query = chatsCollection.whereField("friends", arrayContains: userEmail)
//        
//        // Query the 'chats' collection
//        query.getDocuments { (snapshot, error) in
//            guard let documents = snapshot?.documents, error == nil else {
//                print("Error fetching chats: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            print("Found \(documents.count) documents")
//            for document in documents {
//
//                var chat = try? document.data(as: Chat.self)
//                
//                // Identify the friend's email
//                if let friendEmail = chat?.friends.first(where: { $0 != userEmail }) {
//                    dispatchGroup.enter()
//                    
//                    // Fetch messages for this chat
//                    let messagesCollection = document.reference.collection("messages")
//                    messagesCollection.getDocuments { (messageSnapshot, messageError) in
//                        if let messageDocuments = messageSnapshot?.documents, !messageDocuments.isEmpty {
//                            let messages = messageDocuments.compactMap { messageDocument -> Message? in
//                                try? messageDocument.data(as: Message.self)
//                            }
//                            chat?.messages = messages
//                            if let chat = chat {
//                                self.chats.append(chat)
//                                print(self.chats)
//                            }
//                        } else {
//                            // No messages or the messages collection doesn't exist
//                            chat?.messages = []
//                        }
//                        dispatchGroup.leave()
//                    }
//                    
//                    dispatchGroup.enter()
//                    
//                    // Query the 'users' collection to get the friend's name
//                    db.collection("users").document(friendEmail).getDocument { (userDoc, error) in
//                        if let userData = userDoc?.data(), error == nil {
//                            chat?.friendName = userData["name"] as? String ?? "Unknown"
//                        } else {
//                            print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
//                        }
//                        
//                        dispatchGroup.leave()
//                    }
//                }
//            }
//            dispatchGroup.notify(queue: .main) {
//                self.mainScreen.tableViewChats.reloadData()
//            }
//        }
//    }
    
    func fetchAllReleventChats(userEmail: String) {
        self.chats.removeAll()
        let db = Firestore.firestore()
        let chatsCollection = db.collection("chats")

        let dispatchGroup = DispatchGroup()

        chatsCollection.whereField("friends", arrayContains: userEmail).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching chats: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

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
