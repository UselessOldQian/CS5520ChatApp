
import Foundation
import FirebaseAuth
//hideActivityIndicator

extension RegisterViewController {
    
    func registerNewAccount() {
        showActivityIndicator()
        if let name = registerView.nameTextField.text,
           let email = registerView.emailTextField.text,
           let password = registerView.passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if let maybeError = error {

                    let err = maybeError as NSError
                    switch err.code {
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        Validation.showAlert(self, "Email Occupied", "The email address is already in use.")
                        self.hideActivityIndicator()
                    default:
                        Validation.showAlert(self, "Input Error", "Username or password does not meet requirement.")
                        self.hideActivityIndicator()
                    }
                } else {
                    Validation.showAlert(self, "Success", "You are now logged in!")
                    self.hideActivityIndicator()
                    
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    self.addUserToDatabase(email, name)
                }
                
                
                
                
                
                
                
//                if error == nil {
//                    self.setNameOfTheUserInFirebaseAuth(name: name)
//                    self.addUserToDatabase(email, name)
//                } else {
//                    print("ERROR!!!")
//                    print(error)
//                }
            })
        }
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func addUserToDatabase(_ email: String, _ name: String) {
        let userData: [String: String] = ["name": name]
        database.collection("usersDemo").document(email).setData(userData) { error in
            if let error = error {
                print("Error adding user: \(error)")
            } else {
                print("FOR LOG ONLY!!! Document added with ID: \(email)")
            }
        }
    }
}

