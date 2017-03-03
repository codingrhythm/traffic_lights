//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//
import UIKit

class TrafficLight: SequenceLight {
    
    private var currentLightIndex:Int = -1
    
    let lights: [Light] = [
        Light(in: UIColor.greenColor(), withDuration: 30),
        Light(in: UIColor.yellowColor(), withDuration: 5),
        Light(in: UIColor.redColor())
    ]
    
    
    var lightToSwitchOn: Light? {
        guard currentLightIndex < lights.count else {
            // set to -1, so it can start from beginning
            currentLightIndex = -1
            return nil
        }
        
        currentLightIndex += 1
        
        return lights[currentLightIndex]
    }
}
