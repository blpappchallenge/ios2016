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
                self.title = client.name
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
    
    var account:TestAccount! {
        didSet {
            enterCredentials()
        }
    }
    
    var innerButton: UIButton!
    
    override func viewDidLoad() {
        
        let notFaveImage = UIImage(named: "blankFavStar")
        let faveImage = UIImage(named: "FavStar")
        innerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        innerButton.addTarget(self, action: #selector(self.faveButtonWasPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: innerButton)
       navigationItem.rightBarButtonItem = barButton
        
        if App.favorites.checkClientIsFavorite(id: "clientId") {
            innerButton.setImage(faveImage, for: .normal)
        } else {
            innerButton.setImage(notFaveImage, for: .normal)
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
    
    func makeStar() {

        
    }
    
    @objc func faveButtonWasPressed() {
        if App.favorites.checkClientIsFavorite(id: "clientId") {
            App.favorites.remove(id: "clientId")
            changeToNotFavoriteImage()
        } else {
            App.favorites.add(id: "clientId")
            changeToFavoriteImage()
        }
    }
    
    func changeToNotFavoriteImage() {
        let notFaveImage = UIImage(named: "blankFavStar")
        innerButton.setImage(notFaveImage, for: .normal)
    }
    
    func changeToFavoriteImage() {
        let faveImage = UIImage(named: "FavStar")
        innerButton.setImage(faveImage, for: .normal)
    }
    
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
