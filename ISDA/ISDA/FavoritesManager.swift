//
//  FavoritesManager.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class FavoritesManager {
    func checkIfFavorite(clientId: String) -> Bool {
        if clientId == "favorite" {
            return true
        }
        return false
    }
}
