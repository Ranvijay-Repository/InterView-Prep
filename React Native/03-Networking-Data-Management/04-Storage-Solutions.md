# 💾 **Storage Solutions**

> **Master different storage solutions in React Native including AsyncStorage, SQLite, Realm, and MMKV for efficient data persistence**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [AsyncStorage](#asyncstorage)
- [SQLite](#sqlite)
- [Realm](#realm)
- [MMKV](#mmkv)
- [Storage Comparison](#storage-comparison)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Choosing the right storage solution is crucial for React Native applications. Different storage options offer various trade-offs in terms of performance, complexity, and features.

### **Storage Solutions Overview**

```
┌─────────────────────────────────────┐
│        Storage Solutions            │
│  ┌─────────────────────────────────┐│
│  │        AsyncStorage             ││
│  │  - Simple key-value storage     ││
│  │  - JSON serialization           ││
│  │  - Cross-platform               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        SQLite                   ││
│  │  - Relational database          ││
│  │  - Complex queries              ││
│  │  - ACID compliance              ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Realm                    ││
│  │  - Object database              ││
│  │  - Real-time sync               ││
│  │  - Offline-first                ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        MMKV                     ││
│  │  - High performance             ││
│  │  - Memory mapped                ││
│  │  - Type-safe                    ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 📦 **AsyncStorage**

### **Basic AsyncStorage Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, TextInput, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

const AsyncStorageExample = () => {
  const [userData, setUserData] = useState({
    name: '',
    email: '',
    age: '',
  });
  const [storedData, setStoredData] = useState(null);
  const [loading, setLoading] = useState(false);
  
  useEffect(() => {
    loadStoredData();
  }, []);
  
  const loadStoredData = async () => {
    try {
      setLoading(true);
      const data = await AsyncStorage.getItem('userData');
      if (data) {
        const parsedData = JSON.parse(data);
        setStoredData(parsedData);
        setUserData(parsedData);
      }
    } catch (error) {
      console.error('Error loading data:', error);
      Alert.alert('Error', 'Failed to load stored data');
    } finally {
      setLoading(false);
    }
  };
  
  const saveData = async () => {
    try {
      setLoading(true);
      await AsyncStorage.setItem('userData', JSON.stringify(userData));
      setStoredData(userData);
      Alert.alert('Success', 'Data saved successfully!');
    } catch (error) {
      console.error('Error saving data:', error);
      Alert.alert('Error', 'Failed to save data');
    } finally {
      setLoading(false);
    }
  };
  
  const clearData = async () => {
    try {
      setLoading(true);
      await AsyncStorage.removeItem('userData');
      setStoredData(null);
      setUserData({ name: '', email: '', age: '' });
      Alert.alert('Success', 'Data cleared successfully!');
    } catch (error) {
      console.error('Error clearing data:', error);
      Alert.alert('Error', 'Failed to clear data');
    } finally {
      setLoading(false);
    }
  };
  
  const getAllKeys = async () => {
    try {
      const keys = await AsyncStorage.getAllKeys();
      Alert.alert('All Keys', keys.join(', '));
    } catch (error) {
      console.error('Error getting keys:', error);
      Alert.alert('Error', 'Failed to get keys');
    }
  };
  
  const getMultipleData = async () => {
    try {
      const keys = ['userData', 'settings', 'preferences'];
      const values = await AsyncStorage.multiGet(keys);
      const data = {};
      values.forEach(([key, value]) => {
        if (value) {
          data[key] = JSON.parse(value);
        }
      });
      Alert.alert('Multiple Data', JSON.stringify(data, null, 2));
    } catch (error) {
      console.error('Error getting multiple data:', error);
      Alert.alert('Error', 'Failed to get multiple data');
    }
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>AsyncStorage Example</Text>
      
      <View style={styles.formContainer}>
        <TextInput
          style={styles.input}
          placeholder="Enter your name"
          value={userData.name}
          onChangeText={(text) => setUserData(prev => ({ ...prev, name: text }))}
        />
        
        <TextInput
          style={styles.input}
          placeholder="Enter your email"
          value={userData.email}
          onChangeText={(text) => setUserData(prev => ({ ...prev, email: text }))}
          keyboardType="email-address"
        />
        
        <TextInput
          style={styles.input}
          placeholder="Enter your age"
          value={userData.age}
          onChangeText={(text) => setUserData(prev => ({ ...prev, age: text }))}
          keyboardType="numeric"
        />
      </View>
      
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={styles.button}
          onPress={saveData}
          disabled={loading}
        >
          <Text style={styles.buttonText}>Save Data</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.button}
          onPress={loadStoredData}
          disabled={loading}
        >
          <Text style={styles.buttonText}>Load Data</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.button}
          onPress={clearData}
          disabled={loading}
        >
          <Text style={styles.buttonText}>Clear Data</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.button}
          onPress={getAllKeys}
        >
          <Text style={styles.buttonText}>Get All Keys</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.button}
          onPress={getMultipleData}
        >
          <Text style={styles.buttonText}>Get Multiple Data</Text>
        </TouchableOpacity>
      </View>
      
      {storedData && (
        <View style={styles.dataContainer}>
          <Text style={styles.dataTitle}>Stored Data:</Text>
          <Text style={styles.dataText}>
            {JSON.stringify(storedData, null, 2)}
          </Text>
        </View>
      )}
      
      {loading && (
        <View style={styles.loadingContainer}>
          <Text style={styles.loadingText}>Loading...</Text>
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
  formContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
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
  buttonContainer: {
    marginBottom: 20,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 15,
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  dataContainer: {
    backgroundColor: 'white',
    padding: 15,
    borderRadius: 10,
    flex: 1,
  },
  dataTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  dataText: {
    fontSize: 12,
    color: '#666',
    fontFamily: 'monospace',
  },
  loadingContainer: {
    alignItems: 'center',
    marginTop: 20,
  },
  loadingText: {
    fontSize: 16,
    color: '#666',
  },
});

export default AsyncStorageExample;
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Offline-First-Strategies.md" class="nav-link prev">⬅️ Previous: Offline-First Strategies</a>
    <a href="../04-State-Management/01-Local-State-Context-API.md" class="nav-link next">Next: Local State & Context API ➡️</a>
</div>

---


*Last updated: December 2024*
