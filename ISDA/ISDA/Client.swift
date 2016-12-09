//
//  Client.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

enum ClientType {
    case native
    case web
}

struct Client: Equatable {
    
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
    
    public static func ==(lhs: Client, rhs: Client) -> Bool {
        return lhs.name == rhs.name
    }
    
}
