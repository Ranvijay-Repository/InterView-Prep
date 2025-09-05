# 📱 **Native Debugging**

> **Master native debugging techniques for React Native applications, including iOS and Android platform-specific debugging tools and strategies**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Native Debugging Overview](#native-debugging-overview)
- [iOS Native Debugging](#ios-native-debugging)
- [Android Native Debugging](#android-native-debugging)
- [Native Module Debugging](#native-module-debugging)
- [Bridge Debugging](#bridge-debugging)
- [Native Performance](#native-performance)
- [Cross-Platform Debugging](#cross-platform-debugging)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Native Debugging Overview**

Native debugging involves debugging platform-specific code, native modules, and the React Native bridge to ensure optimal performance and functionality.

### **Native Debugging Ecosystem**

```
┌─────────────────────────────────────┐
│        Native Debugging            │
│  ┌─────────────────────────────────┐│
│  │        iOS Platform            ││
│  │  - Xcode Debugger              ││
│  │  - LLDB                        ││
│  │  - Instruments                 ││
│  │  - Console Logs                ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Android Platform        ││
│  │  - Android Studio              ││
│  │  - GDB                         ││
│  │  - Profiler                    ││
│  │  - Logcat                      ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Bridge Layer            ││
│  │  - JSI Debugging               ││
│  │  - TurboModules                ││
│  │  - Fabric Renderer             ││
│  │  - Native Module Interface     ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

### **Key Debugging Areas**
- **Native Module Issues**: Custom native code problems
- **Bridge Communication**: JavaScript-Native communication
- **Platform-Specific Bugs**: iOS/Android specific issues
- **Performance Issues**: Native performance bottlenecks
- **Memory Issues**: Native memory leaks and optimization

---

## 🍎 **iOS Native Debugging**

### **Xcode Debugger Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Open iOS project in Xcode
cd ios && open YourApp.xcworkspace

# Build and run with debugging
# Product -> Run (Cmd+R)
# Or use command line
xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -configuration Debug
```

### **iOS Native Module Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```swift
// iOS native module with debugging
import Foundation
import React

@objc(DebugModule)
class DebugModule: NSObject {
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc
    func logMessage(_ message: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        // Add breakpoint here for debugging
        print("[iOS Debug] \(message)")
        
        // Debug with LLDB
        // (lldb) po message
        // (lldb) bt
        
        resolver("Message logged successfully")
    }
    
    @objc
    func crashApp(_ resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        // Intentional crash for debugging
        fatalError("Debug crash triggered")
    }
}
```

### **iOS Console Logging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```swift
// iOS console logging utilities
import Foundation
import os.log

class iOSDebugLogger {
    static let shared = iOSDebugLogger()
    private let logger = OSLog(subsystem: "com.yourapp.debug", category: "debug")
    
    func log(_ message: String, level: OSLogType = .default) {
        os_log("%{public}@", log: logger, type: level, message)
    }
    
    func logError(_ error: Error) {
        os_log("Error: %{public}@", log: logger, type: .error, error.localizedDescription)
    }
    
    func logPerformance(_ operation: String, duration: TimeInterval) {
        os_log("Performance: %{public}@ took %{public}f seconds", log: logger, type: .info, operation, duration)
    }
}

// Usage in native module
@objc
func performOperation(_ resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    // Your operation here
    let result = performSomeOperation()
    
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    iOSDebugLogger.shared.logPerformance("performOperation", duration: timeElapsed)
    
    resolver(result)
}
```

### **iOS Instruments Profiling**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Use Instruments for profiling
# Product -> Profile (Cmd+I) in Xcode
# Or command line
instruments -t "Time Profiler" -D trace.trace YourApp.app

# Memory profiling
instruments -t "Allocations" -D memory.trace YourApp.app

# Network profiling
instruments -t "Network" -D network.trace YourApp.app
```

---

## 🤖 **Android Native Debugging**

### **Android Studio Debugger Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Open Android project in Android Studio
cd android && ./gradlew assembleDebug

# Enable debugging
# Run -> Debug 'app'
# Or use command line
./gradlew installDebug
adb shell am start -n com.yourapp/.MainActivity
```

### **Android Native Module Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```java
// Android native module with debugging
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import android.util.Log;

public class DebugModule extends ReactContextBaseJavaModule {
    private static final String TAG = "DebugModule";
    
    public DebugModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }
    
    @Override
    public String getName() {
        return "DebugModule";
    }
    
    @ReactMethod
    public void logMessage(String message, Promise promise) {
        // Add breakpoint here for debugging
        Log.d(TAG, "[Android Debug] " + message);
        
        // Debug with GDB
        // (gdb) break DebugModule.logMessage
        // (gdb) run
        // (gdb) print message
        
        promise.resolve("Message logged successfully");
    }
    
    @ReactMethod
    public void crashApp(Promise promise) {
        // Intentional crash for debugging
        throw new RuntimeException("Debug crash triggered");
    }
}
```

### **Android Logcat Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# View Android logs
adb logcat

# Filter specific tags
adb logcat -s "ReactNativeJS" "ReactNative" "YourApp"

# Filter by log level
adb logcat *:E  # Errors only
adb logcat *:W  # Warnings and above
adb logcat *:I  # Info and above

# Clear logs
adb logcat -c

# Save logs to file
adb logcat > debug.log
```

### **Android Native Logging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```java
// Android native logging utilities
import android.util.Log;
import java.util.concurrent.TimeUnit;

public class AndroidDebugLogger {
    private static final String TAG = "AndroidDebug";
    
    public static void log(String message) {
        Log.d(TAG, message);
    }
    
    public static void logError(String message, Throwable error) {
        Log.e(TAG, message, error);
    }
    
    public static void logPerformance(String operation, long durationMs) {
        Log.i(TAG, String.format("Performance: %s took %d ms", operation, durationMs));
    }
    
    public static void logMemoryUsage() {
        Runtime runtime = Runtime.getRuntime();
        long usedMemory = runtime.totalMemory() - runtime.freeMemory();
        long maxMemory = runtime.maxMemory();
        
        Log.i(TAG, String.format("Memory: %d MB / %d MB", 
            usedMemory / 1024 / 1024, 
            maxMemory / 1024 / 1024));
    }
}

// Usage in native module
@ReactMethod
public void performOperation(Promise promise) {
    long startTime = System.currentTimeMillis();
    
    try {
        // Your operation here
        String result = performSomeOperation();
        
        long duration = System.currentTimeMillis() - startTime;
        AndroidDebugLogger.logPerformance("performOperation", duration);
        
        promise.resolve(result);
    } catch (Exception e) {
        AndroidDebugLogger.logError("Operation failed", e);
        promise.reject("OPERATION_ERROR", e.getMessage());
    }
}
```

---

## 🔗 **Native Module Debugging**

### **Native Module Interface Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// JavaScript side debugging
import { NativeModules } from 'react-native';

const DebugModule = NativeModules.DebugModule;

// Debug native module calls
const debugNativeCall = async (methodName, ...args) => {
  console.log(`[Native Debug] Calling ${methodName} with args:`, args);
  
  try {
    const startTime = performance.now();
    const result = await DebugModule[methodName](...args);
    const endTime = performance.now();
    
    console.log(`[Native Debug] ${methodName} completed in ${endTime - startTime}ms`);
    console.log(`[Native Debug] Result:`, result);
    
    return result;
  } catch (error) {
    console.error(`[Native Debug] ${methodName} failed:`, error);
    throw error;
  }
};

// Usage
const result = await debugNativeCall('logMessage', 'Hello from JavaScript');
```

### **Native Module Error Handling**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Robust native module error handling
const SafeNativeModule = {
  async callMethod(methodName, ...args) {
    try {
      if (!DebugModule || typeof DebugModule[methodName] !== 'function') {
        throw new Error(`Native method ${methodName} not available`);
      }
      
      const result = await DebugModule[methodName](...args);
      return { success: true, data: result };
    } catch (error) {
      console.error(`[Native Error] ${methodName}:`, error);
      return { success: false, error: error.message };
    }
  },
  
  // Retry mechanism for failed calls
  async callWithRetry(methodName, maxRetries = 3, ...args) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
      const result = await SafeNativeModule.callMethod(methodName, ...args);
      
      if (result.success) {
        return result;
      }
      
      if (attempt === maxRetries) {
        throw new Error(`Native method ${methodName} failed after ${maxRetries} attempts`);
      }
      
      // Wait before retry
      await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
    }
  }
};
```

---

## 🌉 **Bridge Debugging**

### **Bridge Communication Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Bridge communication debugging
const BridgeDebugger = {
  // Monitor bridge calls
  monitorBridgeCalls: () => {
    const originalCallNativeModules = global.__callNativeModules;
    
    global.__callNativeModules = function(module, method, params, onFail, onSucc) {
      console.log(`[Bridge] Calling ${module}.${method}`, params);
      
      const startTime = performance.now();
      
      const originalOnSucc = onSucc;
      const originalOnFail = onFail;
      
      onSucc = (result) => {
        const endTime = performance.now();
        console.log(`[Bridge] ${module}.${method} succeeded in ${endTime - startTime}ms`, result);
        originalOnSucc(result);
      };
      
      onFail = (error) => {
        const endTime = performance.now();
        console.error(`[Bridge] ${module}.${method} failed in ${endTime - startTime}ms`, error);
        originalOnFail(error);
      };
      
      return originalCallNativeModules(module, method, params, onFail, onSucc);
    };
  },
  
  // Monitor bridge performance
  measureBridgePerformance: async (operation) => {
    const startTime = performance.now();
    const startMemory = performance.memory?.usedJSHeapSize || 0;
    
    try {
      const result = await operation();
      const endTime = performance.now();
      const endMemory = performance.memory?.usedJSHeapSize || 0;
      
      console.log(`[Bridge Performance]`, {
        duration: `${endTime - startTime}ms`,
        memoryDelta: `${(endMemory - startMemory) / 1024 / 1024}MB`
      });
      
      return result;
    } catch (error) {
      const endTime = performance.now();
      console.error(`[Bridge Performance] Failed after ${endTime - startTime}ms`, error);
      throw error;
    }
  }
};
```

### **JSI Debugging (New Architecture)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// JSI debugging for New Architecture
const JSIDebugger = {
  // Check if New Architecture is enabled
  isNewArchEnabled: () => {
    return global.RN$Bridgeless === true;
  },
  
  // Monitor JSI calls
  monitorJSICalls: () => {
    if (JSIDebugger.isNewArchEnabled()) {
      console.log('[JSI] New Architecture enabled');
      
      // Monitor TurboModule calls
      const originalCallTurboModule = global.__callTurboModule;
      if (originalCallTurboModule) {
        global.__callTurboModule = function(moduleName, methodName, args) {
          console.log(`[JSI] TurboModule call: ${moduleName}.${methodName}`, args);
          
          const startTime = performance.now();
          const result = originalCallTurboModule(moduleName, methodName, args);
          const endTime = performance.now();
          
          console.log(`[JSI] TurboModule result in ${endTime - startTime}ms`, result);
          return result;
        };
      }
    } else {
      console.log('[JSI] Old Architecture (Bridge) enabled');
    }
  }
};
```

---

## ⚡ **Native Performance**

### **Native Performance Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Native performance monitoring
const NativePerformanceMonitor = {
  // Measure native operation performance
  measureNativeOperation: async (operation, name) => {
    const startTime = performance.now();
    const startMemory = performance.memory?.usedJSHeapSize || 0;
    
    try {
      const result = await operation();
      const endTime = performance.now();
      const endMemory = performance.memory?.usedJSHeapSize || 0;
      
      const metrics = {
        name,
        duration: endTime - startTime,
        memoryDelta: endMemory - startMemory,
        timestamp: Date.now()
      };
      
      console.log(`[Native Performance] ${name}:`, metrics);
      return result;
    } catch (error) {
      const endTime = performance.now();
      console.error(`[Native Performance] ${name} failed after ${endTime - startTime}ms`, error);
      throw error;
    }
  },
  
  // Batch native operations
  batchNativeOperations: async (operations) => {
    const startTime = performance.now();
    const results = [];
    
    for (const operation of operations) {
      const result = await NativePerformanceMonitor.measureNativeOperation(
        operation.fn, 
        operation.name
      );
      results.push(result);
    }
    
    const endTime = performance.now();
    console.log(`[Native Performance] Batch of ${operations.length} operations took ${endTime - startTime}ms`);
    
    return results;
  }
};
```

### **Native Memory Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Native memory monitoring
const NativeMemoryMonitor = {
  // Get native memory info
  getNativeMemoryInfo: async () => {
    try {
      const { NativeModules } = require('react-native');
      if (NativeModules.MemoryMonitor) {
        return await NativeModules.MemoryMonitor.getMemoryInfo();
      }
    } catch (error) {
      console.warn('[Native Memory] Monitoring not available:', error);
    }
    return null;
  },
  
  // Monitor native memory usage
  startMonitoring: (interval = 10000) => {
    return setInterval(async () => {
      const memoryInfo = await NativeMemoryMonitor.getNativeMemoryInfo();
      if (memoryInfo) {
        console.log('[Native Memory]', memoryInfo);
      }
    }, interval);
  },
  
  // Check for native memory leaks
  checkForLeaks: async () => {
    const memoryInfo = await NativeMemoryMonitor.getNativeMemoryInfo();
    if (memoryInfo && memoryInfo.used > memoryInfo.threshold) {
      console.warn('[Native Memory] Potential memory leak detected:', memoryInfo);
    }
  }
};
```

---

## 🔄 **Cross-Platform Debugging**

### **Cross-Platform Debugging Strategy**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Cross-platform debugging utilities
const CrossPlatformDebugger = {
  // Platform-specific debugging
  debugByPlatform: (iosDebug, androidDebug) => {
    const { Platform } = require('react-native');
    
    if (Platform.OS === 'ios') {
      return iosDebug();
    } else if (Platform.OS === 'android') {
      return androidDebug();
    }
  },
  
  // Unified logging
  log: (message, level = 'info') => {
    const { Platform } = require('react-native');
    const timestamp = new Date().toISOString();
    
    console.log(`[${Platform.OS.toUpperCase()}] ${timestamp} [${level.toUpperCase()}] ${message}`);
  },
  
  // Platform-specific error handling
  handleError: (error) => {
    const { Platform } = require('react-native');
    
    if (Platform.OS === 'ios') {
      // iOS-specific error handling
      console.error('[iOS Error]', error);
    } else if (Platform.OS === 'android') {
      // Android-specific error handling
      console.error('[Android Error]', error);
    }
  }
};
```

### **Cross-Platform Testing**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Cross-platform testing utilities
const CrossPlatformTester = {
  // Test on both platforms
  testOnBothPlatforms: async (testFn) => {
    const { Platform } = require('react-native');
    
    console.log(`[Cross-Platform Test] Running on ${Platform.OS}`);
    
    try {
      const result = await testFn();
      console.log(`[Cross-Platform Test] ${Platform.OS} test passed`);
      return result;
    } catch (error) {
      console.error(`[Cross-Platform Test] ${Platform.OS} test failed:`, error);
      throw error;
    }
  },
  
  // Compare platform behavior
  comparePlatforms: async (testFn) => {
    const results = {};
    
    // This would need to be run on both platforms
    // and results compared
    const result = await testFn();
    results[Platform.OS] = result;
    
    return results;
  }
};
```

---

## ✅ **Best Practices**

### **1. Native Debugging Best Practices**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Native debugging best practices
const NativeDebuggingBestPractices = {
  // Use proper error handling
  safeNativeCall: async (nativeMethod, ...args) => {
    try {
      return await nativeMethod(...args);
    } catch (error) {
      console.error('[Native Error]', error);
      // Log to crash reporting service
      if (!__DEV__) {
        // Send to crash reporting
      }
      throw error;
    }
  },
  
  // Implement proper logging
  logNativeCall: (methodName, args, result) => {
    if (__DEV__) {
      console.log(`[Native Call] ${methodName}`, {
        args,
        result,
        timestamp: Date.now()
      });
    }
  },
  
  // Use performance monitoring
  monitorNativePerformance: (operation, name) => {
    const startTime = performance.now();
    
    return () => {
      const endTime = performance.now();
      const duration = endTime - startTime;
      
      if (duration > 100) { // 100ms threshold
        console.warn(`[Native Performance] ${name} took ${duration}ms`);
      }
    };
  }
};
```

### **2. Debugging Tools Integration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Debugging tools integration
const DebuggingToolsIntegration = {
  // Flipper integration
  setupFlipper: () => {
    if (__DEV__) {
      import('react-native-flipper').then(({ addPlugin }) => {
        addPlugin({
          getId() {
            return 'NativeDebugger';
          },
          onConnect(connection) {
            connection.send('init');
          },
          onDisconnect() {
            // Cleanup
          }
        });
      });
    }
  },
  
  // Chrome DevTools integration
  setupChromeDevTools: () => {
    if (__DEV__) {
      // Enable Chrome debugging
      console.log('[Debug] Chrome DevTools enabled');
    }
  }
};
```

---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **How do you debug native modules in React Native?**
   - Use Xcode/Android Studio debuggers
   - Check native logs
   - Use breakpoints in native code
   - Monitor bridge communication

2. **What tools do you use for iOS native debugging?**
   - Xcode debugger
   - LLDB
   - Instruments
   - Console logs
   - Simulator

3. **What tools do you use for Android native debugging?**
   - Android Studio debugger
   - GDB
   - Profiler
   - Logcat
   - Emulator

### **Intermediate Questions**
4. **How do you debug bridge communication issues?**
   - Monitor bridge calls
   - Check parameter types
   - Verify method signatures
   - Use bridge debugging tools

5. **How do you handle native module errors?**
   - Implement proper error handling
   - Use try-catch blocks
   - Log errors appropriately
   - Provide fallback mechanisms

6. **What's the difference between debugging old and new architecture?**
   - Old: Bridge-based debugging
   - New: JSI-based debugging
   - Different debugging tools
   - Different performance characteristics

### **Advanced Questions**
7. **How do you debug complex native performance issues?**
   - Use native profilers
   - Monitor memory usage
   - Check CPU usage
   - Analyze call stacks

8. **How do you implement cross-platform debugging?**
   - Use platform-specific tools
   - Implement unified logging
   - Test on both platforms
   - Compare platform behavior

9. **What's your strategy for debugging production native issues?**
   - Implement crash reporting
   - Use remote logging
   - Monitor performance metrics
   - Create debugging endpoints

---

## 🔗 **Related Topics**

- [Debugging Tools](./01-Debugging-Tools.md)
- [Performance Debugging](./02-Performance-Debugging.md)
- [Memory Debugging](./03-Memory-Debugging.md)
- [Native Interoperability](../07-Native-Interoperability/01-Old-vs-New-Architecture.md)
- [Migration & Upgrades](../20-Migration-Upgrades/01-Version-Upgrades.md)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Memory-Debugging.md" class="nav-link prev">⬅️ Previous: Memory Debugging</a>
    <a href="../20-Migration-Upgrades/01-Version-Upgrades.md" class="nav-link next">Next: Version Upgrades ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
