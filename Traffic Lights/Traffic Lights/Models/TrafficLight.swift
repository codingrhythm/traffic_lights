//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//
import UIKit

class TrafficLight: Device {
    
    enum LightMode {
        case green, yellow, red, `default`
    }
    
    var onLightChanged:((Bool) -> Void)?
    
    var stateChanged: ((Bool) -> Void)?
    var isOn: Bool = false {
        didSet {
            stateChanged?(isOn)
        }
    }
    
    var currentLight: ColorLight? {
        for light in lights {
            if light.isOn {
                return light
            }
        }
        
        return nil
    }
    
    var mode:LightMode = .default {
        didSet {
            
            switch mode {
            case .green:
                switchOn(lights[0], duration: interval) { [unowned self] in
                    if self.isOn {
                        self.mode = .yellow
                    }
                }
                onLightChanged?(false)
                
            case .yellow:
                switchOn(lights[1], duration: yellowDuration) { [unowned self] in
                    if self.isOn {
                        self.mode = .red
                    }
                }
                onLightChanged?(false)
                
            case .red:
                switchOn(lights[2])
                onLightChanged?(true)
                
            default:
                // blink yellow light
                switchOn(lights[1], duration: blinkInterval) { [unowned self] in
                    _ = Timer.scheduledTimer(withTimeInterval: self.blinkInterval, repeats: false) { timer in
                        timer.invalidate()
                        
                        if !self.isOn {
                            self.mode = .default
                        }
                    }
                }
                onLightChanged?(false)
            }
        }
    }
    
    let lights: [ColorLight]
    
    private let interval: TimeInterval
    private let yellowDuration: TimeInterval
    private let blinkInterval: TimeInterval
    
    init(interval: TimeInterval = 30, yellowDuration: TimeInterval = 5, blinkInterval: TimeInterval = 1) {
        self.interval = interval
        self.yellowDuration = yellowDuration
        self.blinkInterval = blinkInterval
        
        lights = [
            ColorLight(in: UIColor.green),
            ColorLight(in: UIColor.yellow),
            ColorLight(in: UIColor.red)
        ]
        
        switchOff()
    }
    
    func switchOn(to projectedMode:LightMode = .green) {
        lights.forEach { light in
            light.isOn = false
        }
        
        isOn = projectedMode != .default
        mode = projectedMode
    }
    
    func switchOff() {
        switchOn(to: .default)
    }
    
    func switchOn(_ light: ColorLight, duration: TimeInterval? = nil, completion: (() -> Void)? = nil) {
        light.isOn = true
        
        if let duration = duration {
            
            let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
                timer.invalidate()
                light.isOn = false
                completion?()
            }
            
            timer.tolerance = 0
            
        } else {
            completion?()
        }
    }
}
