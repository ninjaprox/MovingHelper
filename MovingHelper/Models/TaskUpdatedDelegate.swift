//
//  TaskUpdatedDelegate.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/15/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

public protocol TaskUpdatedDelegate {
  /**
  Called whenever any task is updated.
  
  :param: task The updated task.
  */
  func taskUpdated(task: Task)
}