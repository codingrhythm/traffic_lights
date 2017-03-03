//
//  Light.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import UIKit

class TimedLight {
    var color: UIColor
    var isOn = false
    var duration: TimeInterval?
    
    init(in color:UIColor, withDuration duration: TimeInterval? = nil) {
        self.color = color
        self.duration = duration
    }
}
