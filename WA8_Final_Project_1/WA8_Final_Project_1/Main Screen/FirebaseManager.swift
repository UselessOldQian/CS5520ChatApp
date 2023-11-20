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
        self.chats.removeAll()
        let db = Firestore.firestore()
        let chatsCollection = db.collection("chats")
        
        // DispatchGroup to track Firestore queries
        let dispatchGroup = DispatchGroup()

        // Create a query to check if a chat with these two users exists
        let query = chatsCollection.whereField("friends", arrayContains: userEmail)
        
        // Query the 'chats' collection
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching chats: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Found \(documents.count) documents")
            for document in documents {

                var chat = try? document.data(as: Chat.self)
                
                // Identify the friend's email
                if let friendEmail = chat?.friends.first(where: { $0 != userEmail }) {
                    dispatchGroup.enter()
                    
                    // Query the 'users' collection to get the friend's name
                    db.collection("users").document(friendEmail).getDocument { (userDoc, error) in
                        if let userData = userDoc?.data(), error == nil {
                            chat?.friendName = userData["name"] as? String ?? "Unknown"
                        } else {
                            print("Error fetching user data: \(error?.localizedDescription ?? "Unknown error")")
                        }
                        
                        if let chat = chat {
                            self.chats.append(chat)
//                            print(self.chats)
                        }
                        dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.mainScreen.tableViewChats.reloadData()
            }
        }
    }
}
