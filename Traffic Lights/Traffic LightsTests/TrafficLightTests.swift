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
    let light = TrafficLight()
   
    func testCanInitialize() {
        XCTAssertEqual(light.lights.count, 3)
        XCTAssertEqual(light.lights[0].color, UIColor.greenColor())
    }
}
