//
//  XrpHelperUrls.swift
//  WirexUtils
//
//  Created by Hutorov Yevhenii on 7/5/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private enum XrpHelperUrlsConstants {
    static let rippleScheme = ""//"ripple:"
    static let tagArgument = "?dt="
    static let baseXrpChartsUrlString = "https://bithomp.com/explorer/"
}

public struct XrpHelperUrls {
    public static func xrpChartsTx(hash: String) -> URL? {
        return URL(string: XrpHelperUrlsConstants.baseXrpChartsUrlString + hash)
    }
    
    public static func rippleLink(address: String, destinationTag: String? = nil) -> String {
        let link = XrpHelperUrlsConstants.rippleScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let tag = destinationTag?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return link + XrpHelperUrlsConstants.tagArgument + tag
        } else {
            return link
        }
    }
}
