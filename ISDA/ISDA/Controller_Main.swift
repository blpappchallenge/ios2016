//
//  Controller_Main.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//test

import UIKit

class Controller_Main: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var navigator:HomeNavigator!
    
    @IBOutlet weak var TabItem: UITabBarItem!
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "Cell" // also enter this string as the cell identifier in the storyboard
    var Services: [Service]!
    var SelectedService: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator = HomeNavigator(viewController: self)
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
        navigator.goToPlatformsViewController(withService: service)
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
    
    func populateServiceArray() {
        
        // Path to the JSON file that holds the data. *running locally at the moment*
        //let urlString = "http://isda.pcfpoc.cdev.syfbank.com/Services.json"
        //let pictureDirectory = "http://isda.pcfpoc.cdev.syfbank.com/images/"
        let baseDomain = "https://uat.synchronycredit.com/BLPAppChallenge/"
        let servicesJsonURL = baseDomain + "Services.json"
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
                    let servicesJson = parsedData["Services"] as! [String:[String:Any]]
                    let services = self.parseServices(json: servicesJson)
                    
                    self.Services = services
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }).resume()
        
        sleep(1)
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
            
            // Get the test accounts from the connection.
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
    
    
    //TODO: PUt this somewhere else idk where yet
    private func fetchImage(forService service: Service) {
        let baseDomain = "https://uat.synchronycredit.com/BLPAppChallenge/"
        
        let pictureDirectory = baseDomain + "images/"
        // Get the picture from the connection
        let pictureURL = URL(string: (pictureDirectory + service.imageUrl))!
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
                        
                        // set downloaded image for service
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        downloadTask.resume()
    }
    
  
    @IBAction func LaunchOptions(_sender:Any) {
        // Push the page.
    
    }
}

