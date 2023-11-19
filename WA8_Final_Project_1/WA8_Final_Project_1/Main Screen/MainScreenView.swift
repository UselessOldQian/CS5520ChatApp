//
//  MainScreenView.swift
//  WA8_Final_Project_1
//
//  Created by Jacqueline Guo on 11/14/23.
//

import UIKit

class MainScreenView: UIView {
    var profilePic: UIImageView!
    var labelText: UILabel!
    var floatingButtonAddMessage: UIButton!
    var tableViewContacts: UITableView!
    
    var testButton: UIButton!
    var testLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePic()
        setupLabelText()
        setupFloatingButtonAddContact()
        
        testSetupBtn()
        testSetupLabel()
        
        initConstraints()
    }
    
    func testSetupLabel() {
        testLabel = UILabel()
        testLabel.text = "new message here what are you doing right nowhaha do you want to have lunch!"
        testLabel.font = UIFont.boldSystemFont(ofSize: 16)
        testLabel.numberOfLines = 0
        testLabel.lineBreakMode = .byWordWrapping
        testLabel.sizeToFit()
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
//            testLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            testLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            testLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -10),
            
        ])
    }
    
    func testSetupBtn() {
        testButton = UIButton(type: .system)
        testButton.setTitle("test chat screen", for: .normal)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(testButton)
    }
    
    func setupProfilePic(){
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleAspectFill
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = 16.0
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePic)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewMessages(){
    }
    
    func setupFloatingButtonAddContact(){
        floatingButtonAddMessage = UIButton(type: .system)
        floatingButtonAddMessage.setTitle("", for: .normal)
        floatingButtonAddMessage.setImage(UIImage(systemName: "plus.message.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddMessage.contentHorizontalAlignment = .fill
        floatingButtonAddMessage.contentVerticalAlignment = .fill
        floatingButtonAddMessage.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddMessage.layer.cornerRadius = 16
        floatingButtonAddMessage.imageView?.layer.shadowOffset = .zero
        floatingButtonAddMessage.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddMessage.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddMessage.imageView?.clipsToBounds = true
        floatingButtonAddMessage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddMessage)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 32),
            profilePic.heightAnchor.constraint(equalToConstant: 32),
            profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            labelText.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelText.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelText.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
//            
//            tableViewContacts.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 8),
//            tableViewContacts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
//            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddMessage.widthAnchor.constraint(equalToConstant: 60),
            floatingButtonAddMessage.heightAnchor.constraint(equalToConstant: 60),
            floatingButtonAddMessage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonAddMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            testButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
