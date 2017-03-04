//
//  LightViewTests.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 04/03/2017.
//
//


import XCTest
@testable import Traffic_Lights

class LightViewTests: XCTestCase {
    
    func testCanUpdateUIWhenLightStateIsChanged() {
        let light = ColorLight(in: UIColor.red)
        let lightView = LightView()
        lightView.light = light
        
        XCTAssertEqual(lightView.layer.borderColor, light.color.cgColor)
        
        light.isOn = true
        
        XCTAssertEqual(lightView.layer.backgroundColor, light.color.cgColor)
        
        light.isOn = false
        
        XCTAssertNil(lightView.layer.backgroundColor)
    }
}
