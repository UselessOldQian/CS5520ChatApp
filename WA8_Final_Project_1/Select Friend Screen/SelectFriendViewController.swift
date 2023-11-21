//
//  SelectFriendViewController.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/20/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class SelectFriendViewController: UIViewController {
    let selectFriendScreen = SelectFriendView()
    var friends = [User]()
    let database = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = selectFriendScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // handle changes in authentication state
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user != nil{
                print("Invalid credential or user not logged in.")
            } else{
                self.getAllFriends()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        selectFriendScreen.tableViewMessages.delegate = self
        selectFriendScreen.tableViewMessages.dataSource = self
        selectFriendScreen.tableViewMessages.separatorStyle = .none
    }
    
    func getAllFriends() {
        
    }
}
