//
//  LightView.swift
//  Traffic Lights
//
//  Created by Zack Zhu on 04/03/2017.
//
//

import UIKit

class LightView: UIView {
    var light: ColorLight? {
        didSet {
            layer.borderColor = light?.color.cgColor
        
            light?.stateChanged = { [unowned self] isOn in
                self.updateUI()
            }
            
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
    }
    
    private func updateUI() {
        if let light = light {
            layer.backgroundColor = light.isOn ? light.color.cgColor : nil
        }
    }
    
}
