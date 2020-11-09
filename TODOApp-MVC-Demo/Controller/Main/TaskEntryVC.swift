import UIKit

protocol refreshDataDelegate: AnyObject {
    func refreshData()
}

class TaskEntryVC: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    // MARK:- Properties
    weak var delegate: refreshDataDelegate?
    
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
        self.view.showLoader()
        APIManager.addTast(with: description) { (response) in
            if response {
                self.delegate?.refreshData()
                
            } else {
                self.showSimpleAlert(message: AlertMess.taskFail, title: AlertMess.title)
            }
        }
        self.view.hideLoader()
    }
}
