//
//  StringExTests.swift
//  WirexUtilsTests
//
//  Created by Eugen Fedchenko on 9/25/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils

class StringExTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   func testToNumberStr() {
        XCTAssertEqual("12rt".toNumberString(), "12")
        XCTAssertEqual("1234".toNumberString(), "1234")
        XCTAssertEqual("l567890l".toNumberString(), "567890")
        XCTAssertEqual("ljdjeel".toNumberString(), "")
    }
    
    func testHex() {
        let src = "This is string for test number 1234567890"
        let data = src.data(using: .utf8)!
        
        let hexStr = data.hexEncoded()
        let parsedHex = hexStr.parseHex()
        let dataHex = Data(bytes: parsedHex)
        let str2 = String(data: dataHex, encoding: .utf8)
        
        XCTAssertEqual(src, str2)
    }
}
