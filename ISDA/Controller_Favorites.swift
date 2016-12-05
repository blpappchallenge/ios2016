//
//  Controller_Favorites.swift
//  ISDA
//
//  Created by Zack on 11/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_Favorites: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favorites: [Client]!

    @IBOutlet weak var FavoritesList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.FavoritesList.delegate = self
        self.FavoritesList.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell") as! FavoriteTableViewCell
        
        if let favorite = favorites?[row] {
            cell.clientImageView.image = UIImage(named:"home")
            //add the image
        }
        
        return cell
    }
    
    
}
