#  Sample Code For Feedback FB9224451

The `UIFontDescriptor.FeatureKey.featureIdentifier` seems to be unavailable on iOS 14 when built with Xcode 13 against the iOS 15 SDK.

# Update: Workaround

Changing `.featureIdentifier` to `.type` results in successful tests on all UIs. There is however no warning that this is necessary if the depoloyment target is not equal to iOS 15.

Also, to compile on Xcode 12, the code is not particularly elegant:

``` swift
#if swift(>=5.5)
return .type
#else
return .featureIdentifier
#endif
```

Checking for Swift 5.5 violates the basic rule that you should ask what you are asking for (in this case, if you are compiling against the iOS 15 SDK) 

# Steps to Reproduce

Build and test this sample with Xcode 13 (13A5155e) on a simulator or device running iOS 14 or earlier

# Expected Result

Test runs successfully 

# Actual Result

Test crashes: `Thread 1: signal SIGABRT`

Log Output:

```
dyld: lazy symbol binding failed: Symbol not found: _$sSo26UIFontDescriptorFeatureKeya5UIKitE17featureIdentifierABvgZ
  Referenced from: /Users/below/Library/Developer/CoreSimulator/Devices/346C106C-C93E-4227-820C-F82A2A5A7675/data/Containers/Bundle/Application/5C14EC67-A88D-4896-A17A-434E8CFEC4D2/ios15test.app/ios15test
  Expected in: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/swift/libswiftUIKit.dylib

dyld: Symbol not found: _$sSo26UIFontDescriptorFeatureKeya5UIKitE17featureIdentifierABvgZ
  Referenced from: /Users/below/Library/Developer/CoreSimulator/Devices/346C106C-C93E-4227-820C-F82A2A5A7675/data/Containers/Bundle/Application/5C14EC67-A88D-4896-A17A-434E8CFEC4D2/ios15test.app/ios15test
  Expected in: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/swift/libswiftUIKit.dylib
```

```
* thread #1, queue = 'com.apple.main-thread', stop reason = signal SIGABRT
    frame #0: 0x000000011556aa8a dyld`__abort_with_payload + 10
    frame #1: 0x0000000115593831 dyld`abort_with_payload_wrapper_internal + 80
    frame #2: 0x0000000115593863 dyld`abort_with_payload + 9
    frame #3: 0x000000010d17aef8 dyld_sim`abort_with_payload + 26
    frame #4: 0x000000010d1316bf dyld_sim`dyld::halt(char const*) + 672
    frame #5: 0x000000010d131849 dyld_sim`dyld::fastBindLazySymbol(ImageLoader**, unsigned long) + 167
    frame #6: 0x000000010fc15ed9 libdyld.dylib`_dyld_fast_stub_entry(void*, long) + 65
    frame #7: 0x000000010fc145a6 libdyld.dylib`dyld_stub_binder + 282
    frame #8: 0x000000010d119000 ios15test
  * frame #9: 0x000000012b4e97a4 ios15testTests`ios15testTests.testFeatureKey(self=0x00007fc7b1e2d790) at ios15testTests.swift:16:26
    frame #10: 0x000000012b4e9b30 ios15testTests`@objc ios15testTests.testFeatureKey() at <compiler-generated>:0
    frame #11: 0x000000010f1aca3c CoreFoundation`__invoking___ + 140
    frame #12: 0x000000010f1a9c6f CoreFoundation`-[NSInvocation invoke] + 305
    frame #13: 0x00000001231ce231 XCTest`+[XCTFailableInvocation invokeErrorConventionInvocation:completion:] + 118
    frame #14: 0x00000001231ce1b9 XCTest`__65+[XCTFailableInvocation invokeInvocation:lastObservedErrorIssue:]_block_invoke + 23
    frame #15: 0x00000001231cde5c XCTest`__81+[XCTFailableInvocation invokeWithAsynchronousWait:lastObservedErrorIssue:block:]_block_invoke.13 + 71
    frame #16: 0x0000000123270408 XCTest`+[XCTSwiftErrorObservation observeErrorsInBlock:] + 69
    frame #17: 0x00000001231cdcf1 XCTest`+[XCTFailableInvocation invokeWithAsynchronousWait:lastObservedErrorIssue:block:] + 443
    frame #18: 0x00000001231ce0d2 XCTest`+[XCTFailableInvocation invokeInvocation:lastObservedErrorIssue:] + 237
    frame #19: 0x00000001231b94b4 XCTest`__24-[XCTestCase invokeTest]_block_invoke.269 + 109
    frame #20: 0x000000012321c5ba XCTest`-[XCTestCase(XCTIssueHandling) _caughtUnhandledDeveloperExceptionPermittingControlFlowInterruptions:caughtInterruptionException:whileExecutingBlock:] + 183
    frame #21: 0x00000001231b9058 XCTest`-[XCTestCase invokeTest] + 849
    frame #22: 0x00000001231ba872 XCTest`__26-[XCTestCase performTest:]_block_invoke_2 + 43
    frame #23: 0x000000012321c5ba XCTest`-[XCTestCase(XCTIssueHandling) _caughtUnhandledDeveloperExceptionPermittingControlFlowInterruptions:caughtInterruptionException:whileExecutingBlock:] + 183
    frame #24: 0x00000001231ba7a9 XCTest`__26-[XCTestCase performTest:]_block_invoke.367 + 86
    frame #25: 0x0000000123234913 XCTest`+[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 220
    frame #26: 0x00000001231b9fb6 XCTest`-[XCTestCase performTest:] + 693
    frame #27: 0x0000000123202e39 XCTest`-[XCTest runTest] + 57
    frame #28: 0x00000001231b156a XCTest`-[XCTestSuite runTestBasedOnRepetitionPolicy:testRun:] + 156
    frame #29: 0x00000001231b13e0 XCTest`__27-[XCTestSuite performTest:]_block_invoke + 252
    frame #30: 0x00000001231b0c07 XCTest`__59-[XCTestSuite _performProtectedSectionForTest:testSection:]_block_invoke + 24
    frame #31: 0x0000000123234913 XCTest`+[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 220
    frame #32: 0x00000001231b0bbe XCTest`-[XCTestSuite _performProtectedSectionForTest:testSection:] + 159
    frame #33: 0x00000001231b0eee XCTest`-[XCTestSuite performTest:] + 281
    frame #34: 0x0000000123202e39 XCTest`-[XCTest runTest] + 57
    frame #35: 0x00000001231b156a XCTest`-[XCTestSuite runTestBasedOnRepetitionPolicy:testRun:] + 156
    frame #36: 0x00000001231b13e0 XCTest`__27-[XCTestSuite performTest:]_block_invoke + 252
    frame #37: 0x00000001231b0c07 XCTest`__59-[XCTestSuite _performProtectedSectionForTest:testSection:]_block_invoke + 24
    frame #38: 0x0000000123234913 XCTest`+[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 220
    frame #39: 0x00000001231b0bbe XCTest`-[XCTestSuite _performProtectedSectionForTest:testSection:] + 159
    frame #40: 0x00000001231b0eee XCTest`-[XCTestSuite performTest:] + 281
    frame #41: 0x0000000123202e39 XCTest`-[XCTest runTest] + 57
    frame #42: 0x00000001231b156a XCTest`-[XCTestSuite runTestBasedOnRepetitionPolicy:testRun:] + 156
    frame #43: 0x00000001231b13e0 XCTest`__27-[XCTestSuite performTest:]_block_invoke + 252
    frame #44: 0x00000001231b0c07 XCTest`__59-[XCTestSuite _performProtectedSectionForTest:testSection:]_block_invoke + 24
    frame #45: 0x0000000123234913 XCTest`+[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 220
    frame #46: 0x00000001231b0bbe XCTest`-[XCTestSuite _performProtectedSectionForTest:testSection:] + 159
    frame #47: 0x00000001231b0eee XCTest`-[XCTestSuite performTest:] + 281
    frame #48: 0x0000000123202e39 XCTest`-[XCTest runTest] + 57
    frame #49: 0x000000012324af6b XCTest`__44-[XCTTestRunSession runTestsAndReturnError:]_block_invoke_2 + 148
    frame #50: 0x0000000123234913 XCTest`+[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 220
    frame #51: 0x000000012324aed0 XCTest`__44-[XCTTestRunSession runTestsAndReturnError:]_block_invoke + 119
    frame #52: 0x000000012324b051 XCTest`__44-[XCTTestRunSession runTestsAndReturnError:]_block_invoke.91 + 96
    frame #53: 0x00000001231d0104 XCTest`-[XCTestObservationCenter _observeTestExecutionForBlock:] + 325
    frame #54: 0x000000012324ac43 XCTest`-[XCTTestRunSession runTestsAndReturnError:] + 473
    frame #55: 0x00000001231941bf XCTest`-[XCTestDriver _runTests] + 470
    frame #56: 0x000000012322f258 XCTest`_XCTestMain + 108
    frame #57: 0x000000010d1dd9b5 libXCTestBundleInject.dylib`__RunTests_block_invoke_2 + 13
    frame #58: 0x000000010f113c74 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 12
    frame #59: 0x000000010f113070 CoreFoundation`__CFRunLoopDoBlocks + 437
    frame #60: 0x000000010f10da08 CoreFoundation`__CFRunLoopRun + 892
    frame #61: 0x000000010f10d1a7 CoreFoundation`CFRunLoopRunSpecific + 567
    frame #62: 0x000000011a493d85 GraphicsServices`GSEventRunModal + 139
    frame #63: 0x0000000111d9f4df UIKitCore`-[UIApplication _run] + 912
    frame #64: 0x0000000111da439c UIKitCore`UIApplicationMain + 101
    frame #65: 0x000000010e45df42 libswiftUIKit.dylib`UIKit.UIApplicationMain(Swift.Int32, Swift.Optional<Swift.UnsafeMutablePointer<Swift.UnsafeMutablePointer<Swift.Int8>>>, Swift.Optional<Swift.String>, Swift.Optional<Swift.String>) -> Swift.Int32 + 98
    frame #66: 0x000000010d115738 ios15test`static UIApplicationDelegate.main() at <compiler-generated>:0
    frame #67: 0x000000010d1156c7 ios15test`static AppDelegate.$main(self=ios15test.AppDelegate) at AppDelegate.swift:10:1
    frame #68: 0x000000010d115818 ios15test`main at <compiler-generated>:0
    frame #69: 0x000000010fc11bbd libdyld.dylib`start + 1
```

# Notes

Test runs when build with Xcode 12.5.1

