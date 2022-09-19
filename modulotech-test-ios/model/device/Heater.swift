//
//  Heater.swift
//  modulotech-test-ios
//
//  Created by Roman Nabiullin on 19.09.2022.
//

import Foundation


/// "Heater" device.
public final class Heater: Device {
    
    
    public override var description: String {
        var result: String = ""
        result += "Heater(id: \(deviceId), "
        result += "name: \"\(name)\", "
        result += "temperature: \(temperature), "
        result += "mode: \"\(mode)\")"
        return result
    }
    
    
    public override var deviceType: String {
        return L10n.Device.Heater.kind
    }
    
    
    /// Heater mode.
    public var mode: BinaryMode
    
    /// Heater temperature
    public private(set) var temperature: Double
    
    /// Creates an instace of the light device with all parameters specified.
    public init(
        deviceId: Int,
        name: String,
        mode: BinaryMode,
        temperature: Double
    ) {
        self.mode = mode
        self.temperature = clamp(temperature, using: 7...28)
        super.init(id: deviceId, name: name)
    }
    
    /// Creates an instance of the device from its raw model if possible.
    public init?(from rawModel: DeviceProduct) {
        
        guard
            let mode = rawModel.mode.flatMap(BinaryMode.init(rawMode:)),
            let temperature = rawModel.temperature
        else {
            return nil
        }
        
        self.temperature = temperature
        self.mode = mode
        super.init(id: rawModel.deviceId, name: rawModel.name)
        
    }
    
    
    // MARK: Helper
    
    /// Setter for the heater temperature.
    public func set(temperature newValue: Double) {
        temperature = clamp(newValue, using: 7...28)
    }
    
}
