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
    
    
    var generations: [Generation]! {
        didSet {
            if let newestGeneration = generations.last {
                self.selectedGeneration = newestGeneration
            }
        }
    }
    
    var selectedGeneration: Generation! {
        didSet {
            self.clients = selectedGeneration.Clients
        }
    }
    
    var clients: [Client]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension Controller_Clients: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.cellForRow(at: indexPath) as! ClientTableViewCell
        
        if let client = clients?[row] {
            cell.label.text = client.Name
            // cell.clientImageView.image = client.image
        }
        
        return cell
        
    }
}

private extension Controller_Clients {
    
    func toggleGeneration(index: Int) {
        let generationToSelect = generations[index]
        self.selectedGeneration = generationToSelect
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

