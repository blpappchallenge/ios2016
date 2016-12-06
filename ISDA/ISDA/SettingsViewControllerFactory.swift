//
//  SettingsViewControllerFactory.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct SettingsViewControllerFactory: NavigationControllerFactory {
    internal let storyboard = UIStoryboard(name: "Settings", bundle: nil)
    
    func makeAddNewServiceViewController() -> Controller_AddNewService {
        let viewController = storyboard.instantiateViewController(withIdentifier: "addnewservice") as! Controller_AddNewService
        return viewController
    }
}
