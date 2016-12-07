//
//  ServicePersister.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class ServicePersister {
    private (set) var services: [Service]?
    
    func save(_ services: [Service]) {
        self.services = services
    }
    
}
