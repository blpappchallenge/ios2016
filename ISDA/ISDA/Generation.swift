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
    var clients: [Client]
    
    init(name:String, clients:[Client]) {
        self.name = name
        self.clients = clients
    }
}
