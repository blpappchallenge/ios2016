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
        requestHandler.requestServices(completion: self.handleServiceResponse)
        requestHandler.analytics()
    }

    override func viewDidAppear(_ animated: Bool) {
        let dynamoDB = AWSDynamoDB.default()
        let listTableInput = AWSDynamoDBListTablesInput()
        dynamoDB.listTables(listTableInput!).continue({(task: AWSTask?) -> AnyObject? in
            if let error = task?.error {
                print("Error occurred: \(error)")
                return nil
            }
            
            let listTablesOutput = (task?.result)! as AWSDynamoDBListTablesOutput
            
            for tableName in listTablesOutput.tableNames! {
                print("\(tableName)")
            }
            
            return nil
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Services?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cast in the service object to copy the values.
        let service = self.Services?[indexPath.item]
        
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
        navigator.goToPlatformsViewController(withService: service!)
    }
    
    @IBAction func LaunchOptions(_sender:Any) {
        // Push the page.
    
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
