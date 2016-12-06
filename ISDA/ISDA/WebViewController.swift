//
//  WebViewController.swift
//  ClientApp
//
//  Created by Trace Pomplun on 1/18/16.
//  Copyright © 2016 GPShopper. All rights reserved.
//

import Foundation
import UIKit

class WebViewController : UIViewController {
    
    @IBOutlet fileprivate weak var webView: UIWebView!
    
    var client: Client? {
        didSet {
            if let client = client {
                
            }
        }
    }
    
    var url:URL? {
        didSet {
            if let url = url {
                loadRequest(prepareRequest(url))
            }
        }
    }
    
    var account:Account! {
        didSet {
            enterCredentials()
        }
    }
}

    // MARK: UIWEBVIEWDELEGATE
extension WebViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //self.hideActivityIndicator()
    }
}

    // MARK: PRIVATE
private extension WebViewController {
    
    func prepareRequest(_ url:URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    func loadRequest(_ request:URLRequest) {
        //self.showActivityIndicator()
        webView.loadRequest(request)
    }
    
    func enterCredentials() {
        
    }
}
