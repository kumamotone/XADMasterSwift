#!/bin/bash

# XCFrameworksの出力ディレクトリを作成
mkdir -p Frameworks

# XADMasterのビルド
cd XADMaster
xcodebuild -project XADMaster.xcodeproj \
           -scheme XADMaster \
           -configuration Release \
           -sdk macosx \
           SKIP_INSTALL=NO \
           BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
           MACOSX_DEPLOYMENT_TARGET=10.13 \
           CONFIGURATION_BUILD_DIR="../build/Release"

xcodebuild -create-xcframework \
           -framework ../build/Release/XADMaster.framework \
           -output ../Frameworks/XADMaster.xcframework

# UniversalDetectorのビルド
cd ../UniversalDetector
xcodebuild -project UniversalDetector.xcodeproj \
           -scheme UniversalDetector \
           -configuration Release \
           -sdk macosx \
           SKIP_INSTALL=NO \
           BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
           MACOSX_DEPLOYMENT_TARGET=10.13 \
           CONFIGURATION_BUILD_DIR="../build/Release"

xcodebuild -create-xcframework \
           -framework ../build/Release/UniversalDetector.framework \
           -output ../Frameworks/UniversalDetector.xcframework

# Deleting .DS_Store and build because they remain for some reason
rm -rf .DS_Store
rm -rf build

cd ..

# Clean up build
rm -rf build