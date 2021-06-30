#  `UIFontDescriptor.FeatureKey.featureIdentifier` not available on iOS 12

The `UIFontDescriptor.FeatureKey.featureIdentifier` seems to be unavailable on iOS 12 when built with Xcode 13 against the iOS 15 SDK.

# Steps to Reproduce

Build and run this sample on a device running iOS 12.5.4

# Expected Result

Sample runs, shows Hello Screen

# Actual Result

Sample crashes: `Thread 1: signal SIGABRT`

# Notes

Sample runs when build with Xcode 12.5.1

