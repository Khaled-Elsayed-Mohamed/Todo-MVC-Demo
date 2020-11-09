//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, isValid(with: .email, email),
            let password = passwordTextfield.text, isValid(with: .password, password),
            let age = ageTextfield.text, isValid(with: .age, age),
            let name = nameTextfield.text, isValid(with: .name, name)
            else {return}
        
        register(with: email, password: password, age: age, name: name)
        
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
    }
}

extension SignUpVC {
    
    // MARK:- API
    private func register(with email: String, password: String, age: String, name: String) {
        let user = Register(name: name,
                            email: email,
                            password: password,
                            age: age)
        self.view.showLoader()
        APIManager.register(with: user) { (error, registerData) in
            
            if let error = error {
                self.showSimpleAlert(message: AlertMess.inUseEmail, title: AlertMess.title)
                print(error.localizedDescription)
            } else if let registerData = registerData {
                print(registerData.token)
                UserDefaultsManager.shared().token = registerData.token
                self.goToTodoListVC()
            }
            self.view.hideLoader()
        }
    }
    // MARK:- PrivateMethods
    private func goToTodoListVC() {
        let todoListVC = TodoListVC.create()
        self.navigationController?.pushViewController(todoListVC, animated: true)
    }
}
