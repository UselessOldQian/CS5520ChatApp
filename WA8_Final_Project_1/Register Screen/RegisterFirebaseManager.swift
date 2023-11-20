//
//  RegisterFirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by Jacqueline Guo on 11/14/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(){
        showActivityIndicator()
        if let name = registerView.nameTextField.text,
           let email = registerView.emailTextField.text?.lowercased(),
           let password = registerView.passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    self.setNameOfTheUserInFirebaseAuth(name: name, email: email)
                }else{
                    print(error)
                }
            })
        }
    }

    func setNameOfTheUserInFirebaseAuth(name: String, email: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                self.hideActivityIndicator()
                self.addUserToDatabase(name: name, email: email)
                self.navigationController?.popViewController(animated: true)
            }else{
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func addUserToDatabase(name: String, email: String) {
        let database = Firestore.firestore()
        let userDocument = database.collection("users").document(email)
        let userData = User(email: email, name: name)

        do {
            try userDocument.setData(from: userData) { error in
                if let error = error {
                    print("Error adding user to database: \(error.localizedDescription)")
                } else {
                    print("User added to database successfully")
                }
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        } catch let error {
            print("Error encoding user data: \(error.localizedDescription)")
            self.hideActivityIndicator()
        }
    }
}

