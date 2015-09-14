//
//  TaskTableViewCell.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/9/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

public class TaskTableViewCell: UITableViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var notesLabel: UILabel!
  @IBOutlet public var checkbox: Checkbox!
    
    var currentTask: Task?
    public var delegate: TaskUpdatedDelegate?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.currentTask = nil
        self.delegate = nil
    }
  
  public func configureForTask(task: Task) {
    self.currentTask = task
    titleLabel.text = task.title
    notesLabel.text = task.notes
    configureForDoneState(task.done)
  }
  
  func configureForDoneState(done: Bool) {
    checkbox.isChecked = done
    if done {
      backgroundColor = .lightGrayColor()
      titleLabel.alpha = 0.5
      notesLabel.alpha = 0.5
    } else {
      backgroundColor = .whiteColor()
      titleLabel.alpha = 1
      notesLabel.alpha = 1
    }
  }
  
  @IBAction func tappedCheckbox() {
    configureForDoneState(!checkbox.isChecked)
    if let task = currentTask {
        task.done = checkbox.isChecked
        delegate?.taskUpdated(task)
    }
  }
}