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
    // returns a bool value indicates
    // if current sequence reaches end
    func switchToNextLight() -> Bool
}