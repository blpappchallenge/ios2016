//
//  Navigator.swift
//  ClientApp
//
//  Created by Trace Pomplun on 10/19/16.
//  Copyright © 2016 GPShopper. All rights reserved.
//

import Foundation
import UIKit

protocol Navigator {
    var viewController:UIViewController { get }
    
    func push<V:UIViewController>(_ viewController:V)
    func pop<V:UIViewController>(_ viewController:V)
    func present<V:UIViewController>(_ viewController:V)
}

extension Navigator {
    func push<V:UIViewController>(_ v:V) {
        viewController.navigationController?.pushViewController(v, animated: true)
    }
    
    func pop<V:UIViewController>(_ v:V) {
        _ = viewController.navigationController?.popToRootViewController(animated: true) // ? no returning pop ?
    }
    
    func present<V:UIViewController>(_ v:V) {
        viewController.navigationController?.present(v, animated: true, completion: nil)
    }
}
