# 👆 **Gesture Handler**

> **Master react-native-gesture-handler for advanced touch interactions and gesture recognition in React Native**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Basic Gestures](#basic-gestures)
- [Advanced Gestures](#advanced-gestures)
- [Gesture Composition](#gesture-composition)
- [Performance Optimization](#performance-optimization)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

react-native-gesture-handler provides a comprehensive set of gesture recognition tools for React Native. It offers better performance and more control over touch interactions compared to the built-in touch components.

### **Gesture Handler Overview**

```
┌─────────────────────────────────────┐
│        Gesture Handler System       │
│  ┌─────────────────────────────────┐│
│  │        Basic Gestures           ││
│  │  - Tap gestures                 ││
│  │  - Long press gestures          ││
│  │  - Pan gestures                 ││
│  │  - Pinch gestures               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Advanced Gestures        ││
│  │  - Rotation gestures            ││
│  │  - Fling gestures               ││
│  │  - Force touch                  ││
│  │  - Hover gestures               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Gesture Composition      ││
│  │  - Simultaneous gestures        ││
│  │  - Exclusive gestures           ││
│  │  - Gesture sequences            ││
│  │  - Gesture states               ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 👆 **Basic Gestures**

### **Basic Gesture Handler Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState } from 'react';
import { View, Text, StyleSheet, Dimensions } from 'react-native';
import {
  GestureHandlerRootView,
  TapGestureHandler,
  LongPressGestureHandler,
  PanGestureHandler,
  PinchGestureHandler,
  RotationGestureHandler,
  State,
} from 'react-native-gesture-handler';
import Animated, {
  useAnimatedGestureHandler,
  useAnimatedStyle,
  useSharedValue,
  withSpring,
  withTiming,
  runOnJS,
} from 'react-native-reanimated';

const { width: screenWidth, height: screenHeight } = Dimensions.get('window');

const BasicGestureExample = () => {
  const [gestureLog, setGestureLog] = useState([]);
  
  // Shared values for animations
  const scale = useSharedValue(1);
  const translateX = useSharedValue(0);
  const translateY = useSharedValue(0);
  const rotation = useSharedValue(0);
  const opacity = useSharedValue(1);
  
  const addToLog = (gesture) => {
    setGestureLog(prev => [
      ...prev,
      {
        id: Date.now(),
        gesture,
        timestamp: new Date().toLocaleTimeString(),
      },
    ]);
  };
  
  // Tap gesture handler
  const tapGestureHandler = useAnimatedGestureHandler({
    onStart: () => {
      scale.value = withSpring(1.2);
      opacity.value = withTiming(0.7, { duration: 100 });
    },
    onEnd: () => {
      scale.value = withSpring(1);
      opacity.value = withTiming(1, { duration: 100 });
      runOnJS(addToLog)('Tap');
    },
  });
  
  // Long press gesture handler
  const longPressGestureHandler = useAnimatedGestureHandler({
    onStart: () => {
      scale.value = withSpring(1.5);
      opacity.value = withTiming(0.5, { duration: 200 });
    },
    onEnd: () => {
      scale.value = withSpring(1);
      opacity.value = withTiming(1, { duration: 200 });
      runOnJS(addToLog)('Long Press');
    },
  });
  
  // Pan gesture handler
  const panGestureHandler = useAnimatedGestureHandler({
    onStart: () => {
      runOnJS(addToLog)('Pan Start');
    },
    onActive: (event) => {
      translateX.value = event.translationX;
      translateY.value = event.translationY;
    },
    onEnd: () => {
      translateX.value = withSpring(0);
      translateY.value = withSpring(0);
      runOnJS(addToLog)('Pan End');
    },
  });
  
  // Pinch gesture handler
  const pinchGestureHandler = useAnimatedGestureHandler({
    onStart: () => {
      runOnJS(addToLog)('Pinch Start');
    },
    onActive: (event) => {
      scale.value = event.scale;
    },
    onEnd: () => {
      scale.value = withSpring(1);
      runOnJS(addToLog)('Pinch End');
    },
  });
  
  // Rotation gesture handler
  const rotationGestureHandler = useAnimatedGestureHandler({
    onStart: () => {
      runOnJS(addToLog)('Rotation Start');
    },
    onActive: (event) => {
      rotation.value = event.rotation;
    },
    onEnd: () => {
      rotation.value = withSpring(0);
      runOnJS(addToLog)('Rotation End');
    },
  });
  
  // Animated styles
  const animatedStyle = useAnimatedStyle(() => {
    return {
      transform: [
        { scale: scale.value },
        { translateX: translateX.value },
        { translateY: translateY.value },
        { rotate: `${rotation.value}rad` },
      ],
      opacity: opacity.value,
    };
  });
  
  const clearLog = () => {
    setGestureLog([]);
  };
  
  return (
    <GestureHandlerRootView style={styles.container}>
      <Text style={styles.title}>Gesture Handler Examples</Text>
      
      <View style={styles.gestureArea}>
        <PanGestureHandler onGestureEvent={panGestureHandler}>
          <Animated.View style={styles.gestureContainer}>
            <PinchGestureHandler onGestureEvent={pinchGestureHandler}>
              <Animated.View style={styles.gestureContainer}>
                <RotationGestureHandler onGestureEvent={rotationGestureHandler}>
                  <Animated.View style={styles.gestureContainer}>
                    <TapGestureHandler onGestureEvent={tapGestureHandler}>
                      <Animated.View style={styles.gestureContainer}>
                        <LongPressGestureHandler
                          onGestureEvent={longPressGestureHandler}
                          minDurationMs={500}
                        >
                          <Animated.View style={[styles.gestureBox, animatedStyle]}>
                            <Text style={styles.boxText}>Gesture Box</Text>
                            <Text style={styles.instructionText}>
                              Tap, Long Press, Pan, Pinch, or Rotate
                            </Text>
                          </Animated.View>
                        </LongPressGestureHandler>
                      </Animated.View>
                    </TapGestureHandler>
                  </Animated.View>
                </RotationGestureHandler>
              </Animated.View>
            </PinchGestureHandler>
          </Animated.View>
        </PanGestureHandler>
      </View>
      
      <View style={styles.logContainer}>
        <View style={styles.logHeader}>
          <Text style={styles.logTitle}>Gesture Log</Text>
          <TouchableOpacity style={styles.clearButton} onPress={clearLog}>
            <Text style={styles.clearButtonText}>Clear</Text>
          </TouchableOpacity>
        </View>
        
        {gestureLog.map((log) => (
          <View key={log.id} style={styles.logItem}>
            <Text style={styles.logGesture}>{log.gesture}</Text>
            <Text style={styles.logTimestamp}>{log.timestamp}</Text>
          </View>
        ))}
      </View>
    </GestureHandlerRootView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    padding: 20,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  gestureArea: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  gestureContainer: {
    width: 200,
    height: 200,
  },
  gestureBox: {
    width: 200,
    height: 200,
    backgroundColor: '#007AFF',
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
  },
  boxText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  instructionText: {
    color: 'white',
    fontSize: 12,
    textAlign: 'center',
    opacity: 0.8,
  },
  logContainer: {
    backgroundColor: 'white',
    margin: 20,
    borderRadius: 10,
    padding: 15,
    maxHeight: 200,
  },
  logHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 15,
  },
  logTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  clearButton: {
    backgroundColor: '#FF3B30',
    paddingHorizontal: 15,
    paddingVertical: 8,
    borderRadius: 6,
  },
  clearButtonText: {
    color: 'white',
    fontSize: 12,
    fontWeight: 'bold',
  },
  logItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  logGesture: {
    fontSize: 14,
    color: '#333',
    fontWeight: '600',
  },
  logTimestamp: {
    fontSize: 12,
    color: '#666',
  },
});

export default BasicGestureExample;
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Animated-API-LayoutAnimation.md" class="nav-link prev">⬅️ Previous: Animated API & LayoutAnimation</a>
    <a href="./03-Reanimated-2-3.md" class="nav-link next">Next: Reanimated 2/3 ➡️</a>
</div>

---


*Last updated: December 2024*
