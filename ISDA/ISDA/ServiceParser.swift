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

    func checkForAsset(imageName:String) throws -> Bool {
        let asset = UIImage(named: imageName)
        
        if (asset == nil) {
            return false
        }
        else {
            return true
        }
    }
    
    private func parseServices(json: [[String:Any]]) -> [Service] {
        var services = [Service]()
        for currentService in json {
            
            let name = currentService["Name"] as! String
            let logo = currentService["Logo"] as! String
            let description = currentService["Description"] as! String
            
            let generationsJson = currentService["Generations"] as! [[String:Any]]
            let generations = self.parse(generations: generationsJson)
            
            var service = Service(name: name,
                                  description: description,
                                  generations:generations,
                                  imageUrl:logo)
            
            // Download the image.
            let pictureDirectory = service.imageUrl
            
            // Get the picture from the connection
            let pictureURL = URL(string: pictureDirectory)!
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: pictureURL)
            
            // Check if image exists in assets. If not, download from service image url.
            var asset: UIImage!
            var assetExists = false
            
            do {
                assetExists = try! checkForAsset(imageName: service.name)
            }
            catch let error as NSError {
                print(error)
            }
            
            if assetExists {
                asset = UIImage(imageLiteralResourceName: service.name)
                service.logo = asset
            }
            else {
                
                let downloadTask = session.dataTask(with: request as URLRequest) {(data, response, error) in
                    //Chained optionals. For some reason syntax highlighting isn't working
                    if error == nil {
                        
                    }
                    if let _ = response as? HTTPURLResponse,
                        let imageData = data,
                        let downloadedImage = UIImage(data:imageData){
                        service.logo = downloadedImage
                    }
                    else {
                        print(error ?? "Unknown error")
                    }
                    
                }
                downloadTask.resume()
                //sleep(1)
                usleep(10000)
            }
            
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
            let name = currentClient["name"] as! String
            let url = currentClient["URL"] as! String
            let type = currentClient["type"] as! String
            let clientID = currentClient["clientID"] as! String
            let imageURL = currentClient["imageURL"] as! String
            
            let testAccountsJson = currentClient["testAccounts"] as! [[String:Any]]
            let testAccounts = parse(testAccounts: testAccountsJson)
            
            
            var client = Client(id:clientID, url:url, name:name, testAccounts:testAccounts, type:type, imageURL:imageURL)
            
            // Download the image.
            let pictureDirectory = client.imageURL
            
            // Check if image exists in assets. If not, download from service image url.
            var asset: UIImage!
            var assetExists = false
            
            do {
                //TODO: change to client.name
                assetExists = try! checkForAsset(imageName: client.clientID)
            }
            catch let error as NSError {
                print(error)
            }
            
            if assetExists {
                asset = UIImage(imageLiteralResourceName: client.clientID)
                client.logo = asset
            }
            
            
            else {
                // Get the picture from the connection
                let pictureURL = URL(string: pictureDirectory)!
                let session = URLSession(configuration: .default)
                let request = URLRequest(url: pictureURL)
                
                let downloadTask = session.dataTask(with: request as URLRequest) {(data, response, error) in
                    //Chained optionals. For some reason syntax highlighting isn't working
                    if let _ = response as? HTTPURLResponse,
                        
                        
                        let imageData = data,
                        let downloadedImage = UIImage(data:imageData){
                        client.logo = downloadedImage
                        
                    }
                    else {
                        print(error ?? "Unknown error")
                    }
                    
                }
                downloadTask.resume()
                //sleep(1)
                usleep(10000)
            }

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
