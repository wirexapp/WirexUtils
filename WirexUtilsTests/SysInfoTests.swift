//
//  SysInfoTests.swift
//  WirexUtilsTests
//
//  Created by Eugen Fedchenko on 10/5/17.
//  Copyright © 2017 wirex. All rights reserved.
//

import XCTest
import WirexUtils

class SysInfoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSysInfo() {
        let hostName = SysInfo.hostName
        let machine = SysInfo.machine
        let model = SysInfo.model
        let activeCPUs = SysInfo.activeCPUs
        let osRelease = SysInfo.osRelease
        let osRev = SysInfo.osRev
        let osType = SysInfo.osType
        let osVersion = SysInfo.osVersion
        let deviceName = SysInfo.deviceName
        let osDescription = SysInfo.osDescription
        
        print("\(hostName), \(machine), \(model), \(activeCPUs), \(osRelease), \(osRev), \(osType), \(osVersion), \(deviceName), \(osDescription)")
        
        let inf = try? SysInfo.getInfo()
        XCTAssertNotNil(inf)
        
        XCTAssertEqual(hostName, inf?.hostName)
        XCTAssertEqual(machine, inf?.machine)
        XCTAssertEqual(model, inf?.model)
        XCTAssertEqual(activeCPUs, inf?.activeCPUs)
        XCTAssertEqual(osRelease, inf?.osRelease)
        XCTAssertEqual(osRev, inf?.osRev)
        XCTAssertEqual(osType, inf?.osType)
        XCTAssertEqual(osVersion, inf?.osVersion)
    }
}
