//
//  LightModelTests.swift
//  modulotech-test-ios-UnitTests
//
//  Created by Roman Nabiullin on 20.09.2022.
//

import XCTest
@testable import modulotech_test_ios


// MARK: - Class

final class LightModelTests: XCTestCase {
    
    
    // MARK: Helper
    
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
    
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        // Not needed.
    }
    
    override func tearDownWithError() throws {
        // Not needed.
    }
    
    
    // MARK: Intensity bounds
    
    func test_lowerBoundLessThanUpperBound() {
        
        let intensityCase = IntensityCase(
            lowerBound: 30, upperBound: 60,
            initial: 90, expectedAfterClamping: 60
        )
        
        let light: Light = light(forIntensityCase: intensityCase)
        
        XCTAssertEqual(light.minimumIntensity, intensityCase.lowerBound)
        XCTAssertEqual(light.maximumIntensity, intensityCase.upperBound)
        XCTAssertEqual(light.intensity, intensityCase.expectedAfterClamping)
        
    }
    
    func test_lowerBoundGreaterThanUpperBound() {
        
        let intensityCase = IntensityCase(
            lowerBound: 27, upperBound: 10,
            initial: 80, expectedAfterClamping: 27
        )
        
        let light: Light = light(forIntensityCase: intensityCase)
        
        XCTAssertEqual(light.minimumIntensity, intensityCase.upperBound)
        XCTAssertEqual(light.maximumIntensity, intensityCase.lowerBound)
        XCTAssertEqual(light.intensity, intensityCase.expectedAfterClamping)
        
    }
    
    func test_lowerBoundEqualsUpperBound() {
        
        let intensityCase = IntensityCase(
            lowerBound: 15, upperBound: 15,
            initial: 80, expectedAfterClamping: 15
        )
        
        let light: Light = light(forIntensityCase: intensityCase)
        
        XCTAssertEqual(light.minimumIntensity, intensityCase.lowerBound)
        XCTAssertEqual(light.maximumIntensity, intensityCase.upperBound)
        XCTAssertEqual(light.intensity, intensityCase.lowerBound)
        XCTAssertEqual(light.intensity, intensityCase.upperBound)
        XCTAssertEqual(light.intensity, intensityCase.expectedAfterClamping)
        
    }
    
    
    // MARK: Intensity settings
    
    func test_intensitySetter() {
        
        let intensityCase = IntensityCase(
            lowerBound: 0, upperBound: 100,
            initial: 50, expectedAfterClamping: 50
        )
        
        var light: Light = light(forIntensityCase: intensityCase)
        XCTAssertEqual(light.intensity, intensityCase.expectedAfterClamping)
        
        light.set(intensity: 300)
        XCTAssertEqual(light.intensity, intensityCase.upperBound)
        
        light.set(intensity: -300)
        XCTAssertEqual(light.intensity, intensityCase.lowerBound)
        
        light.set(intensity: light.minimumIntensity)
        XCTAssertEqual(light.intensity, intensityCase.lowerBound)
        
        light.set(intensity: light.maximumIntensity)
        XCTAssertEqual(light.intensity, intensityCase.upperBound)
        
        light.set(intensity: 20)
        XCTAssertEqual(light.intensity, 20)
        
    }
    
}
