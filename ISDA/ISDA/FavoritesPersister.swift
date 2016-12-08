//
//  FavoritesPersister.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class FavoritesPersister {
    var currentFavorites = [Client]()
    var isFavorite = false
    
    func add(client: Client) {
        isFavorite = true
    }
    
    func add(id: String) {
        isFavorite = true
    }
    
    func remove(client: Client) {
        isFavorite = false
    }
    
    func remove(id: String) {
        isFavorite = false
    }
    
    func checkClientIsFavorite(id:String) -> Bool {
        return isFavorite
    }
    
    
}
