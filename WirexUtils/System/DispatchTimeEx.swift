//
//  DispatchTime.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/26/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import Foundation

extension DispatchTime {
    
    public func since(_ previous: DispatchTime) -> DispatchTimeInterval {
        return .nanoseconds(Int(uptimeNanoseconds - previous.uptimeNanoseconds))
    }
}

extension DispatchTimeInterval {
    
    public static func fromSeconds(_ seconds: Double) -> DispatchTimeInterval {
        if MemoryLayout<Int>.size < 8 {
            return .milliseconds(Int(seconds * Double(NSEC_PER_SEC / NSEC_PER_MSEC)))
        } else {
            return .nanoseconds(Int(seconds * Double(NSEC_PER_SEC)))
        }
    }
    
    public func toSeconds() -> Double {
        switch self {
            case .seconds(let t): return Double(t)
            case .milliseconds(let t): return (1.0 / Double(NSEC_PER_MSEC)) * Double(t)
            case .microseconds(let t): return (1.0 / Double(NSEC_PER_USEC)) * Double(t)
            case .nanoseconds(let t): return (1.0 / Double(NSEC_PER_SEC)) * Double(t)
        }
    }
    
    public func toNanoseconds() -> Int64 {
        switch self {
            case .seconds(let t): return Int64(NSEC_PER_SEC) * Int64(t)
            case .milliseconds(let t): return Int64(NSEC_PER_MSEC) * Int64(t)
            case .microseconds(let t): return Int64(NSEC_PER_USEC) * Int64(t)
            case .nanoseconds(let t): return Int64(t)
        }
    }
}
