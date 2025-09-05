# 🏗️ **React Native Architecture Migration**

> **Complete guide to migrating from the old React Native architecture to the new architecture (Fabric + TurboModules)**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Overview](#overview)
- [Old vs New Architecture](#old-vs-new-architecture)
- [Migration Prerequisites](#migration-prerequisites)
- [Step-by-Step Migration](#step-by-step-migration)
- [Common Migration Issues](#common-migration-issues)
- [Testing New Architecture](#testing-new-architecture)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Overview**

The New Architecture introduces:
- **Fabric**: New rendering system
- **TurboModules**: New native module system
- **JSI**: JavaScript Interface for direct communication
- **Codegen**: Automatic type generation

### **Benefits of New Architecture**
- **Better Performance**: Direct JSI communication
- **Type Safety**: Automatic TypeScript generation
- **Improved Debugging**: Better error messages
- **Future-Proof**: Foundation for new features

---

## 🔄 **Old vs New Architecture**

### **Old Architecture (Bridge-Based)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// JavaScript → Bridge → Native
// Slower communication
// Limited type safety
// Bridge bottleneck

// Example: Old module
const { NativeModules } = require('react-native');
const { MyNativeModule } = NativeModules;

MyNativeModule.doSomething('param', (result) => {
  console.log(result);
});
```

### **New Architecture (JSI-Based)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// JavaScript ↔ JSI ↔ Native
// Direct communication
// Type-safe interfaces
// Better performance

// Example: New module
import { MyNativeModule } from './MyNativeModule';

const result = await MyNativeModule.doSomething('param');
console.log(result);
```

### **Key Differences**

| Aspect | Old Architecture | New Architecture |
|--------|------------------|------------------|
| **Communication** | Bridge-based | JSI-based |
| **Performance** | Slower | Faster |
| **Type Safety** | Limited | Full TypeScript |
| **Debugging** | Basic | Enhanced |
| **Memory** | Higher usage | Optimized |
| **Synchronization** | Async | Sync/Async |

---

## 🔧 **Migration Prerequisites**

### **1. React Native Version**
```json
// package.json
{
  "dependencies": {
    "react-native": ">=0.68.0"
  }
}
```

### **2. Platform Requirements**
```bash
# iOS
# Xcode 13+
# iOS 11+

# Android
# Android Gradle Plugin 7.0+
# Gradle 7.0+
# compileSdkVersion 31+
```

### **3. Dependencies**
```json
// package.json
{
  "devDependencies": {
    "@react-native-community/cli": "^9.0.0",
    "react-native-codegen": "^0.68.0"
  }
}
```

---

## 🚀 **Step-by-Step Migration**

### **Step 1: Enable New Architecture**

#### **Android Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```properties
# android/gradle.properties
newArchEnabled=true
```

#### **iOS Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```ruby
# ios/Podfile
use_frameworks! :linkage => :static
$RCTNewArchEnabled = true

target 'YourApp' do
  # ... existing configuration
end
```

### **Step 2: Update Dependencies**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Update React Native
npm install react-native@latest

# Update iOS pods
cd ios && pod install && cd ..

# Clean and rebuild
npx react-native clean
```

### **Step 3: Update Metro Configuration**
```javascript
// metro.config.js
const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');

const config = {
  resolver: {
    unstable_enablePackageExports: true,
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
```

### **Step 4: Update Native Code**

#### **Android Updates**
```gradle
// android/app/build.gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        targetSdkVersion 33
    }
}

dependencies {
    implementation "com.facebook.react:react-android"
    implementation "com.facebook.react:newarch"
}
```

#### **iOS Updates**
```swift
// ios/YourApp/AppDelegate.mm
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTNewArchitectureEnabled.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"YourApp"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  
#if RCT_NEW_ARCH_ENABLED
  rootView.fabricEnabled = YES;
#endif
  
  return YES;
}
```

### **Step 5: Update JavaScript Code**

#### **Remove Bridge Dependencies**
```javascript
// ❌ Old way
import { NativeModules } from 'react-native';
const { MyModule } = NativeModules;

// ✅ New way
import { MyModule } from './MyModule';
```

#### **Update Event Listeners**
```javascript
// ❌ Old way
import { DeviceEventEmitter } from 'react-native';

DeviceEventEmitter.addListener('MyEvent', (data) => {
  console.log(data);
});

// ✅ New way
import { MyModule } from './MyModule';

MyModule.addListener('MyEvent', (data) => {
  console.log(data);
});
```

---

## 🛠️ **Common Migration Issues**

### **1. Native Module Compatibility**
```javascript
// Check if module supports New Architecture
const isNewArchEnabled = global.RN$Bridgeless === true;

if (isNewArchEnabled) {
  // Use new module
  import { MyModule } from './MyModule';
} else {
  // Use old module
  const { MyModule } = require('react-native').NativeModules;
}
```

### **2. Third-Party Library Issues**
```bash
# Check library compatibility
npm list react-native

# Look for New Architecture support
# Check library documentation
# Consider alternatives if not supported
```

### **3. Build Issues**
```bash
# Clean everything
npx react-native clean
cd ios && pod deintegrate && pod install && cd ..
cd android && ./gradlew clean && cd ..

# Rebuild
npx react-native run-ios
npx react-native run-android
```

### **4. Performance Issues**
```javascript
// Monitor performance
import { Performance } from 'react-native-performance';

// Measure component render time
const startTime = Performance.now();
// ... component logic
const endTime = Performance.now();
console.log(`Render time: ${endTime - startTime}ms`);
```

---

## 🧪 **Testing New Architecture**

### **1. Unit Tests**
```javascript
// Test new architecture features
describe('New Architecture', () => {
  it('should support JSI modules', async () => {
    const result = await MyJSIModule.doSomething();
    expect(result).toBeDefined();
  });

  it('should handle type-safe interfaces', () => {
    const module = new MyTurboModule();
    expect(module.getType()).toBe('TurboModule');
  });
});
```

### **2. Integration Tests**
```javascript
// Test app functionality
describe('App with New Architecture', () => {
  it('should render without crashing', () => {
    const tree = renderer.create(<App />);
    expect(tree).toBeTruthy();
  });

  it('should handle navigation', () => {
    // Test navigation with new architecture
  });
});
```

### **3. Performance Tests**
```javascript
// Test performance improvements
describe('Performance', () => {
  it('should have better render performance', () => {
    const startTime = performance.now();
    render(<ComplexComponent />);
    const endTime = performance.now();
    
    expect(endTime - startTime).toBeLessThan(100); // 100ms threshold
  });
});
```

---

## ✅ **Best Practices**

### **1. Gradual Migration**
```javascript
// Use feature flags
const useNewArchitecture = useFeatureFlag('new-architecture');

const MyComponent = () => {
  if (useNewArchitecture) {
    return <NewArchitectureComponent />;
  }
  return <OldArchitectureComponent />;
};
```

### **2. Backward Compatibility**
```javascript
// Maintain compatibility
const MyModule = {
  async doSomething() {
    if (global.RN$Bridgeless) {
      return await newArchModule.doSomething();
    }
    return await oldArchModule.doSomething();
  }
};
```

### **3. Error Handling**
```javascript
// Handle new architecture errors
try {
  const result = await newArchModule.doSomething();
  return result;
} catch (error) {
  console.error('New Architecture error:', error);
  // Fallback to old architecture
  return await oldArchModule.doSomething();
}
```

### **4. Monitoring**
```javascript
// Monitor new architecture usage
import { Analytics } from './Analytics';

const trackNewArchUsage = () => {
  Analytics.track('new_architecture_enabled', {
    version: '0.70.0',
    platform: Platform.OS
  });
};
```

### **5. Documentation**
```markdown
# Document migration steps
# Keep compatibility matrix
# Update team on changes
```

---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **What is the New Architecture in React Native?**
   - Fabric rendering system
   - TurboModules for native modules
   - JSI for direct communication
   - Codegen for type safety

2. **What are the benefits of the New Architecture?**
   - Better performance
   - Type safety
   - Improved debugging
   - Future-proofing

3. **How do you enable the New Architecture?**
   - Set newArchEnabled=true in gradle.properties
   - Enable in iOS Podfile
   - Update dependencies
   - Test thoroughly

### **Intermediate Questions**
4. **What's the difference between old and new architecture?**
   - Old: Bridge-based communication
   - New: JSI-based communication
   - Old: Limited type safety
   - New: Full TypeScript support

5. **How do you migrate existing native modules?**
   - Update to TurboModule interface
   - Implement JSI methods
   - Add type definitions
   - Test compatibility

6. **What are common migration issues?**
   - Third-party library compatibility
   - Build configuration issues
   - Performance regressions
   - Breaking changes

### **Advanced Questions**
7. **How do you handle backward compatibility during migration?**
   - Feature flags
   - Conditional imports
   - Fallback mechanisms
   - Gradual rollout

8. **What's your strategy for testing the New Architecture?**
   - Unit tests for new features
   - Integration tests for app functionality
   - Performance benchmarks
   - User acceptance testing

9. **How do you monitor New Architecture adoption?**
   - Analytics tracking
   - Performance monitoring
   - Error reporting
   - User feedback

---

## 🔗 **Related Topics**

- [Version Upgrades](./01-Version-Upgrades.md)
- [Breaking Changes](./02-Breaking-Changes.md)
- [Migration Testing](./04-Migration-Testing.md)
- [Native Interoperability](../07-Native-Interoperability/01-Old-vs-New-Architecture.md)
- [Performance Optimization](../05-Lists-Performance-Optimization/01-FlatList-SectionList.md)

---

## 📚 **Resources**

- [New Architecture Guide](https://reactnative.dev/docs/the-new-architecture/landing-page)
- [Fabric Documentation](https://reactnative.dev/docs/the-new-architecture/fabric-renderer)
- [TurboModules Guide](https://reactnative.dev/docs/the-new-architecture/turbomodules)
- [Migration Guide](https://reactnative.dev/docs/the-new-architecture/migration-guide)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Breaking-Changes.md" class="nav-link prev">⬅️ Previous: Breaking Changes</a>
    <a href="./04-Migration-Testing.md" class="nav-link next">Next: Migration Testing ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
