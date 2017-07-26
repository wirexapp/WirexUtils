//
//  WeakBox.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 12/11/16.
//  Copyright © 2016 Wirex. All rights reserved.
//

import Foundation

public struct WeakBox: Equatable {
    
    public weak var value: AnyObject?
    
    public init(_ value: AnyObject?) {
        self.value = value
    }
}

public func ==(lhs: WeakBox, rhs: WeakBox) -> Bool {
    return lhs.value === rhs.value
}
