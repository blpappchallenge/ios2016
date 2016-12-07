//
//  Controller_AddNewClient.swift
//  ISDA
//
//  Created by Jason  on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class Controller_AddNewClient: UIViewController {
    
    var selectedService: Service?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
