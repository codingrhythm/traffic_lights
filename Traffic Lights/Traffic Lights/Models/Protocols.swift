//
//  Protocols.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 04/03/2017.
//
//

import Foundation

protocol Device {
    var isOn: Bool {get set}
    var stateChanged:((Bool) -> Void)? {get set}
}
