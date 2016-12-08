//
//  WebViewControllerFactory.swift
//  ClientApp
//
//  Created by Matt Wylder on 11/4/16.
//  Copyright © 2016 GPShopper. All rights reserved.
//

import Foundation
import UIKit

struct WebViewControllerFactory {
    private let storyboard = UIStoryboard(name: "Web", bundle: nil)
    
    func makeWebViewController(withClient client:Client) -> WebViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "webViewController") as! WebViewController
        viewController.client = client
        
        return viewController
    }
}
