//
//  StringExtension.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 4/10/17.
//  Copyright © 2016 Wirex. All rights reserved.
//

import Foundation

// MARK:
extension String {

    public var length: Int { return self.characters.count }
    
    public func dropLastChar() -> String {
        return String(characters.dropLast())
    }
}

// MARK:
extension String {
    
    public func toNumberString() -> String {
        let numbers = Set("0123456789".characters.map { $0 })
        
        let s = self.characters.filter { (c) -> Bool in
            return numbers.contains(c)
        }
        
        return String(s)
    }
}

// MARK:
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

// MARK:
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

// MARK:
extension String {
    
    public func isValid(regex: String) -> Bool {
        let res = self.range(of: regex, options: .regularExpression)
        return res != nil
    }
    
    public func isValid(regex: NSRegularExpression) -> Bool {
        return regex.firstMatch(in: self, options: [], range: nsrange) != nil
    }
}

// MARK:
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

// MARK:
// http://nshipster.com/nsregularexpression/
extension String {
    /// An `NSRange` that represents the full range of the string.
    var nsrange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }
    
    /// Returns a substring with the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func substring(with nsrange: NSRange) -> String? {
        guard let range = nsrange.toRange()
            else { return nil }
        let start = UTF16Index(range.lowerBound)
        let end = UTF16Index(range.upperBound)
        return String(utf16[start..<end])
    }
    
    /// Returns a range equivalent to the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func range(from nsrange: NSRange) -> Range<Index>? {
        guard let range = nsrange.toRange() else { return nil }
        let utf16Start = UTF16Index(range.lowerBound)
        let utf16End = UTF16Index(range.upperBound)
        
        guard let start = Index(utf16Start, within: self),
            let end = Index(utf16End, within: self)
            else { return nil }
        
        return start..<end
    }
}

// MARK:
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
