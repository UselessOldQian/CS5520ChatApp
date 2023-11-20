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
    let database = Firestore.firestore()

    var friends = [User]()
    var currentUser:FirebaseAuth.User!
    var existingFriends: Set<String>? = nil
    
    override func loadView() {
        view = friendsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        friendsScreen.tableViewFriends.reloadData()
//        self.fetchUserDocumentIDs()
//        getMoreFriends()
        print("friends: \(friends)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More Friends To Chat"
        self.friendsScreen.tableViewFriends.delegate = self
        self.friendsScreen.tableViewFriends.dataSource = self
        self.friendsScreen.tableViewFriends.separatorStyle = .none
        print("existing friends: \(existingFriends)")
        getMoreFriends()
//        self.friends.append("user001")
//        self.friends.append("user002")
//        self.friends.append("user003")
        
//        friendsScreen.tableViewFriends.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    func getMoreFriends() {
        database.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting users: \(error.localizedDescription)")
                return
            }

            let allUsers = querySnapshot?.documents.compactMap { document -> User? in
                try? document.data(as: User.self)
            } ?? []

            let existingFriendsSet = self.existingFriends ?? Set<String>() // Provide a default empty set if nil
            
            print("existingFriendsSet: \(existingFriendsSet)")
            

            // Filter out users whose email exists in the existingFriends set
            self.friends = allUsers.filter { !existingFriendsSet.contains($0.email) }
            
            print("after filtering: \(self.friends)")
            
            DispatchQueue.main.async {
                self.friendsScreen.tableViewFriends.reloadData()
            }
        }
    }
    
    func createChat(chat: Chat, completion: @escaping (String?) -> Void) {
        let newChatRef = database.collection("chats").document()
        let newChatID = newChatRef.documentID
        var newChat = chat
        newChat.id = newChatID

        let user1Email = chat.friends[0]
        let user2Email = chat.friends[1]

        // Check if the chat document already exists
        newChatRef.getDocument(source: .default) { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching chat: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if documentSnapshot?.exists == true {
                print("Chat document already exists")
                completion(nil)
            } else {
                // Chat document does not exist, proceed with creation
                do {
                    try newChatRef.setData(from: newChat) { error in
                        if let error = error {
                            print("Error adding chat: \(error.localizedDescription)")
                            completion(nil)
                        } else {
                            // Sequentially add chatID to user1's and user2's chat collections
                            var user1ChatCollection = self.database.collection("users").document(user1Email).collection("chats")
                            var user2ChatCollection = self.database.collection("users").document(user2Email).collection("chats")
                            let chatReferenceData = ["chatID": newChatID]
                                                user1ChatCollection.document(newChatID).setData(chatReferenceData) { error in
                                                    if let error = error {
                                                        print("Error adding chat ID to user1: \(error.localizedDescription)")
                                                        // Handle error, e.g., by passing nil to completion
                                                    } else {
                                                        user2ChatCollection.document(newChatID).setData(chatReferenceData) { error in
                                                            if let error = error {
                                                                print("Error adding chat ID to user2: \(error.localizedDescription)")
                                                                // Handle error, e.g., by passing nil to completion
                                                            } else {
                                                                print("Chat added successfully with ID \(newChatID)")
                                                                completion(newChatID) // Pass the newChatID upon successful addition
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                    }
                } catch let error {
                    print("Error encoding chat: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }


    
    
//    func createChat(chat: Chat, completion: @escaping (String?) -> Void) {
//        // Create a reference for a new chat, Firestore generates a new ID
//        let newChatRef = database.collection("chats").document()
//
//        // Retrieve the ID of the new chat
//        let newChatID = newChatRef.documentID
//        var newChat = chat
//        newChat.id = newChatID
//        let user1Email = chat.friends[0]
//        let user2Email = chat.friends[1]
//
//        var user1ChatCollection = database.collection("users").document(user1Email).collection("chats")
//        var user2ChatCollection = database.collection("users").document(user2Email).collection("chats")
//
//        // Add the chat data to Firestore under this new chat ID
//        do {
//            try newChatRef.setData(from: newChat) { error in
//                if let error = error {
//                    print("Error adding chat: \(error.localizedDescription)")
//                    completion(nil) // Pass nil in case of an error
//                } else {
//                    // Chat added successfully, now add newChatID to user1ChatCollection and user2ChatCollection
//                    let chatReferenceData = ["chatID": newChatID]
//                    user1ChatCollection.document(newChatID).setData(chatReferenceData) { error in
//                        if let error = error {
//                            print("Error adding chat ID to user1: \(error.localizedDescription)")
//                            // Handle error, e.g., by passing nil to completion
//                        } else {
//                            user2ChatCollection.document(newChatID).setData(chatReferenceData) { error in
//                                if let error = error {
//                                    print("Error adding chat ID to user2: \(error.localizedDescription)")
//                                    // Handle error, e.g., by passing nil to completion
//                                } else {
//                                    print("Chat added successfully with ID \(newChatID)")
//                                    completion(newChatID) // Pass the newChatID upon successful addition
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        } catch let error {
//            print("Error encoding chat: \(error.localizedDescription)")
//            completion(nil) // Pass nil in case of an encoding error
//        }
//    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! FriendsTableViewCell
//        cell.labelName.text = friends[indexPath.row]
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "users", for: indexPath) as! FriendsTableViewCell
        cell.labelName.text = friends[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = friends[indexPath.row]
        var friends = [String]()
        friends.append((self.currentUser?.email)!)
        friends.append(selectedUser.email)
        print("select friend: \(selectedUser.email)")
        print(friends)
        // Fetch the friend's document from Firestore
        let friendDocument = database.collection("users").document(selectedUser.email)
        friendDocument.getDocument { (documentSnapshot, error) in
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists,
                  let friendData = documentSnapshot.data(),
                  let friendName = friendData["name"] as? String else {
                print("Error fetching friend data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print(friendName)

            // Now you have the friend's name, proceed to create the chat
            let chat = Chat(friends: friends, friendName: friendName, lastMessageID: "")
            print(chat)
            self.createChat(chat: chat) { chatID in
                let chatViewController = ChatViewController()
                chatViewController.chatID = chatID
                chatViewController.currentUser = self.currentUser
                chatViewController.selfEmail = self.currentUser?.email
                chatViewController.friendEmail = selectedUser.email
                chatViewController.friendName = friendName
                // messageViewController.delegate = self
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
    }
}
