//
//  ImageRequestHandler.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

private func fetchImage(forService service: Service) {
    let baseDomain = "https://uat.synchronycredit.com/BLPAppChallenge/"
    
    let pictureDirectory = baseDomain + "images/"
    // Get the picture from the connection
    let pictureURL = URL(string: (pictureDirectory + service.imageUrl))!
    let session = URLSession(configuration: .default)
    let request = URLRequest(url: pictureURL)
    
    let downloadTask = session.dataTask(with: request as URLRequest) {(data, response, error) in
        if let error = error {
            print(error)
        }
        else {
            if let _ = response as? HTTPURLResponse {
                if let imageData = data {
                    let downloadedImage = UIImage(data: imageData)
                    
                    // set downloaded image for service
                }
            }
        }
    }
    downloadTask.resume()
}
