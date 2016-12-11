//
//  ServiceSerializer.swift
//  ISDA
//
//  Created by Zack on 12/9/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class ServiceSerializer {
    
    func serialize(services: [Service]) {
        
        var json = ""
        json += "\"Title\": [{"
        for service in services {
            
            json += serializeLine("Description", service.description, false)
            json += serializeLine("Name", service.name, false)
            json += serializeGeneration(generations: service.generations)
        }
        
        json += "}]"
    }
    
    func serializeLine(_ title: String, _ value: String, _ lastLine: Bool) -> String {
        
        var json = "\"" + title + "\":\"" + value + "\""
        
        if (!lastLine) {
            json += ","
        }
        
        return json
    }
    
    func serializeGeneration(generations: [Generation]) -> String {
        
        var json = ""
        
        for generation in generations {
            
            json += "\"Generation\":[{"
            json += serializeLine("Name", generation.name, false)
            json += serializeClient(generation.clients)
            json += "}]"
            
        }
        
        return json
    }
    
    func serializeClient(_ clients: [Client]) -> String {
        
        var json = ""
        json += "\"Clients\":["
        
        for client in clients {
            json += "{"
            json += serializeLine("generation", "1", false)
            json += serializeLine("clientID", client.clientID, false)
            json += serializeLine("name", client.name, false)
            json += serializeLine("type", client.type, false)
            json += serializeLine("URL", client.url, true)
            json += "]"
        }
        
        json += "]"
        return json
    }
    
    func serializeTestAccount(_ testAccounts: [TestAccount]) -> String {
        
        var json = ""
        json += "\"testAccounts\":["
        
        for testAccount in testAccounts {
            json += "{"
            json += serializeLine("userName", testAccount.userName, false)
            json += serializeLine("password", testAccount.password, true)
            json += "},"
        }
        
        let index = json.index(json.endIndex, offsetBy: -1)
        json = json.substring(to: index)
        json += "]"
        return json
    }
}
