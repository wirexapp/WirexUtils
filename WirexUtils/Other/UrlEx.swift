//
//  UrlExtension.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 6/29/17.
//  Copyright © 2017 gavrilaf. All rights reserved.
//

import Foundation

extension URL {
    public var queryItems: [String: String]? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)?.dictRepr
    }
}

extension URLComponents {
    public var dictRepr:  [String: String]? {
        return self.queryItems?
            .flatMap { $0.dictRepr }
            .reduce([:], +)
    }
}

extension URLQueryItem {
    public var dictRepr: [String: String]? {
        if let value = value {
            return [name: value]
        }
        return nil
    }
}

fileprivate func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}
