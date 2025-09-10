# 🌊 **Physics-Based Animations**

> **Master physics-based animations using react-native-reanimated and react-native-redash for realistic motion and interactions**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Physics Concepts](#physics-concepts)
- [Spring Animations](#spring-animations)
- [Decay Animations](#decay-animations)
- [Gravity Simulations](#gravity-simulations)
- [Collision Detection](#collision-detection)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Physics-based animations create realistic motion by simulating physical forces like gravity, friction, and momentum. These animations feel natural and provide better user experience.

### **Physics-Based Animations Overview**


{% raw %}
```
┌─────────────────────────────────────┐
│        Physics-Based System         │
│  ┌─────────────────────────────────┐│
│  │        Physical Forces          ││
│  │  - Gravity                      ││
│  │  - Friction                     ││
│  │  - Momentum                     ││
│  │  - Elasticity                   ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Animation Types          ││
│  │  - Spring animations            ││
│  │  - Decay animations             ││
│  │  - Bounce effects               ││
│  │  - Pendulum motion              ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Advanced Features        ││
│  │  - Collision detection          ││
│  │  - Particle systems             ││
│  │  - Fluid dynamics               ││
│  │  - Real-time physics            ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```
{% endraw %}


---

## 🌊 **Physics Concepts**

### **Physics-Based Animation Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useRef } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Dimensions } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
  withDecay,
  withTiming,
  withSequence,
  withRepeat,
  runOnJS,
} from 'react-native-reanimated';
import {
  GestureHandlerRootView,
  PanGestureHandler,
  useAnimatedGestureHandler,
} from 'react-native-gesture-handler';

const { width: screenWidth, height: screenHeight } = Dimensions.get('window');

const PhysicsBasedExample = () => {
  // Shared values for physics
  const translateX = useSharedValue(0);
  const translateY = useSharedValue(0);
  const scale = useSharedValue(1);
  const rotation = useSharedValue(0);
  const velocity = useSharedValue({ x: 0, y: 0 });
  
  // Spring physics parameters
  const springConfig = {
    damping: 15,
    stiffness: 150,
    mass: 1,
  };
  
  // Decay physics parameters
  const decayConfig = {
    deceleration: 0.998,
  };
  
  // Pan gesture handler with physics
  const panGestureHandler = useAnimatedGestureHandler({
    onStart: (_, context) => {
      context.startX = translateX.value;
      context.startY = translateY.value;
    },
    onActive: (event, context) => {
      translateX.value = context.startX + event.translationX;
      translateY.value = context.startY + event.translationY;
      velocity.value = { x: event.velocityX, y: event.velocityY };
    },
    onEnd: () => {
      // Apply decay animation based on velocity
      translateX.value = withDecay({
        velocity: velocity.value.x,
        deceleration: decayConfig.deceleration,
      });
      translateY.value = withDecay({
        velocity: velocity.value.y,
        deceleration: decayConfig.deceleration,
      });
    },
  });
  
  // Animated styles
  const animatedStyle = useAnimatedStyle(() => {
    return {
      transform: [
        { translateX: translateX.value },
        { translateY: translateY.value },
        { scale: scale.value },
        { rotate: `${rotation.value}deg` },
      ],
    };
  });
  
  // Physics-based animations
  const gravityDrop = () => {
    translateY.value = withSpring(screenHeight - 200, {
      damping: 20,
      stiffness: 100,
      mass: 1,
    });
  };
  
  const bounce = () => {
    translateY.value = withSequence(
      withSpring(screenHeight - 200, {
        damping: 10,
        stiffness: 200,
        mass: 1,
      }),
      withSpring(0, {
        damping: 15,
        stiffness: 150,
        mass: 1,
      })
    );
  };
  
  const elasticScale = () => {
    scale.value = withSequence(
      withSpring(1.5, {
        damping: 8,
        stiffness: 200,
        mass: 1,
      }),
      withSpring(1, {
        damping: 12,
        stiffness: 150,
        mass: 1,
      })
    );
  };
  
  const pendulum = () => {
    rotation.value = withRepeat(
      withSequence(
        withSpring(30, {
          damping: 15,
          stiffness: 100,
          mass: 1,
        }),
        withSpring(-30, {
          damping: 15,
          stiffness: 100,
          mass: 1,
        })
      ),
      -1,
      true
    );
  };
  
  const magneticPull = () => {
    // Simulate magnetic pull to center
    const centerX = screenWidth / 2 - 100;
    const centerY = screenHeight / 2 - 100;
    
    translateX.value = withSpring(centerX, {
      damping: 20,
      stiffness: 100,
      mass: 1,
    });
    translateY.value = withSpring(centerY, {
      damping: 20,
      stiffness: 100,
      mass: 1,
    });
  };
  
  const orbit = () => {
    // Simulate orbital motion
    const radius = 100;
    const centerX = screenWidth / 2 - 100;
    const centerY = screenHeight / 2 - 100;
    
    rotation.value = withRepeat(
      withTiming(360, { duration: 2000 }),
      -1,
      false
    );
    
    // This would need a more complex implementation for true orbital motion
    translateX.value = withSpring(centerX + radius, springConfig);
    translateY.value = withSpring(centerY, springConfig);
  };
  
  const fluidMotion = () => {
    // Simulate fluid-like motion
    translateX.value = withRepeat(
      withSequence(
        withTiming(100, { duration: 1000 }),
        withTiming(-100, { duration: 1000 }),
        withTiming(0, { duration: 1000 })
      ),
      -1,
      true
    );
    
    translateY.value = withRepeat(
      withSequence(
        withTiming(50, { duration: 800 }),
        withTiming(-50, { duration: 800 }),
        withTiming(0, { duration: 800 })
      ),
      -1,
      true
    );
  };
  
  const reset = () => {
    translateX.value = withSpring(0, springConfig);
    translateY.value = withSpring(0, springConfig);
    scale.value = withSpring(1, springConfig);
    rotation.value = withSpring(0, springConfig);
  };
  
  return (
    <GestureHandlerRootView style={styles.container}>
      <Text style={styles.title}>Physics-Based Animations</Text>
      
      <PanGestureHandler onGestureEvent={panGestureHandler}>
        <Animated.View style={[styles.physicsBox, animatedStyle]}>
          <Text style={styles.boxText}>Physics Box</Text>
          <Text style={styles.instructionText}>Drag me around!</Text>
        </Animated.View>
      </PanGestureHandler>
      
      <View style={styles.controlsContainer}>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={gravityDrop}>
            <Text style={styles.buttonText}>Gravity Drop</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={bounce}>
            <Text style={styles.buttonText}>Bounce</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={elasticScale}>
            <Text style={styles.buttonText}>Elastic Scale</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={pendulum}>
            <Text style={styles.buttonText}>Pendulum</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={magneticPull}>
            <Text style={styles.buttonText}>Magnetic Pull</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={orbit}>
            <Text style={styles.buttonText}>Orbit</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={fluidMotion}>
            <Text style={styles.buttonText}>Fluid Motion</Text>
          </TouchableOpacity>
          <TouchableOpacity style={[styles.button, styles.resetButton]} onPress={reset}>
            <Text style={styles.buttonText}>Reset</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      <View style={styles.infoContainer}>
        <Text style={styles.infoTitle}>Physics Parameters</Text>
        <Text style={styles.infoText}>Spring: Damping={springConfig.damping}, Stiffness={springConfig.stiffness}</Text>
        <Text style={styles.infoText}>Decay: Deceleration={decayConfig.deceleration}</Text>
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
  physicsBox: {
    width: 200,
    height: 200,
    backgroundColor: '#007AFF',
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    position: 'absolute',
    top: 100,
    left: screenWidth / 2 - 100,
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
    marginBottom: 5,
  },
  instructionText: {
    color: 'white',
    fontSize: 12,
    textAlign: 'center',
    opacity: 0.8,
  },
  controlsContainer: {
    position: 'absolute',
    bottom: 100,
    left: 0,
    right: 0,
    padding: 20,
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
    minWidth: 120,
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
  infoContainer: {
    position: 'absolute',
    bottom: 20,
    left: 20,
    right: 20,
    backgroundColor: 'rgba(0,0,0,0.8)',
    padding: 15,
    borderRadius: 10,
  },
  infoTitle: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  infoText: {
    color: 'white',
    fontSize: 12,
    marginBottom: 5,
  },
});

export default PhysicsBasedExample;
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Reanimated-2-3.md" class="nav-link prev">⬅️ Previous: Reanimated 2/3</a>
    <a href="../07-Native-Interoperability/01-Old-vs-New-Architecture.md" class="nav-link next">Next: Old vs New Architecture ➡️</a>
</div>

---


*Last updated: December 2024*
