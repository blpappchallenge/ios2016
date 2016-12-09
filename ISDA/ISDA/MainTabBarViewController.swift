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
    
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var TabBar: UITabBar!
    
    override func viewDidLoad() {
    self.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
    self.TabBar.tintColor = UIColor(red: 0xFF, green: 0xC6, blue: 0x00, alpha: 1)
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
