# 🔄 **App Lifecycle & Threads**

> **Understand React Native's app lifecycle, threading model, and how to handle background/foreground transitions**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [App Lifecycle](#app-lifecycle)
- [Threading Model](#threading-model)
- [AppState API](#appstate-api)
- [Background Tasks](#background-tasks)
- [Memory Management](#memory-management)
- [Performance Considerations](#performance-considerations)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

React Native has a unique threading model and app lifecycle that differs from traditional web applications. Understanding these concepts is crucial for building performant and reliable mobile applications.

### **React Native Threading Model**


```
┌─────────────────────────────────────┐
│        React Native Threads         │
│  ┌─────────────────────────────────┐│
│  │        JavaScript Thread        ││
│  │  - React components             ││
│  │  - Business logic               ││
│  │  - API calls                    ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        UI Thread                ││
│  │  - Native components            ││
│  │  - User interactions            ││
│  │  - Animations                   ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Shadow Thread            ││
│  │  - Layout calculations          ││
│  │  - Flexbox processing           ││
│  │  - Style computations           ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 📱 **App Lifecycle**

React Native applications go through different states during their lifecycle. Understanding these states helps you manage resources and user experience effectively.

### **App Lifecycle States**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, AppState } from 'react-native';

const AppLifecycleExample = () => {
  const [appState, setAppState] = useState(AppState.currentState);
  const [backgroundTime, setBackgroundTime] = useState(null);
  const [foregroundTime, setForegroundTime] = useState(new Date());
  
  useEffect(() => {
    const handleAppStateChange = (nextAppState) => {
      console.log('App state changed from', appState, 'to', nextAppState);
      
      if (appState.match(/inactive|background/) && nextAppState === 'active') {
        // App has come to the foreground
        setForegroundTime(new Date());
        console.log('App has come to the foreground!');
      } else if (nextAppState.match(/inactive|background/)) {
        // App has gone to the background
        setBackgroundTime(new Date());
        console.log('App has gone to the background!');
      }
      
      setAppState(nextAppState);
    };
    
    const subscription = AppState.addEventListener('change', handleAppStateChange);
    
    return () => subscription?.remove();
  }, [appState]);
  
  const getAppStateColor = (state) => {
    switch (state) {
      case 'active':
        return '#4CAF50';
      case 'background':
        return '#FF9800';
      case 'inactive':
        return '#2196F3';
      default:
        return '#9E9E9E';
    }
  };
  
  const getAppStateDescription = (state) => {
    switch (state) {
      case 'active':
        return 'App is running in the foreground and the user is interacting with it';
      case 'background':
        return 'App is running in the background and the user is not interacting with it';
      case 'inactive':
        return 'App is transitioning between foreground and background';
      default:
        return 'Unknown state';
    }
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>App Lifecycle</Text>
      
      <View style={styles.stateContainer}>
        <Text style={styles.label}>Current State:</Text>
        <View style={[styles.stateIndicator, { backgroundColor: getAppStateColor(appState) }]}>
          <Text style={styles.stateText}>{appState.toUpperCase()}</Text>
        </View>
      </View>
      
      <View style={styles.descriptionContainer}>
        <Text style={styles.description}>
          {getAppStateDescription(appState)}
        </Text>
      </View>
      
      <View style={styles.timeContainer}>
        <Text style={styles.label}>Last Foreground:</Text>
        <Text style={styles.timeText}>
          {foregroundTime.toLocaleTimeString()}
        </Text>
      </View>
      
      {backgroundTime && (
        <View style={styles.timeContainer}>
          <Text style={styles.label}>Last Background:</Text>
          <Text style={styles.timeText}>
            {backgroundTime.toLocaleTimeString()}
          </Text>
        </View>
      )}
      
      <View style={styles.instructionsContainer}>
        <Text style={styles.instructions}>
          Try switching to another app or locking your device to see the state changes.
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
  stateContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  stateIndicator: {
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 20,
  },
  stateText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  descriptionContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  description: {
    fontSize: 16,
    lineHeight: 24,
    color: '#666',
    textAlign: 'center',
  },
  timeContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  timeText: {
    fontSize: 16,
    color: '#666',
    fontWeight: '500',
  },
  instructionsContainer: {
    backgroundColor: '#E3F2FD',
    padding: 20,
    borderRadius: 10,
    marginTop: 20,
  },
  instructions: {
    fontSize: 16,
    color: '#1976D2',
    textAlign: 'center',
    lineHeight: 24,
  },
});

export default AppLifecycleExample;
```


---

## 🧵 **Threading Model**

React Native uses a multi-threaded architecture to ensure smooth performance and responsive user interfaces.

### **Thread Communication**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Alert } from 'react-native';

const ThreadingExample = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [result, setResult] = useState(null);
  const [threadInfo, setThreadInfo] = useState('');
  
  useEffect(() => {
    // Simulate getting thread information
    setThreadInfo(`
      JavaScript Thread: Main thread for React components
      UI Thread: Native thread for user interactions
      Shadow Thread: Layout calculations and style processing
    `);
  }, []);
  
  const performHeavyTask = () => {
    setIsLoading(true);
    setResult(null);
    
    // Simulate a heavy computation that would block the JS thread
    const startTime = Date.now();
    
    // This is a blocking operation - in real apps, use Web Workers or break into chunks
    let sum = 0;
    for (let i = 0; i < 10000000; i++) {
      sum += i;
    }
    
    const endTime = Date.now();
    const duration = endTime - startTime;
    
    setResult({
      sum,
      duration,
      message: 'Heavy computation completed'
    });
    setIsLoading(false);
  };
  
  const performAsyncTask = async () => {
    setIsLoading(true);
    setResult(null);
    
    try {
      // Simulate an async operation (API call, file I/O, etc.)
      const response = await new Promise((resolve) => {
        setTimeout(() => {
          resolve({
            data: 'Async operation completed',
            timestamp: new Date().toISOString()
          });
        }, 2000);
      });
      
      setResult(response);
    } catch (error) {
      Alert.alert('Error', 'Async operation failed');
    } finally {
      setIsLoading(false);
    }
  };
  
  const showThreadingInfo = () => {
    Alert.alert(
      'React Native Threading',
      'React Native uses three main threads:\n\n' +
      '1. JavaScript Thread: Runs your React code\n' +
      '2. UI Thread: Handles native components and user input\n' +
      '3. Shadow Thread: Processes layout calculations\n\n' +
      'Communication between threads happens through the Bridge (or JSI in new architecture).',
      [{ text: 'OK' }]
    );
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Threading Model</Text>
      
      <View style={styles.infoContainer}>
        <Text style={styles.infoText}>{threadInfo}</Text>
      </View>
      
      <TouchableOpacity 
        style={[styles.button, styles.primaryButton]}
        onPress={performHeavyTask}
        disabled={isLoading}
      >
        <Text style={styles.buttonText}>
          {isLoading ? 'Processing...' : 'Perform Heavy Task'}
        </Text>
      </TouchableOpacity>
      
      <TouchableOpacity 
        style={[styles.button, styles.secondaryButton]}
        onPress={performAsyncTask}
        disabled={isLoading}
      >
        <Text style={styles.buttonText}>
          {isLoading ? 'Loading...' : 'Perform Async Task'}
        </Text>
      </TouchableOpacity>
      
      <TouchableOpacity 
        style={[styles.button, styles.infoButton]}
        onPress={showThreadingInfo}
      >
        <Text style={styles.buttonText}>Show Threading Info</Text>
      </TouchableOpacity>
      
      {result && (
        <View style={styles.resultContainer}>
          <Text style={styles.resultTitle}>Result:</Text>
          <Text style={styles.resultText}>
            {JSON.stringify(result, null, 2)}
          </Text>
        </View>
      )}
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
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  infoText: {
    fontSize: 14,
    lineHeight: 20,
    color: '#666',
    fontFamily: 'monospace',
  },
  button: {
    padding: 15,
    borderRadius: 8,
    marginBottom: 15,
    alignItems: 'center',
  },
  primaryButton: {
    backgroundColor: '#FF6B6B',
  },
  secondaryButton: {
    backgroundColor: '#4ECDC4',
  },
  infoButton: {
    backgroundColor: '#45B7D1',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  resultContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginTop: 20,
  },
  resultTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  resultText: {
    fontSize: 14,
    color: '#666',
    fontFamily: 'monospace',
  },
});

export default ThreadingExample;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Platform-APIs.md" class="nav-link prev">⬅️ Previous: Platform APIs</a>
    <a href="./05-Touch-Handling-Gestures.md" class="nav-link next">Next: Touch Handling & Gestures ➡️</a>
</div>

---


*Last updated: December 2024*
