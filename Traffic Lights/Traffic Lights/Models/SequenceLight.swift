//
//  SequenceLight.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 3/3/17.
//
//

import Foundation

protocol SequenceLight {
    var lights:[Light] {get}
    // get next light to switch on, 
    // returns nil if sequence is completed
    var lightToSwitchOn:Light? {get}
    
}