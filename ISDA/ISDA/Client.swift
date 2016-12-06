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
    let name: String
    var testAccounts = [TestAccount]()
    
    init(id:String, name:String) {
        self.clientID = id
        self.name = name
    }
}
