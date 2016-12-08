//
//  Controller_AddNewClient.swift
//  ISDA
//
//  Created by Jason  on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class Controller_AddNewClient: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var selectedService: Service?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didPressSelectService(_ sender: Any) {
        let serviceViewController = SettingsViewControllerFactory().makeSelectServiceViewController(completion:self.handleServiceSelected)
        self.navigationController?.pushViewController(serviceViewController, animated: true)
        
    }
    
    @IBAction func didPressSubmit(_ sender: Any) {
        
    }
    
    func handleServiceSelected(service:Service) {
        let id = idTextField.text ?? "default id"
        addNewClient(id: id,
                     url: "",
                     name: "",
                     username: "",
                     password: "",
                     generationName: "",
                     type: "")
    }
    
    func addNewClient(id: String,
                      url: String,
                      name:String,
                      username: String,
                      password:String,
                      generationName:String,
                      type:String) {
        
        if let service = selectedService {
            service.addClient(id: id,
                              url: url,
                              name: name,
                              username: username,
                              password: password,
                              generationName: generationName,
                              type:type)
        }
    }
}
