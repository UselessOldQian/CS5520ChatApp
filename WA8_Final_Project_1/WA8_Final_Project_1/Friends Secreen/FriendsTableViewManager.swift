//
//  FriendsTableViewManager.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import UIKit

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewFriendsID, for: indexPath) as! FriendsTableViewCell
        cell.labelName.text = friends[indexPath.row]
        return cell
    }
}
