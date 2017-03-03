//
//  Light.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import UIKit

struct Light {
    var color: UIColor
    var isOn = false
    var duration: NSTimeInterval?
    
    init(in color:UIColor, withDuration duration: NSTimeInterval? = nil) {
        self.color = color
        self.duration = duration
    }
}