//
//  ExtensionTests.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/20/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//


import UIKit
import XCTest
import MovingHelper

class ExtensionTests: XCTestCase {
  
  //MARK: Dictionary
  
  func testDictionarySafeString() {
    let goodKey = "good_key"
    let badKey = "bad_key"
    let goodValue = "good_value"
    
    let dict = [ goodKey : goodValue ] as NSDictionary
    
    let retrievedGoodValue = dict.safeString(goodKey)
    XCTAssertEqual(retrievedGoodValue, goodValue, "Did not retrieve expected value for valid key!")
    
    let retrievedBadValue = dict.safeString(badKey)
    XCTAssertEqual(retrievedBadValue, "", "Did not retrieve default value for invalid key!")
  }
  
  func testDictionarySafeInt() {
    let goodKey = "good_key"
    let goodNegativeKey = "good_negative_key"
    let badKey = "bad_key"
    let goodValue = 3
    let goodNegativeValue = -2340
    
    let dict = [ goodKey: goodValue,
      goodNegativeKey: goodNegativeValue ] as NSDictionary
    
    let retrievedGoodValue = dict.safeInt(goodKey)
    XCTAssertEqual(retrievedGoodValue, goodValue, "Did not retrieve expected value for valid key!")
    
    let retrievedNegativeValue = dict.safeInt(goodNegativeKey)
    XCTAssertEqual(retrievedNegativeValue, goodNegativeValue, "Did not retrieve expected negative value for valid key!")
    
    let retrievedBadValue = dict.safeInt(badKey)
    XCTAssertEqual(retrievedBadValue, 0, "Did not retrieve default value for invalid key!")
    
  }
  
  func testDictionarySafeBool() {
    let goodKey = "good_key"
    let goodFalseKey = "good_negative_key"
    let goodNullKey = "good_null_key"
    let badKey = "bad_key"
    let goodValue = true
    let goodFalseValue = false
    let goodNullValue = NSNull()
    
    let dict = [ goodKey: goodValue,
      goodFalseKey: goodFalseValue,
      goodNullKey: goodNullValue] as NSDictionary
    
    let retrievedGoodValue = dict.safeBoolean(goodKey)
    XCTAssertEqual(retrievedGoodValue, goodValue, "Did not retrieve expected value for valid key!")
    
    let retrievedGoodFalseValue = dict.safeBoolean(goodFalseKey)
    XCTAssertEqual(retrievedGoodFalseValue, goodFalseValue, "Did not retrieve expected value for false valid key!")
    
    let retrievedGoodNullValue = dict.safeBoolean(goodNullKey)
    XCTAssertEqual(retrievedGoodNullValue, false, "Did not retrieve expected value for null valid key!")
    
    let retrievedBadValue = dict.safeBoolean(badKey)
    XCTAssertEqual(retrievedBadValue, false, "Did not retrieve default value for invalid key!")
  }
  
  //MARK: UITableViewCell
  
  func testCellIdentifierExtension() {
    let taskCellIdentifier = TaskTableViewCell.cellIdentifierFromClassName()
    XCTAssertEqual(taskCellIdentifier, "TaskTableViewCell", "Cell identifier did not properly strip the package name!")
    
    let taskHeaderCellIdentifier = TaskSectionHeaderView.cellIdentifierFromClassName()
    XCTAssertEqual(taskHeaderCellIdentifier, "TaskSectionHeaderView", "Cell identifier did not properly strip the package name!")
  }
}