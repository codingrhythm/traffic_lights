//
//  TrafficLightsViewTests.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 04/03/2017.
//
//

import XCTest
@testable import Traffic_Lights

class TrafficLightsViewTests: XCTestCase {
    
    func testCanUpdateUI() {
        let trafficLights = TrafficLight()
        let trafficLightsView = TrafficLightsView()
        trafficLightsView.redLight = LightView()
        trafficLightsView.greenLight = LightView()
        trafficLightsView.yellowLight = LightView()
        
        trafficLightsView.trafficLights = trafficLights
        
        XCTAssertNotNil(trafficLightsView.redLight?.light)
        XCTAssertNotNil(trafficLightsView.greenLight?.light)
        XCTAssertNotNil(trafficLightsView.yellowLight?.light)
    }
}
