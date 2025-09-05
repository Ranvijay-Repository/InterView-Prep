# 🚀 **Reanimated 2/3**

> **Master React Native Reanimated for high-performance animations and gesture handling with worklets and shared values**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Shared Values](#shared-values)
- [Worklets](#worklets)
- [Animation Functions](#animation-functions)
- [Gesture Integration](#gesture-integration)
- [Layout Animations](#layout-animations)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

React Native Reanimated is a powerful animation library that runs animations on the UI thread, providing smooth 60fps animations. Reanimated 2/3 introduces worklets, shared values, and new animation APIs.

### **Reanimated Overview**

```
┌─────────────────────────────────────┐
│        Reanimated System            │
│  ┌─────────────────────────────────┐│
│  │        Core Concepts            ││
│  │  - Shared Values               ││
│  │  - Worklets                    ││
│  │  - UI Thread execution         ││
│  │  - Gesture integration         ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Animation Functions      ││
│  │  - withTiming                  ││
│  │  - withSpring                  ││
│  │  - withDecay                   ││
│  │  - withSequence                ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Advanced Features       ││
│  │  - Layout animations           ││
│  │  - Shared element transitions  ││
│  │  - Custom animations           ││
│  │  - Performance optimization    ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🚀 **Shared Values**

### **Basic Reanimated Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Dimensions } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withSpring,
  withSequence,
  withRepeat,
  withDelay,
  runOnJS,
} from 'react-native-reanimated';

const { width: screenWidth } = Dimensions.get('window');

const BasicReanimatedExample = () => {
  // Shared values
  const translateX = useSharedValue(0);
  const translateY = useSharedValue(0);
  const scale = useSharedValue(1);
  const rotation = useSharedValue(0);
  const opacity = useSharedValue(1);
  const backgroundColor = useSharedValue('#007AFF');
  
  // Animated styles
  const animatedStyle = useAnimatedStyle(() => {
    return {
      transform: [
        { translateX: translateX.value },
        { translateY: translateY.value },
        { scale: scale.value },
        { rotate: `${rotation.value}deg` },
      ],
      opacity: opacity.value,
      backgroundColor: backgroundColor.value,
    };
  });
  
  // Animation functions
  const slideLeft = () => {
    translateX.value = withTiming(-screenWidth / 2, { duration: 500 });
  };
  
  const slideRight = () => {
    translateX.value = withTiming(screenWidth / 2, { duration: 500 });
  };
  
  const slideUp = () => {
    translateY.value = withTiming(-200, { duration: 500 });
  };
  
  const slideDown = () => {
    translateY.value = withTiming(200, { duration: 500 });
  };
  
  const scaleUp = () => {
    scale.value = withSpring(1.5, { damping: 10, stiffness: 100 });
  };
  
  const scaleDown = () => {
    scale.value = withSpring(0.5, { damping: 10, stiffness: 100 });
  };
  
  const rotate = () => {
    rotation.value = withTiming(360, { duration: 1000 });
  };
  
  const fadeOut = () => {
    opacity.value = withTiming(0, { duration: 500 });
  };
  
  const fadeIn = () => {
    opacity.value = withTiming(1, { duration: 500 });
  };
  
  const changeColor = () => {
    const colors = ['#007AFF', '#34C759', '#FF9500', '#FF3B30', '#AF52DE'];
    const randomColor = colors[Math.floor(Math.random() * colors.length)];
    backgroundColor.value = withTiming(randomColor, { duration: 500 });
  };
  
  const bounce = () => {
    scale.value = withSequence(
      withTiming(1.5, { duration: 200 }),
      withTiming(0.8, { duration: 200 }),
      withTiming(1.2, { duration: 200 }),
      withTiming(1, { duration: 200 })
    );
  };
  
  const pulse = () => {
    scale.value = withRepeat(
      withSequence(
        withTiming(1.2, { duration: 300 }),
        withTiming(1, { duration: 300 })
      ),
      3,
      true
    );
  };
  
  const complexAnimation = () => {
    // Complex sequence of animations
    translateX.value = withSequence(
      withTiming(100, { duration: 300 }),
      withTiming(-100, { duration: 300 }),
      withTiming(0, { duration: 300 })
    );
    
    translateY.value = withSequence(
      withDelay(100, withTiming(100, { duration: 300 })),
      withTiming(-100, { duration: 300 }),
      withTiming(0, { duration: 300 })
    );
    
    rotation.value = withSequence(
      withDelay(200, withTiming(180, { duration: 500 })),
      withTiming(360, { duration: 500 }),
      withTiming(0, { duration: 0 })
    );
  };
  
  const reset = () => {
    translateX.value = withSpring(0);
    translateY.value = withSpring(0);
    scale.value = withSpring(1);
    rotation.value = withSpring(0);
    opacity.value = withSpring(1);
    backgroundColor.value = withSpring('#007AFF');
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Reanimated 2/3 Examples</Text>
      
      <Animated.View style={[styles.animatedBox, animatedStyle]}>
        <Text style={styles.boxText}>Reanimated Box</Text>
      </Animated.View>
      
      <View style={styles.controlsContainer}>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={slideLeft}>
            <Text style={styles.buttonText}>Slide Left</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={slideRight}>
            <Text style={styles.buttonText}>Slide Right</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={slideUp}>
            <Text style={styles.buttonText}>Slide Up</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={slideDown}>
            <Text style={styles.buttonText}>Slide Down</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={scaleUp}>
            <Text style={styles.buttonText}>Scale Up</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={scaleDown}>
            <Text style={styles.buttonText}>Scale Down</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={rotate}>
            <Text style={styles.buttonText}>Rotate</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={changeColor}>
            <Text style={styles.buttonText}>Change Color</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={bounce}>
            <Text style={styles.buttonText}>Bounce</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={pulse}>
            <Text style={styles.buttonText}>Pulse</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={complexAnimation}>
            <Text style={styles.buttonText}>Complex</Text>
          </TouchableOpacity>
          <TouchableOpacity style={[styles.button, styles.resetButton]} onPress={reset}>
            <Text style={styles.buttonText}>Reset</Text>
          </TouchableOpacity>
        </View>
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
    textAlign: 'center',
    marginBottom: 30,
  },
  animatedBox: {
    width: 200,
    height: 200,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
    marginBottom: 40,
  },
  boxText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
  },
  controlsContainer: {
    flex: 1,
    justifyContent: 'center',
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 15,
  },
  button: {
    backgroundColor: '#34C759',
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 8,
    minWidth: 100,
    alignItems: 'center',
  },
  resetButton: {
    backgroundColor: '#FF9500',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 12,
  },
});

export default BasicReanimatedExample;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="./02-Gesture-Handler.md" class="nav-link prev">⬅️ Previous: Gesture Handler</a>
    <a href="./04-Physics-Based-Animations.md" class="nav-link next">Next: Physics-Based Animations ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
