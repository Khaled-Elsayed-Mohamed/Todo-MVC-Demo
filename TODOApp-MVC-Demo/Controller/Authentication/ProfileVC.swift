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
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK:- Properties
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            logoutUser()
        }
    }
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.profileVC)
        return profileVC
    }
    
    //MARK:- IBActions
    @IBAction func addImageButton(_ sender: UIBarButtonItem) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
    
}

extension ProfileVC {
    // MARK:- API
    private func getUserData() {
        self.view.showLoader()
        
        APIManager.getUserData { (error, userData) in
            if let error = error {
                print(error.localizedDescription)
            } else if let userData = userData {
                self.getImage(id: userData.id)
                self.idLabel.text = "\(userData.id)"
                self.nameLabel.text = "Name: \(userData.name)"
                self.emailLabel.text = "Email: \(userData.email)"
                self.ageLabel.text = "Age: \(userData.age)"
            }
            self.view.hideLoader()
        }
    }
    
    private func logoutUser() {
        self.view.showLoader()
        
        APIManager.logout { (success) in
            if success {
                UserDefaultsManager.shared().token = nil
                self.goToSignInVC()
            } else {
                self.showSimpleAlert(message: AlertMess.logoutFail , title: AlertMess.title)
            }
            self.view.hideLoader()
        }
    }
    
    private func uploadImage(image: UIImage) {
        self.view.showLoader()
        APIManager.uploadImage(with: image) { (succ) in
            if succ {
                guard let id = self.idLabel.text else { return }
                self.getImage(id: id)
            } else {
                print("oo")
            }
            self.view.hideLoader()
        }
    }
    
    private func getImage(id: String) {
        
        
        APIManager.getImage(with: id) { (error, data) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                self.profileImage.image = UIImage(data: data)
            }
            
        }
    }
    // MARK:- Private methods
    private func goToSignInVC() {
        let signInVC = SignInVC.create()
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
}

// MARK:- Image Picker Data source
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        
        uploadImage(image: selectedImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

