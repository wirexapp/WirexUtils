//
//  Base58Decoder.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 6/29/17.
//  Copyright © 2017 gavrilaf. All rights reserved.
//

import Foundation

// https://github.com/bitcoin/bitcoin/blob/master/src/base58.cpp

public struct Base58 {
    
    public static func checkedDecode(_ s: String) -> [UInt8] {
        let decoded = decode(s)
        guard decoded.count > 4 else { return [] }
            
        let payload = Array(decoded.prefix(upTo: decoded.count - 4))
        let checksum = decoded.suffix(from: decoded.count - 4)
            
        let d1 = sha265(payload)
        let d2 = sha265(d1)
            
        let c2 = d2[0..<4]
        return checksum.elementsEqual(c2) ? payload : []
    }
        
    public static func decode(_ s: String) -> [UInt8] {
        let chars = s.characters
        var index = chars.startIndex
        
        // Skip & count leading '1's
        var zeroes = 0
        while index < chars.endIndex && chars[index] == "1" {
            zeroes += 1
            index = chars.index(after: index)
        }
        
        let dist = chars.distance(from: index, to: chars.endIndex)
        let size = dist * 733 / 1000 + 1
        
        var b256 = Array<UInt8>(repeating: 0, count: size)
        while index < chars.endIndex {
            let ch = chars[index]
            var carry = Alphabet.pos(forChar: ch)
            
            if carry == -1 {
                return [UInt8]()
            }
            
            var j = size - 1
            while j >= 0 {
                let a = b256[j]
                carry += 58 * Int(a)
                b256[j] = UInt8(carry % 256)
                carry /= 256
                j -= 1
            }
            
            if carry != 0 {
                return [UInt8]()
            }
            
            index = chars.index(after: index)
        }
        
        // Remove trailing spaces
        var indx = 0
        while indx != b256.endIndex && b256[indx] == 0 {
            indx += 1
        }
        
        // Leading zeroes
        if zeroes > 0 {
            let z = Array<UInt8>(repeating: 0, count: zeroes)
            return z + b256.suffix(from: indx)
        } else {
            return Array(b256.suffix(from: indx))
        }
    }
    
    // MARK:
    struct Alphabet {
        static let symbs = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
        
        static func pos(forChar c: Character) -> Int {
            if let indx = symbs.characters.index(of: c) {
                return symbs.characters.distance(from: symbs.characters.startIndex, to: indx)
            }
            
            return -1
        }
    }
    
    // MARK:
    private static func sha265(_ m: [UInt8]) -> [UInt8] {
        return [UInt8](CryptoHelper.sha256(Data(bytes: m)))
    }
}
