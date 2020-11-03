//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Khaled L Said on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK:- Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserData()
    }
    
    
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.profileVC)
        return profileVC
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            logoutUser()
        }
    }
}

extension ProfileVC {
    // MARK:- Private Methods
    private func getUserData() {
        APIManager.getUserData { (error, userData) in
            if let error = error {
                print(error.localizedDescription)
            } else if let userData = userData {
                self.idLabel.text = "Id: \(userData.id)"
                self.nameLabel.text = "Name: \(userData.name)"
                self.emailLabel.text = "Email: \(userData.email)"
                self.ageLabel.text = "Age: \(userData.age)"
            }
        }
    }
    
    private func logoutUser() {
        APIManager.logout { (success) in
            if success {
                UserDefaultsManager.shared().token = nil
                self.goToSignInVC()
            } else {
                self.showSimpleAlert(message: AlertMess.logoutFail , title: AlertMess.title)
            }
        }
    }
    
    private func goToSignInVC() {
        let signInVC = SignInVC.create()
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
}

