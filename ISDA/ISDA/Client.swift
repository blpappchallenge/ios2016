//
//  Client.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

struct Client {
    
    let clientID: String
    let testAccounts: [TestAccount]
    let url: String
    let name: String
    let type: String
    
    init(id:String, url:String, name:String, testAccounts:[TestAccount], type:String) {
        self.clientID = id
        self.name = name
        self.url = url
        self.type = type
        self.testAccounts = testAccounts
    }
}
