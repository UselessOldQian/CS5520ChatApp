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
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the messages!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = false
                self.mainScreen.floatingButtonAddMessage.isHidden = true
                
                //MARK: Reset the profile pic...
                self.mainScreen.profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
                
                //MARK: Reset tableView...
                self.messageList.removeAll()
//                self.mainScreen.tableViewContacts.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = true
                self.mainScreen.floatingButtonAddMessage.isHidden = false
                
                //MARK: setting the profile photo...
//                if let url = self.currentUser?.photoURL{
//                    self.mainScreen.profilePic.loadRemoteImage(from: url)
//                }
                
                //MARK: Logout bar button...
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
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewChats.delegate = self
        mainScreen.tableViewChats.dataSource = self
        
//        self.chats.append(Chat(userId: "user001", text: "Hello there!", _id: "chat001"))
//        self.chats.append(Chat(userId: "user002", text: "How's it going?", _id: "chat002"))
//        self.chats.append(Chat(userId: "user003", text: "Swift is awesome!", _id: "chat003"))
        
        //MARK: removing the separator line...
//        mainScreen.tableViewContacts.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddMessage)
        
        //MARK: tapping the floating add contact button...
        mainScreen.floatingButtonAddMessage.addTarget(self, action: #selector(addContactButtonTapped), for: .touchUpInside)
        
//        mainScreen.testButton.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    @objc func addContactButtonTapped(){
//        fetchUserDocumentIDs()
        navigationController?.pushViewController(friendsScreen, animated: true)
    }
    
    @objc func testButtonTapped() {
        let chatController = ChatViewController()
        navigationController?.pushViewController(chatController, animated: true)
    }
}

