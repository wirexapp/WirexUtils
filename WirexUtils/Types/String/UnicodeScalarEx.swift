//
//  UnicodeScalar.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 4/10/17.
//  Copyright © 2017 Wirex. All rights reserved.
//

import Foundation

extension UnicodeScalar {

    public var isLowercased: Bool {
        return CharacterSet.lowercaseLetters.contains(self)
    }
    
    public var isUppercased: Bool {
        return CharacterSet.uppercaseLetters.contains(self)
    }
    
    public var isDigit: Bool {
        return CharacterSet.decimalDigits.contains(self)
    }
    
    public var isSymbol: Bool {
        return CharacterSet.symbols.contains(self)
    }
    
    public var isWhitespace: Bool {
        return CharacterSet.whitespaces.contains(self)
    }
    
    public var isPunctuation: Bool {
        return CharacterSet.punctuationCharacters.contains(self)
    }
    
    public var isNonBase: Bool {
        return CharacterSet.nonBaseCharacters.contains(self)
    }
    
    public var isLatin: Bool {
        let latin = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        return latin.contains(self)
    }
}
