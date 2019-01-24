//
//  NanoHelperUrls.swift
//  WirexUtils
//
//  Created by Vlad Skintiyan on 1/24/19.
//  Copyright © 2019 wirex. All rights reserved.
//

import Foundation

private enum NanoHelperUrlsConstants {
    static let nanoBaseTxUrl = "https://www.nanode.co/block/"
}

public struct NanoHelperUrls {
    public static func nanoTx(hash: String) -> URL? {
        return URL(string: NanoHelperUrlsConstants.nanoBaseTxUrl + hash)
    }
}
