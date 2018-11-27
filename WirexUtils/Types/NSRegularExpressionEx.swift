//
//  NSRegularExpressionEx.swift
//  WirexUtils
//
//  Created by Valerii Maliuk on 11/27/18.
//  Copyright © 2018 wirex. All rights reserved.
//

//import Foundation

public extension NSRegularExpression {
     public convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    public func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
