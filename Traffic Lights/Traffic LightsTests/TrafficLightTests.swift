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
    let trafficLight = TrafficLight()
   
    func testCanInitialize() {
        XCTAssertEqual(trafficLight.lights.count, 3)
        XCTAssertEqual(trafficLight.lights[0].color, UIColor.green)
        XCTAssertEqual(trafficLight.lights[1].color, UIColor.yellow)
        XCTAssertEqual(trafficLight.lights[2].color, UIColor.red)
    }
    
    func testCanGetNextLightInCorrectOrder() {
        for _ in 0...2 {
            XCTAssertEqual(trafficLight.lightToSwitchOn?.color, UIColor.green)
            XCTAssertEqual(trafficLight.lightToSwitchOn?.color, UIColor.yellow)
            XCTAssertEqual(trafficLight.lightToSwitchOn?.color, UIColor.red)
            XCTAssertNil(trafficLight.lightToSwitchOn?.color)
        }
    }
}
