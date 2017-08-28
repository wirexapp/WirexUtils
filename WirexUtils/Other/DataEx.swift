//
//  DataEx.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 8/28/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import Foundation

extension Data {
    
    public init(bytes: [UInt8]) {
        var values = bytes
        self.init(buffer: UnsafeBufferPointer(start: &values, count: values.count))
    }
    
    public func hexEncoded() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
    public func toBytes() -> [UInt8] {
        return self.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: self.count/MemoryLayout<UInt8>.stride))
        }
    }
    
    public static func xor(data: Data, with key: Data) -> Data {
        var xorData = data
        
        xorData.withUnsafeMutableBytes { (start: UnsafeMutablePointer<UInt8>) -> Void in
            key.withUnsafeBytes { (keyStart: UnsafePointer<UInt8>) -> Void in
                let b = UnsafeMutableBufferPointer<UInt8>(start: start, count: xorData.count)
                
                let k = UnsafeBufferPointer<UInt8>(start: keyStart, count: data.count)
                let length = data.count
                
                for i in 0..<xorData.count {
                    b[i] ^= k[i % length]
                }
            }
        }
        
        return xorData
    }
}
