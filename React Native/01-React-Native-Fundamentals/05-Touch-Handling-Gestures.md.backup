# 👆 **Touch Handling & Gestures**

> **Master touch handling, gesture recognition, and user interaction patterns in React Native**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Basic Touch Handling](#basic-touch-handling)
- [TouchableOpacity](#touchableopacity)
- [TouchableHighlight](#touchablehighlight)
- [TouchableWithoutFeedback](#touchablewithoutfeedback)
- [Pressable Component](#pressable-component)
- [Gesture Responder System](#gesture-responder-system)
- [Pan Gestures](#pan-gestures)
- [Pinch and Zoom](#pinch-and-zoom)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Touch handling is fundamental to mobile applications. React Native provides several components and APIs for handling user interactions, from simple taps to complex gestures.

### **Touch Handling Overview**


{% raw %}
```
┌─────────────────────────────────────┐
│        Touch Handling System        │
│  ┌─────────────────────────────────┐│
│  │        Basic Components         ││
│  │  - TouchableOpacity             ││
│  │  - TouchableHighlight           ││
│  │  - TouchableWithoutFeedback     ││
│  │  - Pressable                    ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Gesture System           ││
│  │  - Pan gestures                 ││
│  │  - Pinch gestures               ││
│  │  - Rotation gestures            ││
│  │  - Long press                   ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Advanced Features        ││
│  │  - Multi-touch                  ││
│  │  - Gesture responder            ││
│  │  - Custom gestures              ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```
{% endraw %}


---

## 👆 **Basic Touch Handling**

Understanding the fundamentals of touch handling is essential for creating responsive user interfaces.

### **TouchableOpacity Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert } from 'react-native';

const TouchableOpacityExample = () => {
  const [pressCount, setPressCount] = useState(0);
  const [lastPressTime, setLastPressTime] = useState(null);
  
  const handlePress = () => {
    const currentTime = Date.now();
    setPressCount(prev => prev + 1);
    setLastPressTime(currentTime);
    
    Alert.alert(
      'Button Pressed',
      `Press count: ${pressCount + 1}\nTime: ${new Date(currentTime).toLocaleTimeString()}`,
      [{ text: 'OK' }]
    );
  };
  
  const handleLongPress = () => {
    Alert.alert('Long Press', 'You held the button for a long time!');
  };
  
  const resetCount = () => {
    setPressCount(0);
    setLastPressTime(null);
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>TouchableOpacity Examples</Text>
      
      <View style={styles.statsContainer}>
        <Text style={styles.statsText}>Press Count: {pressCount}</Text>
        {lastPressTime && (
          <Text style={styles.statsText}>
            Last Press: {new Date(lastPressTime).toLocaleTimeString()}
          </Text>
        )}
      </View>
      
      <TouchableOpacity
        style={styles.primaryButton}
        onPress={handlePress}
        onLongPress={handleLongPress}
        delayLongPress={1000}
        activeOpacity={0.7}
      >
        <Text style={styles.buttonText}>Press Me</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.secondaryButton}
        onPress={resetCount}
        activeOpacity={0.8}
      >
        <Text style={styles.buttonText}>Reset Count</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.disabledButton}
        disabled={true}
        activeOpacity={0.3}
      >
        <Text style={styles.disabledButtonText}>Disabled Button</Text>
      </TouchableOpacity>
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
  statsContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 30,
  },
  statsText: {
    fontSize: 16,
    color: '#333',
    marginBottom: 5,
  },
  primaryButton: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    marginBottom: 15,
    alignItems: 'center',
  },
  secondaryButton: {
    backgroundColor: '#34C759',
    padding: 15,
    borderRadius: 8,
    marginBottom: 15,
    alignItems: 'center',
  },
  disabledButton: {
    backgroundColor: '#CCCCCC',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  disabledButtonText: {
    color: '#666',
    fontWeight: 'bold',
    fontSize: 16,
  },
});

export default TouchableOpacityExample;
```
{% endraw %}


---

## 🎯 **TouchableHighlight**

TouchableHighlight provides visual feedback by changing the background color when pressed.

### **TouchableHighlight Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState } from 'react';
import { View, Text, TouchableHighlight, StyleSheet } from 'react-native';

const TouchableHighlightExample = () => {
  const [selectedItem, setSelectedItem] = useState(null);
  
  const items = [
    { id: 1, title: 'First Item', description: 'This is the first item' },
    { id: 2, title: 'Second Item', description: 'This is the second item' },
    { id: 3, title: 'Third Item', description: 'This is the third item' },
  ];
  
  const handleItemPress = (item) => {
    setSelectedItem(item.id);
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>TouchableHighlight Examples</Text>
      
      <View style={styles.listContainer}>
        {items.map((item) => (
          <TouchableHighlight
            key={item.id}
            style={[
              styles.listItem,
              selectedItem === item.id && styles.selectedItem
            ]}
            onPress={() => handleItemPress(item)}
            underlayColor="#E3F2FD"
            activeOpacity={0.6}
          >
            <View style={styles.itemContent}>
              <Text style={styles.itemTitle}>{item.title}</Text>
              <Text style={styles.itemDescription}>{item.description}</Text>
            </View>
          </TouchableHighlight>
        ))}
      </View>
      
      {selectedItem && (
        <View style={styles.selectedContainer}>
          <Text style={styles.selectedText}>
            Selected: {items.find(item => item.id === selectedItem)?.title}
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
  listContainer: {
    backgroundColor: 'white',
    borderRadius: 10,
    overflow: 'hidden',
    marginBottom: 20,
  },
  listItem: {
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  selectedItem: {
    backgroundColor: '#E3F2FD',
  },
  itemContent: {
    flex: 1,
  },
  itemTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  itemDescription: {
    fontSize: 14,
    color: '#666',
  },
  selectedContainer: {
    backgroundColor: '#4CAF50',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
  },
  selectedText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
});

export default TouchableHighlightExample;
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
    <a href="./04-App-Lifecycle-Threads.md" class="nav-link prev">⬅️ Previous: App Lifecycle & Threads</a>
    <a href="./06-DevMenu-Metro-Debugging.md" class="nav-link next">Next: DevMenu Metro Debugging ➡️</a>
</div>

---


*Last updated: December 2024*
