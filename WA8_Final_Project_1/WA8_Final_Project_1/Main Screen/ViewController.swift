//
//  ViewController.swift
//  WA8_Final_Project_1
//
//  Created by Jacqueline Guo on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    
    var messageList = [Message]()

    var chats = [Chat]()

    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let friendsScreen = FriendsViewController()
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the messages!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = false
                self.mainScreen.floatingButtonAddMessage.isHidden = true
                
                self.mainScreen.profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
                
                self.messageList.removeAll()
                self.chats.removeAll()
                self.mainScreen.tableViewChats.reloadData()
                
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = true
                self.mainScreen.floatingButtonAddMessage.isHidden = false
                self.setupRightBarButton(isLoggedin: true)
                
                if let email = user?.email {
                    self.fetchAllReleventChats(userEmail: email)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Messages"
        
        mainScreen.tableViewChats.delegate = self
        mainScreen.tableViewChats.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.bringSubviewToFront(mainScreen.floatingButtonAddMessage)
        
        mainScreen.floatingButtonAddMessage.addTarget(self, action: #selector(addContactButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    @objc func addContactButtonTapped(){
        navigationController?.pushViewController(friendsScreen, animated: true)
    }
    
    @objc func testButtonTapped() {
        let chatController = ChatViewController()
        navigationController?.pushViewController(chatController, animated: true)
    }
}

