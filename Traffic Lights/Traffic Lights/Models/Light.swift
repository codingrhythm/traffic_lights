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
    
    init(in color:UIColor) {
        self.color = color
    }
}