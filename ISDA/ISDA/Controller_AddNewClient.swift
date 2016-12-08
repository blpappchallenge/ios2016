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
        let serviceViewController = SettingsViewControllerFactory().makeSelectServiceViewController() {service in
                self.selectedService = service
            }
        self.navigationController?.pushViewController(serviceViewController, animated: true)
        
    }
    
    @IBAction func didPressSubmit(_ sender: Any) {
        if let firstService = App.services?.first {
            handleServiceSelected(service: firstService)
        }
    }
    
    func handleServiceSelected(service:Service) {
        let id = idTextField.text ?? "default id"
        let name = nameTextField.text ?? "default name"
        let username = usernameTextField.text ?? "default username"
        let password = passwordTextField.text ?? "default password"
        let url = urlTextField.text ?? "default url"
        addNewClient(id: id,
                     name: name,
                     username: username,
                     password: password,
                     generationName: url)
    }
    
    func addNewClient(id: String,
                      name:String,
                      username: String,
                      password:String,
                      generationName:String) {
        
        if let service = selectedService {
            service.addClient(id: id,
                              name: name,
                              username: username,
                              password: password,
                              generationName: generationName)
        }
    }
}
