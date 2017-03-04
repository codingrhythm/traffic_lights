//
//  File.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import Foundation

class Intersection: Device {
    enum TrafficDirection: String {
        case southNorth = "SN", eastWest = "EW"
    }
    
    var onDirectionChange: (() -> Void)?
    var direction: TrafficDirection? {
        didSet {
            if let direction = direction {
                lights[direction]?.switchOn()
                onDirectionChange?()
            }
        }
    }
    
    let lights: [TrafficDirection: TrafficLight]
    
    var stateChanged: ((Bool) -> Void)?
    var isOn: Bool = false {
        didSet {
            if isOn {
                lights[.eastWest]?.switchOn(to: .red)
            } else {
                for (_, light) in lights {
                    light.switchOff()
                }
            }
            
            stateChanged?(isOn)
        }
    }
    
    init(southNorthLight:TrafficLight = TrafficLight(), eastWestLight:TrafficLight = TrafficLight()) {
        lights = [
            TrafficDirection.southNorth: southNorthLight,
            TrafficDirection.eastWest: eastWestLight
        ]
        
        southNorthLight.onLightChanged = { [unowned self] isCompleted in
            if isCompleted {
                self.direction = .eastWest
            }
        }
        
        eastWestLight.onLightChanged = { [unowned self] isCompleted in
            if isCompleted {
                self.direction = .southNorth
            }
        }
    }
}
