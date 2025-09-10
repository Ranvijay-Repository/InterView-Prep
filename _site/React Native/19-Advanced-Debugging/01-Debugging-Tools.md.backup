# 🔧 **Debugging Tools**

> **Master advanced debugging tools and techniques for React Native development, including Flipper, Chrome DevTools, and native debugging**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Debugging Tools Overview](#debugging-tools-overview)
- [Flipper Integration](#flipper-integration)
- [Chrome DevTools](#chrome-devtools)
- [React Native Debugger](#react-native-debugger)
- [Native Debugging](#native-debugging)
- [Remote Debugging](#remote-debugging)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Debugging Tools Overview**

Advanced debugging tools help developers identify, diagnose, and fix issues in React Native applications across JavaScript and native layers.

### **Debugging Ecosystem**


```
┌─────────────────────────────────────┐
│        Debugging Tools              │
│  ┌─────────────────────────────────┐│
│  │        JavaScript Layer        ││
│  │  - Chrome DevTools             ││
│  │  - React Native Debugger       ││
│  │  - Flipper                     ││
│  │  - Metro Bundler               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Native Layer            ││
│  │  - Xcode Debugger              ││
│  │  - Android Studio              ││
│  │  - LLDB/GDB                    ││
│  │  - Native Logs                 ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Network & Performance   ││
│  │  - Network Inspector           ││
│  │  - Performance Monitor         ││
│  │  - Memory Profiler             ││
│  │  - Bundle Analyzer             ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


### **Key Debugging Areas**
- **JavaScript Errors**: Runtime errors and exceptions
- **Performance Issues**: Slow renders and memory leaks
- **Network Problems**: API calls and data fetching
- **Native Issues**: Platform-specific problems
- **UI/UX Issues**: Layout and styling problems

---

## 🐬 **Flipper Integration**

### **Flipper Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Install Flipper
# Download from: https://fbflipper.com/

# Install React Native Flipper plugin
npm install --save-dev react-native-flipper

# For iOS
cd ios && pod install && cd ..
```


### **Flipper Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// App.js
import { useEffect } from 'react';
import { Platform } from 'react-native';

// Flipper integration
if (__DEV__) {
  import('./flipper-config').then(() => {
    console.log('Flipper configured');
  });
}

const App = () => {
  useEffect(() => {
    if (__DEV__ && Platform.OS === 'ios') {
      // iOS-specific debugging
      console.log('iOS debugging enabled');
    }
  }, []);

  return (
    // Your app components
  );
};
```


### **Flipper Plugins**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// flipper-config.js
import { addPlugin } from 'react-native-flipper';

// Network plugin
addPlugin({
  getId() {
    return 'Network';
  },
  onConnect(connection) {
    connection.send('init');
  },
  onDisconnect() {
    // Cleanup
  },
  runInBackground() {
    return true;
  }
});

// Database plugin
addPlugin({
  getId() {
    return 'Database';
  },
  onConnect(connection) {
    // Database debugging
  }
});
```


### **Custom Flipper Plugins**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Custom plugin for app state
import { addPlugin } from 'react-native-flipper';

const AppStatePlugin = {
  getId() {
    return 'AppState';
  },
  
  onConnect(connection) {
    this.connection = connection;
    this.setupAppStateListener();
  },
  
  setupAppStateListener() {
    import('react-native').then(({ AppState }) => {
      AppState.addEventListener('change', (nextAppState) => {
        this.connection?.send('appStateChange', {
          state: nextAppState,
          timestamp: Date.now()
        });
      });
    });
  },
  
  onDisconnect() {
    this.connection = null;
  }
};

addPlugin(AppStatePlugin);
```


---

## 🌐 **Chrome DevTools**

### **Chrome DevTools Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Enable Chrome debugging
npx react-native start

# In your app, enable debugging
# iOS: Cmd+D -> Debug
# Android: Cmd+M -> Debug
```


### **Chrome DevTools Features**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Console debugging
console.log('Debug message');
console.warn('Warning message');
console.error('Error message');
console.table(data); // Table view
console.group('Group name');
console.groupEnd();

// Performance debugging
console.time('operation');
// Your code here
console.timeEnd('operation');

// Memory debugging
console.memory; // Memory usage info
```


### **Source Maps and Breakpoints**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Debugging with breakpoints
const debugFunction = (data) => {
  debugger; // Breakpoint
  console.log('Data received:', data);
  
  // Step through code
  const processed = data.map(item => {
    return {
      ...item,
      processed: true
    };
  });
  
  return processed;
};

// Conditional debugging
const debugLog = (message, data) => {
  if (__DEV__) {
    console.log(`[DEBUG] ${message}`, data);
  }
};
```


### **Network Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Network debugging with Chrome DevTools
const apiCall = async (url, options) => {
  const startTime = performance.now();
  
  try {
    const response = await fetch(url, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...options.headers
      }
    });
    
    const endTime = performance.now();
    console.log(`API call to ${url} took ${endTime - startTime}ms`);
    
    return response;
  } catch (error) {
    console.error('API call failed:', error);
    throw error;
  }
};
```


---

## 🐛 **React Native Debugger**

### **React Native Debugger Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Install React Native Debugger
# Download from: https://github.com/jhen0409/react-native-debugger

# Or install via Homebrew (macOS)
brew install --cask react-native-debugger
```


### **Redux DevTools Integration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Redux store configuration
import { createStore, applyMiddleware } from 'redux';
import { composeWithDevTools } from 'redux-devtools-extension';

const store = createStore(
  rootReducer,
  composeWithDevTools(
    applyMiddleware(thunk, logger)
  )
);

// Redux actions debugging
const userActions = {
  login: (credentials) => ({
    type: 'USER_LOGIN',
    payload: credentials
  }),
  
  logout: () => ({
    type: 'USER_LOGOUT'
  })
};
```


### **Async Storage Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// AsyncStorage debugging
import AsyncStorage from '@react-native-async-storage/async-storage';

const debugAsyncStorage = {
  async setItem(key, value) {
    try {
      await AsyncStorage.setItem(key, JSON.stringify(value));
      console.log(`[AsyncStorage] Set ${key}:`, value);
    } catch (error) {
      console.error(`[AsyncStorage] Error setting ${key}:`, error);
    }
  },
  
  async getItem(key) {
    try {
      const value = await AsyncStorage.getItem(key);
      const parsed = value ? JSON.parse(value) : null;
      console.log(`[AsyncStorage] Get ${key}:`, parsed);
      return parsed;
    } catch (error) {
      console.error(`[AsyncStorage] Error getting ${key}:`, error);
      return null;
    }
  }
};
```


---

## 📱 **Native Debugging**

### **iOS Debugging with Xcode**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```swift
// iOS native debugging
import Foundation

class DebugHelper {
    static func log(_ message: String) {
        #if DEBUG
        print("[iOS Debug] \(message)")
        #endif
    }
    
    static func logError(_ error: Error) {
        #if DEBUG
        print("[iOS Error] \(error.localizedDescription)")
        #endif
    }
}

// Usage in native module
@objc(DebugModule)
class DebugModule: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc
    func logMessage(_ message: String) {
        DebugHelper.log(message)
    }
}
```


### **Android Debugging with Android Studio**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```java
// Android native debugging
import android.util.Log;

public class DebugHelper {
    private static final String TAG = "ReactNativeDebug";
    
    public static void log(String message) {
        Log.d(TAG, message);
    }
    
    public static void logError(String message, Throwable error) {
        Log.e(TAG, message, error);
    }
}

// Usage in native module
public class DebugModule extends ReactContextBaseJavaModule {
    @Override
    public String getName() {
        return "DebugModule";
    }
    
    @ReactMethod
    public void logMessage(String message) {
        DebugHelper.log(message);
    }
}
```


### **Native Logs**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# iOS logs
xcrun simctl spawn booted log stream --predicate 'process == "YourApp"'

# Android logs
adb logcat | grep "ReactNativeJS"

# Filter specific tags
adb logcat -s "ReactNativeJS" "ReactNative" "YourApp"
```


---

## 🌍 **Remote Debugging**

### **Remote Debugging Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Remote debugging configuration
const debugConfig = {
  enableRemoteDebugging: __DEV__,
  debuggerHost: 'localhost:8081',
  enableChromeDebugging: true,
  enableFlipper: true
};

// Remote debugging utilities
const remoteDebug = {
  log: (message, data) => {
    if (debugConfig.enableRemoteDebugging) {
      console.log(`[Remote Debug] ${message}`, data);
    }
  },
  
  error: (error) => {
    if (debugConfig.enableRemoteDebugging) {
      console.error('[Remote Debug Error]', error);
    }
  }
};
```


### **Production Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Production debugging with crash reporting
import crashlytics from '@react-native-firebase/crashlytics';

const productionDebug = {
  logError: (error, context = {}) => {
    if (__DEV__) {
      console.error('Error:', error, context);
    } else {
      crashlytics().recordError(error);
      crashlytics().setAttributes(context);
    }
  },
  
  logEvent: (event, parameters = {}) => {
    if (__DEV__) {
      console.log('Event:', event, parameters);
    } else {
      crashlytics().log(`${event}: ${JSON.stringify(parameters)}`);
    }
  }
};
```


---

## ✅ **Best Practices**

### **1. Debugging Strategy**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Systematic debugging approach
const debugStrategy = {
  // 1. Reproduce the issue
  reproduce: () => {
    console.log('Reproducing issue...');
  },
  
  // 2. Isolate the problem
  isolate: (component) => {
    console.log('Isolating problem in:', component);
  },
  
  // 3. Add debugging logs
  addLogs: (message, data) => {
    console.log(`[Debug] ${message}`, data);
  },
  
  // 4. Test the fix
  testFix: (fix) => {
    console.log('Testing fix:', fix);
  }
};
```


### **2. Performance Debugging**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Performance debugging utilities
const performanceDebug = {
  measureRender: (componentName) => {
    const start = performance.now();
    return () => {
      const end = performance.now();
      console.log(`${componentName} render time: ${end - start}ms`);
    };
  },
  
  measureAsync: async (operationName, operation) => {
    const start = performance.now();
    try {
      const result = await operation();
      const end = performance.now();
      console.log(`${operationName} took: ${end - start}ms`);
      return result;
    } catch (error) {
      const end = performance.now();
      console.error(`${operationName} failed after: ${end - start}ms`, error);
      throw error;
    }
  }
};
```


### **3. Error Boundaries**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Error boundary for debugging
class DebugErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }
  
  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }
  
  componentDidCatch(error, errorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
    
    // Log to crash reporting service
    if (!__DEV__) {
      crashlytics().recordError(error);
    }
  }
  
  render() {
    if (this.state.hasError) {
      return (
        <View style={styles.errorContainer}>
          <Text style={styles.errorText}>
            Something went wrong: {this.state.error?.message}
          </Text>
        </View>
      );
    }
    
    return this.props.children;
  }
}
```


---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **What debugging tools do you use for React Native?**
   - Chrome DevTools for JavaScript debugging
   - Flipper for advanced debugging
   - Xcode/Android Studio for native debugging
   - React Native Debugger for Redux

2. **How do you debug performance issues?**
   - Use Chrome DevTools Performance tab
   - Monitor render times
   - Check memory usage
   - Profile native performance

3. **What's the difference between debugging in development and production?**
   - Development: Full debugging tools available
   - Production: Limited debugging, crash reporting
   - Source maps for production debugging
   - Remote debugging capabilities

### **Intermediate Questions**
4. **How do you debug network issues in React Native?**
   - Use Flipper Network plugin
   - Chrome DevTools Network tab
   - Monitor API calls and responses
   - Check for CORS issues

5. **How do you debug native module issues?**
   - Use Xcode/Android Studio debuggers
   - Check native logs
   - Verify module registration
   - Test native functionality

6. **What's your approach to debugging memory leaks?**
   - Use Chrome DevTools Memory tab
   - Monitor memory usage over time
   - Check for retained references
   - Use memory profilers

### **Advanced Questions**
7. **How do you set up remote debugging for production issues?**
   - Implement crash reporting
   - Use remote logging services
   - Set up performance monitoring
   - Create debugging endpoints

8. **How do you debug complex state management issues?**
   - Use Redux DevTools
   - Implement state logging
   - Check action dispatching
   - Verify reducer logic

9. **What's your strategy for debugging cross-platform issues?**
   - Test on both platforms
   - Use platform-specific debugging
   - Check for platform differences
   - Implement platform-specific logging

---

## 🔗 **Related Topics**

- [Performance Debugging](./02-Performance-Debugging.md)
- [Memory Debugging](./03-Memory-Debugging.md)
- [Native Debugging](./04-Native-Debugging.md)
- [Performance Optimization](../05-Lists-Performance-Optimization/01-FlatList-SectionList.md)
- [Error Handling](../15-Error-Handling-Recovery/01-Error-Boundaries.md)

---

## 🧭 Navigation

<div class="navigation">
    <a href="../18-React-Native-Ecosystem/04-Creating-Libraries.md" class="nav-link prev">⬅️ Previous: Creating Libraries</a>
    <a href="./02-Performance-Debugging.md" class="nav-link next">Next: Performance Debugging ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
