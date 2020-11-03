//
//  TaskEntryVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Khaled L Said on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol refreshDataDelegate {
     func refreshData()
}

class TaskEntryVC: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    // MARK:- Properties
    var delegate: refreshDataDelegate?
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- IBActions
    @IBAction func saveTaskButton(_ sender: UIButton) {
        addTask()
        
        self.dismiss(animated: true)
    }

    // MARK:- Public methods	
    class func create() -> TaskEntryVC {
        let taskEntryVC: TaskEntryVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.taskEntryVC)
        return taskEntryVC
    }

}

extension TaskEntryVC {
    
    // MARK:- API
    private func addTask() {
        guard let description = descriptionTextfield.text else {return}
        
        APIManager.addTast(with: description) { (response) in
            if response {
                self.delegate?.refreshData()
              
            } else {
                self.showSimpleAlert(message: AlertMess.taskFail, title: AlertMess.title)
            }
        }
    }
}
