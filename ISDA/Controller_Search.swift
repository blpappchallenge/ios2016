//
//  Controller_Search.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_Search: UIViewController, SearchBarDelegate {
    
    fileprivate weak var searchBar: SearchBar!
    @IBOutlet weak var ServiceSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        performSegue(withIdentifier: item.title!, sender: self)
    }
    
    func didCancelSearch(searchBar: SearchBar) {
        
    }
    
    func didEnterSearch(searchBar: SearchBar) {
        
    }

}

private extension Controller_Search {
    func setup() {
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchBar = Bundle.main.loadNibNamed("SearchBar", owner: self, options: nil)![0] as! SearchBar
        searchBar.frame = CGRect(x:8, y:0, width:view.bounds.width-16, height:44)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}
