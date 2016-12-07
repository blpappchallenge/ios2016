//
//  Controller_Settings.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//



import UIKit

class Controller_Settings: UIViewController {
    private var navigator: SettingsNavigator!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator = SettingsNavigator(viewController: self)
    }

    @IBAction func AddNewService(_ sender: Any) {
        navigator.goToAddNewService()
    }
    @IBAction func AddNewClient(_ sender: Any) {
        navigator.goToAddNewClient()
    }
    @IBAction func Help(_ sender: Any) {
        navigator.goToHelp()
    }
}
