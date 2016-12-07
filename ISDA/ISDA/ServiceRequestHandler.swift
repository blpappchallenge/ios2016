//
//  ServiceRequestHandler.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

struct ServiceRequestHandler {
    func requestServices(completion: @escaping ([Service]?, Error?) ->Void) {
        // Path to the JSON file that holds the data. *running locally at the moment*
        //let urlString = "http://isda.pcfpoc.cdev.syfbank.com/Services.json"
        //let pictureDirectory = "http://isda.pcfpoc.cdev.syfbank.com/images/"
        let baseDomain = "https://uat.synchronycredit.com/BLPAppChallenge/"
        let servicesJsonURL = "https://api.myjson.com/bins/qx9v"
        let url = URL(string: servicesJsonURL)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if  let error = error {
                print(error)
            } else {
                do {
                    // Parse the JSON data.
                    let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print(json)
                    
                    let parser = ServiceParser()
                    let services = parser.parse(json: json)
                    completion(services, nil)
                    
                } catch let error as NSError {
                    print(error)
                    completion(nil, error)
                }
            }
            
        }).resume()
        
        sleep(1)
    }
    
    func analytics() {
        // Path to the JSON file that holds the data. *running locally at the moment*
        let urlString = "https://rcmon-da.app.syfbank.com/EComStatsGen2/rest/pullWSStats?wsstatsparam=consumermapply"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if let error = error {
                print(error)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!)
                    print(parsedData)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }).resume()
    }
    
    private func makeMockData(completion:([Service]?, Error?) ->Void) {
        
    }
}
