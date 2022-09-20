//
//  LightModelTests.swift
//  modulotech-test-ios-UnitTests
//
//  Created by Roman Nabiullin on 20.09.2022.
//

import XCTest
@testable import modulotech_test_ios


final class LightModelTests: XCTestCase {
    
    struct IntensityCase {
        let lowerBound: Int
        let upperBound: Int
        let initial: Int
        let expectedAfterClamping: Int
    }
    
    func light(forIntensityCase intensityCase: IntensityCase) -> Light {
        return Light(
            deviceId: .random(in: 0...100_000),
            name: "Light_" + UUID().uuidString,
            mode: .on,
            intensity: intensityCase.initial,
            minimumIntensity: intensityCase.lowerBound,
            maximumIntensity: intensityCase.upperBound
        )
    }
    
    override func setUpWithError() throws {
        // Not needed.
    }
    
    override func tearDownWithError() throws {
        // Not needed.
    }
    
    func test_lowerBoundEqualsUpperBound() throws {
        
        let intensityCase = IntensityCase(
            lowerBound: 15, upperBound: 15,
            initial: 80, expectedAfterClamping: 15
        )
        
        let light: Light = light(forIntensityCase: intensityCase)
        
        XCTAssertEqual(light.minimumIntensity, intensityCase.lowerBound)
        XCTAssertEqual(light.maximumIntensity, intensityCase.upperBound)
        XCTAssertEqual(light.intensity, intensityCase.lowerBound)
        XCTAssertEqual(light.intensity, intensityCase.upperBound)
        
    }
    
}
