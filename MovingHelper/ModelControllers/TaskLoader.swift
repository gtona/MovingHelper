//
//  TaskLoader.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

/*
Struct to load tasks from JSON.
*/
public struct TaskLoader {
  
  static func loadSavedTasksFromJSONFile(fileName: FileName) -> [Task]? {
    let path = fileName.jsonFileName().pathInDocumentsDirectory()
    if let data = NSData(contentsOfFile: path) {
      return tasksFromData(data)
    } else {
      return nil
    }
  }
  
  
  /**
  - returns: The stock moving tasks included with the app.
  */
  public static func loadStockTasks() -> [Task] {
    if let path = NSBundle.mainBundle()
      .pathForResource(FileName.StockTasks.rawValue, ofType: "json"),
      data = NSData(contentsOfFile: path),
      tasks = tasksFromData(data) {
        return tasks
    }
    
    //Fall through case
    NSLog("Tasks did not load!")
    return [Task]()
  }
  
  private static func tasksFromData(data: NSData) -> [Task]? {    
    do {
      let arrayOfTaskDictionaries = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [NSDictionary]
      return Task.tasksFromArrayOfJSONDictionaries(arrayOfTaskDictionaries!)
    } catch {
      return nil
    }
  }
}