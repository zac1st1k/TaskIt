//
//  ViewController.swift
//  TaskIt
//
//  Created by Zac on 31/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    
//    var taskArray:[TaskModel] = []
//    var completedArray:[TaskModel] = []
//    var baseArray:[[TaskModel]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd-MM-yyyy"
        
//        let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: Date.from(2014, month: 12, day: 3), isCompleted: false)
//        let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: Date.from(2014, month: 12, day: 1), isCompleted: false)
//        taskArray = [task1, task2, TaskModel(task: "Gym", subtask: "Leg Day", date: Date.from(2014, month: 12, day: 2), isCompleted: false)]
//        completedArray = [TaskModel(task:"Code", subtask:"Task Project", date: Date.from(2014, month: 1, day: 1) ,isCompleted:true)]
//        baseArray = [taskArray, completedArray]
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
            TaskDetailVC.taskModel = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
//            TaskDetailVC.mainVC = self
        }
        else if segue.identifier == "showTaskAdd" {
            let AddTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
//            AddTaskVC.mainVC = self
        }
    }
    
    // UITableView Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as TaskCell
        var task = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.subtask
        cell.dateLabel.text = Date.toString(task.date)
        if task.isCompleted == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
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
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
//        var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: !thisTask.isCompleted)
        thisTask.isCompleted = !thisTask.isCompleted
//        baseArray[indexPath.section].removeAtIndex(indexPath.row)
//        baseArray[abs(indexPath.section - 1)].append(newTask)
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
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
    //Helper
    func taskFetchRequest() -> NSFetchRequest {
        let fetcheRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetcheRequest.sortDescriptors = [sortDescriptor]
        return fetcheRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    // NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }

}

