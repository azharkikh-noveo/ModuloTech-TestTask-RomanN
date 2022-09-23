//
//  clamp.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


/// Clamps a value using closed range bounds.
public func clamp<Value: Comparable>(
    _ value: Value,
    using bounds: ClosedRange<Value>
) -> Value {
    return max(bounds.lowerBound, min(bounds.upperBound, value))
}
