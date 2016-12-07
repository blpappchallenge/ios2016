//
//  ParserTests.swift
//  ISDA
//
//  Created by Matt Wylder on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import XCTest
@testable import ISDA

class ParserTests: XCTestCase {
    let jsonFactory = MockJsonFactory()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParser() {
        let dict = jsonFactory.makeDictionary()!
        let parser = ServiceParser()
        
        let result = parser.parse(json: dict)
        
    }
    
}
