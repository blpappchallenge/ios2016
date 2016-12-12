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
        
    }
}
