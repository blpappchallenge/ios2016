//
//  Controller_WebView.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_WebView: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var client = Client()
    var accountType = ""
    var userName = ""
    var password = ""
    var branch = ""
    var url = ""
    var loginMethod = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        webView.delegate = self
//        url = url.replacingOccurrences(of: "#branch", with: branch)
//        url = url.replacingOccurrences(of: "#clientID", with: service.clientID)
//        url = url.replacingOccurrences(of: "#accountType", with: accountType)
//        webView.loadRequest(URLRequest(url: URL(string: url)!))
//        
//        // Set up the long pressure gesture recognizer.
//        let longGesture = UILongPressGestureRecognizer(target: self, action: Selector(("longTap:")))
//        webView.addGestureRecognizer(longGesture)
    }

    func longTap(sender: UIGestureRecognizer) {
        print("Long tap")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRequest() {
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        //********Abstract this out into the JSON file at some point**********//
        // Insert the username and password, then click the login button.
        // This varies depending on the service.
//        if (loginMethod == "Automatic")
//        {
//            if (service.gen == 5)
//            {
//                webView.stringByEvaluatingJavaScript(from: "document.getElementById('userName').value = '" + userName + "';")
//                webView.stringByEvaluatingJavaScript(from: "document.getElementById('password').value = '" + password + "';")
//                webView.stringByEvaluatingJavaScript(from: "document.getElementById('secLoginBtn').click();")
//            }
//            else if (service.gen == 4)
//            {
//                webView.stringByEvaluatingJavaScript(from: "document.getElementById('username').value = '" + userName + "';")
//                webView.stringByEvaluatingJavaScript(from: "document.getElementById('login1').click();")
//                webView.stringByEvaluatingJavaScript(from: "document.getElementById('passwordLogin').value = '" + password + "';")
//            }
//        }
    }
}

