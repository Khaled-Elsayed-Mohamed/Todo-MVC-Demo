import UIKit

class TodoListVC: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK:- Properties
    var tasksArr = [TaskData]()
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfig() 
        getAllTasks()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    // MARK:- IBActions
    @IBAction func profileButton(_ sender: UIBarButtonItem) {
        goToProfileVC()
    }
    
    @IBAction func addTaskButton(_ sender: UIBarButtonItem) {
        goToTaskEntryVC()
    }
    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        return todoListVC
    }
}

extension TodoListVC {
    // MARK:- API
    private func getAllTasks() {
        APIManager.getAllTasks { (error, taskResponse) in
            if let error = error {
                print(error)
            } else if let taskResponse = taskResponse {
                self.tasksArr = taskResponse.data
                self.tableView.reloadData()
            }
        }
    }
    // MARK:- Private Methods
    private func goToTaskEntryVC() {
        let taskEntryVC = TaskEntryVC.create()
        taskEntryVC.delegate = self
        self.present(taskEntryVC, animated: true)
    }
    
    private func goToProfileVC() {
        let profileVC = ProfileVC.create()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    private func tableViewConfig() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: Cells.taskCell, bundle: nil), forCellReuseIdentifier: Cells.taskCell)
        
    }
    
}

extension TodoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasksArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.taskCell, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        cell.configCell(task: self.tasksArr[indexPath.row])
        return cell
    }
    
    
}



extension TodoListVC: refreshDataDelegate {
    func refreshData() {
        getAllTasks()
        
    }
    
    
}
