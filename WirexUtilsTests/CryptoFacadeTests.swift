//
//  CryptoFacadeTests.swift
//  WirexUtilsTests
//
//  Created by Eugen Fedchenko on 9/25/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils

// Test data generator
// https://www.freeformatter.com/hmac-generator.html

class CryptoFacadeTests: XCTestCase {

    func testMD5() {
        let msg = "This is test string"
        let calculated = "cbc8824b28a863df726d421801084c01"
        
        let md5 = CryptoFacade.md5HexDigest(msg)
        XCTAssertEqual(md5, calculated)
    }
    
    func testSHA256() {
        let msg = "This is test string"
        let calculated = "9960a70760879076fb6096718329b023074bf6ff39c12f9ebab10c0e742c3ce8"
        
        let sha256 = CryptoFacade.sha256(msg.data(using: .utf8)!).hexEncoded()
        XCTAssertEqual(sha256, calculated)
    }
    
    func testHMACSHA512() {
        let msg = "This is string"
        let key = "Secret"
        
        let calculated =
        "380d70a7b29be9a94731fbc21101704fcd8755baf5475c20b2b69c770ee82f85e9f186d78418d6ca89e7601af71e9452b0ed2da923933cebdab135a2f7057c3e"
        
        let hmac = CryptoFacade.hmacSHA512(msg, usingKey: key).hexEncoded()
        //print(hmac)
        
        XCTAssertEqual(hmac, calculated)
    }
    
    func testDESCrypto() {
        let msg = "This is a very secured string with numbers: 123456789"
        let psw = "12345678"
        let iv = "87654321"
        
        let msgData = msg.data(using: .utf8)!
        let pswData = psw.data(using: .utf8)!
        let ivData = iv.data(using: .utf8)!
        
        let crypted = try? CryptoFacade.desEncryptData(msgData, usingKey: pswData, iv: ivData)
        let decrypted = try? CryptoFacade.desDecryptData(crypted!, usingKey: pswData, iv: ivData)
        let msgDecrypted = String(data: decrypted!, encoding: .utf8)!
        
        print("DES")
        print("Message: \(msg), Password: \(psw)")
        print("In size: \(msgData.count) Out size: \(crypted!.count)")
        print("Hex encoded: \(crypted!.hexEncoded())")
        print("Base64 encoded: \(crypted!.base64EncodedString())")
        print("Bytes array: \(crypted!.toBytes())")
        print("Decrypted msg: \(msgDecrypted)")
        
        XCTAssertEqual(msg, msgDecrypted)
    }
    
    func testAESCrypto() {
        let msg = "This is a very secured string with numbers: 123456789"
        let psw = "example key 1234"
        let iv = "87654321"
        
        let msgData = msg.data(using: .utf8)!
        let pswData = psw.data(using: .utf8)!
        let ivData = iv.data(using: .utf8)!
        
        let crypted = try? CryptoFacade.aesEncryptData(msgData, usingKey: pswData, iv: ivData)
        let decrypted = try? CryptoFacade.aesDecryptData(crypted!, usingKey: pswData, iv: ivData)
        let msgDecrypted = String(data: decrypted!, encoding: .utf8)!
        
        print("AES")
        print("Message: \(msg), Password: \(psw)")
        print("In size: \(msgData.count) Out size: \(crypted!.count)")
        print("Hex encoded: \(crypted!.hexEncoded())")
        print("Base64 encoded: \(crypted!.base64EncodedString())")
        print("Bytes array: \(crypted!.toBytes())")
        print("Decrypted msg: \(msgDecrypted)")
        
        XCTAssertEqual(msg, msgDecrypted)
    }
}
