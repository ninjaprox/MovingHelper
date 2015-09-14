//
//  LocalizedStrings.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/**
Helper structure to centralize localized strings.
*/
struct LocalizedStrings {
  
  //MARK: VC titles
  
  static let taskListTitle = NSLocalizedString("Task List",
    comment: "Title for task list VC")
  static let whenMovingTitle = NSLocalizedString("When Are You Moving?",
    comment: "Title for when moving vc")
  static let editTitle = NSLocalizedString("Edit Task", comment: "Title for edit mode in task detail VC")
  
  //MARK: List VC
  static let addButtonTitle = NSLocalizedString("Add",
    comment: "Title for add new task button")
  
  static let oneMonthBefore = NSLocalizedString("One Month Before Moving",
    comment: "Title for section of items due one month before moving")
  static let oneWeekBefore = NSLocalizedString("One Week Before Moving",
    comment: "Title for section of items due one week before moving")
  static let oneDayBefore = NSLocalizedString("One Day Before Moving",
    comment: "Title for section of items due one week before moving")
  static let oneDayAfter = NSLocalizedString("One Day After Moving",
    comment: "Title for section of items due one day after moving")
  static let oneWeekAfter = NSLocalizedString("One Week After Moving",
    comment: "Title for section of items due one day after moving")
  static let oneMonthAfter = NSLocalizedString("One Month After Moving",
    comment: "Title for section of items due one month after moving")
  
  
  //MARK: Task Detail VC
  
  //MARK: When moving VC
  static let createTasks = NSLocalizedString("Create Tasks",
    comment: "Title for create tasks button")
  static let updateDate = NSLocalizedString("Update Move Date",
    comment: "Title for update move date button")
  
  //MARK: Time formats
  static let daysLeftFormat = NSLocalizedString("(%d days left)",
    comment: "Format for how many days are left before something happens, with placeholder for days")
  static let daysAgoFormat = NSLocalizedString("(%d days ago)",
    comment: "Format for how many days ago something should have happened, with placeholder for days")
}