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
    
    var chats = [Chat]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser: FirebaseAuth.User?
    
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
                self.chats.removeAll()
                self.mainScreen.tableViewChats.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = true
                self.mainScreen.floatingButtonAddMessage.isHidden = false
//                self.setupChatListener()

//                print("viewWillAppear user: \(self.currentUser?.email)")
//                self.database.collection("users")
//                    .document((self.currentUser?.email)!)
//                    .collection("chats")
//                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
//                        if let documents = querySnapshot?.documents{
//                            self.chats.removeAll()
//                            for document in documents{
//                                do{
//                                    let chat  = try document.data(as: Chat.self)
//                                    self.chats.append(chat)
//                                }catch{
//                                    print(error)
//                                }
//                            }
//                            self.chats.sort(by: {$0.friendName < $1.friendName})
//                            self.mainScreen.tableViewChats.reloadData()
//                        }
//                    })
                self.getAllChats(userEmail: (self.currentUser?.email)!)
//                self.setupRightBarButton(isLoggedin: true)
//                if let email = user?.email {
//                    self.getAllChats(userEmail: email)
//                }
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Chats"
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewChats.delegate = self
        mainScreen.tableViewChats.dataSource = self
        mainScreen.tableViewChats.separatorStyle = .none
//        print("viewDidLoad user: \(currentUser?.email)")
//        getAllChats()
        
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
    
    func getAllChats(userEmail: String) {

        guard let userEmail = currentUser?.email else {
            print("User not logged in or email not available")
            return
        }
        
//        var chatIDs: [String] = []
        
        let userCollection = database.collection("users").document(userEmail).collection("chats")
        userCollection.addSnapshotListener { (querySnapshot, error) in
            guard let userDocuments = querySnapshot?.documents else {
                print("No documents in users collection: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let chatCollection = self.database.collection("chats")
            
            let dispatchGroup = DispatchGroup()
            
     
            
            for userDoc in userDocuments {
                let chatDocRef = chatCollection.document(userDoc.documentID)
                
                dispatchGroup.enter()
                
                DispatchQueue.main.async {
                    chatDocRef.getDocument { (document, error) in
                        defer {
                            dispatchGroup.leave()
                        }
                        guard let chatDocument = document else {
                            print("Error fetching data document or doesn't exist")
                            return
                        }
                        if let chatData = chatDocument.data() {
                            if let friendName = chatData["friendName"] as? String,
                               let friends = chatData["friends"] as? [String],
                               let lastMessageID = chatData["lastMessageID"] as? String {
                                
                                self.chats.append(Chat(id: userDoc.documentID, friends: friends, friendName: friendName, lastMessageID: lastMessageID))
                                print("self chats: \(self.chats)")
                            }
                        }
                    }
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                print("self chats in notify:  \(self.chats)")
                self.mainScreen.tableViewChats.reloadData()
            }
            
            
            
            
            
            
            
//            chatIDs = documents.map { document in
//                return document.documentID
//            }
            
            
//            DispatchQueue.main.async {
//                // Update your UI, e.g., reloading a table view
//                self.mainScreen.tableViewChats.reloadData()
//            }
        }
    }

    @objc func addContactButtonTapped(){
        let existingFriends = getExistingFriends()
        let friendsScreenController = FriendsViewController()
        friendsScreenController.currentUser = self.currentUser
        friendsScreenController.existingFriends = existingFriends
        navigationController?.pushViewController(friendsScreenController, animated: true)
    }
    
    func getExistingFriends() -> Set<String> {
        var friendSet = Set<String>()
        friendSet.insert((currentUser?.email)!)
        print("getExistingFriends user's email: \(currentUser?.email)")
        for chat in chats {
            friendSet.insert(chat.friends[1])
        }
        return friendSet
    }
    
    @objc func testButtonTapped() {
        let chatController = ChatViewController()
        navigationController?.pushViewController(chatController, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chats", for: indexPath) as! ChatsTableViewCell
        let chat = chats[indexPath.row]
        cell.labelName.text = chat.friendName
        let messageID = chat.lastMessageID
        let messageDocument = database.collection("chats").document(chat.id!).collection("messages").document(messageID)
        messageDocument.getDocument { (documentSnapshot, error) in
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists,
                  let message = try? documentSnapshot.data(as: Message.self) else {
                print("Error fetching message: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Update the cell with the message data
            DispatchQueue.main.async {
                cell.labelName.text = chat.friendName
                cell.labelText.text = message.text
                cell.senderName.text = message.sender
                cell.labelTime.text = message.time
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectChat = chats[indexPath.row]
        let chatViewController = ChatViewController()
        chatViewController.currentUser = self.currentUser
        chatViewController.chatID = selectChat.id
        chatViewController.selfEmail = currentUser?.email
        chatViewController.friendEmail = selectChat.friends[1]
        chatViewController.friendName = selectChat.friendName
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}

/*
 
 
 
 var currentUser: FirebaseAuth.User?
 var chatID: String!
 var selfEmail: String!
 var friendEmail: String!
 var friendName: String!
 */
