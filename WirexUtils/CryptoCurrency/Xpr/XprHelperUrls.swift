//
//  XprHelperUrls.swift
//  WirexUtils
//
//  Created by Hutorov Yevhenii on 7/5/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private enum XprHelperUrlsConstants {
    static let rippleScheme = "ripple:"
    static let tagArgument = "?dt="
    static let baseXrpChartsUrlString = "https://xrpcharts.ripple.com/#/transactions/"
}

public struct XprHelperUrls {
    public static func xrpChartsTx(hash: String) -> URL? {
        return URL(string: XprHelperUrlsConstants.baseXrpChartsUrlString + hash)
    }
    
    public static func rippleLink(address: String, destinationTag: String? = nil) -> String {
        let link = XprHelperUrlsConstants.rippleScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let tag = destinationTag?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return link + XprHelperUrlsConstants.tagArgument + tag
        } else {
            return link
        }
    }
}
