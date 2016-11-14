//
//  Controller_Main.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_Main: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "Cell" // also enter this string as the cell identifier in the storyboard
    var Services = [Service]()
    var SelectedService: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the selected values to the launch options controller.
        if (segue.identifier == "segue") {
            let svc = segue.destination as! Controller_LaunchOptions
            svc.service = SelectedService
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        populateServiceArray()
        return self.Services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cast in the service object to copy the values.
        let service = self.Services[indexPath.item]
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (reuseIdentifier), for: indexPath as IndexPath) as! Service
        
        cell.Name = service.Name
        cell.URL = service.URL
        cell.Clients = service.Clients
        cell.Gen = service.Gen
        cell.Label.text = service.Name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected service at index #\(indexPath.item)!")
        
        // Get the cell information to pass onto the next page (web view)
        let service = Services[indexPath.item]
        
        SelectedService = service
        
        // Perform the segue.
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    func populateServiceArray() {
        
        // Path to the JSON file that holds the data. *running locally at the moment*
        let urlString = "http://localhost:8080/static/Data2.json"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    // Parse the JSON data.
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    
                    // Read in the list of services.
                    let services = parsedData["Services"] as! [String:[String:Any]]
                    print(services)
                    
                    // Loop through all of the services and instantiate.
                    for (serviceName, serviceInfo) in services {
                        let service = Service()
                        service.Name = serviceName
                        service.URL = serviceInfo["URL"] as! String
                        service.Gen = serviceInfo["Gen"] as! Double
                        
                        let clients = serviceInfo["Clients"] as! [String:[String:Any]]
                        
                        // Loop through all of the clients under the current service.
                        for (clientName, clientInfo) in clients {
                            // Creat an object for the client.
                            let client = Client()
                            client.ClientID = clientInfo["clientID"] as! String
                            client.Name = clientName
                            
                            // Get the test accounts from the connection.
                            let testAccounts = clientInfo["testAccounts"] as? [AnyObject]
                            
                            for field in testAccounts ?? [] {
                                let userName = field["userName"] as! String
                                let password = field["password"] as! String
                                let testAccount = TestAccount()
                                testAccount.userName = userName
                                testAccount.password = password
                                client.TestAccounts.append(testAccount)
                            }
                            
                            
                            // Add the service to the array.
                            service.Clients.append(client)
                        }
                        self.Services.append(service)
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }).resume()
        
        sleep(2)
    }

}

