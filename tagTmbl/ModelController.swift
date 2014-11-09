//
//  ModelController.swift
//  tagTmbl
//
//  Created by satorun on 11/9/14.
//  Copyright (c) 2014 satorun. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var results : NSArray = [["post_url":"http://yahoo.co.jp"]]

    override init() {
        super.init()
        // Create the data model.
        let dateFormatter = NSDateFormatter()
        //var model : taggedModel = taggedModel()
        //model.request()
        
        TMAPIClient.sharedInstance().tagged("cat", parameters: nil) { (results : AnyObject!, error : NSError!) -> Void in
            self.results = results as NSArray
            NSLog("%@", self.results)
            NSNotificationCenter.defaultCenter().postNotificationName("apiRequestDoneNotification", object: nil, userInfo: nil)
        }
            
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.results.count == 0) || (index >= self.results.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as DataViewController
        dataViewController.dataObject = self.results[index]
        return dataViewController
    }

    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return self.results.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.results.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

