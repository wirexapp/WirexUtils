//
//  BtcHelperUrls.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/28/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import Foundation

private enum BtcHelperUrlsConstants {
    static let bitcoinScheme = "bitcoin:"
}

public struct BtcHelperUrls {
    public static func tradeblockTx(hash: String) -> URL? {
        return URL(string: "https://tradeblock.com/bitcoin/tx/" + hash)
    }
    
    public static func blockcypherTx(hash: String) -> URL? {
        return URL(string: "https://live.blockcypher.com/btc/tx/" + hash)
    }
    
    public static func bitcoinLink(address: String) -> String {
        return BtcHelperUrlsConstants.bitcoinScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
