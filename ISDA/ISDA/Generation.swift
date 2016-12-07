//
//  Generation.swift
//  Demo Repository
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

struct Generation {
    let name: String
    let url: String
    var clients: [Client]
    
    init(name:String, url:String, clients:[Client]) {
        self.name = name
        self.url = url
        self.clients = clients
    }
}
