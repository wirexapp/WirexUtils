//
//  MulticastDelegate.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 12/11/16.
//  Copyright © 2016 Wirex. All rights reserved.
//

import Foundation

public class MulticastDelegate <T> {
    
    public init() {}
    
    public func addDelegate(_ delegate: T) {
        lock.lock()
        defer { self.lock.unlock() }
        
        weakDelegates.append(WeakBox(delegate as AnyObject))
    }
    
    public func removeDelegate(_ delegate: T) {
        lock.lock()
        defer { self.lock.unlock() }
        
        weakDelegates = weakDelegates.filter { (p) -> Bool in
            return p.value !== delegate as AnyObject
        }
    }
    
    public func invoke(_ invocation: (T) -> Void) {
        lock.lock()
        defer { self.lock.unlock() }

        for (index, delegate) in weakDelegates.enumerated().reversed() {
            if let delegate = delegate.value as? T {
                invocation(delegate)
            } else {
                weakDelegates.remove(at: index)
            }
        }
    }
    
    private var lock = NSLock()
    private var weakDelegates = [WeakBox]()
}

