//
//  PlatformsNavigator.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

struct PlatformsNavigator: Navigator {
    let viewController: UIViewController
    let webFactory = WebViewControllerFactory()
    
    func goToWebView(forClient client: Client) {
        let webViewController = webFactory.makeWebViewController(withClient:client)
        push(webViewController)
    }
}
