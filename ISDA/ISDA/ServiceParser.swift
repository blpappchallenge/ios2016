//
//  ServiceParser.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

struct ServiceParser {
    func parse(json: [[String:Any]]) -> [Service] {
        //let servicesJson = json["Services"] as! [[String:Any]]
        return parseServices(json: json)
    }
    
    private func parseServices(json: [[String:Any]]) -> [Service] {
        var services = [Service]()
        for currentService in json {
            
            let name = currentService["Name"] as! String
            let logo = currentService["Logo"] as! String
            let description = currentService["Description"] as! String
            
            let generationsJson = currentService["Generations"] as! [[String:Any]]
            let generations = self.parse(generations: generationsJson)
            
            let service = Service(name: name,
                                  description: description,
                                  generations:generations,
                                  imageUrl:logo)
            
            services.append(service)
        }
        return services
    }
    
    private func parse(generations json: [[String:Any]]) -> [Generation] {
        var generations = [Generation]()
        for currentGen in json {
            
            let name = currentGen["Name"] as! String
            
            let clientsJson = currentGen["Clients"] as! [[String:Any]]
            let clients = self.parse(clients: clientsJson)
            
            let generation = Generation(name:name, clients:clients)
            generations.append(generation)
        }
        return generations
    }
    
    private func parse(clients json: [[String:Any]]) -> [Client] {
        var clients = [Client]()
        for currentClient in json {
            //let id = currentClient["clientID"] as! String
            //TODO: remove id from initializer (no longer needed)
            let id = ""
            let name = currentClient["name"] as! String
            let url = currentClient["URL"] as! String
            let type = currentClient["type"] as! String
            
            let testAccountsJson = currentClient["testAccounts"] as! [[String:Any]]
            let testAccounts = parse(testAccounts: testAccountsJson)
            
            
            let client = Client(id:id, url:url, name:name, testAccounts:testAccounts, type:type)
            clients.append(client)
        }
        return clients
    }
    
    private func parse(testAccounts json: [[String:Any]]) -> [TestAccount] {
        var testAccounts = [TestAccount]()
        for currentAccount in json {
            let userName = currentAccount["userName"] as! String
            let password = currentAccount["password"] as! String
            let testAccount = TestAccount(userName:userName,
                                          password:password)
            testAccounts.append(testAccount)
        }
        return testAccounts
    }

}
