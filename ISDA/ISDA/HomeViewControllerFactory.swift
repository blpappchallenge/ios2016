//
//  HomeViewControllerFactory.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct HomeViewControllerFactory: NavigationControllerFactory {
    internal let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
}
