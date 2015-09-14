//
//  FileLoadingStringExtension.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/15/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/*
An extension to facilitate creating paths based on the receiving string.
*/
extension String {
  
  /*
  Appends the receiver as a path component to the path of the NSDocumentDirectory.
  
  :returns: The full path to the receiver in the NSDocumentDirectory
  */
  func pathInDocumentsDirectory() -> String {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    if let last = urls.last as? NSURL,
      documentsDirectory = last.path {
        return documentsDirectory.stringByAppendingPathComponent(self)
    }
    
    //Fall-through
    return self
  }
}