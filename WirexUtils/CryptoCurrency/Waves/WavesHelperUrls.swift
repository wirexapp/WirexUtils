//
//  WavesHelperUrls.swift
//  WirexUtils
//
//  Created by Yevhenii Hutorov on 11/28/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private enum WavesHelperUrlsConstants {
    static let wavesBaseTxUrl = "https://wavesexplorer.com/tx/"
    static let testnetBaseTxUrl = "https://testnet.wavesexplorer.com/tx/"
    static let wavesScheme = ""//"waves:"
}

public struct WavesHelperUrls {
    public static func wavesTx(hash: String) -> URL? {
        return URL(string: WavesHelperUrlsConstants.wavesBaseTxUrl + hash)
    }
    
    public static func wavesTestnetTx(hash: String) -> URL? {
        return URL(string: WavesHelperUrlsConstants.testnetBaseTxUrl + hash)
    }
    
    public static func wavesLink(address: String) -> String {
        return WavesHelperUrlsConstants.wavesScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
