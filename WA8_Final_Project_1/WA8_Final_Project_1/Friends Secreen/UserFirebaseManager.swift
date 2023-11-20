//
//  UserFirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import Foundation
import FirebaseFirestore

extension FriendsViewController{
    func fetchUserDocumentIDs() {
        
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.friends.removeAll()
                for document in querySnapshot!.documents {
                    self.friends.append(String(document.documentID))
//                    print("Document ID: \(document.documentID)")
                }
                self.friendsScreen.tableViewFriends.reloadData()
            }
        }
    }
    
    func checkOrCreateChat(userEmailA: String, userEmailB: String) {
        let db = Firestore.firestore()
        let chatsCollection = db.collection("chats")

        // Create a query to check if a chat with these two users exists
        let query = chatsCollection.whereField("friends", arrayContains: userEmailA)
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }

            // Check if there's a chat where both emails exist
            let existingChat = snapshot?.documents.first { document in
                let friends = document.get("friends") as? [String] ?? []
                return friends.contains(userEmailB)
            }

            if let existingChat = existingChat {
                // Chat exists, handle as needed
                print("Chat document found with ID: \(existingChat.documentID)")
            } else {
                // No such chat exists, create a new one
                let newChatData: [String: Any] = ["friends": [userEmailA, userEmailB]]
                chatsCollection.addDocument(data: newChatData) { err in
                    if let err = err {
                        print("Error adding chat document: \(err)")
                    } else {
                        print("New chat document created")
                    }
                }
            }
        }
    }


}
