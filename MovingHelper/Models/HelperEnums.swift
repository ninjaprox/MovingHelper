//
//  HelperEnums.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/14/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

/**
A file to store Enums which help prevent the use of hard-coded strings.
*/

import Foundation

enum SegueIdentifier: String {
  case ShowMovingDateVCSegue = "ShowMovingDateVC",
  ShowDetailVCSegue = "ShowDetailVC",
  ShowAddVCSegue = "ShowAddVC"
}

public enum UserDefaultKey: String {
  case MovingDate = "com.razeware.movinghelper.movingdate",
  LastAddedTaskID = "com.razeware.movinghelper.lastaddedtaskid"
  
  public static func resetAll() {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.removeObjectForKey(MovingDate.rawValue)
    defaults.removeObjectForKey(LastAddedTaskID.rawValue)
    defaults.synchronize()
  }
}

public enum TaskJSONKey: String {
  case TaskID = "task_id",
  Title = "title",
  Notes = "notes",
  DueDate = "due_date",
  Done = "done"
}

public enum FileName: String {
  case StockTasks = "stock_tasks",
  SavedTasks = "saved_tasks"
  
  func jsonFileName() -> String {
    return rawValue + ".json"
  }
}