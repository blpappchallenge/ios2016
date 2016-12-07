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
    
    private var navigator:PlatformsNavigator!
    
    //The service that this Page describes
    var service: Service! {
        didSet {
            self.generations = service.generations
        }
    }
    
    var generations: [Generation]! {
        didSet {
            if let newestGeneration = generations.last {
                self.selectedGeneration = newestGeneration
            }
        }
    }
    
    var selectedGeneration: Generation! {
        didSet {
            self.clients = selectedGeneration.clients
        }
    }
    
    var clients: [Client]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator = PlatformsNavigator(viewController:self)
        let faveImage = UIImage(named: "favStar")
        let innerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        innerButton.setImage(faveImage, for: .normal)
        innerButton.addTarget(self, action: #selector(self.faveButtonWasPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: innerButton)
        navigationItem.rightBarButtonItem = barButton
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

