//
//  loginViewController.swift
//  tagTmbl
//
//  Created by satorun on 11/9/14.
//  Copyright (c) 2014 satorun. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    let tmblOAuthTokenKey = "tmblOAuthToken"
    let tmblOAuthSecretKey = "tmblOAuthSecret"
    
    var client :TMAPIClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        
    }
    
    
    
    func login() {
        client!.authenticate("tagtmbl", callback: { (error : NSError!) -> Void in
            if (error == nil) {
                let ud : NSUserDefaults = NSUserDefaults.standardUserDefaults()
                ud.setObject(self.client!.OAuthToken, forKey: self.tmblOAuthTokenKey)
                ud.setObject(self.client!.OAuthTokenSecret, forKey: self.tmblOAuthSecretKey)
                ud.synchronize()
                
                self.performSegueWithIdentifier("login", sender: nil);
            }
        })
    }
    
    func isLogin() -> Bool {
        let ud : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var token : NSString? = ud.stringForKey(self.tmblOAuthTokenKey)
        var secret : NSString? = ud.stringForKey(self.tmblOAuthSecretKey)
        if(token != nil && secret != nil) {
            self.client!.OAuthToken = token
            self.client!.OAuthTokenSecret = secret
            
            return true
        }
        return false
    }
    
    @IBAction func tapLogin(sender: AnyObject) {
        self.client = TMAPIClient.sharedInstance()
        
        if (self.isLogin()) {
            self.performSegueWithIdentifier("login", sender: nil);
        } else {
            login()
        }
    }
    
}
