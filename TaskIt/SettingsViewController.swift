//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Zac on 7/02/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var capitalizedTableView: UITableView!
    @IBOutlet weak var completeNewTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        capitalizedTableView.delegate = self
        capitalizedTableView.dataSource = self
        capitalizedTableView.scrollEnabled = false
        completeNewTableView.delegate = self
        completeNewTableView.dataSource = self
        completeNewTableView.scrollEnabled = false
        
        versionLabel.text = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonTapped:"))
        navigationItem.leftBarButtonItem = doneButton
        
        if NSUserDefaults.standardUserDefaults().boolForKey("loadOnce") == false {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loadOnce")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isCapitalized")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isCompleted")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Table View Datasouce 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == capitalizedTableView {
            var capitalizeCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizedCell", forIndexPath: indexPath) as UITableViewCell
            if indexPath.row == 0 {
                capitalizeCell.textLabel?.text = "Do Not capitalize"
                if NSUserDefaults.standardUserDefaults().boolForKey("isCapitalized") == false {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                capitalizeCell.textLabel?.text = "Yes, Capitalize!"
                if NSUserDefaults.standardUserDefaults().boolForKey("isCapitalized") == true {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return capitalizeCell
        } else {
            var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
            if indexPath.row == 0 {
                cell.textLabel?.text = "Do Not Complete New Task"
                if NSUserDefaults.standardUserDefaults().boolForKey("isCompleted") == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                cell.textLabel?.text = "Yes, Complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey("isCompleted") == true{
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == capitalizedTableView {
            return "Captitalize new Task?"
        }
        else {
            return "Complete new Task?"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == capitalizedTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isCapitalized")
            }
            else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isCapitalized")
            }
        }
        else {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isCompleted")
            }
            else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isCompleted")
            }
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    func doneBarButtonTapped (barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}