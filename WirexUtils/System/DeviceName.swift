//
//  DeviceName.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 10/5/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import Foundation

public struct DeviceName {
    
    public static func name(byCode code: String) -> String? {
        return devicesByCode[code]
    }
    
    static let devicesByCode = ["i386"     : "Simulator",
                                "x86_64"   : "Simulator",
                         
                                "iPod1,1"  : "iPod Touch 1G",
                                "iPod2,1"  : "iPod Touch 2G",
                                "iPod3,1"  : "iPod Touch 3G",
                                "iPod4,1"  : "iPod Touch 4G",
                                "iPod5,1"  : "iPod Touch 5G",
                                "iPod7,1"  : "iPod Touch 6G",
                         
                                "iPhone1,1" : "iPhone",
                                "iPhone1,2" : "iPhone 3G",
                                "iPhone2,1" : "iPhone 3GS",
                                "iPhone3,1" : "iPhone 4",
                                "iPhone3,2" : "iPhone 4",
                                "iPhone3,3" : "iPhone 4",
                                "iPhone4,1" : "iPhone 4S",
                                "iPhone5,1" : "iPhone 5",
                                "iPhone5,2" : "iPhone 5",
                                "iPhone5,3" : "iPhone 5c",
                                "iPhone5,4" : "iPhone 5c",
                                "iPhone6,1" : "iPhone 5s",
                                "iPhone6,2" : "iPhone 5s",
                                "iPhone7,1" : "iPhone 6 Plus",
                                "iPhone7,2" : "iPhone 6",
                                "iPhone8,1" : "iPhone 6S",
                                "iPhone8,2" : "iPhone 6S Plus",
                                "iPhone8,4" : "iPhone SE",
                                "iPhone9,1" : "iPhone 7",
                                "iPhone9,3" : "iPhone 7",
                                "iPhone9,2" : "iPhone 7 Plus",
                                "iPhone9,4" : "iPhone 7 Plus",
                                "iPhone10,1": "iPhone 8",
                                "iPhone10,4": "iPhone 8",
                                "iPhone10,2": "iPhone 8 Plus",
                                "iPhone10,5": "iPhone 8 Plus",
                                "iPhone10,3": "iPhone X",
                                "iPhone10,6": "iPhone X",
                                "iPhone11,2": "iPhone XS",
                                "iPhone11,4": "iPhone XS Max",
                                "iPhone11,6": "iPhone XS Max",
                                "iPhone11,8": "iPhone XR",
                         
                                "iPad1,1" : "iPad",
                                "iPad2,1" : "iPad 2 (WiFi)",
                                "iPad2,2" : "iPad 2 (GSM)",
                                "iPad2,3" : "iPad 2 (CDMA)",
                                "iPad2,4" : "iPad 2 (32nm)",
                                "iPad2,5" : "iPad mini (WiFi)",
                                "iPad2,6" : "iPad mini (GSM)",
                                "iPad2,7" : "iPad mini (CDMA)",
                                "iPad3,1" : "iPad 3(WiFi)",
                                "iPad3,2" : "iPad 3(CDMA)",
                                "iPad3,3" : "iPad 3(4G)",
                                "iPad3,4" : "iPad 4 (WiFi)",
                                "iPad3,5" : "iPad 4 (4G)",
                                "iPad3,6" : "iPad 4 (CDMA)",
                                "iPad4,1" : "iPad Air",
                                "iPad4,2" : "iPad Air (4G)",
                                "iPad4,3" : "iPad Air (4G)",
                                "iPad4,4" : "iPad mini 2",
                                "iPad4,5" : "iPad mini 2",
                                "iPad4,6" : "iPad mini 2",
                                "iPad4,7" : "iPad mini 3",
                                "iPad4,8" : "iPad mini 3",
                                "iPad4,9" : "iPad mini 3",
                                "iPad5,1" : "iPad mini 4",
                                "iPad5,2" : "iPad mini 4",
                                "iPad5,3" : "iPad Air 2",
                                "iPad5,4" : "iPad Air 2",
                                "iPad6,3" : "iPad Pro 9.7-inch",
                                "iPad6,4" : "iPad Pro 9.7-inch",
                                "iPad6,7" : "iPad Pro 1G",
                                "iPad6,8" : "iPad Pro 1G",
                                "iPad6,11": "iPad (2017)",
                                "iPad6,12": "iPad (2017)",
                                "iPad7,1" : "iPad Pro 2G",
                                "iPad7,2" : "iPad Pro 2G",
                                "iPad7,3" : "iPad Pro 10.5-inch",
                                "iPad7,4" : "iPad Pro 10.5-inch",
                                "iPad8,1" : "iPad Pro 11-inch",
                                "iPad8,2" : "iPad Pro 11-inch",
                                "iPad8,3" : "iPad Pro 11-inch",
                                "iPad8,4" : "iPad Pro 11-inch",
                                "iPad8,5" : "iPad Pro 12.9-inch",
                                "iPad8,6" : "iPad Pro 12.9-inch",
                                "iPad8,7" : "iPad Pro 12.9-inch",
                                "iPad8,8" : "iPad Pro 12.9-inch"]
}
