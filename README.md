# XADMasterSwift

XADMasterSwift is a Swift wrapper for the [XADMaster](https://github.com/MacPaw/XADMaster) library, designed to make it easily accessible via Swift Package Manager (SPM). This project aims to provide a convenient way to use XADMaster's powerful archive extraction capabilities in Swift projects.

## Features

- Swift-friendly interface for XADMaster
- Easy integration with Swift Package Manager
- Support for various archive formats (ZIP, RAR, 7z, etc.)
- macOS compatibility

## Requirements

- macOS 10.13+
- Xcode 12.0+
- Swift 5.3+

## Installation

To use XADMasterSwift in your project, add it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kumamotone/XADMasterSwift.git", from: "1.0.0")
]
```

Then, add "XADMasterSwift" as a dependency for your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["XADMasterSwift"]),
]
```

## Usage

Import XADMasterSwift in your Swift file:

```swift
import XADMasterSwift
```

Then you can use the XADMasterSwift API to work with archives.

## Setup for Development

If you want to contribute to XADMasterSwift or modify it for your needs, follow these steps:

1. Clone the repository with submodules:
   ```
   git clone --recursive https://github.com/your-username/XADMasterSwift.git
   ```

2. The XCFrameworks are already included in the repository, so no additional build steps are required for normal use.

## Updating XCFrameworks

If you need to update the XCFrameworks (e.g., after updating the XADMaster submodule), follow these steps:

1. Build the XCFrameworks:
   ```
   cd XADMasterSwift
   chmod +x build_xcframeworks.sh
   ./build_xcframeworks.sh
   ```

2. The generated XCFrameworks will be placed in the `Frameworks` directory. Commit and push your changes.

## Contributing

Contributions to XADMasterSwift are welcome. Please feel free to submit a Pull Request.

## Acknowledgements

This project wraps and depends on [XADMaster](https://github.com/MacPaw/XADMaster) by MacPaw. We are grateful for their work on this excellent archive extraction library.