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
    var completedArray:[TaskModel] = []
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd-MM-yyyy"
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: Date.from(2014, month: 12, day: 3), isCompleted: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: Date.from(2014, month: 12, day: 1), isCompleted: false)
        taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: Date.from(2014, month: 12, day: 2), isCompleted: false)]
        completedArray = [TaskModel(task:"Code", subTask:"Task Project", date: Date.from(2014, month: 1, day: 1) ,isCompleted:true)]
        baseArray = [taskArray, completedArray]
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        func sortByDate (taskOne:TaskModel, tasktwo: TaskModel) -> Bool {
//            return taskOne.date.timeIntervalSince1970 < tasktwo.date.timeIntervalSince1970
//        }
//        taskArray = taskArray.sorted(sortByDate)
        
        baseArray[0] = baseArray[0].sorted({ (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//            return countElements(taskOne.task) > countElements(taskTwo.task)
        })
        
        tableView.reloadData()
        //        if tableView.indexPathForSelectedRow() != nil {
        //            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: true)
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let TaskDetailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            //            let indexPath = sender as NSIndexPath
            let indexPath = tableView.indexPathForSelectedRow()!
            TaskDetailVC.taskModel = baseArray[indexPath.section][indexPath.row]
            TaskDetailVC.mainVC = self
        }
        else if segue.identifier == "showTaskAdd" {
            let AddTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            AddTaskVC.mainVC = self
        }
    }
    
    // UITableView Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as TaskCell
        cell.taskLabel.text = baseArray[indexPath.section][indexPath.row].task
        cell.descriptionLabel.text = baseArray[indexPath.section][indexPath.row].subTask
        cell.dateLabel.text = Date.toString(baseArray[indexPath.section][indexPath.row].date)
        if baseArray[indexPath.section][indexPath.row].isCompleted == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showTaskDetail", sender: indexPath)
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && baseArray[0].count != 0 {
            return "To Do Tasks"
        }
        else if section == 1 && baseArray[1].count != 0 {
            return "Completed Tasks"
        }
        else {
            return nil
        }
    }
    //    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return CGFloat(44)
    //    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25
//    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: !thisTask.isCompleted)
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        baseArray[abs(indexPath.section - 1)].append(newTask)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        if indexPath.section == 0 {
            return "Mark as Completed"
        }
        else {
            return "Mark as Uncompleted"
        }
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        println("AccessoryButtonTapped")
    }
    
    @IBAction func addTaskBarButtonItemPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }

}

