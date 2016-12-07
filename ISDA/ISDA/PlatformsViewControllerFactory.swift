//
//  ClientViewControllerFactory.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct PlatformsViewControllerFactory {
    internal let storyboard = UIStoryboard(name: "Platforms", bundle: nil)

    func makePlatformsViewController(service: Service) -> Controller_Clients {
        let viewController = storyboard.instantiateViewController(withIdentifier: "platforms") as! Controller_Clients
        viewController.service = service
        return viewController
    }
}
