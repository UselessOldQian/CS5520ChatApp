
import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.createButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        
        // hide keyword if app screen is tapped
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onRegisterTapped(){
        registerNewAccount()
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}
