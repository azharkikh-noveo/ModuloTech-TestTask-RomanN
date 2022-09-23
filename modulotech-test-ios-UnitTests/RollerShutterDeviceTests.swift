//
//  RollerShutterDeviceTests.swift
//  modulotech-test-ios-UnitTests
//
//  Created by Roman Nabiullin on 20.09.2022.
//

import XCTest
@testable import modulotech_test_ios


// MARK: - Class

final class RollerShutterDeviceTests: XCTestCase {
    
    
    // MARK: Helper
    
    struct PositionCase {
        let lowerBound: Int
        let upperBound: Int
        let initial: Int
        let expectedAfterClamping: Int
    }
    
    func rollerShutter(forPositionCase positionCase: PositionCase) -> RollerShutter {
        return RollerShutter(
            deviceId: .random(in: 0...100_000),
            name: "RollerShutter_" + UUID().uuidString,
            position: positionCase.initial,
            minimumPosition: positionCase.lowerBound,
            maximumPosition: positionCase.upperBound
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
        
        let positionCase = PositionCase(
            lowerBound: 30, upperBound: 60,
            initial: 90, expectedAfterClamping: 60
        )
        
        let rollerShutter: RollerShutter = rollerShutter(forPositionCase: positionCase)
        
        XCTAssertEqual(rollerShutter.minimumPosition, positionCase.lowerBound)
        XCTAssertEqual(rollerShutter.maximumPosition, positionCase.upperBound)
        XCTAssertEqual(rollerShutter.position, positionCase.expectedAfterClamping)
        
    }
    
    func test_lowerBoundGreaterThanUpperBound() {
        
        let positionCase = PositionCase(
            lowerBound: 27, upperBound: 10,
            initial: 80, expectedAfterClamping: 27
        )
        
        let rollerShutter: RollerShutter = rollerShutter(forPositionCase: positionCase)
        
        XCTAssertEqual(rollerShutter.minimumPosition, positionCase.upperBound)
        XCTAssertEqual(rollerShutter.maximumPosition, positionCase.lowerBound)
        XCTAssertEqual(rollerShutter.position, positionCase.expectedAfterClamping)
        
    }
    
    func test_lowerBoundEqualsUpperBound() {
        
        let positionCase = PositionCase(
            lowerBound: 15, upperBound: 15,
            initial: 80, expectedAfterClamping: 15
        )
        
        let rollerShutter: RollerShutter = rollerShutter(forPositionCase: positionCase)
        
        XCTAssertEqual(rollerShutter.minimumPosition, positionCase.lowerBound)
        XCTAssertEqual(rollerShutter.maximumPosition, positionCase.upperBound)
        XCTAssertEqual(rollerShutter.position, positionCase.lowerBound)
        XCTAssertEqual(rollerShutter.position, positionCase.upperBound)
        XCTAssertEqual(rollerShutter.position, positionCase.expectedAfterClamping)
        
    }
    
    
    // MARK: Intensity settings
    
    func test_positionSetter() {
        
        let positionCase = PositionCase(
            lowerBound: 0, upperBound: 100,
            initial: 50, expectedAfterClamping: 50
        )
        
        var rollerShutter: RollerShutter = rollerShutter(forPositionCase: positionCase)
        XCTAssertEqual(rollerShutter.position, positionCase.expectedAfterClamping)
        
        rollerShutter.set(position: 300)
        XCTAssertEqual(rollerShutter.position, positionCase.upperBound)
        
        rollerShutter.set(position: -300)
        XCTAssertEqual(rollerShutter.position, positionCase.lowerBound)
        
        rollerShutter.set(position: rollerShutter.minimumPosition)
        XCTAssertEqual(rollerShutter.position, positionCase.lowerBound)
        
        rollerShutter.set(position: rollerShutter.maximumPosition)
        XCTAssertEqual(rollerShutter.position, positionCase.upperBound)
        
        rollerShutter.set(position: 20)
        XCTAssertEqual(rollerShutter.position, 20)
        
    }
    
}
