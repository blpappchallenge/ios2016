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
    var logo: UIImage?
    var generations = [Generation]()
    
    init(name:String, description: String) {
        self.name = name
        self.description = description
    }
}
