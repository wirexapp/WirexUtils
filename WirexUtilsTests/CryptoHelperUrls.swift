//
//  CryptoHelperUrls.swift
//  WirexUtilsTests
//
//  Created by Hutorov Yevhenii on 7/5/18.
//  Copyright © 2018 wirex. All rights reserved.
//

import XCTest
import WirexUtils

class CryptoHelperUrls: XCTestCase {
    
    func testLitecoinLink() {
        let link = LtcHelperUrls.litecoinLink(address: "1234abcd")
        
        XCTAssertEqual(link, "litecoin:1234abcd")
    }
    
    func testRippleLinkWithoutTag() {
        let link = XprHelperUrls.rippleLink(address: "1234abcd")
        
        XCTAssertEqual(link, "ripple:1234abcd")
    }
    
    func testRippleLinkWithTag() {
        let link = XprHelperUrls.rippleLink(address: "1234abcd", destinationTag: "5678")
        
        XCTAssertEqual(link, "ripple:1234abcd?dt=5678")
    }
    
    func testrippleInfoToolTxUrl() {
        let url = XprHelperUrls.rippleInfoToolTx(hash: "7138341640E43809E989FFC45DA072EE5A3F4778D5F1605CF269674F378A5FAD")
        
        XCTAssertEqual(url?.absoluteString, "https://ripple.com/build/ripple-info-tool/#7138341640E43809E989FFC45DA072EE5A3F4778D5F1605CF269674F378A5FAD")
    }
}
