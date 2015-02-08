//
//  ViewController.swift
//  TaskIt
//
//  Created by Zac on 31/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, TaskDetailViewControllerDelegate, AddTaskViewControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let taskDetailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = tableView.indexPathForSelectedRow()!
            taskDetailVC.taskModel = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
            taskDetailVC.delegate = self
        }
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.delegate = self
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
        let task = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.subtask
        cell.dateLabel.text = Date.toString(task.date)
        if task.isCompleted == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if fetchedResultsController.sections!.count == 2 {
            if section == 0 {
                return "To Do Tasks"
            }
            else {
                return "Completed Tasks"
            }
        }
        else {
            if fetchedResultsController.fetchedObjects![0].isCompleted == false {
                return "To Do Tasks"
            }
            else {
                return "Completed Tasks"
            }
            
        }
        
//        var sectionInfo = fetchedResultsController.sections![0].name
//        if sectionInfo == "0" {
//            return "To Do Tasks"
//        }
//        else {
//                return "Completed Tasks"
//        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        thisTask.isCompleted = !thisTask.isCompleted
       (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        if fetchedResultsController.sections!.count == 2 {
            if indexPath.section == 0 {
                return "Mark as Completed"
            }
            else {
                return "Mark as Uncompleted"
            }
        }
        else if fetchedResultsController.fetchedObjects![0].isCompleted == false {
            return "Mark as Completed"
        }
        else {
            return "Mark as Uncompleted"
        }
    }

    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        println("AccessoryButtonTapped")
    }

    //Helper
    func taskFetchRequest() -> NSFetchRequest {
        let fetcheRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "isCompleted", ascending: true)
        fetcheRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        return fetcheRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "isCompleted", cacheName: nil)
        return fetchedResultsController
    }
    // NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    //MARK: - TaskDetailViewController Delegate
    func taskDetailEdited() {
        println("Task Detail Edited")
    }
    //MARK: - AddTaskViewController Delegate
    func addTask(message: String) {
        self.showAlert(message: message)
    }
    func addTaskCanceled(message: String) {
        self.showAlert(message: message)
    }
    //MARK: - Helper
    func showAlert(message: String = "Congratulations!") {
        var alert = UIAlertController(title: "Change Model!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    //MARK: - IBActions
    
    @IBAction func addTaskBarButtonItemPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
}

