//
//  SysInfo.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 10/5/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import Foundation

// https://github.com/mattgallagher/CwlUtils/blob/master/Sources/CwlUtils/CwlSysctl.swift

public struct SysInfo {
    
    public struct Info {
        public let hostName: String
        public let machine: String
        public let model: String
        public let activeCPUs: Int32
        public let osRelease: String
        public let osRev: Int32
        public let osType: String
        public let osVersion: String
    }
    
    public static func getInfo() throws -> Info {
        return Info(hostName: try SysInfo.stringForKeys([CTL_KERN, KERN_HOSTNAME]),
                    machine: try SysInfo.stringForKeys([CTL_HW, HW_MODEL]),
                    model: try SysInfo.stringForKeys([CTL_HW, HW_MACHINE]),
                    activeCPUs: try SysInfo.valueOfType(Int32.self, forKeys: [CTL_HW, HW_AVAILCPU]),
                    osRelease: try SysInfo.stringForKeys([CTL_KERN, KERN_OSRELEASE]),
                    osRev: try SysInfo.valueOfType(Int32.self, forKeys: [CTL_KERN, KERN_OSREV]),
                    osType: try SysInfo.stringForKeys([CTL_KERN, KERN_OSTYPE]),
                    osVersion: try SysInfo.stringForKeys([CTL_KERN, KERN_OSVERSION]))
    }
    
    /// "My-Name-iPhone" (from Settings -> General -> About -> Name)
    public static var hostName: String {
        return (try? SysInfo.stringForKeys([CTL_KERN, KERN_HOSTNAME])) ?? ""
    }
    
    /// "N71mAP"
    public static var machine: String {
        return (try? SysInfo.stringForKeys([CTL_HW, HW_MODEL])) ?? ""
    }
    
    /// e.g. "iPhone8,1"
    public static var model: String {
        return (try? SysInfo.stringForKeys([CTL_HW, HW_MACHINE])) ?? ""
    }
    
    /// e.g. "8" or "2"
    public static var activeCPUs: Int32 {
        return (try? SysInfo.valueOfType(Int32.self, forKeys: [CTL_HW, HW_AVAILCPU])) ?? 0
    }
    
    /// e.g. "15.3.0" or "15.0.0"
    public static var osRelease: String {
        return (try? SysInfo.stringForKeys([CTL_KERN, KERN_OSRELEASE])) ?? ""
    }
    
    /// e.g. 199506 or 199506
    public static var osRev: Int32 {
        return (try? SysInfo.valueOfType(Int32.self, forKeys: [CTL_KERN, KERN_OSREV])) ?? 0
    }
    
    /// e.g. "Darwin" or "Darwin"
    public static var osType: String {
        return (try? SysInfo.stringForKeys([CTL_KERN, KERN_OSTYPE])) ?? ""
    }
    
    /// e.g. "15D21" or "13D20"
    public static var osVersion: String {
        return (try? SysInfo.stringForKeys([CTL_KERN, KERN_OSVERSION])) ?? ""
    }
    
    /// Redable description of iPhone
    public static var deviceName: String {
        return DeviceName.name(byCode: self.model) ?? self.model
   }
    
    /// Redable description of iOS
    public static var osDescription: String {
        return "iOS \(UIDevice.current.systemVersion)"
    }
    
    
    // MARK: Internal
    
    enum Error: Swift.Error {
        case unknown
        case malformedUTF8
        case invalidSize
        case posixError(POSIXErrorCode)
    }
    
    /// Access the raw data for an array of sysctl identifiers.
    static func dataForKeys(_ keys: [Int32]) throws -> [Int8] {
        return try keys.withUnsafeBufferPointer() { keysPointer throws -> [Int8] in
            // Preflight the request to get the required data size
            var requiredSize = 0
            let preFlightResult = Darwin.sysctl(UnsafeMutablePointer<Int32>(mutating: keysPointer.baseAddress),
                                                UInt32(keys.count), nil, &requiredSize, nil, 0)
            if preFlightResult != 0 {
                throw POSIXErrorCode(rawValue: errno).map { Error.posixError($0) } ?? Error.unknown
            }
            
            // Run the actual request with an appropriately sized array buffer
            let data = Array<Int8>(repeating: 0, count: requiredSize)
            let result = data.withUnsafeBufferPointer() { dataBuffer -> Int32 in
                return Darwin.sysctl(UnsafeMutablePointer<Int32>(mutating: keysPointer.baseAddress), UInt32(keys.count), UnsafeMutableRawPointer(mutating: dataBuffer.baseAddress), &requiredSize, nil, 0)
            }
            if result != 0 {
                throw POSIXErrorCode(rawValue: errno).map { Error.posixError($0) } ?? Error.unknown
            }
            
            return data
        }
    }
    
    /// Convert a sysctl name string like "hw.memsize" to the array of `sysctl` identifiers (e.g. [CTL_HW, HW_MEMSIZE])
    static func keysForName(_ name: String) throws -> [Int32] {
        var keysBufferSize = Int(CTL_MAXNAME)
        var keysBuffer = Array<Int32>(repeating: 0, count: keysBufferSize)
        try keysBuffer.withUnsafeMutableBufferPointer { (lbp: inout UnsafeMutableBufferPointer<Int32>) throws in
            try name.withCString { (nbp: UnsafePointer<Int8>) throws in
                guard sysctlnametomib(nbp, lbp.baseAddress, &keysBufferSize) == 0 else {
                    throw POSIXErrorCode(rawValue: errno).map { Error.posixError($0) } ?? Error.unknown
                }
            }
        }
        if keysBuffer.count > keysBufferSize {
            keysBuffer.removeSubrange(keysBufferSize..<keysBuffer.count)
        }
        return keysBuffer
    }
    
    /// Invoke `sysctl` with an array of identifers, interpreting the returned buffer as the specified type. This function will throw `Error.invalidSize` if the size of buffer returned from `sysctl` fails to match the size of `T`.
    static func valueOfType<T>(_ type: T.Type, forKeys keys: [Int32]) throws -> T {
        let buffer = try dataForKeys(keys)
        if buffer.count != MemoryLayout<T>.size {
            throw Error.invalidSize
        }
        return try buffer.withUnsafeBufferPointer() { bufferPtr throws -> T in
            guard let baseAddress = bufferPtr.baseAddress else { throw Error.unknown }
            return baseAddress.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
    }
    
    /// Invoke `sysctl` with an array of identifers, interpreting the returned buffer as the specified type. This function will throw `Error.invalidSize` if the size of buffer returned from `sysctl` fails to match the size of `T`.
    static func valueOfType<T>(_ type: T.Type, forKeys keys: Int32...) throws -> T {
        return try valueOfType(type, forKeys: keys)
    }
    
    /// Invoke `sysctl` with the specified name, interpreting the returned buffer as the specified type. This function will throw `Error.invalidSize` if the size of buffer returned from `sysctl` fails to match the size of `T`.
    static func valueOfType<T>(_ type: T.Type, forName name: String) throws -> T {
        return try valueOfType(type, forKeys: keysForName(name))
    }
    
    /// Invoke `sysctl` with an array of identifers, interpreting the returned buffer as a `String`. This function will throw `Error.malformedUTF8` if the buffer returned from `sysctl` cannot be interpreted as a UTF8 buffer.
    static func stringForKeys(_ keys: [Int32]) throws -> String {
        let optionalString = try dataForKeys(keys).withUnsafeBufferPointer() { dataPointer -> String? in
            dataPointer.baseAddress.flatMap { String(validatingUTF8: $0) }
        }
        guard let s = optionalString else {
            throw Error.malformedUTF8
        }
        return s
    }
    
    /// Invoke `sysctl` with an array of identifers, interpreting the returned buffer as a `String`. This function will throw `Error.malformedUTF8` if the buffer returned from `sysctl` cannot be interpreted as a UTF8 buffer.
    static func stringForKeys(_ keys: Int32...) throws -> String {
        return try stringForKeys(keys)
    }
    
    /// Invoke `sysctl` with the specified name, interpreting the returned buffer as a `String`. This function will throw `Error.malformedUTF8` if the buffer returned from `sysctl` cannot be interpreted as a UTF8 buffer.
    static func stringForName(_ name: String) throws -> String {
        return try stringForKeys(keysForName(name))
    }
}
