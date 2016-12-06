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
    let name: String
    
    init(id:String, name:String, testAccounts:[TestAccount]) {
        self.clientID = id
        self.name = name
        self.testAccounts = testAccounts
    }
}
