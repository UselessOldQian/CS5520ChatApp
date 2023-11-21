//
//  FriendsTableViewManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import UIKit
import FirebaseAuth

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! FriendsTableViewCell
        cell.labelName.text = friends[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = Auth.auth().currentUser {
            // User is signed in
            print("User Email: \(user.email ?? "No email")")
            if let senderEmail = user.email {
                let receiverEmail = friends[indexPath.row]
                if senderEmail == receiverEmail {
                    showAlert(with: "Error", message: "Cannot create chat, sender and receiver is the same")
                    return
                }
                
                checkOrCreateChat(userEmailA: senderEmail, userEmailB: receiverEmail) { chatDocumentID in
                    if let chatDocumentID = chatDocumentID {
                        print("Chat document ID: \(chatDocumentID)")
                        // Pop to MainScreen
                        self.navigationController?.popViewController(animated: true)
                        let chatViewController = ChatViewController()
                        chatViewController.chatID = chatDocumentID
                        chatViewController.selfEmail = senderEmail
                        chatViewController.friendEmail = receiverEmail
                        self.fetchUserName(byEmail: receiverEmail) { userName in
                            if let userName = userName {
                                print("User's name: \(userName)")
                                chatViewController.friendName = userName
                            } else {
                                print("User's name could not be fetched")
                            }
                        }
                        
                        self.navigationController?.pushViewController(chatViewController, animated: true)
                    } else {
                        print("No chat document found or created")
                    }
                }
//                self.checkOrCreateChat(userEmailA: senderEmail, userEmailB: receiverEmail)
            }
        } else {
            // No user is signed in
            print("No user is currently signed in")
            return
        }
//        print("Chats: \(friends[indexPath.row])")
    }
    
    private func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
