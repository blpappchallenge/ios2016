//
//  Service.swift
//  Test this
//
//  Created by Zack on 11/4/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

struct Service {
    let name: String
    let description: String
    var generations: [Generation]
    var deepLink: String
    let imageUrl: String
    var logo: UIImage?

    
    init(name:String, description: String, generations:[Generation], imageUrl:String) {
        self.name = name
        self.description = description
        self.generations = generations
        self.imageUrl = imageUrl
        self.deepLink = ""
    }
    
    func add(client: Client, generationName: String) {
        for var generation in generations {
            if generation.name == generationName {
                generation.clients.append(client)
            }
        }
    }
    
    func addClient(id:String, url:String, name:String, username:String, password:String, generationName: String, type:String, imageURL:String) {
        let testAccount = TestAccount(userName: username, password: password)
        let client = Client(id: id, url:url, name: name, testAccounts: [testAccount], type:type, imageURL:imageURL)
        add(client: client, generationName: generationName)
    }
}
