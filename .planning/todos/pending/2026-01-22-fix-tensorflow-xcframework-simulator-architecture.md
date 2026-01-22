---
created: 2026-01-22T17:12
title: Fix TensorFlow XCFramework iOS simulator architecture mismatch
area: ios
files:
  - ios/Podfile
  - ios/Podfile.lock
---

## Problem

iOS simulator build fails with linker error:

```
Error (Xcode): Building for 'iOS-simulator', but linking in object file 
(/Users/home/Projects/embeddingGemma/build/ios/Debug-iphonesimulator/XCFrameworkIntermediates/TensorFlowLiteSelectTfOps/TensorFlowLiteSelectTfOps.framework/TensorFlowLiteSelectTfOps[983](any.o)) built for 'iOS'
```

The TensorFlowLiteSelectTfOps XCFramework is built for iOS arm64 but the simulator build requires x86_64/arm64-simulator slices. This is pulled in by flutter_gemma 0.12.2 via CocoaPods.

**Context:**
- Discovered during 00-01-PLAN.md execution
- Dart code compiles correctly - this is a native build issue
- Blocks iOS simulator testing entirely

## Solution

TBD - Possible approaches:
1. Check if TensorFlowLiteSelectTfOps pod has simulator-compatible version
2. Modify Podfile to exclude simulator slices or use different pod spec
3. Check flutter_gemma issue tracker for known workarounds
4. Consider using `EXCLUDED_ARCHS` in Xcode build settings
5. Rebuild/update CocoaPods cache with `pod cache clean --all && pod install`
