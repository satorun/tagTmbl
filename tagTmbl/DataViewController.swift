//
//  DataViewController.swift
//  tagTmbl
//
//  Created by satorun on 11/9/14.
//  Copyright (c) 2014 satorun. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: NSDictionary = dataObject as? NSDictionary {
            self.dataLabel!.text = obj.description
        } else {
            self.dataLabel!.text = ""
        }
    }


}

