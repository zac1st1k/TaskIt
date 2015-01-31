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
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: "01/14/2014")
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: "01/14/2014")
        taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: "01/14/2014")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.dateLabel.text = taskArray[indexPath.row].date
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

