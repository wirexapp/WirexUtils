//
//  EthHelperUrls.swift
//  WirexUtils
//
//  Created by Jur STR on 8/17/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private enum EthHelperUrlsConstants {
    static let ethBaseTxUrl = "https://etherscan.io/tx/"
    static let testnetBaseTxUrl = "https://kovan.etherscan.io/tx/"
    static let ethereumScheme = ""//"ether:"
}

public struct EthHelperUrls {
    public static func ethChartsTx(hash: String) -> URL? {
        return URL(string: EthHelperUrlsConstants.ethBaseTxUrl + hash)
    }

    public static func ethTestnetChartsTx(hash: String) -> URL? {
        return URL(string: EthHelperUrlsConstants.testnetBaseTxUrl + hash)
    }
    
    public static func ethereumLink(address: String) -> String {
        return EthHelperUrlsConstants.ethereumScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
