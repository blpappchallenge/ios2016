//
//  ServiceParser.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

struct ServiceParser {
    func parse(json: [String:Any]) -> [Service] {
        let servicesJson = json["Services"] as! [String:[String:Any]]
        return parseServices(json: servicesJson)
    }
    
    private func parseServices(json: [String:[String:Any]]) -> [Service] {
        var services = [Service]()
        for (serviceName, serviceInfo) in json {
            
            let logo = serviceInfo["Logo"] as! String
            let description = serviceInfo["Description"] as! String
            
            let generationsJson = serviceInfo["Generations"] as! [String:[String:Any]]
            let generations = self.parseGenerations(json: generationsJson)
            
            let service = Service(name: serviceName, description: description, generations:generations, imageUrl:logo)
            
            services.append(service)
        }
        return services
    }
    
    private func parseGenerations(json: [String:[String:Any]]) -> [Generation] {
        var generations = [Generation]()
        for (genName, genInfo) in json {
            
            let url = genInfo["URL"] as! String
            
            let clientsJson = genInfo["Clients"] as! [String:[String:Any]]
            let clients = self.parseClients(json: clientsJson)
            
            let generation = Generation(name:genName, url:url, clients:clients)
            generations.append(generation)
        }
        return generations
    }
    
    private func parseClients(json: [String:[String:Any]]) -> [Client] {
        var clients = [Client]()
        for (clientName, clientInfo) in json {
            
            let id = clientInfo["clientID"] as! String
            let name = clientName
            
            let testAccountsJson = clientInfo["testAccounts"] as? [AnyObject]
            var testAccounts = [TestAccount]()
            
            for field in testAccountsJson ?? [] {
                let userName = field["userName"] as! String
                let password = field["password"] as! String
                let testAccount = TestAccount()
                testAccount.userName = userName
                testAccount.password = password
                testAccounts.append(testAccount)
            }
            
            let client = Client(id:id, name:name, testAccounts:testAccounts)
            clients.append(client)
        }
        return clients
    }

}
