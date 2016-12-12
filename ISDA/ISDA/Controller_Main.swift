//
//  Controller_Main.swift
//  Test this
//
//  Created by Zack on 10/20/16.
//  Copyright © 2016 Zack. All rights reserved.
//test

import UIKit
import AWSS3
import AWSDynamoDB
import AWSSQS
import AWSSNS
import AWSCognito

class Controller_Main: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var navigator:HomeNavigator!
    private let requestHandler = ServiceRequestHandler()
    
    @IBOutlet weak var TabItem: UITabBarItem!
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "Cell" // also enter this string as the cell identifier in the storyboard
    var Services: [Service]? {
        didSet {
    
        }
    }
    var SelectedService: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        navigator = HomeNavigator(viewController:self)
        
        DispatchQueue.main.async {
            self.requestHandler.requestServices(completion: self.handleServiceResponse)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.23, green:0.24, blue:0.26, alpha:1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Services?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cast in the service object to copy the values.
        var service = self.Services?[indexPath.item]
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (reuseIdentifier), for: indexPath as IndexPath) as! ServiceCollectionViewCell
        
        cell.logoView.image = service?.logo
        cell.descriptionLabel.text = service?.description
        cell.nameLabel.text = service?.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected service at index #\(indexPath.item)!")
        
        // Get the cell information to pass onto the next page (web view)
        let service = Services?[indexPath.item]
        let firstClient = service?.generations[0].clients[0]
        
        if firstClient?.type == "native" {
            let url = URL(string: (firstClient?.url)!)
            UIApplication.shared.open(url!)
        }
        else if firstClient?.type == "web"
        {
            navigator.goToPlatformsViewController(withService: service!)
        }
        else {
            let settingsNavigator = SettingsNavigator(viewController: self)
            settingsNavigator.goToAddNewService()
        }
    }
    
    @IBAction func LaunchOptions(_sender:Any) {
        // Push the page.
    
    }
    
    //class that gets the objects from db
    class DDBTableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
        
        var ISBN:String?
        var Title:[Any]?
        var Author:String?
        
        
        class func dynamoDBTableName() -> String {
            return "Books"
        }
        
        
        // if we define attribute it must be included when calling it in function testing...
        class func hashKeyAttribute() -> String {
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
    func insertValues(){
        
        //static values
        let newBook = DDBTableRow.self()
        newBook?.ISBN = "3333"
        newBook?.Author = "Ray Jay"
        //newBook?.Title = "Less go"
        
        
        
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
}

private extension Controller_Main {
    func handleServiceResponse(services:[Service]?, error:Error?) {
        Services = services
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setup() {
        let logo = #imageLiteral(resourceName: "syf_logo")
        let imageView = UIImageView(image: logo)
        self.navigationController?.navigationBar.topItem?.titleView = imageView
    }
}






