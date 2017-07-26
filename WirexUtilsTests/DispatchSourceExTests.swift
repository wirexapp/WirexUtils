//
//  DispatchSourceExTests.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/26/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils


class DispatchSourceExTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepeatingTimer() {
        let exp = expectation(description: "")
        
        var counter = 0
        let timer = DispatchSource.repeatingTimer(interval: DispatchTimeInterval.seconds(1)) {
            print("tick: \(counter)")
            if counter < 3 {
                counter += 1
            } else {
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: TimeInterval(5)) { (_) in
            XCTAssertEqual(counter, 3)
            timer.cancel()
        }
    }
}
