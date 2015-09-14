//
//  MovingDateViewController.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

public protocol MovingDateDelegate {
  func createdMovingTasks(tasks: [Task])
  func updatedMovingDate()
}

/**
VC to use to select a moving date.
*/
class MovingDateViewController: UIViewController {
  
  @IBOutlet weak var whenMovingDatePicker: UIDatePicker!
  @IBOutlet weak var whenMovingLabel: UILabel!
  @IBOutlet weak var daysLeftLabel: UILabel!
  @IBOutlet weak var createTasksButton: UIButton!
  var updatingDate = false
  var delegate: MovingDateDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Localize strings
    whenMovingLabel.text = LocalizedStrings.whenMovingTitle
    
    whenMovingDatePicker.minimumDate = NSDate.startOfToday()
    
    if let movingDate = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultKey.MovingDate.rawValue) as? NSDate {
      whenMovingDatePicker.date = movingDate
      createTasksButton.setTitle(LocalizedStrings.updateDate, forState: .Normal)
    } else {
      whenMovingDatePicker.date = twoMonthsFromToday()
      createTasksButton.setTitle(LocalizedStrings.createTasks,
        forState: .Normal)
    }
    
    datePickerChanged()
  }
  
  //MARK: Date helpers
  
  func twoMonthsFromToday() -> NSDate {
    let currentCalendar = NSCalendar.currentCalendar()
    
    let today = NSDate.startOfToday()
    let twoMonths = NSDateComponents()
    twoMonths.month = 2
    let updatedDate = currentCalendar.dateByAddingComponents(twoMonths,
      toDate: today,
      options: .allZeros)
    return updatedDate!
  }
  
  //MARK: IBActions
  
  @IBAction func datePickerChanged() {
    let updatedDate = whenMovingDatePicker.date.startOfDay()
    let today = NSDate.startOfToday()
    
    let components = NSCalendar.currentCalendar().components(.CalendarUnitDay,
      fromDate: today,
      toDate: updatedDate,
      options: nil)
    
    daysLeftLabel.text = NSString(format: LocalizedStrings.daysLeftFormat, components.day) as String
  }
  
  @IBAction func createTasks() {
    let updatedDate = whenMovingDatePicker.date.startOfDay()
    
    if !updatingDate {
      //If we're not updating the date, this is a new set of tasks and we should load the stock task.
      let tasks = TaskLoader.loadStockTasks()
      delegate?.createdMovingTasks(tasks)
    }
    
    //In any case, we should update the moving date and notify the delegate it was updated.
    NSUserDefaults.standardUserDefaults().setObject(updatedDate, forKey: UserDefaultKey.MovingDate.rawValue)
    NSUserDefaults.standardUserDefaults().synchronize()
    delegate?.updatedMovingDate()
    
    dismissViewControllerAnimated(true, completion: nil)
  }
}