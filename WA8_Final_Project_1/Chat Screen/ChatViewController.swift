//
//  ChatViewController.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewController: UIViewController {
    let chatScreen = ChatView()
    var messages = [Message]()
    let database = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    var chatID: String!
    var selfEmail: String!
    var friendEmail: String!
    var friendName: String!
    
    
    
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //code omitted...
                
            } else{
                //code omitted...
                
                //MARK: Observe Firestore database to display the contacts list...
//                self.database.collection("users")
//                    .document((self.currentUser?.email)!)
//                    .collection("chats")
//                    .document(self.chatID)
//                    .collection("messages")
//                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
//                        if let documents = querySnapshot?.documents{
//                            self.messages.removeAll()
//                            for document in documents{
//                                do{
//                                    let message  = try document.data(as: Message.self)
//                                    self.messages.append(message)
//                                }catch{
//                                    print(error)
//                                }
//                            }
//                            self.messages.sort(by: {$0.time < $1.time})
//                            self.chatScreen.tableViewMessages.reloadData()
//                        }
//                    })
                self.getAllMessages(chatID: self.chatID)
//                self.getAllMessages(chatID: self.chatID)
                self.scrollToBottom()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friendName // change to the tapped cell
        chatScreen.tableViewMessages.delegate = self
        chatScreen.tableViewMessages.dataSource = self
        chatScreen.tableViewMessages.separatorStyle = .none
    
//        getAllMessages(chatID: chatID)
        self.chatScreen.buttonSend.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
//        scrollToBottom()
//        chatScreen.tableViewMessages.reloadData()
    }
//
    func getAllMessages(chatID: String) {
        let messageCollection = database.collection("chats").document(chatID).collection("messages").order(by: "time")

        messageCollection.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            self.messages = documents.compactMap { document -> Message? in
                try? document.data(as: Message.self)
            }

            DispatchQueue.main.async {
                self.chatScreen.tableViewMessages.reloadData()
            }
        }
    }
    
    @objc func onButtonAddTapped() {
        
        let text = chatScreen.textFieldMessage.text!
        let sender = (self.currentUser?.email!)!
        let datetime = Date()
        let datetimeEpoch = datetime.timeIntervalSince1970
        let df = DateFormatter()
        df.dateFormat = "y/MM/dd H:mm a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        let time = df.string(from: datetime)
        
        let message = Message(text: text, sender: sender, time: time)
        saveMessageToFirestore(message: message)
        
    }
    
    func saveMessageToFirestore(message: Message) {
        let newMessageRef = database.collection("chats").document(chatID).collection("messages").document()
        let newMessageID = newMessageRef.documentID
        var newMessage = message
        newMessage.id = newMessageID

        do {
            try newMessageRef.setData(from: newMessage) { error in
                if let error = error {
                    print("Error adding message: \(error.localizedDescription)")
                    // Handle the error
                } else {
                    print("Message added successfully with ID \(newMessageID)")

                    // Update the lastMessageID in the chat document
                    let chatDocumentRef = self.database.collection("chats").document(self.chatID)
                    chatDocumentRef.updateData(["lastMessageID": newMessageID]) { err in
                        if let err = err {
                            print("Error updating chat's lastMessageID: \(err.localizedDescription)")
                            // Handle the error
                        } else {
                            print("Chat's lastMessageID updated successfully")
                            // Perform any follow-up actions as necessary
                        }
                    }
                }
            }
        } catch let error {
            print("Error encoding message: \(error.localizedDescription)")
            // Handle the error
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func scrollToBottom() {
        let numberOfSections = chatScreen.tableViewMessages.numberOfSections
        let numberOfRows = chatScreen.tableViewMessages.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            chatScreen.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
        
        DispatchQueue.main.async {
            let numberOfSections = self.chatScreen.tableViewMessages.numberOfSections
            let numberOfRows = self.chatScreen.tableViewMessages.numberOfRows(inSection: numberOfSections - 1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
                self.chatScreen.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewMessID, for: indexPath) as! MessagesTableViewCell
        let message = messages[indexPath.row]
        cell.labelMessage.text = message.text
        cell.labelTime.text = message.time
//        print("LABELMESSAGE:")
//        print(cell.labelMessage.text)
        if message.sender == selfEmail {
            cell.setSelfConstraint()
        } else {
            cell.setOppoConstraint()
        }
                
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
}
