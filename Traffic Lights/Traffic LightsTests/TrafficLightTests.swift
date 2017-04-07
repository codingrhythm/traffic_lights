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
        XCTAssertFalse(trafficLight.isOn)
        XCTAssertEqual(trafficLight.signal, .off)
    }
    
    private func checkIsLightOn(within lights:[ColorLight], onlyAt index:Int) {
        XCTAssertTrue(lights[index].isOn)
        for i in 0...lights.count - 1 {
            if lights[i].isOn {
                if i != index {
                    XCTFail(String(format: "Device should not be on at %d", i))
                }
            }
        }
    }
    
    func testCanSwitchOff() {
        let trafficLight = TrafficLight(interval: 0, yellowDuration: 0, blinkInterval: 0)
        let expectation = self.expectation(description: "Light mode should be default")
        trafficLight.onSignalChanged = { completed in
            XCTAssertTrue(completed)
            XCTAssertEqual(trafficLight.signal, .red)
            
            var numberOfBlink = 0
            trafficLight.onSignalChanged = { completed in
                XCTAssertFalse(completed)
                XCTAssertEqual(trafficLight.signal, .off)
                self.checkIsLightOn(within: trafficLight.lights, onlyAt: 1)
                
                numberOfBlink += 1
                if numberOfBlink == 10 {
                    expectation.fulfill()
                }
                
            }
            trafficLight.signal = .off
            
        }
        trafficLight.signal = .red
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }

    }
    
    func testCanSwitchOnToRed() {
        let trafficLight = TrafficLight(interval: 0, yellowDuration: 0)
        let expectation = self.expectation(description: "Red light is switched on")
        trafficLight.onSignalChanged = {[unowned self] completed in
            XCTAssertTrue(completed)
            XCTAssertEqual(trafficLight.signal, .red)
            self.checkIsLightOn(within: trafficLight.lights, onlyAt: 2)
            expectation.fulfill()
        }
        trafficLight.signal = .red
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }
        
    }
    
    func testCanSwitchOnToGreenAndTurnToRed() {
        let trafficLight = TrafficLight(interval: 0.1, yellowDuration: 0.1)
        let expectation = self.expectation(description: "Red light is switched on")
        var numberOfLightChanges = 0
        trafficLight.onSignalChanged = {[unowned self] completed in
            numberOfLightChanges += 1
            if completed {
                XCTAssertEqual(trafficLight.signal, .red)
                self.checkIsLightOn(within: trafficLight.lights, onlyAt: 2)
                expectation.fulfill()
            } else {
                if numberOfLightChanges == 1 {
                    XCTAssertEqual(trafficLight.signal, .green)
                    self.checkIsLightOn(within: trafficLight.lights, onlyAt: 0)
                } else if numberOfLightChanges == 2 {
                    XCTAssertEqual(trafficLight.signal, .yellow)
                    self.checkIsLightOn(within: trafficLight.lights, onlyAt: 1)
                }
            }
        }
        trafficLight.signal = .green
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error)
        }

    }

}
