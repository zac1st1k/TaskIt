//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Zac on 2/02/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController, TaskDetailViewControllerDelegate {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate:AddTaskViewControllerDelegate?
    
    @IBAction func saveBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: appDelegate.managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
        if NSUserDefaults.standardUserDefaults().boolForKey("isCapitalized") == true {
            task.task = taskTextField.text.capitalizedString
        } else {
            task.task = taskTextField.text
        }
        if NSUserDefaults.standardUserDefaults().boolForKey("isCompleted") == true {
            task.isCompleted = true
        }
        else {
            task.isCompleted = false
        }
        task.date = datePicker.date
        task.subtask = subtaskTextField.text
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = appDelegate.managedObjectContext!.executeFetchRequest(request, error: &error)!
        for n in results {
            println(n)
            
        }
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task Added")
    }
    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCanceled("Task Was Not Added")
    }
}
