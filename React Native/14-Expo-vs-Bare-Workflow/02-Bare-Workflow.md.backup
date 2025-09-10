# 🔧 **Bare Workflow**

> **Master bare React Native workflow, native development, and custom native modules**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Bare Workflow Overview](#-bare-workflow-overview)
- [Project Setup](#-project-setup)
- [Native Development](#-native-development)
- [Custom Native Modules](#-custom-native-modules)
- [Build Process](#-build-process)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 🔧 **Bare Workflow Overview**

### **Bare Workflow Architecture**


{% raw %}
```mermaid
graph TD
    A[Bare React Native] --> B[Android Project]
    A --> C[iOS Project]
    A --> D[JavaScript Bundle]
    
    B --> E[Gradle Build]
    B --> F[Native Android Code]
    C --> G[Xcode Build]
    C --> H[Native iOS Code]
    D --> I[Metro Bundler]
```
{% endraw %}


### **Key Benefits**
- **Full Control**: Complete access to native code
- **Custom Native Modules**: Write custom native functionality
- **Performance**: Optimized native implementations
- **Flexibility**: No Expo limitations

---

## 🏗️ **Project Setup**

### **Bare React Native Project Structure**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// Project structure for bare React Native
const BareProjectStructure = {
  // Root directory
  root: {
    'package.json': 'Project dependencies and scripts',
    'metro.config.js': 'Metro bundler configuration',
    'react-native.config.js': 'React Native CLI configuration',
    'babel.config.js': 'Babel configuration',
    'tsconfig.json': 'TypeScript configuration',
    'android/': 'Android native project',
    'ios/': 'iOS native project',
    'src/': 'JavaScript/TypeScript source code',
  },

  // Android project structure
  android: {
    'app/': 'Android application code',
    'app/src/main/': 'Main Android source',
    'app/src/main/java/': 'Java/Kotlin source code',
    'app/src/main/res/': 'Android resources',
    'app/build.gradle': 'App-level Gradle configuration',
    'build.gradle': 'Project-level Gradle configuration',
    'gradle.properties': 'Gradle properties',
    'settings.gradle': 'Gradle settings',
  },

  // iOS project structure
  ios: {
    'ProjectName.xcodeproj/': 'Xcode project file',
    'ProjectName/': 'iOS application code',
    'ProjectName/AppDelegate.h': 'iOS app delegate header',
    'ProjectName/AppDelegate.m': 'iOS app delegate implementation',
    'ProjectName/Info.plist': 'iOS app configuration',
    'ProjectName.xcworkspace': 'Xcode workspace (if using CocoaPods)',
    'Podfile': 'CocoaPods dependencies',
  },

  // Source code structure
  src: {
    'components/': 'Reusable React components',
    'screens/': 'Screen components',
    'navigation/': 'Navigation configuration',
    'services/': 'API and business logic services',
    'utils/': 'Utility functions',
    'types/': 'TypeScript type definitions',
    'constants/': 'App constants',
    'assets/': 'Images, fonts, and other assets',
  }
};

// Package.json for bare React Native project
const BarePackageJson = {
  name: 'BareReactNativeApp',
  version: '1.0.0',
  private: true,
  scripts: {
    'android': 'react-native run-android',
    'ios': 'react-native run-ios',
    'start': 'react-native start',
    'test': 'jest',
    'lint': 'eslint .',
    'build:android': 'cd android && ./gradlew assembleRelease',
    'build:ios': 'cd ios && xcodebuild -workspace BareReactNativeApp.xcworkspace -scheme BareReactNativeApp -configuration Release',
    'clean:android': 'cd android && ./gradlew clean',
    'clean:ios': 'cd ios && xcodebuild clean',
  },
  dependencies: {
    'react': '^18.2.0',
    'react-native': '^0.72.0',
    '@react-navigation/native': '^6.1.0',
    '@react-navigation/stack': '^6.3.0',
    'react-native-screens': '^3.25.0',
    'react-native-safe-area-context': '^4.7.0',
    'react-native-gesture-handler': '^2.12.0',
  },
  devDependencies: {
    '@babel/core': '^7.20.0',
    '@babel/preset-env': '^7.20.0',
    '@babel/runtime': '^7.20.0',
    '@react-native/eslint-config': '^0.72.0',
    '@react-native/metro-config': '^0.72.0',
    '@tsconfig/react-native': '^3.0.0',
    '@types/react': '^18.0.24',
    '@types/react-test-renderer': '^18.0.0',
    'babel-jest': '^29.2.1',
    'eslint': '^8.19.0',
    'jest': '^29.2.1',
    'metro-react-native-babel-preset': '0.76.5',
    'prettier': '^2.4.1',
    'react-test-renderer': '18.2.0',
    'typescript': '^4.8.4',
  },
  jest: {
    preset: 'react-native',
  },
};

export { BareProjectStructure, BarePackageJson };
```
{% endraw %}


### **Metro Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// metro.config.js for bare React Native
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

const defaultConfig = getDefaultConfig(__dirname);

const config = {
  transformer: {
    // Enable Hermes
    hermesParser: true,
    
    // Enable inline requires
    inlineRequires: true,
    
    // Enable minification
    minifierConfig: {
      keep_fnames: true,
      mangle: {
        keep_fnames: true,
      },
    },
  },
  
  resolver: {
    // Asset extensions
    assetExts: ['bin', 'txt', 'jpg', 'png', 'json', 'ttf', 'otf', 'woff', 'woff2'],
    
    // Source extensions
    sourceExts: ['js', 'json', 'ts', 'tsx', 'jsx'],
    
    // Platform extensions
    platforms: ['ios', 'android', 'native', 'web'],
  },
  
  serializer: {
    // Custom serializer options
    getModulesRunBeforeMainModule: () => [
      require.resolve('react-native/Libraries/Core/InitializeCore'),
    ],
  },
  
  server: {
    // Metro server configuration
    port: 8081,
    enhanceMiddleware: (middleware) => {
      return (req, res, next) => {
        // Custom middleware logic
        return middleware(req, res, next);
      };
    },
  },
  
  watchFolders: [
    // Additional folders to watch
    // '../shared-package',
  ],
};

module.exports = mergeConfig(defaultConfig, config);
```
{% endraw %}


---

## 📱 **Native Development**

### **Android Native Module**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```java
// android/app/src/main/java/com/bareapp/CustomModule.java
package com.bareapp;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;

import android.util.Log;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;

public class CustomModule extends ReactContextBaseJavaModule {
    private static final String MODULE_NAME = "CustomModule";
    private ReactApplicationContext reactContext;

    public CustomModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @ReactMethod
    public void getDeviceInfo(Promise promise) {
        try {
            WritableMap deviceInfo = Arguments.createMap();
            
            deviceInfo.putString("brand", Build.BRAND);
            deviceInfo.putString("model", Build.MODEL);
            deviceInfo.putString("version", Build.VERSION.RELEASE);
            deviceInfo.putInt("sdkVersion", Build.VERSION.SDK_INT);
            deviceInfo.putString("manufacturer", Build.MANUFACTURER);
            
            promise.resolve(deviceInfo);
        } catch (Exception e) {
            promise.reject("DEVICE_INFO_ERROR", e.getMessage());
        }
    }

    @ReactMethod
    public void showToast(String message, Promise promise) {
        try {
            android.widget.Toast.makeText(
                reactContext,
                message,
                android.widget.Toast.LENGTH_LONG
            ).show();
            
            promise.resolve("Toast shown successfully");
        } catch (Exception e) {
            promise.reject("TOAST_ERROR", e.getMessage());
        }
    }

    @ReactMethod
    public void checkPermission(String permission, Promise promise) {
        try {
            Context context = reactContext.getApplicationContext();
            int result = context.checkSelfPermission(permission);
            
            boolean granted = result == PackageManager.PERMISSION_GRANTED;
            promise.resolve(granted);
        } catch (Exception e) {
            promise.reject("PERMISSION_ERROR", e.getMessage());
        }
    }

    @ReactMethod
    public void performAsyncTask(ReadableMap params, Promise promise) {
        // Simulate async task
        new Thread(() -> {
            try {
                Thread.sleep(2000); // Simulate work
                
                WritableMap result = Arguments.createMap();
                result.putString("status", "completed");
                result.putString("message", "Async task completed successfully");
                result.putDouble("timestamp", System.currentTimeMillis());
                
                promise.resolve(result);
            } catch (Exception e) {
                promise.reject("ASYNC_TASK_ERROR", e.getMessage());
            }
        }).start();
    }
}
```
{% endraw %}


### **iOS Native Module**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```objc
// ios/BareApp/CustomModule.h
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface CustomModule : NSObject <RCTBridgeModule>

@end
```
{% endraw %}



{% raw %}
```objc
// ios/BareApp/CustomModule.m
#import "CustomModule.h"
#import <React/RCTLog.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

@implementation CustomModule

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getDeviceInfo:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        NSMutableDictionary *deviceInfo = [NSMutableDictionary dictionary];
        
        UIDevice *device = [UIDevice currentDevice];
        deviceInfo[@"name"] = device.name;
        deviceInfo[@"model"] = device.model;
        deviceInfo[@"systemName"] = device.systemName;
        deviceInfo[@"systemVersion"] = device.systemVersion;
        deviceInfo[@"identifierForVendor"] = device.identifierForVendor.UUIDString;
        
        // Get device model name
        struct utsname systemInfo;
        uname(&systemInfo);
        deviceInfo[@"deviceModel"] = [NSString stringWithCString:systemInfo.machine
                                                         encoding:NSUTF8StringEncoding];
        
        resolve(deviceInfo);
    } @catch (NSException *exception) {
        reject(@"DEVICE_INFO_ERROR", exception.reason, nil);
    }
}

RCT_EXPORT_METHOD(showToast:(NSString *)message
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Toast"
                                                                           message:message
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            [rootViewController presentViewController:alert animated:YES completion:nil];
            
            // Auto dismiss after 2 seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        });
        
        resolve(@"Toast shown successfully");
    } @catch (NSException *exception) {
        reject(@"TOAST_ERROR", exception.reason, nil);
    }
}

RCT_EXPORT_METHOD(checkPermission:(NSString *)permission
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        // iOS permission checking logic
        BOOL granted = NO;
        
        if ([permission isEqualToString:@"camera"]) {
            granted = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized;
        } else if ([permission isEqualToString:@"location"]) {
            granted = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
                     [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
        }
        
        resolve(@(granted));
    } @catch (NSException *exception) {
        reject(@"PERMISSION_ERROR", exception.reason, nil);
    }
}

RCT_EXPORT_METHOD(performAsyncTask:(NSDictionary *)params
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // Simulate async work
            [NSThread sleepForTimeInterval:2.0];
            
            NSDictionary *result = @{
                @"status": @"completed",
                @"message": @"Async task completed successfully",
                @"timestamp": @([[NSDate date] timeIntervalSince1970] * 1000)
            };
            
            resolve(result);
        });
    } @catch (NSException *exception) {
        reject(@"ASYNC_TASK_ERROR", exception.reason, nil);
    }
}

@end
```
{% endraw %}


---

## 🔧 **Custom Native Modules**

### **JavaScript Bridge**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import { NativeModules, NativeEventEmitter } from 'react-native';

const { CustomModule } = NativeModules;

// Custom module wrapper
const CustomModuleWrapper = {
  // Get device information
  getDeviceInfo: async () => {
    try {
      const deviceInfo = await CustomModule.getDeviceInfo();
      return deviceInfo;
    } catch (error) {
      console.error('Error getting device info:', error);
      throw error;
    }
  },

  // Show toast message
  showToast: async (message) => {
    try {
      const result = await CustomModule.showToast(message);
      return result;
    } catch (error) {
      console.error('Error showing toast:', error);
      throw error;
    }
  },

  // Check permission
  checkPermission: async (permission) => {
    try {
      const granted = await CustomModule.checkPermission(permission);
      return granted;
    } catch (error) {
      console.error('Error checking permission:', error);
      throw error;
    }
  },

  // Perform async task
  performAsyncTask: async (params = {}) => {
    try {
      const result = await CustomModule.performAsyncTask(params);
      return result;
    } catch (error) {
      console.error('Error performing async task:', error);
      throw error;
    }
  }
};

// Event emitter for native events
const customModuleEmitter = new NativeEventEmitter(CustomModule);

// Subscribe to native events
const subscribeToEvents = (callback) => {
  const subscription = customModuleEmitter.addListener('CustomEvent', callback);
  return subscription;
};

// Unsubscribe from events
const unsubscribeFromEvents = (subscription) => {
  subscription.remove();
};

export { CustomModuleWrapper, subscribeToEvents, unsubscribeFromEvents };
```
{% endraw %}


### **React Native Component Using Custom Module**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert } from 'react-native';
import { CustomModuleWrapper, subscribeToEvents } from './CustomModuleWrapper';

const BareWorkflowDemo = () => {
  const [deviceInfo, setDeviceInfo] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    loadDeviceInfo();
    
    // Subscribe to native events
    const subscription = subscribeToEvents((event) => {
      console.log('Received native event:', event);
    });

    return () => {
      subscription.remove();
    };
  }, []);

  const loadDeviceInfo = async () => {
    try {
      setLoading(true);
      const info = await CustomModuleWrapper.getDeviceInfo();
      setDeviceInfo(info);
    } catch (error) {
      Alert.alert('Error', `Failed to load device info: ${error.message}`);
    } finally {
      setLoading(false);
    }
  };

  const handleShowToast = async () => {
    try {
      await CustomModuleWrapper.showToast('Hello from native module!');
    } catch (error) {
      Alert.alert('Error', `Failed to show toast: ${error.message}`);
    }
  };

  const handleCheckPermission = async () => {
    try {
      const granted = await CustomModuleWrapper.checkPermission('camera');
      Alert.alert('Permission Status', `Camera permission: ${granted ? 'Granted' : 'Denied'}`);
    } catch (error) {
      Alert.alert('Error', `Failed to check permission: ${error.message}`);
    }
  };

  const handleAsyncTask = async () => {
    try {
      setLoading(true);
      const result = await CustomModuleWrapper.performAsyncTask({ 
        taskId: 'test-task',
        timeout: 5000 
      });
      Alert.alert('Async Task Result', JSON.stringify(result, null, 2));
    } catch (error) {
      Alert.alert('Error', `Async task failed: ${error.message}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Bare Workflow Demo</Text>
      
      {loading && (
        <Text style={styles.loadingText}>Loading...</Text>
      )}

      {deviceInfo && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Device Information</Text>
          {Object.entries(deviceInfo).map(([key, value]) => (
            <Text key={key} style={styles.infoText}>
              {key}: {String(value)}
            </Text>
          ))}
        </View>
      )}

      <View style={styles.buttonContainer}>
        <TouchableOpacity 
          style={styles.button}
          onPress={handleShowToast}
        >
          <Text style={styles.buttonText}>Show Toast</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.button}
          onPress={handleCheckPermission}
        >
          <Text style={styles.buttonText}>Check Permission</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.button}
          onPress={handleAsyncTask}
          disabled={loading}
        >
          <Text style={styles.buttonText}>Perform Async Task</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.button}
          onPress={loadDeviceInfo}
        >
          <Text style={styles.buttonText}>Reload Device Info</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
  loadingText: {
    fontSize: 18,
    textAlign: 'center',
    color: '#666',
    marginBottom: 20,
  },
  section: {
    marginBottom: 20,
    padding: 15,
    backgroundColor: '#f8f9fa',
    borderRadius: 8,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  infoText: {
    fontSize: 14,
    color: '#666',
    marginBottom: 5,
  },
  buttonContainer: {
    marginTop: 20,
  },
  button: {
    backgroundColor: '#007bff',
    padding: 15,
    borderRadius: 8,
    marginBottom: 10,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default BareWorkflowDemo;
```
{% endraw %}


---

## 🎯 **Best Practices**

### **1. Bare Workflow Development**
- Use proper project structure
- Implement native modules correctly
- Handle errors gracefully
- Test on both platforms

### **2. Native Development**
- Follow platform conventions
- Use proper memory management
- Implement proper error handling
- Document native APIs

### **3. Performance**
- Optimize native code
- Use proper threading
- Minimize bridge calls
- Profile performance

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What is bare React Native workflow?**
2. **How do you create custom native modules?**
3. **What are the benefits of bare workflow?**

### **Advanced Questions**
1. **How would you implement a custom native module?**
2. **Explain the bridge between JavaScript and native code.**
3. **How do you handle platform-specific code?**

### **Practical Questions**
1. **Create a custom native module for both platforms.**
2. **Implement a native UI component.**
3. **Set up a bare React Native project.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Expo-Overview.md" class="nav-link prev">⬅️ Previous: Expo Overview</a>
    <a href="./03-Expo-vs-Bare-Comparison.md" class="nav-link next">Next: Expo vs Bare Comparison ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
