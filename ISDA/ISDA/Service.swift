//
//  Service.swift
//  Test this
//
//  Created by Zack on 11/4/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Service: UICollectionViewCell {
    

    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var LogoView: UIImageView!
    var Name: String!
    var Description: String!
    var Generations = [Generation]()
    var Logo: UIImage!
}
