//
//  TaskDetailViewController.swift
//  taskapp
//
//  Created by Guilherme on 07/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var taskItem: TaskItem?
    
    var taskID: String?

    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var taskNav: UINavigationItem!
    
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var txtExpDate: UITextField!
    
    @IBOutlet weak var swiCompleted: UISwitch!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initTask()
        
    }
    
    func initTask() {
        
        if let task = self.taskItem {
            
            self.taskNav.title = "Detail"
            self.txtTitle.text = task.title
            self.txtDescription.text = task.taskDescription
            self.txtExpDate.text = task.expirationDate
            self.swiCompleted.setOn(task.isComplete!, animated: false)
            self.taskID = task.id
            
        } else {
            
            self.taskNav.title = "New"
            self.txtTitle.text = ""
            self.txtDescription.text = ""
            self.txtExpDate.text = ""
            self.swiCompleted.setOn(false, animated: false)
            self.taskID = nil
            
        }
        
    }

    @IBAction func save(_ sender: Any) {
        
        // update
        if let _ = self.taskID {
            
            let updTask = TaskItem(id: self.taskID!, expDate: txtExpDate.text!, title: txtTitle.text!, desc: txtDescription.text!, isCompl: swiCompleted.isOn, owner: (self.taskItem?.owner)!)
            
            TaskService().update(task: updTask, onSuccess: { response in
                
                self.taskItem = response?.body
                self.initTask()
                self.showMessage("Task updated!")
                
            }, onError: {_ in
                
                self.showMessage("Fail to update task!")
                
            }, always: {
                
            })

            
        } else { // create
           
            let newTask = TaskItem(expDate: txtExpDate.text!, title: txtTitle.text!, desc: txtDescription.text!, isCompl: swiCompleted.isOn)
            
            TaskService().create(task: newTask, onSuccess: { response in
                
                self.taskItem = response?.body
                self.initTask()
                self.showMessage("Task saved!")
                
            }, onError: {_ in 
                
                self.showMessage("Fail to save task!")
                
            }, always: {
                
            })
        }
    }
    
    func showMessage(_ msg:String) {
        let myalert = UIAlertController(title: "Mensagem", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        myalert.addAction(UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            
            myalert.dismiss(animated: true)
        })
        self.present(myalert, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
