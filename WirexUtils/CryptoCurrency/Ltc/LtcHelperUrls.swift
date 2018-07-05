//
//  LtcHelperUrls.swift
//  WirexUtils
//
//  Created by Hutorov Yevhenii on 4/4/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private struct LtcHelperUrlsConstants {
    static let litecoinScheme = "litecoin:"
}

public struct LtcHelperUrls {
    public static func tradeblockTx(hash: String) -> URL? {
        return URL(string: "https://live.blockcypher.com/ltc/tx/" + hash)
    }
    
    public static func litecoinLink(address: String) -> String {
        return LtcHelperUrlsConstants.litecoinScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
