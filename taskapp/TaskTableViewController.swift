//
//  TaskTableViewController.swift
//  taskapp
//
//  Created by Guilherme on 06/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import UIKit


class TaskTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {

    var tasks: Tasks?
    var selectedTaskItem: TaskItem?
    var filterTasks = [TaskItem]()
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var btnSearch: UIBarButtonItem!
    
    var searchController: UISearchController!
    
    @IBAction func searchClick(_ sender: Any) {
        
        self.searchController = searchControllerWith(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.navBar.titleView = searchController.searchBar
        self.definesPresentationContext = true
        self.btnSearch.tintColor = UIColor.clear
        self.btnSearch.isEnabled = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.resignFirstResponder()
        self.btnSearch.tintColor = UIColor.blue
        self.btnSearch.isEnabled = true
        self.navBar.titleView = nil
        filterTasks = (self.tasks?.results)!
        self.tableView.reloadData()
        
    }
    
    func cancelBarButtonItemClicked() {
        self.searchBarCancelButtonClicked(self.searchController.searchBar)
        filterTasks = [TaskItem]()
        self.tableView.reloadData()
    }
    
    
    func searchControllerWith(searchResultsController: UIViewController?) -> UISearchController {
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.barTintColor = UIColor.blue
        
        return searchController
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filterTasks = (self.tasks?.results)!
        }else {
            var results = [TaskItem]()
            for item in (tasks?.results)! {
                //filtra tasks
                if item.taskDescription?.lowercased().range(of: searchText.lowercased()) != nil {
                    results.append(item)
                }
            }
            filterTasks = [TaskItem]()
            filterTasks = results
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTasks()

    }
    
    func loadTasks() {
        
        // Tasks loading ...
        TaskService().tasks(onSuccess: { response in
            
            self.tasks = response?.body
            
            self.filterTasks = (self.tasks?.results)!
            
            if self.tasks != nil {
                print("Tasks Loaded! Size: \(String(describing: self.tasks?.count))")
            }
            
        }, onError: {_ in
            
            print("Error loading tasks...!")
            
        }, always: {
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filterTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell

        let taskItem = self.filterTasks[indexPath.row]
        
        cell.lblOwner.text = taskItem.owner
        cell.lblDescription.text = taskItem.taskDescription
        cell.lblExpDate.text = taskItem.expirationDate
        
        cell.isCompletedOval.isHidden = !(taskItem.isComplete)!

        print("cell \(indexPath.row) \(cell.lblDescription) \(cell.lblExpDate)")
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(100)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedTaskItem = self.filterTasks[indexPath.row]
        performSegue(withIdentifier: "taskDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskDetailVC: TaskDetailViewController = segue.destination as! TaskDetailViewController
        taskDetailVC.taskItem = self.selectedTaskItem
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // delete
            let delTask = self.filterTasks[indexPath.row]
                
            TaskService().delete(task: delTask, onSuccess: { _ in
                
                self.filterTasks.remove(at: indexPath.row)
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                self.showMessage("Task deleted!")
                
            }, onError: {_ in
                
                self.showMessage("Fail to delete task!")
                
            }, always: {
                self.tableView.reloadData()
            })
                
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTasks()
    }

    func showMessage(_ msg:String) {
        let myalert = UIAlertController(title: "Mensagem", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        myalert.addAction(UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            
            myalert.dismiss(animated: true)
        })
        self.present(myalert, animated: true)
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        self.selectedTaskItem = nil
        performSegue(withIdentifier: "taskDetail", sender: self)
        
    }


}
