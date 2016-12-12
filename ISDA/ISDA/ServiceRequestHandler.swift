//
//  ServiceRequestHandler.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import AWSS3
import AWSDynamoDB
import AWSSQS
import AWSSNS
import AWSCognito

struct ServiceRequestHandler {
    private let mockFactory = MockJsonFactory()
    private let parser = ServiceParser()
    func requestServices(completion: @escaping ([Service]?, Error?) ->Void) {

        //first create expression
        let dynamoDBObjectMapper2 = AWSDynamoDBObjectMapper.default()
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.indexName = "Author-index"
        queryExpression.hashKeyAttribute = "Author"
        queryExpression.hashKeyValues = ("Ray Jay")
        
        
        dynamoDBObjectMapper2.query(DDBTableRow.self, expression: queryExpression).continue({ (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                if (task.result != nil) {
                    NSLog("Somthing happened")
                    //starting the output of data
                    let tableRow = task.result as AWSDynamoDBPaginatedOutput!
                    
                    let row = tableRow?.items[0] as! DDBTableRow
                    let json = row.Title as? [[String:Any]]
                    print(json)
                    
                    // Parse the JSON data.
                    //let json = try JSONSerialization.jsonObject(with: row.Title!) as! [String:Any]
                    let services = self.parser.parse(json: json!)
                    
                    //Save the global services
                    App.services = services
                    completion(services, nil)
                }
            }
            else {
                print("Error: \(task.error)")
                
            }
            return nil
        })
    }
    
    func updateServices(_ json: Any) {
        
        //static values
        let newBook = InsertRow.self()
        newBook?.ISBN = "3333"
        newBook?.Author = "Ray Jay"
        newBook?.Title = json
        
        //saving it
        
        let insertValues = AWSDynamoDBObjectMapper.default()
        
        insertValues.save(newBook!).continue({ (task: AWSTask!) -> AnyObject! in
            if ((task.error) != nil) {
                NSLog("Failed")
                print("Error: \(task.error)")
            }
            if ((task.result) != nil){
                NSLog("Something happened")
            }
            return nil
        })
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
    
    func queryDatabase() {
        
        
    }
    
    class DDBTableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
        
        var ISBN:String?
        var Title:[Any]?
        var Author:String?
        
        class func dynamoDBTableName() -> String! {
            return "Books"
        }
        
        // if we define attribute it must be included when calling it in function testing...
        class func hashKeyAttribute() -> String! {
            return "ISBN"
        }
        
        class func ignoreAttributes() -> Array<AnyObject>! {
            return nil
        }
        
        //MARK: NSObjectProtocol hack
        //Fixes Does not conform to the NSObjectProtocol error
        
        func isEqual(object: AnyObject?) -> Bool {
            return super.isEqual(object)
        }
        
        override func `self`() -> Self {
            return self
        }
    }
    
    class InsertRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
        
        var ISBN:String?
        var Title:Any?
        var Author:String?
        
        
        class func dynamoDBTableName() -> String! {
            return "Books"
        }
        
        
        // if we define attribute it must be included when calling it in function testing...
        class func hashKeyAttribute() -> String! {
            return "ISBN"
        }
        
        
        
        class func ignoreAttributes() -> Array<AnyObject>! {
            return nil
        }
        
        //MARK: NSObjectProtocol hack
        //Fixes Does not conform to the NSObjectProtocol error
        
        func isEqual(object: AnyObject?) -> Bool {
            return super.isEqual(object)
        }
        
        override func `self`() -> Self {
            return self
        }
        
        
    }
    
    private func makeMockData(completion:([Service]?, Error?) ->Void) {
        let services = mockFactory.makeServices()
        
        completion(services, nil)
    }
}
