//
//  TaskModel.swift
//  TaskIt
//
//  Created by Zac on 3/02/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)

class TaskModel: NSManagedObject {

    @NSManaged var task: String
    @NSManaged var subtask: String
    @NSManaged var date: NSDate
    @NSManaged var isCompleted: Bool

}
