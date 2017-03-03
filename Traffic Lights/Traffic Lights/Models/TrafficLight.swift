//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//
import UIKit


struct TrafficLight: SequenceLight {
    
    let lights: [Light] = [
        Light(in: UIColor.greenColor(), withDuration: 30),
        Light(in: UIColor.yellowColor(), withDuration: 5),
        Light(in: UIColor.redColor())
    ]
    
    var currentLight: Light? {
        return lights.filter { $0.isOn }.first
    }
    
    func switchToNextLight() -> Bool {
        return false
    }
}
