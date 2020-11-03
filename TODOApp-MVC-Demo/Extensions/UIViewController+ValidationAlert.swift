import Foundation
import UIKit

extension UIViewController {
    
    func isValid(with validationType: ValidationType,_ string: String) -> Bool {
        switch validationType {
            
        case .email:
            if !string.isValidEmail || string.isEmpty {
                showSimpleAlert(message: validationType.error.message, title: validationType.error.title)
                return false
            }
        case .password:
            if !string.isValidPassword || string.isEmpty {
                showSimpleAlert(message: validationType.error.message, title: validationType.error.title)
                return false
            }
            
        case .name:
            if !string.isValidName || string.isEmpty {
                showSimpleAlert(message: validationType.error.message, title: validationType.error.title)
                return false
            }
            
        case .age:
            guard let age = Int(string) else {return false}
            if age <= 0 || string.isEmpty {
                showSimpleAlert(message: validationType.error.message, title: validationType.error.title)
                return false
            }
        }
        return true
    }
}
