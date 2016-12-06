//
//  TestAccount.swift
//  Test this
//
//  Created by Zack on 10/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class TestAccount: NSObject {
    var userName: String!
    var password: String!
    
    func TestAccount(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
}

struct Account {
    let userName: String
    let password:String
    
    init(userName:String,password:String) {
        self.userName = userName
        self.password = password
    }
}
