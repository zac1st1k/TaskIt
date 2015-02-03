//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Zac on 2/02/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func saveBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: appDelegate.managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = datePicker.date
        task.isCompleted = false
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = appDelegate.managedObjectContext!.executeFetchRequest(request, error: &error)!
        for n in results {
            println(n)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}