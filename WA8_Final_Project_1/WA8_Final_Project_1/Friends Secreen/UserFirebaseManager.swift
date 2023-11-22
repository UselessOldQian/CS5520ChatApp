//
//  UserFirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import Foundation
import FirebaseFirestore

extension FriendsViewController{
    func fetchUserDocumentIDs(completion: @escaping () -> Void) {
        
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion()
            } else {
                self.friends.removeAll()
                for document in querySnapshot!.documents {
                    self.friends.append(String(document.documentID))
//                    print("Document ID: \(document.documentID)")
                }
                self.friendsScreen.tableViewFriends.reloadData()
                completion()
            }
        }
    }
    
    func checkOrCreateChat(userEmailA: String, userEmailB: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let chatsCollection = db.collection("chats")

        // Create a query to check if a chat with these two users exists
        let query = chatsCollection.whereField("friends", arrayContains: userEmailA)
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)  // Return nil on error
                return
            }

            // Check if there's a chat where both emails exist
            let existingChat = snapshot?.documents.first { document in
                let friends = document.get("friends") as? [String] ?? []
                return friends.contains(userEmailB)
            }

            if let existingChat = existingChat {
                // Chat exists, return the document ID
                print("Chat document found with ID: \(existingChat.documentID)")
                completion(existingChat.documentID)
            } else {
                // No such chat exists, create a new one
                let newChatData: [String: Any] = ["friends": [userEmailA, userEmailB]]
                chatsCollection.document(userEmailA+":"+userEmailB).setData(newChatData) { err in
                    if let err = err {
                        print("Error adding chat document: \(err)")
                        completion(nil)  // Return nil on error
                    } else {
                        // Return the newly created document ID
                        print("New chat document created")
//                        chatsCollection.document().documentID
                        completion(userEmailA+":"+userEmailB)
                    }
                }
            }
        }
    }
    
    func updateFriendsTableNames(emails: [String]) {
        let group = DispatchGroup()
        var fetchedNames = [String?](repeating: nil, count: emails.count)

        for (index, email) in emails.enumerated() {
            group.enter()
            fetchUserName(byEmail: email) { userName in
                fetchedNames[index] = userName
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.names = fetchedNames.compactMap { $0 } // Remove nils and update names
            self.friendsScreen.tableViewFriends.reloadData()
        }
    }
    
    func fetchUserName(byEmail email: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")

        // Query the 'users' collection for the document with the given email
        usersCollection.document(email).getDocument { (document, error) in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let document = document, document.exists {
                let userName = document.data()?["name"] as? String
                completion(userName)
            } else {
                print("Document does not exist")
                completion(nil)
            }
        }
    }



}
