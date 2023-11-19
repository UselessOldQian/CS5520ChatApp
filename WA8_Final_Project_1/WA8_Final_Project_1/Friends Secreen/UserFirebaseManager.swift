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

}
