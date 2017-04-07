//
//  Light.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import UIKit

class ColorLight {
    var color: UIColor
    var stateChanged: ((Bool) -> Void)?
    var isOn: Bool = false {
        didSet {
            stateChanged?(isOn)
        }
    }

    init(in color:UIColor) {
        self.color = color
    }
}
