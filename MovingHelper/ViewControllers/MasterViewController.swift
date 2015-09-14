//
//  MasterViewController.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

//MARK: - Main view controller class
public class MasterViewController: UITableViewController {
  
  //MARK: Properties
  
  private var movingDate: NSDate?
  private var sections = [[Task]]()
  private var allTasks = [Task]() {
    didSet {
      sections = SectionSplitter.sectionsFromTasks(allTasks)
    }
  }
  
  //MARK: View Lifecycle
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = LocalizedStrings.taskListTitle
    
    movingDate = movingDateFromUserDefaults()
    if let storedTasks = TaskLoader.loadSavedTasksFromJSONFile(FileName.SavedTasks) {
      allTasks = storedTasks
    } //else case handled in view did appear
  }
  
  override public func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if allTasks.count == 0 {
      showChooseMovingDateVC()
    } //else we're already good to go.
  }
  
  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      let segueIdentifier: SegueIdentifier = SegueIdentifier(rawValue: identifier)!
      switch segueIdentifier {
      case .ShowDetailVCSegue:
        if let indexPath = self.tableView.indexPathForSelectedRow() {
          let task = taskForIndexPath(indexPath)
          (segue.destinationViewController as! DetailViewController).detailTask = task
        }
        
      case .ShowMovingDateVCSegue:
        (segue.destinationViewController as! MovingDateViewController).delegate = self
      default:
        NSLog("Unhandled identifier \(identifier)")
        //Do nothing.
      }
    }
  }
  
  //MARK: Task Handling
  
  func addOrUpdateTask(task: Task) {
    let index = task.dueDate.getIndex()
    let dueDateTasks = sections[index]
    
    var tasksWithDifferentID = filter(dueDateTasks) { $0.taskID != task.taskID }
    tasksWithDifferentID.append(task)
    tasksWithDifferentID.sort({ $0.taskID > $1.taskID })
    
    sections[index] = tasksWithDifferentID
    tableView.reloadData()
  }
  
  //MARK: IBActions
  
  @IBAction func calendarIconTapped() {
    showChooseMovingDateVC()
  }
  
  private func showChooseMovingDateVC() {
    performSegueWithIdentifier(SegueIdentifier.ShowMovingDateVCSegue.rawValue, sender: nil)
  }
  
  //MARK: File Writing
  
  private func saveTasksToFile() {
    TaskSaver.writeTasksToFile(allTasks, fileName: FileName.SavedTasks)
  }
  
  //MARK: Moving Date Handling
  
  private func movingDateFromUserDefaults() -> NSDate? {
    return NSUserDefaults.standardUserDefaults()
      .valueForKey(UserDefaultKey.MovingDate.rawValue) as? NSDate
  }
}

//MARK: - Task Updated Delegate Extension

extension MasterViewController: TaskUpdatedDelegate {
  public func taskUpdated(task: Task) {
    addOrUpdateTask(task)
    saveTasksToFile()
  }
}

//MARK: - Moving Date Delegate Extension

extension MasterViewController: MovingDateDelegate {
  public func createdMovingTasks(tasks: [Task]) {
    allTasks = tasks
    saveTasksToFile()
  }
  
  public func updatedMovingDate() {
    movingDate = movingDateFromUserDefaults()
    tableView.reloadData()
  }
}

//MARK: - Table View Data Source Extension

extension MasterViewController : UITableViewDataSource {
  
  private func taskForIndexPath(indexPath: NSIndexPath) -> Task {
    let tasks = tasksForSection(indexPath.section)
    return tasks[indexPath.row]
  }
  
  private func tasksForSection(section: Int) -> [Task] {
    let currentSection = sections[section]
    return currentSection
  }
  
  override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sections.count
  }
  
  override public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  override public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableCellWithIdentifier(TaskSectionHeaderView.cellIdentifierFromClassName()) as! TaskSectionHeaderView
    let dueDate = TaskDueDate.fromIndex(section)
    
    if let moveDate = movingDate {
      header.configureForDueDate(dueDate, moveDate: moveDate)
    }
    
    return header
  }
  
  override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let tasks = tasksForSection(section)
    return tasks.count
  }
  
  override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TaskTableViewCell.cellIdentifierFromClassName(), forIndexPath: indexPath) as! TaskTableViewCell
    let task = taskForIndexPath(indexPath)
    cell.configureForTask(task)
    
    return cell
  }
}

