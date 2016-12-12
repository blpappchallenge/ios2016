//
//  ServiceSerializer.swift
//  ISDA
//
//  Created by Zack on 12/9/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class ServiceSerializer {
    
    func serialize(_ services: [Service]) -> String {
        
        var json = ""
        json += "["
        for service in services {
            
            json += "{"
            json += serializeLine("Description", service.description, false)
            json += serializeLine("Name", service.name, false)
            json += serializeLine("Logo", service.imageUrl, false)
            json += serializeGeneration(generations: service.generations)
            json += "},"
        }
        
        let index = json.index(json.endIndex, offsetBy: -1)
        json = json.substring(to: index)
        json += "]"
        return json
    }
    
    private func serializeLine(_ title: String, _ value: String, _ lastLine: Bool) -> String {
        
        var json = "\"" + title + "\":\"" + value + "\""
        
        if (!lastLine) {
            json += ","
        }
        
        return json
    }
    
    private func serializeGeneration(generations: [Generation]) -> String {
        
        var json = ""
        json += "\"Generations\":["
        
        for generation in generations {
            
            json += "{"
            json += serializeLine("Name", generation.name, false)
            json += serializeClient(generation.clients)
            json += "},"
            
        }
        
        let index = json.index(json.endIndex, offsetBy: -1)
        json = json.substring(to: index)
        json += "]"
        return json
    }
    
    private func serializeClient(_ clients: [Client]) -> String {
        
        var json = ""
        json += "\"Clients\":["
        
        for client in clients {
            json += "{"
            json += serializeLine("generation", "1", false)
            json += serializeLine("clientID", client.clientID, false)
            json += serializeLine("name", client.name, false)
            json += serializeLine("type", client.type, false)
            json += serializeLine("URL", client.url, false)
            json += serializeTestAccount(client.testAccounts)
            json += "},"
        }
        
        let index = json.index(json.endIndex, offsetBy: -1)
        json = json.substring(to: index)
        json += "]"
        return json
    }
    
    private func serializeTestAccount(_ testAccounts: [TestAccount]) -> String {
        
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
