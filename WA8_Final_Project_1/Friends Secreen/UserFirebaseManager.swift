//
//  UserFirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import Foundation
import FirebaseFirestore

extension FriendsViewController{
//    func fetchUserDocumentIDs() {
//
//        let db = Firestore.firestore()
//        db.collection("users").getDocuments { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                self.friends.removeAll()
//                for document in querySnapshot!.documents {
//                    self.friends.append(String(document.documentID))
////                    print("Document ID: \(document.documentID)")
//                }
//                self.friendsScreen.tableViewFriends.reloadData()
//            }
//        }
//    }
    
    func getMoreFriendsToChat() {
        let database = Firestore.firestore()
        database.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting users: \(error.localizedDescription)")
                return
            }

            self.friends = querySnapshot?.documents.compactMap { document -> User? in
                try? document.data(as: User.self)
            } ?? []
            
            self.friends = self.friends.filter {!self.existingFriends!.contains($0.email)}

            DispatchQueue.main.async {
                self.friendsScreen.tableViewFriends.reloadData()
            }
        }
    }

}
