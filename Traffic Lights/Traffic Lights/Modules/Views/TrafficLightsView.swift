//
//  TrafficLightsView.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 04/03/2017.
//
//

import UIKit

class TrafficLightsView: UIView {
    @IBOutlet var greenLight: LightView?
    @IBOutlet var yellowLight: LightView?
    @IBOutlet var redLight: LightView?
    
    var trafficLights: TrafficLight? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    private func updateUI() {
        greenLight?.light = trafficLights?.lights[0]
        yellowLight?.light = trafficLights?.lights[1]
        redLight?.light = trafficLights?.lights[2]
    }
}
