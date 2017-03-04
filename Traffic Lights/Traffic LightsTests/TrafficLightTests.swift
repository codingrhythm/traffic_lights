//
//  TrafficLightTests.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import XCTest
@testable import Traffic_Lights

class TrafficLightTests: XCTestCase {
    
    func testCanInitialize() {
        let trafficLight = TrafficLight()
        XCTAssertEqual(trafficLight.lights.count, 3)
        XCTAssertEqual(trafficLight.lights[0].color, UIColor.green)
        XCTAssertEqual(trafficLight.lights[1].color, UIColor.yellow)
        XCTAssertEqual(trafficLight.lights[2].color, UIColor.red)
        XCTAssertFalse(trafficLight.isOn)
        XCTAssertEqual(trafficLight.mode, .default)
    }
    
    private func checkIsDeviceOn(within devices:[Device], onlyAt index:Int) {
        XCTAssertTrue(devices[index].isOn)
        for i in 0...devices.count - 1 {
            if devices[i].isOn {
                if i != index {
                    XCTFail(String(format: "Device should not be on at %d", i))
                }
            }
        }
    }
    
    func testCanSwitchOff() {
        let trafficLight = TrafficLight(interval: 0, yellowDuration: 0, blinkInterval: 0)
        let expectation = self.expectation(description: "Light mode should be default")
        trafficLight.onLightChanged = { completed in
            XCTAssertTrue(completed)
            XCTAssertEqual(trafficLight.mode, .red)
            
            var numberOfBlink = 0
            trafficLight.onLightChanged = { completed in
                XCTAssertFalse(completed)
                XCTAssertEqual(trafficLight.mode, .default)
                self.checkIsDeviceOn(within: trafficLight.lights, onlyAt: 1)
                
                numberOfBlink += 1
                if numberOfBlink == 10 {
                    expectation.fulfill()
                }
                
            }
            trafficLight.switchOff()
            
        }
        trafficLight.switchOn(to: .red)
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }

    }
    
    func testCanSwitchOnToRed() {
        let trafficLight = TrafficLight(interval: 0, yellowDuration: 0)
        let expectation = self.expectation(description: "Red light is switched on")
        trafficLight.onLightChanged = {[unowned self] completed in
            XCTAssertTrue(completed)
            XCTAssertEqual(trafficLight.mode, .red)
            self.checkIsDeviceOn(within: trafficLight.lights, onlyAt: 2)
            expectation.fulfill()
        }
        trafficLight.switchOn(to: .red)
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }
        
    }
    
    func testCanSwitchOnToGreenAndTurnToRed() {
        let trafficLight = TrafficLight(interval: 0.1, yellowDuration: 0.1)
        let expectation = self.expectation(description: "Red light is switched on")
        var numberOfLightChanges = 0
        trafficLight.onLightChanged = {[unowned self] completed in
            numberOfLightChanges += 1
            if completed {
                XCTAssertEqual(trafficLight.mode, .red)
                self.checkIsDeviceOn(within: trafficLight.lights, onlyAt: 2)
                expectation.fulfill()
            } else {
                if numberOfLightChanges == 1 {
                    XCTAssertEqual(trafficLight.mode, .green)
                    self.checkIsDeviceOn(within: trafficLight.lights, onlyAt: 0)
                } else if numberOfLightChanges == 2 {
                    XCTAssertEqual(trafficLight.mode, .yellow)
                    self.checkIsDeviceOn(within: trafficLight.lights, onlyAt: 1)
                }
            }
        }
        trafficLight.switchOn(to: .green)
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }

    }

}
