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
    
    private func switchOn(light:MockLight, completion:@escaping ()->Void) {
        intersectionSwitch.switchOn(light) {
            XCTAssertFalse(light.isOn)
            XCTAssertTrue(light.wasSwitchedOn)
            completion()
        }
    }
    
    func testCanSwitchOnLightForTwoSeconds() {
        let expectation = self.expectation(description: "Light is switched on for 2 seconds")
        let light = MockLight(in: UIColor.red, withDuration: 2)
        
        self.switchOn(light: light) {
            XCTAssertEqual(Int(light.actualDuration), 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.1) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testCanSwitchOnLightForFiveSeconds() {
        let expectation = self.expectation(description: "Light is switched on for 5 seconds")
        let light = MockLight(in: UIColor.red, withDuration: 5)
        
        self.switchOn(light: light) {
            XCTAssertEqual(Int(light.actualDuration), 5)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.1) { (error) in
            XCTAssertNil(error)
        }
    }
}
