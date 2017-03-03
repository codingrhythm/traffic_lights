//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//
import UIKit

class TrafficLight: SequenceLight {
    
    fileprivate var currentLightIndex:Int = -1
    
    let lights: [TimedLight] = [
        TimedLight(in: UIColor.green, withDuration: 30),
        TimedLight(in: UIColor.yellow, withDuration: 5),
        TimedLight(in: UIColor.red)
    ]
    
    
    var lightToSwitchOn: TimedLight? {
        guard currentLightIndex < lights.count - 1 else {
            // set to -1, so it can start from beginning
            currentLightIndex = -1
            return nil
        }
        
        currentLightIndex += 1
        
        return lights[currentLightIndex]
    }
}
