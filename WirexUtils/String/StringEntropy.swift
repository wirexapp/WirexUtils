//
//  StringEntropy.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 4/10/17.
//  Copyright © 2017 Wirex. All rights reserved.
//

import Foundation

public enum PasswordStrength {
    case weakest
    case weak
    case reasonable
    case strong
    case strongest
    
    
    public static func strength(forString s: String) -> PasswordStrength {
        let entropy = s.entropy()
        
        if entropy < 28 {
            return .weakest
        } else if entropy < 36 {
            return .weak
        } else if entropy < 60 {
            return .reasonable
        } else if entropy < 128 {
            return .strong
        }
        
        return .strongest
    }
}

extension String {
    public func entropy() -> Double {
        var includesLowercase = false
        var includesUppercase = false
        var includesDecimal = false
        var includesPunctuation = false
        var includesSymbol = false
        var includesWhitespace = false
        var includesNonBase = false
        
        var measure: Double = 0.0
        
        self.unicodeScalars.forEach { (ch) in
            if !includesLowercase && ch.isLowercased {
                includesLowercase = true
                measure += 26
            } else if !includesUppercase && ch.isUppercased {
                includesUppercase = true
                measure += 26
            } else if !includesDecimal && ch.isDigit {
                includesDecimal = true
                measure += 10
            } else if !includesPunctuation && ch.isPunctuation {
                includesPunctuation = true
                measure += 20
            } else if !includesSymbol && ch.isSymbol {
                includesSymbol = true
                measure += 10
            } else if !includesWhitespace && ch.isWhitespace {
                includesWhitespace = true
                measure += 32 + 128
            } else if !includesNonBase && ch.isNonBase {
                includesNonBase = true
                measure += 32 + 128
            }
        }
        
        return log2(measure) * Double(self.unicodeScalars.count)
    }

}
