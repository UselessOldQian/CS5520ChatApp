//
//  FriendsView.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/19.
//

import UIKit

class FriendsView: UIView {
    var tableViewFriends: UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewFriends()
        
        initConstraints()
    }
    
    func setupTableViewFriends(){
        tableViewFriends = UITableView()
        tableViewFriends.register(FriendsTableViewCell.self, forCellReuseIdentifier: "users")
        tableViewFriends.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewFriends)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            tableViewFriends.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -8),
            tableViewFriends.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewFriends.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewFriends.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
