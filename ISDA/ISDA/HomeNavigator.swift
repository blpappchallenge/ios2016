//
//  MainNavigator.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct HomeNavigator:Navigator {
    let viewController:UIViewController
    let platformsFactory = PlatformsViewControllerFactory()
    
    func goToPlatformsViewController(withService service: Service) {
        let platformsViewController = platformsFactory.makePlatformsViewController(service: service)
        platformsViewController.generations = service.generations
        push(platformsViewController)
    }
}
