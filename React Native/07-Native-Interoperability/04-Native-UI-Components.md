# 🎨 **Native UI Components**

> **Master creating custom native UI components with Fabric for React Native's new architecture**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Fabric Component Architecture](#fabric-component-architecture)
- [Component Implementation](#component-implementation)
- [Props and State Management](#props-and-state-management)
- [Event Handling](#event-handling)
- [Performance Optimization](#performance-optimization)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Creating custom native UI components with Fabric allows you to build high-performance, platform-specific components that integrate seamlessly with React Native's new architecture.

### **Native UI Components Overview**


```
┌─────────────────────────────────────┐
│        Native UI Components         │
│  ┌─────────────────────────────────┐│
│  │        Fabric Architecture      ││
│  │  - Component specification      ││
│  │  - Native implementation        ││
│  │  - JavaScript interface         ││
│  │  - Event handling               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Component Types          ││
│  │  - View components              ││
│  │  - Text components              ││
│  │  - Image components             ││
│  │  - Custom components            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Benefits                 ││
│  │  - Better performance           ││
│  │  - Platform-specific features   ││
│  │  - Type safety                  ││
│  │  - Future-proof                 ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 🎨 **Fabric Component Architecture**

### **Component Specification Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Custom Native Component Specification
// This file defines the interface for the native component

export interface CustomViewProps extends ViewProps {
  // Basic props
  title: string;
  subtitle?: string;
  
  // Styling props
  backgroundColor?: string;
  textColor?: string;
  borderRadius?: number;
  
  // Behavior props
  enabled?: boolean;
  interactive?: boolean;
  
  // Data props
  data?: CustomData[];
  selectedIndex?: number;
  
  // Event handlers
  onPress?: (event: PressEvent) => void;
  onLongPress?: (event: PressEvent) => void;
  onSelectionChange?: (index: number) => void;
  onDataUpdate?: (data: CustomData[]) => void;
}

export interface CustomData {
  id: string;
  title: string;
  value: number;
  color: string;
}

export interface PressEvent {
  nativeEvent: {
    timestamp: number;
    locationX: number;
    locationY: number;
  };
}

// Component specification
export interface Spec extends ComponentSpec<CustomViewProps> {
  // Component methods
  setTitle(title: string): void;
  setData(data: CustomData[]): void;
  setSelectedIndex(index: number): void;
  animateToPosition(x: number, y: number): void;
  
  // Component constants
  readonly Constants: {
    DEFAULT_BACKGROUND_COLOR: string;
    DEFAULT_TEXT_COLOR: string;
    ANIMATION_DURATION: number;
  };
}

// Component implementation
export default codegenNativeComponent<CustomViewProps>('CustomView');
```


### **Component Usage Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Custom Native Component Usage
import React, { useRef, useState, useCallback } from 'react';
import { View, Text, StyleSheet, Alert } from 'react-native';
import CustomView from './CustomView';

const CustomViewExample = () => {
  const customViewRef = useRef(null);
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [data, setData] = useState([
    { id: '1', title: 'Item 1', value: 10, color: '#FF6B6B' },
    { id: '2', title: 'Item 2', value: 20, color: '#4ECDC4' },
    { id: '3', title: 'Item 3', value: 30, color: '#45B7D1' },
    { id: '4', title: 'Item 4', value: 40, color: '#96CEB4' },
  ]);
  
  // Event handlers
  const handlePress = useCallback((event) => {
    console.log('Custom view pressed:', event.nativeEvent);
    Alert.alert('Press Event', 'Custom view was pressed!');
  }, []);
  
  const handleLongPress = useCallback((event) => {
    console.log('Custom view long pressed:', event.nativeEvent);
    Alert.alert('Long Press Event', 'Custom view was long pressed!');
  }, []);
  
  const handleSelectionChange = useCallback((index) => {
    console.log('Selection changed to index:', index);
    setSelectedIndex(index);
  }, []);
  
  const handleDataUpdate = useCallback((newData) => {
    console.log('Data updated:', newData);
    setData(newData);
  }, []);
  
  // Component methods
  const updateTitle = useCallback(() => {
    if (customViewRef.current) {
      customViewRef.current.setTitle(`Updated at ${new Date().toLocaleTimeString()}`);
    }
  }, []);
  
  const addNewItem = useCallback(() => {
    const newItem = {
      id: Date.now().toString(),
      title: `Item ${data.length + 1}`,
      value: Math.floor(Math.random() * 100),
      color: ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4'][Math.floor(Math.random() * 4)]
    };
    
    const newData = [...data, newItem];
    setData(newData);
    
    if (customViewRef.current) {
      customViewRef.current.setData(newData);
    }
  }, [data]);
  
  const selectNextItem = useCallback(() => {
    const nextIndex = (selectedIndex + 1) % data.length;
    setSelectedIndex(nextIndex);
    
    if (customViewRef.current) {
      customViewRef.current.setSelectedIndex(nextIndex);
    }
  }, [selectedIndex, data.length]);
  
  const animateComponent = useCallback(() => {
    if (customViewRef.current) {
      const randomX = Math.random() * 200 - 100;
      const randomY = Math.random() * 200 - 100;
      customViewRef.current.animateToPosition(randomX, randomY);
    }
  }, []);
  
  const resetComponent = useCallback(() => {
    setSelectedIndex(0);
    setData([
      { id: '1', title: 'Item 1', value: 10, color: '#FF6B6B' },
      { id: '2', title: 'Item 2', value: 20, color: '#4ECDC4' },
      { id: '3', title: 'Item 3', value: 30, color: '#45B7D1' },
      { id: '4', title: 'Item 4', value: 40, color: '#96CEB4' },
    ]);
    
    if (customViewRef.current) {
      customViewRef.current.setTitle('Custom View');
      customViewRef.current.setSelectedIndex(0);
      customViewRef.current.animateToPosition(0, 0);
    }
  }, []);
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Custom Native Component</Text>
      
      {/* Custom Native Component */}
      <CustomView
        ref={customViewRef}
        style={styles.customView}
        title="Custom View"
        subtitle="Native component example"
        backgroundColor="#007AFF"
        textColor="white"
        borderRadius={15}
        enabled={true}
        interactive={true}
        data={data}
        selectedIndex={selectedIndex}
        onPress={handlePress}
        onLongPress={handleLongPress}
        onSelectionChange={handleSelectionChange}
        onDataUpdate={handleDataUpdate}
      />
      
      {/* Controls */}
      <View style={styles.controlsContainer}>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={updateTitle}>
            <Text style={styles.buttonText}>Update Title</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={addNewItem}>
            <Text style={styles.buttonText}>Add Item</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={selectNextItem}>
            <Text style={styles.buttonText}>Next Item</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={animateComponent}>
            <Text style={styles.buttonText}>Animate</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity style={[styles.button, styles.resetButton]} onPress={resetComponent}>
            <Text style={styles.buttonText}>Reset</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      {/* Status Info */}
      <View style={styles.statusContainer}>
        <Text style={styles.statusTitle}>Component Status</Text>
        <Text style={styles.statusText}>Selected Index: {selectedIndex}</Text>
        <Text style={styles.statusText}>Data Items: {data.length}</Text>
        <Text style={styles.statusText}>Selected Item: {data[selectedIndex]?.title}</Text>
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
  customView: {
    width: '100%',
    height: 200,
    marginBottom: 30,
  },
  controlsContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 15,
  },
  button: {
    backgroundColor: '#007AFF',
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
  statusContainer: {
    backgroundColor: '#E3F2FD',
    padding: 15,
    borderRadius: 10,
  },
  statusTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#1976D2',
    marginBottom: 10,
  },
  statusText: {
    fontSize: 14,
    color: '#1976D2',
    marginBottom: 5,
  },
});

export default CustomViewExample;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Codegen-TurboModules.md" class="nav-link prev">⬅️ Previous: Codegen & TurboModules</a>
    <a href="../08-Platform-Capabilities/01-Permissions-Security.md" class="nav-link next">Next: Permissions & Security ➡️</a>
</div>

---


*Last updated: December 2024*
