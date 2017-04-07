//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//
import UIKit

class TrafficLight {
    
    enum SignalType {
        case green, yellow, red, off
    }
    
    let yellowLight = ColorLight(in: UIColor.yellow)
    let redLight = ColorLight(in: UIColor.red)
    let greenLight = ColorLight(in: UIColor.green)
    
    var onSignalChanged:((Bool) -> Void)?
    
    var isOn: Bool {
        return signal != .off
    }
    
    var currentLight: ColorLight? {
        for light in lights {
            if light.isOn {
                return light
            }
        }
        
        return nil
    }
    
    var signal: SignalType = .off {
        didSet {
            handleSignalChange()
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
            greenLight,
            yellowLight,
            redLight
        ]
        
        handleSignalChange()
    }
    
    private func handleSignalChange() {
        currentLight?.isOn = false
        
        switch signal {
        case .green:
            switchOn(greenLight, for: interval) { [unowned self] in
                if self.isOn {
                    self.signal = .yellow
                }
            }
            onSignalChanged?(false)
            
        case .yellow:
            switchOn(yellowLight, for: yellowDuration) { [unowned self] in
                if self.isOn {
                    self.signal = .red
                }
            }
            onSignalChanged?(false)
            
        case .red:
            switchOn(redLight)
            onSignalChanged?(true)
            
        case .off:
            switchOn(yellowLight, for: blinkInterval) { [unowned self] in
                _ = Timer.scheduledTimer(withTimeInterval: self.blinkInterval, repeats: false) { timer in
                    timer.invalidate()
                    
                    if !self.isOn {
                        self.signal = .off
                    }
                }
            }
            onSignalChanged?(false)
        }
    }
    
    
    private func switchOn(_ light: ColorLight, for duration: TimeInterval? = nil, completion: (() -> Void)? = nil) {
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
