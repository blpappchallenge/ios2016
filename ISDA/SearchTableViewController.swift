//
//  SearchTableViewController.swift
//  ISDA
//
//  Created by Jason  on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    var navigator: PlatformsNavigator!
    
    var results: [SearchResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        self.navigator = PlatformsNavigator(viewController:self)
        createSearchBar()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.20, green:0.40, blue:0.50, alpha:1.0)
    }

    func createSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.keyboardType = .default
        
        self.navigationItem.titleView = searchBar
        
}
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let client = results?[indexPath.section].clients[indexPath.row] {
            navigator.goToWebView(forClient: client)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return results?[section].serviceName
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?[section].clients.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        let result = results![indexPath.section]
        let clients = result.clients
        
        cell.textLabel?.text = clients[indexPath.row].name
        
        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            searchBar.endEditing(true)
            self.results = search(query:query)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let results = search(query: searchText)
        self.results = results
        
        if results.isEmpty {
            //tableView.isHidden = true
            //show some kind of view saying "no results"
        } else {
            self.tableView.reloadData()
        }
    }
    
    private func search(query:String) -> [SearchResult] {
        var results = [SearchResult]()
        if let services = App.services {
            for service in services {
                var clientResults = [Client]()
                for generation in service.generations {
                    for client in generation.clients {
                        let clientName = client.name.lowercased()
                        let subString = query.lowercased()
                        if clientName.contains(subString) {
                            clientResults.append(client)
                        }
                    }
                }
                if !clientResults.isEmpty {
                    results.append(SearchResult(serviceName: service.name, clients: clientResults))
                }
            }
        }
        return results
    }
}

struct SearchResult {
    let serviceName: String
    let clients: [Client]
}
