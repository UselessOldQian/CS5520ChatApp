//
//  ContactsViewController.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/20/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ContactsViewController: UIViewController {
    let contactsScreen = ContactsView()
    var contacts = [User]()
    let database = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = contactsScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // handle changes in authentication state
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("Invalid credential or user not logged in.")
            } else {
                if let email = user?.email {
                    self.getAllContacts(email)
                } else {
                    print("No email address linked with current user.")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        contactsScreen.tableViewContacts.delegate = self
        contactsScreen.tableViewContacts.dataSource = self
        contactsScreen.tableViewContacts.separatorStyle = .none
    }
    
    func getAllContacts(_ email: String) {
        print("getAllContacts called")
        let userCollections = database.collection("usersDemo")
        userCollections.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            for doc in documents {
                print("doc id: \(doc.documentID)")
                print("email: \(email)")
                if doc.documentID != email {
                    if let userData = try? doc.data(as: User.self) {
                        self.contacts.append(userData)
                    } else {
                        print("Failed to convert Firestore document to User object")
                    }
                }
                print("DOC DATA: \(doc.data())")
            }
            print("contacts 1: \(self.contacts)")
            


            DispatchQueue.main.async {
                self.contactsScreen.tableViewContacts.reloadData()
            }
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactsID, for: indexPath) as! ContactsTableViewCell
        let contact = contacts[indexPath.row]
        cell.labelName.text = contact.name
        
        return cell
    }
}
