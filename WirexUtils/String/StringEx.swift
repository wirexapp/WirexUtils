//
//  StringExtension.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 4/10/17.
//  Copyright © 2016 Wirex. All rights reserved.
//

import Foundation

extension String {

    public var length: Int { return self.characters.count }
    
    public func dropLastChar() -> String {
        return String(characters.dropLast())
    }
}

extension String {
    
    public func toNumberString() -> String {
        let numbers = Set("0123456789".characters.map { $0 })
        
        let s = self.characters.filter { (c) -> Bool in
            return numbers.contains(c)
        }
        
        return String(s)
    }
}

extension String {
    
    public func md5HexDigest() -> String {
        return CryptoHelper.md5HexDigest(self) as String
    }
    
    public func parseHex() -> [UInt8] {
        guard self.characters.count > 0 && self.characters.count % 2 == 0 else { return [] }
        
        var data = [UInt8](repeating: 0, count: self.characters.count/2)
        var byteLiteral = ""
        
        for (index, character) in self.characters.enumerated() {
            if index % 2 == 0 {
                byteLiteral = String(character)
            } else {
                byteLiteral.append(character)
                guard let byte = UInt8(byteLiteral, radix: 16) else { return [] }
                data[index / 2] = byte
            }
        }
        return data
    }

}

extension String {
    
    public var isLatinOnlyString: Bool {
        let us = self.unicodeScalars.first { (u) -> Bool in return !u.isLatin }
        return us == nil
    }
    
    public var isLatinAndDigitOnlyString: Bool {
        let us = self.unicodeScalars.first { (u) -> Bool in return !u.isLatin && !u.isDigit }
        return us == nil
    }
    
    public var isLatinFullString: Bool {
        let us = self.unicodeScalars.first { (u) -> Bool in return !u.isLatin && !u.isDigit && !u.isPunctuation && !u.isWhitespace }
        return us == nil
    }
}

extension String {
    public func isValid(regex: String) -> Bool {
        let res = self.range(of: regex, options: .regularExpression)
        return res != nil
    }
}

extension String {

    public static func localized(key: String, bundle: Bundle, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, bundle: bundle, comment: "")
        if format == key {
            return withVaList(args) { return eng(key: key, bundle: bundle, $0) }
        }
        return String(format: format, locale: Locale.current, arguments: args)
    }
    
    private static func eng(key: String, bundle: Bundle, _ params: CVaListPointer) -> String {
        if let path = bundle.path(forResource: "Base", ofType: "lproj"), let bundle = Bundle(path: path) {
            let format = NSLocalizedString(key, bundle: bundle, comment: "")
            return NSString(format: format, arguments: params) as String
        }
        return key
    }
}

extension String {
    public static func flag(forCountryCode code: String) -> Character {
        let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value
    
        var string = ""
        code.uppercased().unicodeScalars.forEach {
            if let scala = UnicodeScalar(base + $0.value) {
                string.append(String(describing: scala))
            }
        }
    
        return Character(string)
    }
}
