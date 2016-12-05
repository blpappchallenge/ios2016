//
//  Controller_Settings.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//



import UIKit

class Controller_Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clearChildViews()
    }
    
    func showChildController(controllerName: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: controllerName)
        //let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController?.pushViewController(viewController, animated: true)
        
//        self.addChildViewController(viewController)
//        view.addSubview(viewController.view)
//        viewController.view.frame = view.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        viewController.didMove(toParentViewController: self)
    }
    
    func clearChildViews() {
        
        // Clear all of the child views if any.
        for childController in self.childViewControllers {
            
            childController.view.removeFromSuperview()
            childController.removeFromParentViewController()
        }
    }

    @IBAction func AddNewService(_ sender: Any) {
        showChildController(controllerName: "addnewservice")
    }
    @IBAction func AddNewClient(_ sender: Any) {
        
    }
    @IBAction func Help(_ sender: Any) {
        
    }
}




