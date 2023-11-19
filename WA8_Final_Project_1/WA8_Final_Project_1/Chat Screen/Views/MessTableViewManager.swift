//
//  MessTableViewManager.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import UIKit

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewMessID, for: indexPath) as! MessagesTableViewCell
        cell.labelMessage.text = messagesList[indexPath.row].message
//        print("LABELMESSAGE:")
//        print(cell.labelMessage.text)
        if messagesList[indexPath.row].myself {
            cell.setSelfConstraint()
        } else {
            cell.setOppoConstraint()
        }
        return cell
    }
}
