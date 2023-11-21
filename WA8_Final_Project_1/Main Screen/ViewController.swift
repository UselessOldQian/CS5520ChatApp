
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    let mainScreen = MainScreenView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
//    var currentUser: FirebaseAuth.User?
    
    let database = Firestore.firestore()
    var chats = [Chat]()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // handle authentication state change
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            // no user signed in
            if user == nil {
//                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the messages!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = false
                self.mainScreen.floatingButtonAddMessage.isHidden = true
                // reset profile pic
                self.mainScreen.profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
                
                //MARK: Reset tableView...
//                self.messageList.removeAll()
//                self.mainScreen.tableViewContacts.reloadData()
                
                // setup sign in bar button
                self.setupRightBarButton(isLoggedin: false)
                
            } else {
                // user has signed in
                Validation.defaults.set(user?.email, forKey: "auth")
//                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddMessage.isEnabled = true
                self.mainScreen.floatingButtonAddMessage.isHidden = false
                
                // set profile pic
//                if let url = self.currentUser?.photoURL{
//                    self.mainScreen.profilePic.loadRemoteImage(from: url)
//                }
                
                // setup logout bar button
                self.setupRightBarButton(isLoggedin: true)
                
                self.getAllChats(userEmail: (user?.email)!)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Messages"
        
        //MARK: patching table view delegate and data source...
//        mainScreen.tableViewContacts.delegate = self
//        mainScreen.tableViewContacts.dataSource = self
        
        //MARK: removing the separator line...
//        mainScreen.tableViewContacts.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddMessage)
        
        //MARK: tapping the floating add contact button...
        mainScreen.floatingButtonAddMessage.addTarget(self, action: #selector(selectContactButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func getAllChats(userEmail: String) {
        // get last message with each friend from chats collection
        
        
    }
    
    @objc func selectContactButtonTapped() {
        let contactsViewController = ContactsViewController()
        navigationController?.pushViewController(contactsViewController, animated: true)
    }
}
