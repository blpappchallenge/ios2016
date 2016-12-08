//
//  Controller_Clients.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_Clients: UIViewController {
    @IBOutlet weak var OmniApplications: UILabel!
    @IBOutlet weak var OmniPayments: UILabel!
    @IBOutlet weak var OmniLogins: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var toggleGeneration: UISegmentedControl!
    @IBOutlet weak var ServiceLogoView: UIImageView!
    var navigator:PlatformsNavigator!
    var clients: [Client]!
    var logo:UIImage!
    
    //The service that this Page describes
    var service: Service! {
        didSet {
            self.generations = service.generations
        }
    }
    
    var generations: [Generation]! {
        didSet {
            if let newestGeneration = generations.first{
                self.selectedGeneration = newestGeneration
            }
        }
    }
    
    var selectedGeneration: Generation! {
        didSet {
            self.clients = selectedGeneration.clients
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Will need to move below back to WebViewController
        self.navigator = PlatformsNavigator(viewController:self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigator = PlatformsNavigator(viewController:self)
        ServiceLogoView.image = logo
    }
    
}

extension Controller_Clients: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentClient = selectedGeneration.clients[indexPath.row] 
            navigator.goToWebView(forClient: currentClient)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "client") as! ClientTableViewCell
        
        if let client = clients?[row] {
            cell.label.text = client.name
            // cell.clientImageView.image = client.image
        }
        
        return cell
    }
}

private extension Controller_Clients {
    
    // TODO: Use this when the user changes generations.
    func toggleGeneration(index: Int) {
        let generationToSelect = generations[index]
        self.selectedGeneration = generationToSelect
    }
    
    @objc func faveButtonWasPressed() {
        //TODO: Adds favorited client to Favorites Table
        //var isFavorited = App.favorites.add(client: "")
    }


    func populateAnalyticsData() {
        // Path to the JSON file that holds the data. *running locally at the moment*
        let urlString = "https://api.myjson.com/bins/4e1k5"
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

}

