//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Zac on 31/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
//    var mainVC: ViewController!
    
    @IBOutlet weak var taskLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var taskModel:TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskLabel.text = taskModel.task
        descriptionLabel.text = taskModel.subtask
        datePicker.date = taskModel.date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        taskModel.task = taskLabel.text
        taskModel.subtask = descriptionLabel.text
        taskModel.date = datePicker.date
        taskModel.isCompleted = taskModel.isCompleted
        appDelegate.saveContext()
        navigationController?.popViewControllerAnimated(true)

    }
}
