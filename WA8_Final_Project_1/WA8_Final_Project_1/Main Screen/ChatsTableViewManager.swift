//
//  ContactsTableViewManager.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import UIKit
import FirebaseAuth

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
        cell.labelName.text = chats[indexPath.row].friendName
        if let message = chats[indexPath.row].messages?.first(where: { $0.id == chats[indexPath.row].lastMessageID }) {
            cell.labelText.text = message.text
            cell.labelTime.text = message.time
        } else {
            cell.labelText.text = "No Messages"
            cell.labelTime.text = "Unknown Time"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = Auth.auth().currentUser {
            let chatController = ChatViewController()
            chatController.chatID = chats[indexPath.row].id
            chatController.selfEmail = user.email
            chatController.friendName = chats[indexPath.row].friendName
            
            if let friendEmail = chats[indexPath.row].friends.first(where: { $0 != user.email }) {
                // friendEmail now contains the first email in the array that is not user.email
                print("Friend's email: \(friendEmail)")
                chatController.friendEmail = friendEmail
                navigationController?.pushViewController(chatController, animated: true)
            } else {
                // All emails in the array are equal to user.email, or the array is empty
                print("No different email found")
            }
        }
//        self.sendMsgs(from: "usera", to: "userb")
    }
}
