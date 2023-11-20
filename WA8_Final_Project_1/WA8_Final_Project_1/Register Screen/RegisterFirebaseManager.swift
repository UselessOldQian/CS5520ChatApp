//
//  RegisterFirebaseManager.swift
//  WA8_Final_Project_1
//
//  Created by Jacqueline Guo on 11/14/23.
//

import UIKit
import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        showActivityIndicator()
        let name = registerView.nameTextField.text
        let email = registerView.emailTextField.text
        let password = registerView.passwordTextField.text
        if name?.isEmpty == true || email?.isEmpty == true || password?.isEmpty == true {
            showAlert(with: "Error", message: "All fields must be filled out.")
            self.hideActivityIndicator()
            return
        }
        
        if !isValidEmail(email) {
            showAlert(with: "Error", message: "Please provide correct email address.")
            self.hideActivityIndicator()
            return
        }
        
        if let name = name, let email = email, let password = password {
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
    
    private func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

