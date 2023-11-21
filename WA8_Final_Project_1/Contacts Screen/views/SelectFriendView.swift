//
//  SelectFriendView.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/20/23.
//

import UIKit

class SelectFriendView: UIView {
    var tableViewFriends: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewFriends()
        
        initConstraints()
    }
    
    func setupTableViewFriends() {
        tableViewFriends = UITableView()
        tableViewFriends.backgroundColor = .white
        tableViewFriends.register(FriendsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFriendsID)
        tableViewFriends.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewFriends)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewFriends.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableViewFriends.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewFriends.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewFriends.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
