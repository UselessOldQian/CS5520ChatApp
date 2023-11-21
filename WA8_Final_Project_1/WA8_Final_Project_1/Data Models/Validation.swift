//
//  Validation.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import Foundation
import UIKit

class Validation {
    static let defaults = UserDefaults.standard
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPhone(_ phone: String) -> Bool {
        let characterSet = CharacterSet.decimalDigits.inverted
        return phone.rangeOfCharacter(from: characterSet) == nil
    }
    
    static func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[A-Za-z0-9]{3,10}$"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePred.evaluate(with: username)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^[A-Za-z0-9]{8,16}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    
    static func showAlert(_ view: UIViewController, _ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alertController, animated: true, completion: nil)
    }
}
