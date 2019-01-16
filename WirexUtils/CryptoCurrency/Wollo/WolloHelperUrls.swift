//
//  WolloHelperUrls.swift
//  WirexUtils
//
//  Created by Vlad Skintiyan on 12/19/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

private enum WolloHelperUrlsConstants {
    static let wolloBaseTxUrl = "https://stellar.expert/explorer/public/tx/"
    static let testnetBaseTxUrl = "https://stellar.expert/explorer/testnet/tx/"
    static let wolloScheme = ""//"wollo:"
}

public struct WolloHelperUrls {
    public static func wolloTx(hash: String) -> URL? {
        return URL(string: WolloHelperUrlsConstants.wolloBaseTxUrl + hash)
    }
    
    public static func wolloTestnetTx(hash: String) -> URL? {
        return URL(string: WolloHelperUrlsConstants.testnetBaseTxUrl + hash)
    }
    
    public static func wolloLink(address: String) -> String {
        return WolloHelperUrlsConstants.wolloScheme + address.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
