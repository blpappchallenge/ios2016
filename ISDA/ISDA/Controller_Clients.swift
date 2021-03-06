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
    
    @IBOutlet weak var toggleView: UISegmentedControl!
    //@IBOutlet weak var ServiceLogoView: UIImageView!
    
    var navigator:PlatformsNavigator!
    
    var logo:UIImage?
    
    var dataSources: [GenerationDataSource]?
    
    var service: Service!
    
    
    @IBAction func didChangeGeneration(_ sender: Any) {
        self.tableView.dataSource = dataSources?[toggleView.selectedSegmentIndex]
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator = PlatformsNavigator(viewController:self)
        //ServiceLogoView.image = logo
        
        self.tableView.delegate = self
        let dataSources = makeDataSources(service: self.service)
        self.setupToggleView(service: self.service)
        self.dataSources = dataSources
        
        self.tableView.dataSource = dataSources.first
    }
}

extension Controller_Clients: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedDataSource = dataSources?[toggleView.selectedSegmentIndex] {
            let client = selectedDataSource.clients[indexPath.row]
            navigator.goToWebView(forClient: client)
        }
    }
}

private extension Controller_Clients {
    func makeDataSources(service:Service) -> [GenerationDataSource] {
        var dataSources = [GenerationDataSource]()
        for generation in service.generations {
            let dataSource = GenerationDataSource(clients: generation.clients)
            dataSources.append(dataSource)
        }
        return dataSources
    }
    
    func setupToggleView(service: Service) {
        let generations = service.generations
        var i = 0
        toggleView.removeAllSegments()
        for generation in generations {
            toggleView.insertSegment(withTitle: generation.name, at: i, animated: false)
            i += 1
        }
        toggleView.setEnabled(true, forSegmentAt: 0)
        toggleView.selectedSegmentIndex = 0
    }
}
