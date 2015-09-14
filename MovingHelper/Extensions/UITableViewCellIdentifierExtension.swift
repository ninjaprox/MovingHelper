//
//  UITableViewCellIdentifierExtension.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/20/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

/**
An extension to allow easy use of UITableViewCell identifiers that are
the same as the name of the class.
*/
public extension UITableViewCell {
  
  /**
  :returns: The cell identifier based on the class's name, but not tied
  to the project bundle. A class of FooTableViewCell would return "FooTableViewCell" as the identifier.
  */
  public static func cellIdentifierFromClassName() -> String {
    let classString = NSStringFromClass(self)
    
    //This grabs a string that is [project name].[class name]
    
    let pieces = classString.componentsSeparatedByString(".")
    
    if pieces.count == 2 {
      return pieces[1]
    } else {
      //Return the full string.
      return classString
    }
  }
}