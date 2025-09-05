# 📱 **Platform APIs**

> **Master the platform-specific APIs and utilities that React Native provides for accessing device capabilities and platform features**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Platform Module](#platform-module)
- [Dimensions API](#dimensions-api)
- [SafeAreaView](#safeareaview)
- [StatusBar](#statusbar)
- [KeyboardAvoidingView](#keyboardavoidingview)
- [Linking API](#linking-api)
- [Alert API](#alert-api)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

React Native provides several platform APIs that allow you to access device-specific features and handle platform differences. These APIs are essential for creating native-feeling applications.

### **Platform APIs Overview**

```
┌─────────────────────────────────────┐
│        Platform APIs                │
│  ┌─────────────────────────────────┐│
│  │        Device APIs              ││
│  │  - Platform                     ││
│  │  - Dimensions                   ││
│  │  - SafeAreaView                 ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        UI APIs                  ││
│  │  - StatusBar                    ││
│  │  - KeyboardAvoidingView         ││
│  │  - Alert                        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        System APIs              ││
│  │  - Linking                      ││
│  │  - AppState                     ││
│  │  - NetInfo                      ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🖥️ **Platform Module**

The `Platform` module provides information about the current platform and allows you to write platform-specific code.

### **Basic Platform Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, StyleSheet, Platform } from 'react-native';

const PlatformExample = () => {
  const platformInfo = {
    OS: Platform.OS,
    Version: Platform.Version,
    isIOS: Platform.OS === 'ios',
    isAndroid: Platform.OS === 'android',
    isWeb: Platform.OS === 'web',
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Platform Information</Text>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Operating System:</Text>
        <Text style={styles.value}>{platformInfo.OS}</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Version:</Text>
        <Text style={styles.value}>{platformInfo.Version}</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Is iOS:</Text>
        <Text style={styles.value}>{platformInfo.isIOS ? 'Yes' : 'No'}</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Is Android:</Text>
        <Text style={styles.value}>{platformInfo.isAndroid ? 'Yes' : 'No'}</Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  infoContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  value: {
    fontSize: 16,
    color: '#666',
  },
});

export default PlatformExample;
```

### **Platform-Specific Styling**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Platform } from 'react-native';

const PlatformSpecificStyling = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Platform-Specific Styling</Text>
      
      <TouchableOpacity style={styles.button}>
        <Text style={styles.buttonText}>Platform Button</Text>
      </TouchableOpacity>
      
      <View style={styles.card}>
        <Text style={styles.cardText}>
          This card has different shadows and borders based on the platform.
        </Text>
      </View>
      
      <View style={styles.platformInfo}>
        <Text style={styles.platformText}>
          Current Platform: {Platform.OS}
        </Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  button: {
    backgroundColor: '#007AFF',
    padding: Platform.OS === 'ios' ? 15 : 12,
    borderRadius: Platform.OS === 'ios' ? 8 : 4,
    marginBottom: 20,
    alignItems: 'center',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.25,
        shadowRadius: 3.84,
      },
      android: {
        elevation: 5,
      },
    }),
  },
  buttonText: {
    color: 'white',
    fontSize: Platform.OS === 'ios' ? 16 : 14,
    fontWeight: 'bold',
  },
  card: {
    backgroundColor: 'white',
    padding: 20,
    marginBottom: 20,
    borderRadius: 10,
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
      },
      android: {
        elevation: 3,
        borderWidth: 1,
        borderColor: '#e0e0e0',
      },
    }),
  },
  cardText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  platformInfo: {
    backgroundColor: Platform.OS === 'ios' ? '#E3F2FD' : '#FFF3E0',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
  },
  platformText: {
    fontSize: 16,
    fontWeight: '600',
    color: Platform.OS === 'ios' ? '#1976D2' : '#F57C00',
  },
});

export default PlatformSpecificStyling;
```

---

## 📏 **Dimensions API**

The `Dimensions` API provides information about the device's screen dimensions and allows you to create responsive layouts.

### **Basic Dimensions Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Dimensions } from 'react-native';

const DimensionsExample = () => {
  const [dimensions, setDimensions] = useState(Dimensions.get('window'));
  
  useEffect(() => {
    const subscription = Dimensions.addEventListener('change', ({ window }) => {
      setDimensions(window);
    });
    
    return () => subscription?.remove();
  }, []);
  
  const isLandscape = dimensions.width > dimensions.height;
  const isTablet = dimensions.width >= 768;
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Device Dimensions</Text>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Width:</Text>
        <Text style={styles.value}>{dimensions.width}px</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Height:</Text>
        <Text style={styles.value}>{dimensions.height}px</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Scale:</Text>
        <Text style={styles.value}>{dimensions.scale}</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Font Scale:</Text>
        <Text style={styles.value}>{dimensions.fontScale}</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Orientation:</Text>
        <Text style={styles.value}>{isLandscape ? 'Landscape' : 'Portrait'}</Text>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.label}>Device Type:</Text>
        <Text style={styles.value}>{isTablet ? 'Tablet' : 'Phone'}</Text>
      </View>
      
      <View style={[styles.responsiveBox, { width: dimensions.width * 0.8 }]}>
        <Text style={styles.boxText}>
          Responsive Box (80% of screen width)
        </Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  infoContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  value: {
    fontSize: 16,
    color: '#666',
  },
  responsiveBox: {
    height: 100,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 10,
    marginTop: 30,
    alignSelf: 'center',
  },
  boxText: {
    color: 'white',
    fontWeight: 'bold',
    textAlign: 'center',
  },
});

export default DimensionsExample;
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Styling-Flexbox.md" class="nav-link prev">⬅️ Previous: Styling & Flexbox</a>
    <a href="./04-App-Lifecycle-Threads.md" class="nav-link next">Next: App Lifecycle & Threads ➡️</a>
</div>

---


*Last updated: December 2024*
