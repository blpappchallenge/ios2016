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
    let generations: [Generation]
    let imageUrl: String
    var logo: UIImage?

    
    init(name:String, description: String, generations:[Generation], imageUrl:String) {
        self.name = name
        self.description = description
        self.generations = generations
        self.imageUrl = imageUrl
    }
}
