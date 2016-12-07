//
//  SettingsViewControllerFactory.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct SettingsViewControllerFactory {
    internal let storyboard = UIStoryboard(name: "Settings", bundle: nil)
    
    func makeNavigationController() -> UINavigationController {
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        return navigationController
    }
    
    func makeAddNewServiceViewController() -> Controller_AddNewService {
        let viewController = storyboard.instantiateViewController(withIdentifier: "addnewservice") as! Controller_AddNewService
        return viewController
    }
    
    //TODO: View Controller only in storyboard
    func makeAddNewClientViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "addnewclient")
        return viewController
    }
    
    //TODO: Make help view controller
}
