//
//  BtcPaymentURITests.swift
//  BtcUtils
//
//  Created by Eugen Fedchenko on 7/3/17.
//  Copyright © 2017 gavrilaf. All rights reserved.
//

import XCTest
import WirexUtils

class BtcPaymentURITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreate() {
        
    }
    
    func testParse() {
        let u1 = CryptoPaymentURI(fromStr: "bitcoin:175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W")
        XCTAssertEqual(u1?.address, "175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W")
        XCTAssertNil(u1?.amount)
        XCTAssertNil(u1?.label)
        XCTAssertNil(u1?.message)
        XCTAssertEqual(u1?.parameters.count, 0)
        
        let u2 = CryptoPaymentURI(fromStr: "bitcoin:175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W?label=Luke-Jr")
        XCTAssertEqual(u2?.address, "175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W")
        XCTAssertEqual(u2?.label, "Luke-Jr")
        XCTAssertEqual(u2?.parameters ?? [:], ["label" : "Luke-Jr"])
        
        let u3 = CryptoPaymentURI(fromStr: "bitcoin:175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W?amount=0.03452")
        XCTAssertEqual(u3?.address, "175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W")
        XCTAssertEqual(u3?.amount, Decimal(string: "0.03452"))
        
        let u4 = CryptoPaymentURI(fromStr: "bitcoin:175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W?amount=50&label=Luke-Jr&message=Donation%20for%20project%20xyz")
        XCTAssertEqual(u4?.address, "175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W")
        XCTAssertEqual(u4?.amount, Decimal(50))
        XCTAssertEqual(u4?.label, "Luke-Jr")
        XCTAssertEqual(u4?.message, "Donation for project xyz")
        
        
        let u5 = CryptoPaymentURI(fromStr: "bitcoin:175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W?amount=100&user=Vasya")
        XCTAssertEqual(u5?.address, "175tWpb8K1S7NmH4Zx6rewF9WQrcZv245W")
        XCTAssertEqual(u5?.amount, Decimal(100))
        XCTAssertEqual(u5?.parameters ?? [:], ["amount" : "100", "user" : "Vasya"])
    }
    
    
}
