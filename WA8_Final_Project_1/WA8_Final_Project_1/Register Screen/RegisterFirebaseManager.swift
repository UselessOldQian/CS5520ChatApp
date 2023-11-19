//
//  RegisterFirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by Jacqueline Guo on 11/14/23.
//

import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        showActivityIndicator()
        if let name = registerView.nameTextField.text,
           let email = registerView.emailTextField.text,
           let password = registerView.passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                }else{
                    print(error)
                }
            })
        }
    }

    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }else{
                print("Error occured: \(String(describing: error))")
            }
        })
    }
}

