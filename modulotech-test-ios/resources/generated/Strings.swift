// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Device {
    internal enum BinaryMode {
      /// OFF
      internal static let off = L10n.tr("Localizable", "device.binaryMode.off", fallback: "OFF")
      /// ON
      internal static let on = L10n.tr("Localizable", "device.binaryMode.on", fallback: "ON")
    }
    internal enum Device {
      /// Device
      internal static let kind = L10n.tr("Localizable", "device.device.kind", fallback: "Device")
    }
    internal enum Heater {
      /// Heater
      internal static let kind = L10n.tr("Localizable", "device.heater.kind", fallback: "Heater")
      internal enum DeviceListState {
        /// Heater: off
        internal static let off = L10n.tr("Localizable", "device.heater.deviceListState.off", fallback: "Heater: off")
        /// Heater: on at %@°C
        internal static func onAt(_ p1: Any) -> String {
          return L10n.tr("Localizable", "device.heater.deviceListState.onAt", String(describing: p1), fallback: "Heater: on at %@°C")
        }
      }
    }
    internal enum Light {
      /// Light
      internal static let kind = L10n.tr("Localizable", "device.light.kind", fallback: "Light")
      internal enum DeviceListState {
        /// Light: off
        internal static let off = L10n.tr("Localizable", "device.light.deviceListState.off", fallback: "Light: off")
        /// Light: on at %@
        internal static func onAt(_ p1: Any) -> String {
          return L10n.tr("Localizable", "device.light.deviceListState.onAt", String(describing: p1), fallback: "Light: on at %@")
        }
      }
    }
    internal enum RollerShutter {
      /// Roller shutter
      internal static let kind = L10n.tr("Localizable", "device.rollerShutter.kind", fallback: "Roller shutter")
      internal enum DeviceListState {
        /// Roller shutter: closed
        internal static let closed = L10n.tr("Localizable", "device.rollerShutter.deviceListState.closed", fallback: "Roller shutter: closed")
        /// Roller shutter: opened
        internal static let opened = L10n.tr("Localizable", "device.rollerShutter.deviceListState.opened", fallback: "Roller shutter: opened")
        /// Roller shutter: opened at %@%
        internal static func openedAt(_ p1: Any) -> String {
          return L10n.tr("Localizable", "device.rollerShutter.deviceListState.openedAt", String(describing: p1), fallback: "Roller shutter: opened at %@%")
        }
      }
    }
  }
  internal enum DeviceList {
    internal enum State {
      /// Fetching the device list.
      internal static let loading = L10n.tr("Localizable", "deviceList.state.loading", fallback: "Fetching the device list.")
      /// Failed to load the device list.
      /// %@
      /// 
      /// Try to restart the application.
      internal static func loadingError(_ p1: Any) -> String {
        return L10n.tr("Localizable", "deviceList.state.loadingError", String(describing: p1), fallback: "Failed to load the device list.\n%@\n\nTry to restart the application.")
      }
    }
  }
  internal enum DeviceSettings {
    internal enum Heater {
      internal enum Mode {
        /// Selected mode "OFF"
        internal static let off = L10n.tr("Localizable", "deviceSettings.heater.mode.off", fallback: "Selected mode \"OFF\"")
        /// Selected mode "ON"
        internal static let on = L10n.tr("Localizable", "deviceSettings.heater.mode.on", fallback: "Selected mode \"ON\"")
      }
      internal enum Slider {
        /// Temperature: %@ °C
        internal static func title(_ p1: Any) -> String {
          return L10n.tr("Localizable", "deviceSettings.heater.slider.title", String(describing: p1), fallback: "Temperature: %@ °C")
        }
      }
    }
    internal enum Light {
      internal enum Mode {
        /// Selected mode "OFF"
        internal static let off = L10n.tr("Localizable", "deviceSettings.light.mode.off", fallback: "Selected mode \"OFF\"")
        /// Selected mode "ON"
        internal static let on = L10n.tr("Localizable", "deviceSettings.light.mode.on", fallback: "Selected mode \"ON\"")
      }
      internal enum Slider {
        /// Intensity: %@
        internal static func title(_ p1: Any) -> String {
          return L10n.tr("Localizable", "deviceSettings.light.slider.title", String(describing: p1), fallback: "Intensity: %@")
        }
      }
    }
    internal enum NavigationBar {
      /// Device settings
      internal static let title = L10n.tr("Localizable", "deviceSettings.navigationBar.title", fallback: "Device settings")
    }
    internal enum RollerShutter {
      internal enum Slider {
        internal enum Title {
          /// Closed
          internal static let closed = L10n.tr("Localizable", "deviceSettings.rollerShutter.slider.title.closed", fallback: "Closed")
          /// Opened
          internal static let opened = L10n.tr("Localizable", "deviceSettings.rollerShutter.slider.title.opened", fallback: "Opened")
          /// Opened at %@%
          internal static func openedAt(_ p1: Any) -> String {
            return L10n.tr("Localizable", "deviceSettings.rollerShutter.slider.title.openedAt", String(describing: p1), fallback: "Opened at %@%")
          }
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
