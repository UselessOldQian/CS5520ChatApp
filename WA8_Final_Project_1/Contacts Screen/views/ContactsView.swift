//
//  ContactsView.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/20/23.
//

import UIKit

class ContactsView: UIView {
    var tableViewContacts: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewContacts()
        
        initConstraints()
    }
    
    func setupTableViewContacts() {
        tableViewContacts = UITableView()
        tableViewContacts.backgroundColor = .white
        tableViewContacts.register(ContactsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewContacts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContacts)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewContacts.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewContacts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
