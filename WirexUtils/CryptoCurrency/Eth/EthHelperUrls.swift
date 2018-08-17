//
//  EthHelperUrls.swift
//  WirexUtils
//
//  Created by Jur STR on 8/17/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private struct EthHelperUrlsConstants {
    static let ethBaseTxUrl = "https://etherscan.io/tx/"
    static let testnetBaseTxUrl = "https://kovan.etherscan.io/tx/"
}

public struct EthHelperUrls {
    public static func ethChartsTx(hash: String) -> URL? {
        return URL(string: EthHelperUrlsConstants.ethBaseTxUrl + hash)
    }

    public static func ethTestnetChartsTx(hash: String) -> URL? {
        return URL(string: EthHelperUrlsConstants.testnetBaseTxUrl + hash)
    }
}
