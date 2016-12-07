//
//  SettingsNavigator.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

struct SettingsNavigator: Navigator {
    let viewController: UIViewController
    let factory = SettingsViewControllerFactory()
    
    func goToAddNewService() {
        let vc = factory.makeAddNewServiceViewController()
        push(vc)
    }
    
    func goToAddNewClient() {
        let vc = factory.makeAddNewClientViewController()
        push(vc)
    }
    
    func goToHelp() {
        
        
    }
}
