//
//  SearchBar.swift
//  LandsEnd
//
//  Created by Matt Wylder on 8/24/16.
//  Copyright © 2016 GPShopper. All rights reserved.
//

import Foundation
import UIKit

protocol SearchBarDelegate {
    func didCancelSearch(searchBar: SearchBar)
    func didEnterSearch(searchBar: SearchBar)
}

class SearchBar: UIView {
    var delegate: SearchBarDelegate!
    var text: String? {
        return textField.text
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldPrimaryActionTriggered(searchBar: AnyObject) {
        delegate.didEnterSearch(searchBar: self)
    }
    
    @IBAction func cancelButtonTapped(searchBar: AnyObject) {
        delegate.didCancelSearch(searchBar: self)
    }
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}
