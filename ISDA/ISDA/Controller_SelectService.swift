//
//  Controller_SelectService.swift
//  ISDA
//
//  Created by Matt Wylder on 12/7/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class Controller_SelectService: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var completion: ((Service)->Void)?
    var selectedService: Service?
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let service = App.services?[indexPath.row] {
            self.dismiss(animated: true, completion: nil)
            completion?(service)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = App.services![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "services")!
        cell.textLabel?.text = service.name
        return cell
    }
}
