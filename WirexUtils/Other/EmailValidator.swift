//
//  EmailValidator.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 11/29/16.
//  Copyright © 2016 Wirex. All rights reserved.
//

import Foundation

public struct EmailValidator {
    
    private static let name = "[a-z0-9!#$%&'*+/=?^_`{|}~]"
    private static let server = "[a-z0-9\\.-]"
    private static let pattern = "^\(name)+([\\.-]?\(name)+)*@\(server)+([\\.-]?\(server)+)*(\\.\\w{2,3})+$"
    
    private static let rx = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    
    public static func isValid(email: String) -> Bool {
        return email.isValid(regex: rx)
        //return email.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
}
