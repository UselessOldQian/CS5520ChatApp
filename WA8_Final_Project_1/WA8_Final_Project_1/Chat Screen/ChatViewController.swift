//
//  ChatViewController.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import UIKit
import FirebaseFirestore

class ChatViewController: UIViewController {
    let chatScreen = ChatView()
    var messagesList = [Message]()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let auth = Validation.defaults.object(forKey: "auth") as! String? {
//            self.database.collection("users")
//                .document(auth)
//                .collection("bella@email.com") // change to the tapped cell
//                .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
//                    if let documents = querySnapshot?.documents {
//                        self.messagesList.removeAll()
//                        for document in documents {
//                            print(document)
//                            do {
//                                let message  = try document.data(as: Message.self)
//                                self.messagesList.append(message)
//                            } catch {
//                                print(error)
//                            }
//                        }
//                        self.messagesList.sort(by: {$0.time < $1.time})
//                        self.chatScreen.tableViewMessages.reloadData()
//                    }
//                })
//        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Bella" // change to the tapped cell
        chatScreen.tableViewMessages.delegate = self
        chatScreen.tableViewMessages.dataSource = self
        chatScreen.tableViewMessages.separatorStyle = .none
        
        messagesList.append(Message(message: "Hi", myself: true, time: Date()))
        messagesList.append(Message(message: "New message", myself: false, time: Date()))
        messagesList.append(Message(message: "lkjsdfkj lksdj sdkfja sdfkjdskfjlsk a kjfsdkfjs aksjd klajs kj dfkajf kdsjfk jsdkfl jsdklf jasdf laksdjf ksdjf lskdjf kslkdfj a!", myself: true, time: Date()))
        messagesList.append(Message(message: "sjkdfl sjdklf jslkdfj skld kfsjd lkfjslk dslkfslkdfj slkdjf lksjd flksdlksdlkjf skldjf", myself: false, time: Date()))
        messagesList.append(Message(message: "123123 123", myself: false, time: Date()))
        messagesList.append(Message(message: "lkdjfl", myself: true, time: Date()))
        messagesList.append(Message(message: "laskdjflksdj flskj lksjf klsjdf lksdj flksfj lksd jflksjd flksjfkljsdlkf jsldkfj lksdf lksdjf kldsj flkwiod uaiow jiwj ldijdlisj dilje lifjesl fjsleif lsiejf lisejf lisejf", myself: true, time: Date()))
        messagesList.append(Message(message: "1", myself: false, time: Date()))
        messagesList.append(Message(message: "dklsfj lskdfj lksdjf ksldjf lksdj flkjsd flksjdlfk jsdlkfj ", myself: true, time: Date()))
        
        scrollToBottom()
//        chatScreen.tableViewMessages.reloadData()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
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
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
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
