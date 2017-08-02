//
//  EmailValidator.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 11/29/16.
//  Copyright © 2016 Wirex. All rights reserved.
//

import Foundation

public struct EmailValidator {
    
    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    public static func isValid(email: String) -> Bool {
        return emailTest.evaluate(with: email)
    }
}
