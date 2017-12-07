//
//  TaskTableViewController.swift
//  taskapp
//
//  Created by Guilherme on 06/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {

    var tasks: Tasks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tasks loading ...
        TaskService().tasks(onSuccess: { response in
            
            self.tasks = response?.body
            
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
        return tasks?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell

        let taskItem = self.tasks?.results![indexPath.row]
        
        cell.lblOwner.text = taskItem?.owner ?? ""
        cell.lblDescription.text = taskItem?.taskDescription ?? ""
        cell.lblExpDate.text = taskItem?.expirationDate ?? ""
        
        let isCompleted = taskItem?.isComplete
        
        if !isCompleted! {
            cell.isCompletedOval.isHidden = true
        }

        print("cell \(indexPath.row) \(cell.lblDescription) \(cell.lblExpDate)")
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(100)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
