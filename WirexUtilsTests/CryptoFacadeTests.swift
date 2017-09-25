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
        let msg = "This is a very secured string with numbers: 123456789"
        let psw = "Password"
        
        let msgData = msg.data(using: .utf8)!
        let pswData = psw.data(using: .utf8)!
        
        let crypted = try? CryptoFacade.desEncryptData(msgData, usingKey: pswData)
        let decrypted = try? CryptoFacade.desDecryptData(crypted!, usingKey: pswData)
        let msgDecrypted = String(data: decrypted!, encoding: .utf8)!
        
        //print("Message: \(msg), Password: \(psw)")
        //print("In size: \(msgData.count) Out size: \(crypted!.count)")
        //print("Base64 encoded: \(crypted!.base64EncodedString())")
        //print("Bytes array: \(crypted!.toBytes())")
        //print("Decrypted msg: \(msgDecrypted)")
        
        XCTAssertEqual(msg, msgDecrypted)
    }
    
    
    
}
