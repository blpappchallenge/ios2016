//
//  Controller_Clients.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_Clients: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var OmniApplications: UILabel!
    @IBOutlet weak var OmniPayments: UILabel!
    @IBOutlet weak var OmniLogins: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var clients: [Client]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    func populateAnalyticsData() {
        // Path to the JSON file that holds the data. *running locally at the moment*
        let urlString = "https://api.myjson.com/bins/4e1k5"
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

}

