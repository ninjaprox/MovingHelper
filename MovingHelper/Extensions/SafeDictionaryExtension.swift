//
//  SafeDictionaryExtension.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/**
An extension to facilitate getting type-safe data out of an NSDictionary.

Inspired by Erica Sadun and Mike Ash (though for some reason I can't get
this to work with subscript):
http://ericasadun.com/2015/06/01/swift-safe-array-indexing-my-favorite-thing-of-the-new-week/
*/
public extension NSDictionary {
  
  /**
  Checks a dictionary for a value for a given key, and returns either its
  String value or an empty string.
  
  :param: key: The key to use to check the dictionary
  :returns: The found string, or an empty string if it was not found.
  */
  public func safeString(key: String) -> String {
    //Is there a value for the key?
    if let item: AnyObject = self[key] {
      //Is that value a string?
      if let string = item as? String {
        return string
      }
    }
    
    //Fall-through case
    return ""
  }
  
  /**
  Checks a dictionary for a value for a given key, and returns either its
  integer value or zero.
  
  :param: key: The key to use to check the dictionary
  :returns: The found number, or zero if it was not found.
  */
  public func safeInt(key: String) -> Int {
    //Is there a value for the key?
    if let item: AnyObject = self[key] {
      if let number = item as? NSNumber {
        return number.integerValue
      }
    }
    
    return 0
  }
  
  /**
  Checks a dictionary for a value for a given key, and returns either its
  boolean value or false.
  
  :param: key: The key to use to check the dictionary
  :returns: The found boolean value, or false if it was not found.
  */
  public func safeBoolean(key:String) -> Bool {
    //Is there a value for the key?
    if let item: AnyObject = self[key] {
      if let number = item as? NSNumber {
        return number.boolValue
      }
    }
    
    //Fall-through case
    return false
  }
  
}

