//
//  XprHelperUrls.swift
//  WirexUtils
//
//  Created by Hutorov Yevhenii on 7/5/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import Foundation

public struct XprHelperUrls {
    public static func rippleInfoToolTx(hash: String) -> URL? {
        return URL(string: "https://ripple.com/build/ripple-info-tool/#" + hash)
    }
    
    public static func rippleLink(address: String, destinationTag: String? = nil) -> String {
        let link = "ripple:" + address.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let tag = destinationTag?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return link + "?dt=" + tag
        } else {
            return link
        }
    }
}
