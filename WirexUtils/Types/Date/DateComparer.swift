//
//  DateComparer.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 2/13/17.
//  Copyright © 2017 Wirex. All rights reserved.
//

import Foundation

public struct DateComparer {

    public static func minutesBetween(_ start: Date, _ end: Date) -> Int {
        let components = Calendar.current.dateComponents([.minute], from: start, to: end)
        return components.minute ?? 0
    }
    
    public static func hoursBetween(_ start: Date, _ end: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: start, to: end)
        return components.day ?? 0
    }

    public static func daysBetween(_ start: Date, _ end: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    public static func monthsBetween(_ start: Date, _ end: Date) -> Int {
        let components = Calendar.current.dateComponents([.month], from: start, to: end)
        return components.month ?? 0
    }
    
    public static func yearsBetween(_ start: Date, _ end: Date) -> Int {
        let components = Calendar.current.dateComponents([.year], from: start, to: end)
        return components.year ?? 0
    }
    
    // MARK:
    
    public static func yearsBeforeNow(_ d: Date) -> Int {
        let now = Date()
        return yearsBetween(d, now)
    }
    
    public static func monthsBeforeNow(_ d: Date) -> Int {
        let now = Date()
        return monthsBetween(d, now)
    }
    
    public static func daysBeforeNow(_ d: Date) -> Int {
        let now = Date()
        return daysBetween(d, now)
    }

    public static func hoursBeforeNow(_ d: Date) -> Int {
        let now = Date()
        return hoursBetween(d, now)
    }
    
    public static func minutesBeforeNow(_ d: Date) -> Int {
        let now = Date()
        return minutesBetween(d, now)
    }
}
