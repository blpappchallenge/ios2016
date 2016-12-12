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
    
    var clientID: String
    var testAccounts: [TestAccount]
    var url: String
    var name: String
    var type: String
    var imageURL: String
    var logo: UIImage?
    
    init(id:String, url:String, name:String, testAccounts:[TestAccount], type:String, imageURL:String) {
        self.clientID = id
        self.name = name
        self.url = url
        self.type = type
        self.testAccounts = testAccounts
        self.imageURL = imageURL
    }
    
    public static func ==(lhs: Client, rhs: Client) -> Bool {
        return lhs.name == rhs.name
    }
    
}
