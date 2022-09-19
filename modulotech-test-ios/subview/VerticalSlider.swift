//
//  VerticalSlider.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 17.09.2022.
//

import UIKit


// MARK: - Slider

/// Vertical slider.
public class VerticalSlider: BaseSlider {
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.transform = .identity.rotated(by: -0.5 * .pi)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
