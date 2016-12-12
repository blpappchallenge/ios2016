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
    
    func goToAddNewClient(nativeService: Service, image: UIImage) {
        let vc = factory.makeAddNewClientViewController()
        vc.nativeService = nativeService
        vc.nativeImage = image
        vc.selectedService = nativeService
        push(vc)
    }
    
    func goToAddNewClient(webService: Service, image: UIImage) {
        let vc = factory.makeAddNewClientViewController()
        vc.webService = webService
        vc.webImage = image
        vc.selectedService = webService
        push(vc)
    }
    func goToHelp() {
        let vc = factory.makeHelpViewController()
        push(vc)
    }
}
