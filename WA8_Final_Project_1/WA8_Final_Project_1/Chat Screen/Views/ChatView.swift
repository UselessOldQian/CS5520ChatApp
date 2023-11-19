//
//  ChatView.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import UIKit

class ChatView: UIView {
    var tableViewMessages: UITableView!
    var textFieldMessage: UITextField!
    var buttonSend: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewMessages()
        setupTextFieldMessage()
        setupButtonSend()
        
        initConstraints()
    }
    
    func setupTableViewMessages() {
        tableViewMessages = UITableView()
        tableViewMessages.backgroundColor = .white
        tableViewMessages.register(MessagesTableViewCell.self, forCellReuseIdentifier: Configs.tableViewMessID)
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewMessages)
    }
    
    func setupTextFieldMessage() {
        textFieldMessage = UITextField()
        textFieldMessage.borderStyle = .none
        textFieldMessage.layer.borderWidth = 0.4
        textFieldMessage.layer.cornerRadius = 5
        textFieldMessage.autocapitalizationType = .none
        textFieldMessage.translatesAutoresizingMaskIntoConstraints = false
        textFieldMessage.textContentType = .oneTimeCode
        self.addSubview(textFieldMessage)
    }
    
    func setupButtonSend() {
        buttonSend = UIButton(type: .system)
        
//        buttonSend.tintColor = UIColor.red
        
        buttonSend.setTitle("Send", for: .normal)
        
//        buttonSend.setTitleColor(.black, for: .normal)
        buttonSend.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        buttonSend.layer.borderWidth = 2
//        buttonSend.layer.borderColor = UIColor.blue.cgColor
//        buttonSend.layer.cornerRadius = 5
        
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSend)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewMessages.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            textFieldMessage.topAnchor.constraint(equalTo: tableViewMessages.bottomAnchor, constant: 20),
            textFieldMessage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            textFieldMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            textFieldMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            
            buttonSend.topAnchor.constraint(equalTo: tableViewMessages.bottomAnchor, constant: 20),
            buttonSend.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonSend.leadingAnchor.constraint(equalTo: textFieldMessage.trailingAnchor, constant: 8),
            buttonSend.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
