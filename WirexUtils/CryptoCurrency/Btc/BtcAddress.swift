//
//  BtcAddress.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 6/28/17.
//  Copyright © 2017 gavrilaf. All rights reserved.
//

import Foundation

public struct BtcAddress {
    
    public init(string s: String) {
        let decoded = Base58.checkedDecode(s)
        let ver = decoded.first ?? UInt8.max
        
        let validPrefix = BtcAddress.prefixes.index(of: ver) != nil || BtcAddress.testnetPrefixes.index(of: ver) != nil
        
        let size = (decoded.count - 1) // [0] - version
        let validSize = (size == 20 || size == 32 || (size == 33 && decoded[33] == 1))
        
        if validPrefix && validSize {
            version = ver
            isValid = true
            payload = size == 33 ? Array(decoded[1..<size]) : Array(decoded.suffix(size))
        } else {
            version = UInt8.max
            isValid = false
            payload = []
        }
    }
    
    public let version: UInt8
    public let payload: [UInt8]
    public let isValid: Bool
    
    public var isTestnet: Bool {
        return BtcAddress.testnetPrefixes.index(of: version) != nil
    }
    
    public var payloadHex: String {
        return payload.map { String(format: "%02hhx", $0) }.joined()
    }
    
    static let prefixes: [UInt8] = [0, 5, 128]
    static let testnetPrefixes: [UInt8] = [111, 196, 239]
}
