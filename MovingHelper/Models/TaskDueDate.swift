//
//  TaskDueDate.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/14/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

public enum TaskDueDate: String {
  case OneMonthBefore = "month_before",
  OneWeekBefore = "week_before",
  OneDayBefore = "day_before",
  OneDayAfter = "day_after",
  OneWeekAfter = "week_after",
  OneMonthAfter = "month_after"
  
  static func fromIndex(index: Int) -> TaskDueDate {
    switch index {
    case 0:
      return OneMonthBefore
    case 1:
      return OneWeekBefore
    case 2:
      return OneDayBefore
    case 3:
      return OneDayAfter
    case 4:
      return OneWeekAfter
    case 5:
      return OneMonthAfter
    default:
      assert(false, "Unexpected index for task due date: \(index)")
    }
  }
  
  func getIndex() -> Int {
    switch self {
    case .OneMonthBefore:
      return 0
    case .OneWeekBefore:
      return 1
    case .OneDayBefore:
      return 2
    case .OneDayAfter:
      return 3
    case .OneWeekAfter:
      return 4
    case .OneMonthAfter:
      return 5
    }
  }
  
  func getTitle() -> String {
    switch self {
    case .OneMonthBefore:
      return LocalizedStrings.oneMonthBefore
    case .OneWeekBefore:
      return LocalizedStrings.oneWeekBefore
    case .OneDayBefore:
      return LocalizedStrings.oneDayBefore
    case .OneDayAfter:
      return LocalizedStrings.oneDayAfter
    case .OneWeekAfter:
      return LocalizedStrings.oneWeekAfter
    case .OneMonthAfter:
      return LocalizedStrings.oneMonthAfter
    }
  }
  
  public func isOverdueForMoveDate(moveDate: NSDate) -> Bool {
    let taskDueDate = dueDateForMoveDate(moveDate)
    
    return taskDueDate.compare(NSDate.startOfToday()) == NSComparisonResult.OrderedAscending
  }
  
  func dueDateForMoveDate(moveDate: NSDate) -> NSDate {
    let components = NSDateComponents()
    switch self {
    case .OneMonthBefore:
      components.month = -1
    case .OneWeekBefore:
      components.day = -7
    case .OneDayBefore:
      components.day = -1
    case .OneDayAfter:
      components.day = 1
    case .OneWeekAfter:
      components.day = 7
    case .OneMonthAfter:
      components.month = 1
    }
    
    return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: moveDate, options: .allZeros)!
  }
  
  public func daysFromDueDate(moveDate: NSDate) -> String {
    let taskDueDate = dueDateForMoveDate(moveDate)
    
    let components = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay,
      fromDate: NSDate.startOfToday(),
      toDate: taskDueDate,
      options: .allZeros)
    
    let daysLeft = components.day
    if daysLeft >= 0 {
      return NSString(format: LocalizedStrings.daysLeftFormat, daysLeft) as String
    } else {
      return NSString(format: LocalizedStrings.daysAgoFormat, abs(daysLeft)) as String
    }
  }
}