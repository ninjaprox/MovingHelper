//
//  DetailViewController.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  //MARK: Properties
  //    @IBOutlet weak var editSaveButton: UIBarButtonItem!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var doneCheckbox: Checkbox!
  @IBOutlet weak var daysRemainingLabel: UILabel!
  @IBOutlet weak var dueDatePicker: UIPickerView!
  @IBOutlet weak var notesTextView: UITextView!
  
  var detailTask: Task?
  var moveDate: NSDate!
  var inEditMode = false {
    didSet {
      if (inEditMode) {
        titleTextField.borderStyle = .Bezel
        notesTextView.layer.borderWidth = 1
        notesTextView.editable = false
        titleTextField.enabled = false
      } else {
        titleTextField.enabled = true
        notesTextView.editable = true
        titleTextField.borderStyle = .None
        notesTextView.layer.borderWidth = 0
      }
    }
  }
  
  //MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    moveDate = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultKey.MovingDate.rawValue) as! NSDate
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    configureForCurrentTask()
  }
  
  //MARK: IBActions
  
  @IBAction func checkboxToggled() {
    detailTask!.done = !detailTask!.done
  }
  
  //MARK: Task-based UI updates
  
  private func configureForCurrentTask() {
    if let task: Task = detailTask {
      title = task.title
      titleTextField.text = task.title
      doneCheckbox.isChecked = task.done
      dueDatePicker.selectRow(task.dueDate.getIndex(),
        inComponent: 0,
        animated: true)
      updateFromDueDate(task.dueDate)
      
      notesTextView.text = task.notes
    } else {
      title = LocalizedStrings.editTitle
      inEditMode = true
    }
  }
  
  //MARK: Due Date-based UI updates
  private func updateFromDueDate(dueDate: TaskDueDate) {
    daysRemainingLabel.text = dueDate.daysFromDueDate(moveDate)
    if dueDate.isOverdueForMoveDate(moveDate) {
      daysRemainingLabel.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
    } else {
      daysRemainingLabel.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
    }
  }
}

//MARK: - UIPickerView Data Source Extension

extension DetailViewController: UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 6
  }
}

//MARK: - UIPickerView Delegate Extension

extension DetailViewController: UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return TaskDueDate.fromIndex(row).getTitle()
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let dueDate = TaskDueDate.fromIndex(row)
    updateFromDueDate(dueDate)
  }
}

