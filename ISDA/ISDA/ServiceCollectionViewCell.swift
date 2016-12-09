//
//  ServiceCollectionViewCell.swift
//  ISDA
//
//  Created by Matt Wylder on 12/5/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation
import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoView: UIImageView!
    
    func requestImage(from pictureName: String, completion:@escaping (UIImage)->Void) {
        let pictureDirectory = "https://uat.synchronycredit.com/BLPAppChallenge/images/\(pictureName)"
        
        // Get the picture from the connection
        let pictureURL = URL(string: pictureDirectory)!
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: pictureURL)
        
        let downloadTask = session.dataTask(with: request as URLRequest) {(data, response, error) in
            //Chained optionals. For some reason syntax highlighting isn't working
            if let _ = response as? HTTPURLResponse,
               let imageData = data,
               let downloadedImage = UIImage(data:imageData){
                /*
                 XXX: Something's not right with your image data and the UIImage initializer is 
                      failing
                 
                    This will work if you remove downloadedImage from the if let and replace it with
                    an image in assets
                 */
                self.logoView.image = downloadedImage
                completion(downloadedImage)
            }
            else {
                print(error ?? "Unknown error")
            }
            
        }
        downloadTask.resume()
    }
}
