//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Zac on 31/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var mainVC: ViewController!
    
    @IBOutlet weak var taskLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var taskModel:TaskModel = TaskModel(task: "", subTask: "", date: NSDate())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskLabel.text = taskModel.task
        descriptionLabel.text = taskModel.subTask
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
        var task = TaskModel(task: taskLabel.text, subTask: descriptionLabel.text, date: datePicker.date)
        mainVC.taskArray[mainVC.tableView.indexPathForSelectedRow()!.row] = task
        navigationController?.popViewControllerAnimated(true)

    }
}
