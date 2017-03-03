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
    
    let lights: [TimedLight]
    
    
    var lightToSwitchOn: TimedLight? {
        guard currentLightIndex < lights.count - 1 else {
            // set to -1, so it can start from beginning
            currentLightIndex = -1
            return nil
        }
        
        currentLightIndex += 1
        
        return lights[currentLightIndex]
    }
    
    init(interval:TimeInterval = 30, yellowDuration:TimeInterval = 5) {
        lights = [
            TimedLight(in: UIColor.green, withDuration: interval),
            TimedLight(in: UIColor.yellow, withDuration: yellowDuration),
            TimedLight(in: UIColor.red)
        ]
    }
}
