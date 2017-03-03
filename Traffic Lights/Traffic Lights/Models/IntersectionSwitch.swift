//
//  File.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import Foundation

class IntersectionSwitch {
    enum TrafficDirection: String {
        case southNorth = "SN", eastWest = "EW"
    }
    
    var direction: TrafficDirection = .southNorth
    
    let lights: [TrafficDirection: TrafficLight]
    
    init(southNorthLight:TrafficLight = TrafficLight(), eastWestLight:TrafficLight = TrafficLight()) {
        lights = [
            TrafficDirection.southNorth: southNorthLight,
            TrafficDirection.eastWest: eastWestLight
        ]
    }
    
    func switchOn(_ light: TimedLight, completion: @escaping (() -> Void)) {
        light.isOn = true
        
        if let duration = light.duration {
            
            let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
                light.isOn = false
                completion()
            }
            
            timer.tolerance = 0
            
        } else {
            completion()
        }
    }
    
    
    func start() {
        
    }
    
    func stop() {
        
    }
}
