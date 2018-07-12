//
//  CryptoPaymentURI.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 6/29/17.
//  Copyright © 2017 gavrilaf. All rights reserved.
//

import Foundation

public struct CryptoPaymentURI {
    
    public enum Scheme: String {
        case btc = "bitcoin"
        case ltc = "litecoin"
        case xrp = "ripple"
        
        public var str: String { return self.rawValue }
    }
    
    public enum Fields: String {
        case amount = "amount"
        case label = "label"
        case msg = "message"
        case destinationTag = "dt"
        
        public var str: String { return self.rawValue }
    }
    
    public let address: String
    public let parameters: [String : String]
    public let scheme: Scheme?
    
    public var amount: Decimal? {
        if let s = parameters[Fields.amount.str] {
            return formatter.number(from: s)?.decimalValue
        }
        return nil
    }
    
    public var label: String? {
        return parameters[Fields.label.str]
    }
    
    public var message: String? {
        return parameters[Fields.msg.str]
    }
    
    public var destinationTag: String? {
        return parameters[Fields.destinationTag.str]
    }
    
    public init(scheme: Scheme, address: String, amount: Decimal? = nil, label: String? = nil, message: String? = nil, params: [String : String]? = nil) {
        self.scheme = scheme
        self.address = address
        
        var pp = Dictionary<String, String>()
        
        if let amount = amount {
            pp[Fields.amount.str] = formatter.string(from: amount as NSDecimalNumber)
        }
        
        if let label = label {
            pp[Fields.label.str] = label
        }
        
        if let label = label {
            pp[Fields.label.str] = label
        }
        
        if let params = params {
            params.forEach { (k, v) in pp[k] = v }
        }
        
        self.parameters = pp
    }
    
    public init?(fromStr s: String) {
        guard let components = URLComponents(string: s) else { return nil }
        guard !components.path.isEmpty else { return nil }
        
        self.scheme = Scheme(rawValue: components.scheme?.lowercased() ?? "")
        self.address = components.path
        self.parameters = components.dictRepr
    }
    
    public var str: String {
        var c = URLComponents()
        
        c.scheme = self.scheme?.str ?? ""
        c.path = self.address
        
        let qi = parameters.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        
        if !qi.isEmpty {
            c.queryItems = qi
        }
        
        return c.string ?? ""
    }
    
    private let formatter = { () -> NumberFormatter in
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.minimumIntegerDigits = 1
        fmt.maximumFractionDigits = 6
        fmt.roundingMode = .down
        fmt.decimalSeparator = "."
        
        return fmt
    }()
}
