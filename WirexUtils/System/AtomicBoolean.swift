//
//  AtomicBoolean.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/10/17.
//  Copyright © 2017 Wirex. All rights reserved.
//

import Foundation

public struct AtomicBoolean {
    private var val: UInt8 = 0
    
    public var value: Bool {
        get {
            return val != 0
        }
        
        set {
            if newValue {
                OSAtomicTestAndSet(7, &val)
            } else {
                OSAtomicTestAndClear(7, &val)
            }
        }
    }
}
