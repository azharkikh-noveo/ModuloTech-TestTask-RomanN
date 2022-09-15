//
//  BaseSlider.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 16.09.2022.
//

import UIKit
import Combine


// MARK: - Slider

/// Base class for custom sliders.
public class BaseSlider: UISlider {
    
    
    /// Storage for the subscriptions.
    public var disposeBag: Set<AnyCancellable> = []
    
    /// Slider step.
    public var step: Float = 1
    
    /// Publishes whenever a slider changes its value.
    public let valueChanged: PassthroughSubject<BaseSlider, Never>
    
    
    // MARK: Init
    
    public override init(frame: CGRect) {
        
        self.valueChanged = .init()
        
        super.init(frame: .zero)
        
        tintColor = Asset.Colors.lightSteelBlue.color
        
        addTarget(self, action: #selector(onValueChange(_:)), for: .valueChanged)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Helper
    
    /// Publishes events on value change.
    @objc private func onValueChange(_ slider: UISlider) {
        if let slider = slider as? BaseSlider {
            valueChanged.send(slider)
        }
    }
    
    /// Sets the value
    public func set(value: Float) {
        
        let newValue: Float = step * round(value / step)
        
        if 1e-10 < fabsf(self.value - newValue) {
            self.value = newValue
        }
        
    }
    
}
