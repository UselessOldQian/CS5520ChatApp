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
    
    override func loadView() {
        view = friendsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        friendsScreen.tableViewFriends.reloadData()
        self.fetchUserDocumentIDs()
        print("friends: \(friends)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More friends to chat"
        friendsScreen.tableViewFriends.delegate = self
        friendsScreen.tableViewFriends.dataSource = self
//        friendsScreen.tableViewFriends.separatorStyle = .none
        
//        self.friends.append("user001")
//        self.friends.append("user002")
//        self.friends.append("user003")
        
        friendsScreen.tableViewFriends.reloadData()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
