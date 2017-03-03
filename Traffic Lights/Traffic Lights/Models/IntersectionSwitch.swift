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
    
    let lights: [TrafficDirection: TrafficLight] = [
        TrafficDirection.southNorth: TrafficLight(),
        TrafficDirection.eastWest: TrafficLight()
    ]
    
    func switchOn(_ light: TimedLight, completion: (() -> Void)) {
        
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
}
