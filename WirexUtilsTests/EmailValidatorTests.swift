//
//  EmailValidatorTests.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 8/15/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils

class EmailValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testEmailValidator() {
        XCTAssertFalse(EmailValidator.isValid(email: ""))
        XCTAssertFalse(EmailValidator.isValid(email: "@"))
        XCTAssertFalse(EmailValidator.isValid(email: "@."))
        XCTAssertFalse(EmailValidator.isValid(email:"@.com"))
        XCTAssertFalse(EmailValidator.isValid(email: "foo@.com"))
        XCTAssertFalse(EmailValidator.isValid(email: "@foo.com"))
        XCTAssertTrue(EmailValidator.isValid(email: "f@b.co"))
        XCTAssertTrue(EmailValidator.isValid(email: "foo@bar.com"))
        XCTAssertTrue(EmailValidator.isValid(email: "ehfe!#$%&'*+/=?^_`{|}~@gmail.com"))
        XCTAssertTrue(EmailValidator.isValid(email: "foo!-bar!-baz@foo.bar"))
        XCTAssertFalse(EmailValidator.isValid(email: "f@b."))
        XCTAssertFalse(EmailValidator.isValid(email: "æøå@gmail.com"))
    }
}
