//
//  UIViewController+ShowAlert.swift
//  TODOApp-MVC-Demo
//
//  Created by Khaled L Said on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showAlert(message: String, title: String, handler:  ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: handler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
