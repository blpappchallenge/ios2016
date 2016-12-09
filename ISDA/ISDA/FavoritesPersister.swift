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
    
    func add(client: Client) {
        currentFavorites.append(client)
    }
    
    func remove(client clientToRemove: Client) {
        for (index, curClient) in currentFavorites.enumerated() {
            if curClient == clientToRemove {
                currentFavorites.remove(at: index)
            }
        }
    }
    
    func checkClientIsFavorite(client:Client) -> Bool {
        for curClient in currentFavorites {
            if curClient == client {
                return true
            }
        }
        return false
    }
}
