
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chats", for: indexPath) as! ChatsTableViewCell
        let chat = chats[indexPath.row]
        cell.labelName.text = chat.name
        cell.labelText.text = chat.lastText
        cell.labelTime.text = Validation.formatDate(chat.date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectChat = chats[indexPath.row]
//        let chatViewController = ChatViewController()
//        chatViewController.currentUser = self.currentUser
//        chatViewController.chatID = selectChat.id
//        chatViewController.selfEmail = currentUser?.email
//        chatViewController.friendEmail = selectChat.friends[1]
//        chatViewController.friendName = selectChat.friendName
//        navigationController?.pushViewController(chatViewController, animated: true)
    }
}
