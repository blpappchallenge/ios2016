//
//  Controller_Settings.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//



import UIKit

class Controller_Settings: UIViewController {
    private var navigator: SettingsNavigator!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator = SettingsNavigator(viewController: self)
    }
        
    }
    
    func clearChildViews() {
        
        // Clear all of the child views if any.
        for childController in self.childViewControllers {
            
            childController.view.removeFromSuperview()
            childController.removeFromParentViewController()
        }
    }

    @IBAction func AddNewService(_ sender: Any) {
        let vc = SettingsViewControllerFactory().makeAddNewServiceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func AddNewClient(_ sender: Any) {
        navigator.goToAddNewClient()
    }
    @IBAction func Help(_ sender: Any) {
        navigator.goToHelp()
    }
}




