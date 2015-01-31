//
//  ViewController.swift
//  TaskIt
//
//  Created by Zac on 31/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd-MM-yyyy"
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: Date.from(2014, month: 12, day: 1))
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: Date.from(2014, month: 12, day: 1))
        taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: Date.from(2014, month: 12, day: 1))]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let TaskDetailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
//            let indexPath = sender as NSIndexPath
            let indexPath = tableView.indexPathForSelectedRow()
            println(indexPath!.row)
            TaskDetailVC.taskModel = taskArray[indexPath!.row]
        }
    }
    
    // UITableView Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as TaskCell
        cell.taskLabel.text = taskArray[indexPath.row].task
        cell.descriptionLabel.text = taskArray[indexPath.row].subTask
        cell.dateLabel.text = Date.toString(taskArray[indexPath.row].date)
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showTaskDetail", sender: indexPath)
    }
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return CGFloat(44)
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}

