//
//  GenerationDataSource.swift
//  ISDA
//
//  Created by Matt Wylder on 12/8/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class GenerationDataSource: NSObject, UITableViewDataSource {
    let clients:[Client]
    
    init(clients:[Client]) {
        self.clients = clients
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "client") as! ClientTableViewCell
        
        let client = clients[row]
            cell.label.text = client.name
            cell.clientImageView.image = client.logo
        
        return cell
    }
}
