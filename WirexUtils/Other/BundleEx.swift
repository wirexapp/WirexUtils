//
//  BundleExtension.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 5/25/17.
//  Copyright © 2017 Wirex. All rights reserved.
//

import Foundation

extension Bundle {
    
    public func string(key: String) -> String? {
        return self.infoDictionary?[key] as? String
    }
}
