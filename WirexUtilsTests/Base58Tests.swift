//
//  Base58Tests.swift
//  BtcUtils
//
//  Created by Eugen Fedchenko on 6/29/17.
//  Copyright © 2017 gavrilaf. All rights reserved.
//

import XCTest
import WirexUtils

class Base58Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    let data = [("", ""),
                ("61", "2g"),
                ("626262", "a3gV"),
                ("636363", "aPEr"),
                ("73696d706c792061206c6f6e6720737472696e67", "2cFupjhnEsSn59qHXstmK2ffpLv2"),
                ("00eb15231dfceb60925886b67d065299925915aeb172c06647", "1NS17iag9jJgTHD1VXjvLCEnZuQ3rJDE9L"),
                ("516b6fcd0f", "ABnLTmg"),
                ("bf4f89001e670274dd", "3SEo3LWLoPntC"),
                ("572e4794", "3EFU7m"),
                ("ecac89cad93923c02321", "EJDM8drfXA6uyA"),
                ("10c8511e", "Rt5zm"),
                ("00000000000000000000", "1111111111")]
    
    func testDecode() {
        
        for p in data {
            XCTAssertEqual(p.0.parseHex(), Base58.decode(p.1))
        }
    }
    
}
