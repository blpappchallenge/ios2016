//
//  MockJsonFactory.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class MockJsonFactory {
    
    func makeDictionary() -> [String:Any]? {
        let data = makeData()!
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json as! [String:Any]
        } catch {
            return nil
        }
    }
    
    private func makeData() -> Data? {
        let fileName = "response"
        let fileExtension = "json"
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: fileName, withExtension: fileExtension)!
        do {
            return try Data(contentsOf: url)
        }
        catch {
            return nil
        }
    }
}
