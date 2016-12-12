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
    
    var client: Client! {
        didSet {
            if let client = client {
                self.title = client.name
            }
        }
    }
    
    var innerButton: UIButton!
    
    override func viewDidLoad() {
        
        let notFaveImage = UIImage(named: "blankFavStar")
        let faveImage = UIImage(named: "Fav")
        innerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        innerButton.addTarget(self, action: #selector(self.faveButtonWasPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: innerButton)
       navigationItem.rightBarButtonItem = barButton
        
        if App.favorites.checkClientIsFavorite(client: self.client) {
            innerButton.setImage(faveImage, for: .normal)
        } else {
            innerButton.setImage(notFaveImage, for: .normal)
        }
        
        // Load the web view.
        webView.loadRequest(URLRequest(url: URL(string: client.url)!))
        
        navigationController?.title = client.name
    }
}

    // MARK: UIWEBVIEWDELEGATE
extension WebViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //self.hideActivityIndicator()
        
        let userName = client.testAccounts[0].userName
        let password = client.testAccounts[0].password
        
        
        // mService
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('userName').value = '" + userName + "';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('password').value = '" + password + "';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('secLoginBtn').click();")
        
        //mApply
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('firstName_0009').value = '" + userName + "';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('lastName_0012').value = '" + password + "';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('homeAddress_0014').value = '777 Long Ridge Rd';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('zipCode_0018').value = '06901';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('zipCode_0018').trigger();")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('emailAddr_0569').value = 'blpappchallenge@gmail.com';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('currAdd_0134').value = '10';")
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('homePhone_0021').value = '7777777777';")
    }
}

    // MARK: PRIVATE
private extension WebViewController {
    
    func makeStar() {

        
    }
    
    @objc func faveButtonWasPressed() {
        if App.favorites.checkClientIsFavorite(client: self.client) {
            App.favorites.remove(client: self.client)
            changeToNotFavoriteImage()
        } else {
            App.favorites.add(client: self.client)
            changeToFavoriteImage()
        }
    }
    
    func changeToNotFavoriteImage() {
        let notFaveImage = UIImage(named: "blankFavStar")
        innerButton.setImage(notFaveImage, for: .normal)
    }
    
    func changeToFavoriteImage() {
        let faveImage = UIImage(named: "Fav")
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
