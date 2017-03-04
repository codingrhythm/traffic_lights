//
//  ViewController.swift
//  Traffic Lights
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var southNorthLight: TrafficLightsView?
    @IBOutlet var eastWestLight: TrafficLightsView?
    
    var intersection = Intersection()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        southNorthLight?.trafficLights = intersection.lights[.southNorth]
        eastWestLight?.trafficLights = intersection.lights[.eastWest]
    }

    @IBAction func onMainSwitchValueChange(_ sender: UISwitch) {
        intersection.isOn = sender.isOn
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

