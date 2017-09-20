//
//  AtomicBoolean.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/10/17.
//  Copyright © 2017 Wirex. All rights reserved.
//

import Foundation

public struct AtomicBoolean {
    
    public init() {}
    
    public var value: Bool {
        get { return flag != 0 }
        
        set {
            if newValue {
                OSAtomicTestAndSet(7, &flag)
            } else {
                OSAtomicTestAndClear(7, &flag)
            }
        }
    }
    
    private var flag: UInt8 = 0
}
