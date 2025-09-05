# 🏠 **Local State & Context API**

> **Master local state management and Context API for building scalable React Native applications with efficient data flow**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Local State Management](#local-state-management)
- [Context API](#context-api)
- [Custom Hooks](#custom-hooks)
- [State Patterns](#state-patterns)
- [Performance Optimization](#performance-optimization)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

State management is crucial for React Native applications. Understanding local state and Context API helps you build maintainable applications with proper data flow and component communication.

### **State Management Overview**

```
┌─────────────────────────────────────┐
│        State Management             │
│  ┌─────────────────────────────────┐│
│  │        Local State              ││
│  │  - useState                     ││
│  │  - useReducer                   ││
│  │  - Component-level state        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Context API              ││
│  │  - createContext                ││
│  │  - useContext                   ││
│  │  - Provider pattern             ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Custom Hooks             ││
│  │  - State logic reuse            ││
│  │  - Side effects                 ││
│  │  - Business logic               ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🏠 **Local State Management**

### **useState Hook Examples**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, TextInput, Alert } from 'react-native';

const LocalStateExample = () => {
  // Basic state
  const [count, setCount] = useState(0);
  const [name, setName] = useState('');
  const [isVisible, setIsVisible] = useState(true);
  
  // Complex state object
  const [user, setUser] = useState({
    id: 1,
    name: '',
    email: '',
    preferences: {
      theme: 'light',
      notifications: true,
    },
  });
  
  // Array state
  const [items, setItems] = useState([]);
  const [newItem, setNewItem] = useState('');
  
  // Function to update complex state
  const updateUser = (field, value) => {
    setUser(prev => ({
      ...prev,
      [field]: value,
    }));
  };
  
  // Function to update nested state
  const updateUserPreference = (preference, value) => {
    setUser(prev => ({
      ...prev,
      preferences: {
        ...prev.preferences,
        [preference]: value,
      },
    }));
  };
  
  // Function to add item to array
  const addItem = () => {
    if (newItem.trim()) {
      setItems(prev => [...prev, {
        id: Date.now(),
        text: newItem,
        completed: false,
      }]);
      setNewItem('');
    }
  };
  
  // Function to toggle item completion
  const toggleItem = (id) => {
    setItems(prev => prev.map(item =>
      item.id === id ? { ...item, completed: !item.completed } : item
    ));
  };
  
  // Function to remove item
  const removeItem = (id) => {
    setItems(prev => prev.filter(item => item.id !== id));
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Local State Management</Text>
      
      {/* Basic State Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Basic State</Text>
        <Text style={styles.counterText}>Count: {count}</Text>
        <View style={styles.buttonRow}>
          <TouchableOpacity
            style={styles.button}
            onPress={() => setCount(prev => prev + 1)}
          >
            <Text style={styles.buttonText}>+</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.button}
            onPress={() => setCount(prev => prev - 1)}
          >
            <Text style={styles.buttonText}>-</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.button}
            onPress={() => setCount(0)}
          >
            <Text style={styles.buttonText}>Reset</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      {/* User State Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>User State</Text>
        <TextInput
          style={styles.input}
          placeholder="Enter name"
          value={user.name}
          onChangeText={(text) => updateUser('name', text)}
        />
        <TextInput
          style={styles.input}
          placeholder="Enter email"
          value={user.email}
          onChangeText={(text) => updateUser('email', text)}
          keyboardType="email-address"
        />
        <View style={styles.preferenceRow}>
          <TouchableOpacity
            style={[styles.preferenceButton, user.preferences.theme === 'light' && styles.activeButton]}
            onPress={() => updateUserPreference('theme', 'light')}
          >
            <Text style={styles.preferenceButtonText}>Light</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[styles.preferenceButton, user.preferences.theme === 'dark' && styles.activeButton]}
            onPress={() => updateUserPreference('theme', 'dark')}
          >
            <Text style={styles.preferenceButtonText}>Dark</Text>
          </TouchableOpacity>
        </View>
        <TouchableOpacity
          style={[styles.preferenceButton, user.preferences.notifications && styles.activeButton]}
          onPress={() => updateUserPreference('notifications', !user.preferences.notifications)}
        >
          <Text style={styles.preferenceButtonText}>
            Notifications: {user.preferences.notifications ? 'On' : 'Off'}
          </Text>
        </TouchableOpacity>
      </View>
      
      {/* Items List Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Items List</Text>
        <View style={styles.inputRow}>
          <TextInput
            style={[styles.input, styles.flexInput]}
            placeholder="Add new item"
            value={newItem}
            onChangeText={setNewItem}
          />
          <TouchableOpacity
            style={styles.addButton}
            onPress={addItem}
          >
            <Text style={styles.buttonText}>Add</Text>
          </TouchableOpacity>
        </View>
        {items.map(item => (
          <View key={item.id} style={styles.itemRow}>
            <TouchableOpacity
              style={[styles.itemButton, item.completed && styles.completedButton]}
              onPress={() => toggleItem(item.id)}
            >
              <Text style={[styles.itemText, item.completed && styles.completedText]}>
                {item.text}
              </Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.removeButton}
              onPress={() => removeItem(item.id)}
            >
              <Text style={styles.removeButtonText}>×</Text>
            </TouchableOpacity>
          </View>
        ))}
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
    fontSize: 20,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 15,
    color: '#007AFF',
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    minWidth: 60,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  input: {
    width: '100%',
    height: 50,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    paddingHorizontal: 15,
    marginBottom: 15,
    fontSize: 16,
  },
  flexInput: {
    flex: 1,
    marginRight: 10,
  },
  inputRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 15,
  },
  addButton: {
    backgroundColor: '#34C759',
    padding: 15,
    borderRadius: 8,
    minWidth: 60,
    alignItems: 'center',
  },
  preferenceRow: {
    flexDirection: 'row',
    marginBottom: 15,
  },
  preferenceButton: {
    backgroundColor: '#f0f0f0',
    padding: 10,
    borderRadius: 8,
    marginRight: 10,
    alignItems: 'center',
    minWidth: 80,
  },
  activeButton: {
    backgroundColor: '#007AFF',
  },
  preferenceButtonText: {
    color: '#333',
    fontWeight: '600',
  },
  itemRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 10,
  },
  itemButton: {
    flex: 1,
    backgroundColor: '#f0f0f0',
    padding: 15,
    borderRadius: 8,
    marginRight: 10,
  },
  completedButton: {
    backgroundColor: '#E8F5E8',
  },
  itemText: {
    fontSize: 16,
    color: '#333',
  },
  completedText: {
    textDecorationLine: 'line-through',
    color: '#666',
  },
  removeButton: {
    backgroundColor: '#FF3B30',
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  removeButtonText: {
    color: 'white',
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default LocalStateExample;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="../03-Networking-Data-Management/04-Storage-Solutions.md" class="nav-link prev">⬅️ Previous: Storage Solutions</a>
    <a href="./02-Redux-Toolkit-RTK-Query.md" class="nav-link next">Next: Redux Toolkit & RTK Query ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
