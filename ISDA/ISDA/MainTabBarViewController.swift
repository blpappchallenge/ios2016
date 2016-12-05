//
//  MainTabBarController.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        self.setup()
    }
}

private extension MainTabBarViewController {
    
    func setup() {
        self.viewControllers = self.makeRootNavigationControllers()
    }
    
    func makeRootNavigationControllers() -> [UINavigationController] {
        //home favorites settings search
        return [HomeViewControllerFactory().makeNavigationController(),
                FavoritesViewControllerFactory().makeNavigationController(),
                SettingsViewControllerFactory().makeNavigationController(),
                SearchViewControllerFactory().makeNavigationController()]
    }
}
