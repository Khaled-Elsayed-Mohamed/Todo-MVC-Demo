import UIKit

class SignInVC: UIViewController {
    
    // MARK:- Outlet
    @IBOutlet weak var signInLogo: UIImageView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK:- IBActions
    @IBAction func signinButton(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, isValid(with: .email, email),
            let password = passwordTextfield.text, isValid(with: .password, password) else { return }
        login(with: email, password: password)
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }
    
}

extension SignInVC {
    
    // MARK:- API
    private func login(with email: String, password: String) {
        self.view.showLoader()
        APIManager.login(with: email, password: password) { (error, loginData) in
            
            if let error = error {
                print(error	)
                self.showSimpleAlert(message: AlertMess.invalidEmail , title: AlertMess.title)
            } else if let loginData = loginData {
                
                UserDefaultsManager.shared().token = loginData.token
                self.goToTodoListVC()
            }
            self.view.hideLoader()
        }
        
    }
    
    // MARK:- Private Methods
    private func goToTodoListVC() {
        let todoListVC = TodoListVC.create()
        self.navigationController?.pushViewController(todoListVC, animated: true)
    }
    
}
