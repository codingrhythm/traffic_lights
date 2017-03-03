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
    let intersectionSwitch = IntersectionSwitch()
    
    func testCanSwitchOnLightForTwoSeconds() {
        let expectation = self.expectation(description: "Light is switched on for 2 seconds")
        let light = MockLight(in: UIColor.red, withDuration: 2)
        
        intersectionSwitch.switchOn(light) {
            XCTAssertFalse(light.isOn)
            XCTAssertTrue(light.wasSwitchedOn)
            XCTAssertEqual(Int(light.actualDuration), 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.1) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testCanSwitchOnLightWithoutDuration() {
        let expectation = self.expectation(description: "Light is switched on")
        let light = MockLight(in: UIColor.red)
        
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
