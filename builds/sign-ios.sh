#!/bin/sh

security create-keychain -p 'tempPassword' ios-build.keychain
security import ./builds/appleWorldwide.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./builds/myCertificate.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./builds/myCertificate.p12 -k ~/Library/Keychains/ios-build.keychain -P "$P12_PASSWORD" -T /usr/bin/codesign
security list-keychain -s ~/Library/Keychains/ios-build.keychain
security unlock-keychain -p 'tempPassword' ~/Library/Keychains/ios-build.keychain

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./builds/profile/* ~/Library/MobileDevice/Provisioning\ Profiles/

sudo mkdir -p ./platforms/ios/cordova/
sudo cp ./builds/build-release.xcconfig ./platforms/ios/cordova/build-release.xcconfig
