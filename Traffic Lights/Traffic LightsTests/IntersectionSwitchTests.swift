//
//  IntersectionSwitchTests.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import XCTest
@testable import Traffic_Lights

class IntersectionSwitchTests: XCTestCase {
    
    func testCanSwitchOn() {
        let snLight = TrafficLight(interval: 0.05, yellowDuration: 0.05, blinkInterval: 0.05)
        let ewLight = TrafficLight(interval: 0.05, yellowDuration: 0.05, blinkInterval: 0.05)
        let intersection = Intersection(southNorthLight: snLight, eastWestLight: ewLight)
        
        XCTAssertFalse(snLight.isOn)
        XCTAssertFalse(ewLight.isOn)
        XCTAssertEqual(snLight.mode, .default)
        XCTAssertEqual(ewLight.mode, .default)
        
        var numberOfChanges = 0
        var lastDirection: Intersection.TrafficDirection?
        
        let expectation = self.expectation(description: "Intersection can switch direction")
        intersection.onDirectionChange = {
            XCTAssertNotEqual(lastDirection, intersection.direction)
            lastDirection = intersection.direction
            numberOfChanges += 1
            
            if intersection.direction == .southNorth {
                XCTAssertEqual(snLight.currentLight?.color, UIColor.green)
                XCTAssertEqual(ewLight.currentLight?.color, UIColor.red)
            } else {
                XCTAssertEqual(snLight.currentLight?.color, UIColor.red)
                XCTAssertEqual(ewLight.currentLight?.color, UIColor.green)
            }
            
            if numberOfChanges == 5 {
                expectation.fulfill()
            }
        }
        
        intersection.isOn = true
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testCanSwitchOff() {
        let snLight = TrafficLight(interval: 0.05, yellowDuration: 0.05, blinkInterval: 0.05)
        let ewLight = TrafficLight(interval: 0.05, yellowDuration: 0.05, blinkInterval: 0.05)
        let intersection = Intersection(southNorthLight: snLight, eastWestLight: ewLight)
        
        let expectation = self.expectation(description: "Intersection can be switched off")
        var numberOfChanges = 0
        intersection.onDirectionChange = {
            numberOfChanges += 1
            
            if numberOfChanges == 3 {
                intersection.isOn = false
            }
        }
        
        intersection.stateChanged = { isOn in
            if !isOn {
                XCTAssertFalse(snLight.isOn)
                XCTAssertFalse(ewLight.isOn)
                XCTAssertEqual(snLight.mode, .default)
                XCTAssertEqual(ewLight.mode, .default)
                expectation.fulfill()
            }
        }
        
        intersection.isOn = true
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }

    }
}
