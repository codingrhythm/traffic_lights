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

class MockIntersectionSwitch: IntersectionSwitch {
    var numberOfDirectionChanged = 0
    var maxNumberOfDirectionChanges = 2
    var onComplete:(()->Void)?
    var lightsSwitchedOn:[TimedLight] = []
    
    override func switchOn(_ light: TimedLight, completion: @escaping (() -> Void)) {
        lightsSwitchedOn.append(light)
        super.switchOn(light, completion: completion)
    }
    
    override func reverseDirection() {
        if numberOfDirectionChanged < maxNumberOfDirectionChanges {
            numberOfDirectionChanged += 1
            super.reverseDirection()
        } else {
            onComplete?()
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
        let southNorthLight = TrafficLight(interval: 0.6, yellowDuration: 0.1)
        let eastWestLight = TrafficLight(interval: 0.6, yellowDuration: 1)
        
        let intersectionSwitch = MockIntersectionSwitch(
            southNorthLight: southNorthLight,
            eastWestLight: eastWestLight
        )
        
        let expectation = self.expectation(description: "Traffic lights are on")
        let expectedLightPattern: [UIColor] = [UIColor.green, UIColor.yellow, UIColor.red]
        intersectionSwitch.onComplete = {
            XCTAssertEqual(intersectionSwitch.lightsSwitchedOn.count, 9)
            
            for i in 0...8 {
                XCTAssertEqual(intersectionSwitch.lightsSwitchedOn[i].color, expectedLightPattern[i % 3])
            }
            
            expectation.fulfill()
        }
        
        intersectionSwitch.start()
        
        waitForExpectations(timeout: 4) { (error) in
            XCTAssertNil(error)
        }
    }
}
