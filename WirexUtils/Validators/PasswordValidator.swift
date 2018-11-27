//
//  PasswordValidator.swift
//  WirexUtils
//
//  Created by Valerii Maliuk on 11/27/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

public enum PasswordStrength {
    case weak
    case medium
    case strong
}

public protocol PasswordValidator {
    func validate(_ password: String) -> PasswordStrength
}

public class PasswordStrengthValidator: PasswordValidator {
    private let strongStrengthRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])(?=.{16,})"
    private let mediumStrengthRegEx = "(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{8,})"

    public init() {}
    public func validate(_ password: String) -> PasswordStrength {
        let strongPredicate = NSRegularExpression(strongStrengthRegEx)
        let mediumPredicate = NSRegularExpression(mediumStrengthRegEx)

        if strongPredicate.matches(password) {
            return .strong
        } else if mediumPredicate.matches(password) {
            return .medium
        } else {
            return .weak
        }
    }
}

