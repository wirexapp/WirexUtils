//
//  BtcHelperUrls.swift
//  WirexUtils
//
//  Created by Eugen Fedchenko on 7/28/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import Foundation

public struct BtcHelperUrls {
    public static func tradeblockTx(hash: String) -> URL? {
        return URL(string: "https://tradeblock.com/bitcoin/tx/" + hash)
    }
}
