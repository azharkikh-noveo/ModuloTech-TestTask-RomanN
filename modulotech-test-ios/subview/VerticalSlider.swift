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


// MARK: - Preview

#if DEBUG
import SwiftUI


struct VerticalSlider_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            let view = VerticalSlider(frame: .zero)
            view.minimumValue = 0
            view.maximumValue = 100
            view.step = 1
            view.set(value: 33)
            return view
        }
        .frame(
            width: 300,
            height: 300,
            alignment: .center
        )
        .border(Color.blue, width: 0.6)
        
    }
    
}
#endif
