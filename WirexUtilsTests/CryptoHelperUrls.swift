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
        
//        XCTAssertEqual(link, "litecoin:1234abcd")
        XCTAssertEqual(link, "1234abcd")
    }
    
    func testRippleLinkWithoutTag() {
        let link = XrpHelperUrls.rippleLink(address: "1234abcd")
        
//        XCTAssertEqual(link, "ripple:1234abcd")
        XCTAssertEqual(link, "1234abcd")
    }
    
    func testRippleLinkWithTag() {
        let link = XrpHelperUrls.rippleLink(address: "1234abcd", destinationTag: "5678")
        
//        XCTAssertEqual(link, "ripple:1234abcd?dt=5678")
        XCTAssertEqual(link, "1234abcd?dt=5678")
    }
    
    func testWolloLinkWithTag() {
        let link = WolloHelperUrls.wolloLink(address: "1234abcd")
        
        //        XCTAssertEqual(link, "ripple:1234abcd?dt=5678")
        XCTAssertEqual(link, "1234abcd")
    }
    
    func testWavesLinkWithTag() {
        let link = WavesHelperUrls.wavesLink(address: "1234abcd")
        
        //        XCTAssertEqual(link, "ripple:1234abcd?dt=5678")
        XCTAssertEqual(link, "1234abcd")
    }
    
    func testrippleInfoToolTxUrl() {
        let url = XrpHelperUrls.xrpChartsTx(hash:  "081E7626F9073A168D04A52B50F361764DEA87AAD9736BE4524EEB9E718B200C")
        
        XCTAssertEqual(url?.absoluteString, "https://xrpcharts.ripple.com/#/transactions/081E7626F9073A168D04A52B50F361764DEA87AAD9736BE4524EEB9E718B200C")
    }
}
