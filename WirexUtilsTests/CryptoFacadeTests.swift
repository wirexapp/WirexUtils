//
//  CryptoFacadeTests.swift
//  WirexUtilsTests
//
//  Created by Eugen Fedchenko on 9/25/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils

class CryptoFacadeTests: XCTestCase {
    
    func testDESCrypto() {
        let msg = "This is a very big secret!!! 123456789"
        let psw = "Password"
        
        let msgData = msg.data(using: .utf8)!
        let pswData = psw.data(using: .utf8)!
        
        let crypted = try? CryptoFacade.desEncryptData(msgData, usingKey: pswData)
        let decrypted = try? CryptoFacade.desDecryptData(crypted!, usingKey: pswData)
        let msgDecrypted = String(data: decrypted!, encoding: .utf8)!
        
        //print("IN: \(msgData.count) OUT: \(crypted!.count) \n \(crypted!.hexEncoded())")
        //print(msgDecrypted)
        
        XCTAssertEqual(msg, msgDecrypted)
    }
    
    
    
}
