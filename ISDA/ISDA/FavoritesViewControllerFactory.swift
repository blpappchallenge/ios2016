//
//  FavoritesViewControllerFactory.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct FavoritesViewControllerFactory {
    internal let storyboard: UIStoryboard = UIStoryboard(name: "Favorites", bundle: nil)
    
    func makeNavigationController() -> UINavigationController {
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        return navigationController
    }
}
