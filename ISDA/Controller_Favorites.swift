//
//  Controller_Favorites.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_Favorites: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var navigator: PlatformsNavigator!
    @IBOutlet weak var FavoritesList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator = PlatformsNavigator(viewController:self)
        self.FavoritesList.dataSource = self
        self.FavoritesList.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.20, green:0.40, blue:0.50, alpha:1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FavoritesList.reloadData()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteForThisRow = App.favorites.currentFavorites[indexPath.row]
        navigator.goToWebView(forClient: favoriteForThisRow)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.favorites.currentFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowNumber = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell") as! FavoriteTableViewCell
        
        let favoriteForThisRow = App.favorites.currentFavorites[rowNumber]
        cell.ClientName.text = favoriteForThisRow.name
        cell.ClientImage.image = favoriteForThisRow.logo
        
        return cell
    }
    
    
}
