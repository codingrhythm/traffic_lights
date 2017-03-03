//
//  IntersectionSwitchTests.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import XCTest
@testable import Traffic_Lights

class MockLight: TimedLight {
    var wasSwitchedOn = false
    var switchOnTime = Date()
    var actualDuration: TimeInterval = 0
    override var isOn: Bool {
        didSet {
            if isOn != oldValue {
                if !oldValue {
                    wasSwitchedOn = true
                    switchOnTime = Date()
                } else {
                    actualDuration = -switchOnTime.timeIntervalSinceNow
                }
                
            }
        }
    }
    
}

class IntersectionSwitchTests: XCTestCase {
    
    
    func testCanSwitchOnLightForOneSeconds() {
        let expectation = self.expectation(description: "Light is switched on for 1 second")
        let light = MockLight(in: UIColor.red, withDuration: 1)
        let intersectionSwitch = IntersectionSwitch()
        
        intersectionSwitch.switchOn(light) {
            XCTAssertFalse(light.isOn)
            XCTAssertTrue(light.wasSwitchedOn)
            XCTAssertEqual(Int(light.actualDuration), 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.1) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testCanSwitchOnLightWithoutDuration() {
        let expectation = self.expectation(description: "Light is switched on")
        let light = MockLight(in: UIColor.red)
        let intersectionSwitch = IntersectionSwitch()
        
        intersectionSwitch.switchOn(light) { 
            XCTAssertTrue(light.isOn)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testCanStart() {
        
    }
    
    func testCanStop() {
        
    }
}
