//
//  TodayViewController.swift
//  TestWidget
//
//  Created by Zack on 11/10/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let defaults = UserDefaults.init(suiteName: "group.com.synchrony.test")
        
        lblUsername.text = defaults?.value(forKey: "username") as! String?
        lblPassword.text = defaults?.value(forKey: "password") as! String?
        
        
        
        //print(defaults.value(forKey: "username"))
        //print(defaults.value(forKey: "password"))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func btnCopyUsername_Click(_ sender: UIButton) {
        let defaults = UserDefaults.init(suiteName: "group.com.synchrony.test")
        
        UIPasteboard.general.string = defaults?.value(forKey: "username") as! String?
    }
    
    @IBAction func btnCopyPassword_Click(_ sender: UIButton) {
        let defaults = UserDefaults.init(suiteName: "group.com.synchrony.test")
        
        UIPasteboard.general.string = defaults?.value(forKey: "password") as! String?
    }
    
}
