//
//  HeaterDerviceTests.swift
//  modulotech-test-ios-UnitTests
//
//  Created by Roman Nabiullin on 20.09.2022.
//

import XCTest
@testable import modulotech_test_ios


// MARK: - Class

final class HeaterDerviceTests: XCTestCase {
    
    
    // MARK: Helper
    
    struct TemperatureCase {
        let lowerBound: Double
        let upperBound: Double
        let initial: Double
        let expectedAfterClamping: Double
    }
    
    func heater(forTemperatureCase temperatureCase: TemperatureCase) -> Heater {
        return Heater(
            deviceId: .random(in: 0...100_000),
            name: "Heater_" + UUID().uuidString,
            mode: .on,
            temperature: temperatureCase.initial,
            minimumTemperature: temperatureCase.lowerBound,
            maximumTemperature: temperatureCase.upperBound
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
        
        let temperatureCase = TemperatureCase(
            lowerBound: 30, upperBound: 60,
            initial: 90, expectedAfterClamping: 60
        )
        
        let heater: Heater = heater(forTemperatureCase: temperatureCase)
        
        XCTAssertEqual(heater.minimumTemperature, temperatureCase.lowerBound)
        XCTAssertEqual(heater.maximumTemperature, temperatureCase.upperBound)
        XCTAssertEqual(heater.temperature, temperatureCase.expectedAfterClamping)
        
    }
    
    func test_lowerBoundGreaterThanUpperBound() {
        
        let temperatureCase = TemperatureCase(
            lowerBound: 27, upperBound: 10,
            initial: 80, expectedAfterClamping: 27
        )
        
        let heater: Heater = heater(forTemperatureCase: temperatureCase)
        
        XCTAssertEqual(heater.minimumTemperature, temperatureCase.upperBound)
        XCTAssertEqual(heater.maximumTemperature, temperatureCase.lowerBound)
        XCTAssertEqual(heater.temperature, temperatureCase.expectedAfterClamping)
        
    }
    
    func test_lowerBoundEqualsUpperBound() {
        
        let temperatureCase = TemperatureCase(
            lowerBound: 15, upperBound: 15,
            initial: 80, expectedAfterClamping: 15
        )
        
        let heater: Heater = heater(forTemperatureCase: temperatureCase)
        
        XCTAssertEqual(heater.minimumTemperature, temperatureCase.lowerBound)
        XCTAssertEqual(heater.maximumTemperature, temperatureCase.upperBound)
        XCTAssertEqual(heater.temperature, temperatureCase.lowerBound)
        XCTAssertEqual(heater.temperature, temperatureCase.upperBound)
        XCTAssertEqual(heater.temperature, temperatureCase.expectedAfterClamping)
        
    }
    
    
    // MARK: Intensity settings
    
    func test_temperatureSetter() {
        
        let temperatureCase = TemperatureCase(
            lowerBound: 0, upperBound: 100,
            initial: 50, expectedAfterClamping: 50
        )
        
        var heater: Heater = heater(forTemperatureCase: temperatureCase)
        XCTAssertEqual(heater.temperature, temperatureCase.expectedAfterClamping)
        
        heater.set(temperature: 300)
        XCTAssertEqual(heater.temperature, temperatureCase.upperBound)
        
        heater.set(temperature: -300)
        XCTAssertEqual(heater.temperature, temperatureCase.lowerBound)
        
        heater.set(temperature: heater.minimumTemperature)
        XCTAssertEqual(heater.temperature, temperatureCase.lowerBound)
        
        heater.set(temperature: heater.maximumTemperature)
        XCTAssertEqual(heater.temperature, temperatureCase.upperBound)
        
        heater.set(temperature: 20)
        XCTAssertEqual(heater.temperature, 20)
        
    }
    
}
