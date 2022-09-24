# modulo Tech

## Application

The described application is a simple test task designed as a manager for smart home devices. It fetches the list of devices from the server and allows to manipulate with the parameters of each (ex: heater can be turned on/off and its temperature can be changed). The changes are kept within the app life cycle.


## Build

The app requires XCode 13+ installed and the following tools:

* _SwiftLint_ - linter used for the code style.
* _SwiftGen_ - used to generate code access for localizable strings, color and image assets. 

The tools should be installed using *homebrew* as: `brew install swiftlint` and `brew install swiftgen`.


## Stack

The application is designed with MVVM+Coordinators architecture pattern.

The Combine framework is used for all application layers including UI, business logic and network.

The UI is written in UIKit + autolayout(SnapKit).

The project uses the only third-party library *SnapKit* for the convenient autolayout interface.

## Details

The app screen  generally includes the following components: ViewController, ViewModel, Subview-s.

The network layer is implemented with `NetworkService` that uses `URLSession` for the requests. It has a raw model layer for decoding raw device models that converted into the domain models for in-app usage.

Supported languages: English, Japanese.

