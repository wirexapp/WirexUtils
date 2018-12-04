//
//  CryptoAddressValidator.swift
//  WirexUtils
//
//  Created by Igor Voytovich on 12/4/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

public struct CryptoAddressConstants {
    public static let allowedCharacters = "^[a-z,0-9]{1,120}$"
}

public struct CryptoAddressValidator {
    public var isValid: Bool { return validate() }
    public let address: String
    private let regExp: NSRegularExpression
    
    public init(address: String, pattern: String? = CryptoAddressConstants.allowedCharacters) {
        self.address = address
        if let pattern = pattern, let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)  {
            self.regExp = regExp
        } else {
            self.regExp = try! NSRegularExpression(pattern: CryptoAddressConstants.allowedCharacters, options: .caseInsensitive)
        }
    }
    
    private func validate() -> Bool {
        return regExp.matches(in: address, options: [], range: NSRange(address.startIndex..., in: address)).count == 1
    }
}
