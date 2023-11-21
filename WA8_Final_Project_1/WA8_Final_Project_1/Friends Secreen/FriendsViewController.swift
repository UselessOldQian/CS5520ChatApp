//
//  FriendsViewController.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FriendsViewController: UIViewController {
    
    let friendsScreen = FriendsView()
    
    var friends = [String]()
    
    var names = [String]()
    
    override func loadView() {
        view = friendsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchUserDocumentIDs() {
            self.updateFriendsTableNames(emails: self.friends)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More friends to chat"
        friendsScreen.tableViewFriends.delegate = self
        friendsScreen.tableViewFriends.dataSource = self
        
        friendsScreen.tableViewFriends.reloadData()
    }
}
