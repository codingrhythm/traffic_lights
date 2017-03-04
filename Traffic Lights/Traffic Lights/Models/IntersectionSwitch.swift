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
    
    private var currentLight: TrafficLight? {
        if let key = direction {
            return lights[key]
        }
        
        return nil
    }
    
    var direction: TrafficDirection? {
        didSet {
            switchOnNextLight()
        }
    }
    
    let lights: [TrafficDirection: TrafficLight]
    
    init(southNorthLight:TrafficLight = TrafficLight(), eastWestLight:TrafficLight = TrafficLight()) {
        lights = [
            TrafficDirection.southNorth: southNorthLight,
            TrafficDirection.eastWest: eastWestLight
        ]
    }
    
    private func switchOnNextLight() {
        guard !isStopped else {
            return
        }
        
        if let light = currentLight?.lightToSwitchOn {
            switchOn(light) { [unowned self] in
                self.switchOnNextLight()
            }
        } else {
            reverseDirection()
        }
    }
    
    func reverseDirection() {
        if direction == .southNorth {
            direction = .eastWest
        } else {
            direction = .southNorth
        }
    }
    
    func switchOn(_ light: TimedLight, completion: @escaping (() -> Void)) {
        light.isOn = true
        
        if let duration = light.duration {
            
            let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
                timer.invalidate()
                light.isOn = false
                completion()
            }
            
            timer.tolerance = 0
            
        } else {
            completion()
        }
    }
    
    
    func start() {
        isStopped = false
        direction = .southNorth
    }
    
    private var isStopped = true
    func stop() {
        isStopped = true
    }
}
