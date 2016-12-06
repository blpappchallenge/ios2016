//
//  Controller_Main.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//test

import UIKit

class Controller_Main: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var TabItem: UITabBarItem!
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "Cell" // also enter this string as the cell identifier in the storyboard
    var Services = [Service]()
    var SelectedService: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        // Add the SYF logo to the navigation header.
        let logo = #imageLiteral(resourceName: "syf_logo")
        let imageView = UIImageView(image: logo)
        self.navigationController?.navigationBar.topItem?.titleView = imageView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        populateServiceArray()
        populateAnalyticsData()
        return self.Services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cast in the service object to copy the values.
        let service = self.Services[indexPath.item]
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (reuseIdentifier), for: indexPath as IndexPath) as! ServiceCollectionViewCell
        
        cell.logoView.image = service.logo
        cell.descriptionLabel.text = service.description
        cell.nameLabel.text = service.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected service at index #\(indexPath.item)!")
        
        // Get the cell information to pass onto the next page (web view)
        let service = Services[indexPath.item]
        
        // Show the view controller.
        showChildController(controllerName: "launchoptions")
    }
    
    func showChildController(controllerName: String) {
        
        let storyboard = UIStoryboard(name: "Platforms", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: controllerName)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func populateAnalyticsData() {
        // Path to the JSON file that holds the data. *running locally at the moment*
        let urlString = "https://rcmon-da.app.syfbank.com/EComStatsGen2/rest/pullWSStats?wsstatsparam=consumermapply"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if error != nil {
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
    
    func populateServiceArray() {
        
        // Path to the JSON file that holds the data. *running locally at the moment*
        //let urlString = "http://isda.pcfpoc.cdev.syfbank.com/Services.json"
        //let pictureDirectory = "http://isda.pcfpoc.cdev.syfbank.com/images/"
        let baseDomain = "https://uat.synchronycredit.com/BLPAppChallenge/"
        let servicesJsonURL = baseDomain + "Services.json"
        let pictureDirectory = baseDomain + "images/"
        let url = URL(string: servicesJsonURL)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if  let error = error {
                print(error)
            } else {
                do {
                    // Parse the JSON data.
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print(parsedData)
                    // Read in the list of services.
                    //let services = parsedData["Services"] as! [String:[String:[String:Any]]]
                    let services = parsedData["Services"] as! [String:[String:Any]]
                    
                    // Loop through all of the services and instantiate.
                    for (serviceName, serviceInfo) in services {
                        
                        let logo = serviceInfo["Logo"] as! String
                        let description = serviceInfo["Description"] as! String
                        var service = Service(name: serviceName, description: description)
                        
                        // Get the picture from the connection
                        let pictureURL = URL(string: (pictureDirectory + logo))!
                        let session = URLSession(configuration: .default)
                        let request = URLRequest(url: pictureURL)
                        
                        let downloadTask = session.dataTask(with: request as URLRequest) {(data, response, error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                if let _ = response as? HTTPURLResponse {
                                    if let imageData = data {
                                        let downloadedImage = UIImage(data: imageData)
                                        
                                        service.logo = downloadedImage
                                        self.collectionView.reloadData()
                                    }
                                }
                            }
                        }
                        
                        downloadTask.resume()
                        
                        let generations = serviceInfo["Generations"] as! [String:[String:Any]]
                        
                        // Loop through all of the generations of the service.
                        for (genName, genInfo) in generations {
                            
                            let generation = Generation()
                            generation.Name = genName
                            generation.URL = genInfo["URL"] as! String
                            
                            
                            let clients = genInfo["Clients"] as! [String:[String:Any]]
                            
                            // Loop through all of the clients under the current generation.
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
                                
                                
                                // Add the generation to the array.
                                service.generations.append(generation)
                            }
                        }
                        self.Services.append(service)
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }).resume()
        
        sleep(1)
    }
  
    @IBAction func LaunchOptions(_sender:Any) {
        // Push the page.
    
    }
}

