//
//  UrlExTests.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/26/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils

class UrlExTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUrl() {
        XCTAssertEqual(URL(str: "http://www.ya.ru?one=1&two=2&three=3").queryItems, ["one" : "1", "two" : "2", "three" : "3"])
        XCTAssertEqual(URL(str: "http://www.ya.ru").queryItems, [:])
    }
}
