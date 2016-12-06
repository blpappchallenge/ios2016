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
                    let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print(json)
                    
                    let parser = ServiceParser()
                    self.Services = parser.parse(json: json)
                    
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

