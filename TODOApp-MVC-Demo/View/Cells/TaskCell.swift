//
//  TaskCell.swift
//  TODOApp-MVC-Demo
//
//  Created by Khaled L Said on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol DeleteTaskDelegate: AnyObject {
    func deleteTask(cell: UITableViewCell)
    
    
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: DeleteTaskDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK:- IBActions
    
    @IBAction func deleteTask(_ sender: UIButton) {
        delegate?.deleteTask(cell: self)
    }
    
    // MARK:- Methods
    
    func configCell(task: TaskData) {
        descriptionLabel.text = task.description
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


