# ⚡ **JSI, Fabric & TurboModules**

> **Master the core components of React Native's new architecture: JSI, Fabric, and TurboModules**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [JSI (JavaScript Interface)](#jsi-javascript-interface)
- [Fabric (New Renderer)](#fabric-new-renderer)
- [TurboModules](#turbomodules)
- [Integration Examples](#integration-examples)
- [Performance Benefits](#performance-benefits)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

JSI, Fabric, and TurboModules are the three pillars of React Native's new architecture. They work together to provide better performance, type safety, and developer experience.

### **New Architecture Components**

```
┌─────────────────────────────────────┐
│        New Architecture             │
│  ┌─────────────────────────────────┐│
│  │        JSI                      ││
│  │  - JavaScript Interface         ││
│  │  - Direct memory access         ││
│  │  - Synchronous communication    ││
│  │  - C++ binding                  ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Fabric                   ││
│  │  - New renderer                 ││
│  │  - Concurrent features          ││
│  │  - Better performance           ││
│  │  - Type safety                  ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        TurboModules             ││
│  │  - Native module system         ││
│  │  - Code generation              ││
│  │  - Type safety                  ││
│  │  - Better performance           ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## ⚡ **JSI (JavaScript Interface)**

### **JSI Implementation Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// JSI Implementation Example
import { TurboModuleRegistry } from 'react-native';

// JSI allows direct communication between JavaScript and native code
const JSIExample = TurboModuleRegistry.get('JSIExample');

class JSIDemonstration {
  constructor() {
    this.setupJSICapabilities();
  }
  
  // 1. Synchronous function calls
  synchronousOperations() {
    console.log('=== Synchronous Operations ===');
    
    // Direct function calls without bridge overhead
    const result1 = JSIExample.add(10, 20);
    const result2 = JSIExample.multiply(5, 6);
    const result3 = JSIExample.complexCalculation(100, 200, 300);
    
    console.log('Add result:', result1);
    console.log('Multiply result:', result2);
    console.log('Complex calculation:', result3);
    
    return { result1, result2, result3 };
  }
  
  // 2. Direct memory access
  memoryOperations() {
    console.log('=== Memory Operations ===');
    
    // Create large data structure
    const largeData = new Array(1000).fill(0).map((_, i) => ({
      id: i,
      value: Math.random() * 1000,
      timestamp: Date.now()
    }));
    
    // Process directly in native code without serialization
    const processedData = JSIExample.processLargeData(largeData);
    console.log('Processed data length:', processedData.length);
    
    return processedData;
  }
  
  // 3. Type-safe operations
  typeSafeOperations() {
    console.log('=== Type Safe Operations ===');
    
    try {
      // JSI provides better type checking
      const stringResult = JSIExample.processString('Hello JSI');
      const numberResult = JSIExample.processNumber(42);
      const booleanResult = JSIExample.processBoolean(true);
      
      console.log('String result:', stringResult);
      console.log('Number result:', numberResult);
      console.log('Boolean result:', booleanResult);
      
      return { stringResult, numberResult, booleanResult };
    } catch (error) {
      console.error('Type safety error:', error);
      throw error;
    }
  }
  
  // 4. Performance comparison
  performanceComparison() {
    console.log('=== Performance Comparison ===');
    
    const iterations = 10000;
    
    // JSI performance test
    const jsiStartTime = Date.now();
    for (let i = 0; i < iterations; i++) {
      JSIExample.quickOperation(i);
    }
    const jsiEndTime = Date.now();
    const jsiTime = jsiEndTime - jsiStartTime;
    
    // JavaScript performance test
    const jsStartTime = Date.now();
    for (let i = 0; i < iterations; i++) {
      this.jsQuickOperation(i);
    }
    const jsEndTime = Date.now();
    const jsTime = jsEndTime - jsStartTime;
    
    console.log(`JSI time: ${jsiTime}ms`);
    console.log(`JavaScript time: ${jsTime}ms`);
    console.log(`Performance ratio: ${(jsTime / jsiTime).toFixed(2)}x`);
    
    return { jsiTime, jsTime, ratio: jsTime / jsiTime };
  }
  
  // JavaScript equivalent for comparison
  jsQuickOperation(value) {
    return value * 2 + 1;
  }
  
  // 5. Error handling
  errorHandling() {
    console.log('=== Error Handling ===');
    
    try {
      // JSI provides better error handling
      const result = JSIExample.riskyOperation();
      console.log('Risky operation result:', result);
      return result;
    } catch (error) {
      console.error('JSI error caught:', error);
      return null;
    }
  }
  
  setupJSICapabilities() {
    console.log('JSI capabilities initialized');
  }
}

export default JSIDemonstration;
```

---

## 🎨 **Fabric (New Renderer)**

### **Fabric Implementation Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Fabric Implementation Example
import React, { useState, useCallback } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const FabricExample = () => {
  const [count, setCount] = useState(0);
  const [items, setItems] = useState([]);
  
  // Fabric provides better performance for frequent updates
  const handleIncrement = useCallback(() => {
    setCount(prev => prev + 1);
  }, []);
  
  const handleDecrement = useCallback(() => {
    setCount(prev => prev - 1);
  }, []);
  
  const addItem = useCallback(() => {
    setItems(prev => [...prev, {
      id: Date.now(),
      value: Math.random() * 100,
      timestamp: new Date().toISOString()
    }]);
  }, []);
  
  const removeItem = useCallback((id) => {
    setItems(prev => prev.filter(item => item.id !== id));
  }, []);
  
  const clearItems = useCallback(() => {
    setItems([]);
  }, []);
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Fabric Renderer Example</Text>
      
      {/* Counter Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Counter</Text>
        <Text style={styles.counterText}>{count}</Text>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={handleDecrement}>
            <Text style={styles.buttonText}>-</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={handleIncrement}>
            <Text style={styles.buttonText}>+</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      {/* Items Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Dynamic Items</Text>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={addItem}>
            <Text style={styles.buttonText}>Add Item</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={clearItems}>
            <Text style={styles.buttonText}>Clear</Text>
          </TouchableOpacity>
        </View>
        
        {items.map(item => (
          <View key={item.id} style={styles.itemContainer}>
            <Text style={styles.itemText}>
              Item {item.id}: {item.value.toFixed(2)}
            </Text>
            <TouchableOpacity
              style={styles.removeButton}
              onPress={() => removeItem(item.id)}
            >
              <Text style={styles.removeButtonText}>×</Text>
            </TouchableOpacity>
          </View>
        ))}
      </View>
      
      {/* Performance Info */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Fabric Benefits</Text>
        <Text style={styles.infoText}>
          • Concurrent rendering for better performance
        </Text>
        <Text style={styles.infoText}>
          • Type-safe component props
        </Text>
        <Text style={styles.infoText}>
          • Better memory management
        </Text>
        <Text style={styles.infoText}>
          • Improved debugging capabilities
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
    textAlign: 'center',
    marginBottom: 30,
  },
  section: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#333',
  },
  counterText: {
    fontSize: 48,
    fontWeight: 'bold',
    textAlign: 'center',
    color: '#007AFF',
    marginBottom: 20,
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  button: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 8,
    minWidth: 100,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  itemContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 15,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    marginBottom: 10,
  },
  itemText: {
    fontSize: 16,
    color: '#333',
  },
  removeButton: {
    backgroundColor: '#FF3B30',
    width: 30,
    height: 30,
    borderRadius: 15,
    alignItems: 'center',
    justifyContent: 'center',
  },
  removeButtonText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
  },
  infoText: {
    fontSize: 14,
    color: '#666',
    marginBottom: 5,
  },
});

export default FabricExample;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="./01-Old-vs-New-Architecture.md" class="nav-link prev">⬅️ Previous: Old vs New Architecture</a>
    <a href="./03-Codegen-TurboModules.md" class="nav-link next">Next: Codegen & TurboModules ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
