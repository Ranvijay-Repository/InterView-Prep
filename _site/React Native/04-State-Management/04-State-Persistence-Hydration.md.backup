# 💾 **State Persistence & Hydration**

> **Master state persistence and hydration techniques to maintain application state across app restarts and sessions**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [AsyncStorage Integration](#asyncstorage-integration)
- [Redux Persist](#redux-persist)
- [Zustand Persistence](#zustand-persistence)
- [Hydration Strategies](#hydration-strategies)
- [Performance Considerations](#performance-considerations)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

State persistence ensures that user data and application state survive app restarts, providing a seamless user experience. Understanding different persistence strategies is crucial for building robust mobile applications.

### **State Persistence Overview**


```
┌─────────────────────────────────────┐
│        State Persistence            │
│  ┌─────────────────────────────────┐│
│  │        Storage Options          ││
│  │  - AsyncStorage                 ││
│  │  - SQLite                       ││
│  │  - MMKV                         ││
│  │  - Secure Storage               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Persistence Strategies   ││
│  │  - Selective persistence        ││
│  │  - Encryption                   ││
│  │  - Compression                  ││
│  │  - Migration                    ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Hydration Patterns       ││
│  │  - Lazy loading                 ││
│  │  - Progressive hydration        ││
│  │  - Error handling               ││
│  │  - Fallback strategies          ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 💾 **AsyncStorage Integration**

### **Custom Persistence Hook**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import { useState, useEffect, useCallback } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

const usePersistedState = (key, initialValue) => {
  const [state, setState] = useState(initialValue);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  
  // Load state from storage
  useEffect(() => {
    const loadState = async () => {
      try {
        setIsLoading(true);
        setError(null);
        
        const storedValue = await AsyncStorage.getItem(key);
        if (storedValue !== null) {
          const parsedValue = JSON.parse(storedValue);
          setState(parsedValue);
        }
      } catch (err) {
        console.error(`Error loading state for key ${key}:`, err);
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };
    
    loadState();
  }, [key]);
  
  // Save state to storage
  const setPersistedState = useCallback(async (newValue) => {
    try {
      setError(null);
      setState(newValue);
      
      if (newValue === null || newValue === undefined) {
        await AsyncStorage.removeItem(key);
      } else {
        await AsyncStorage.setItem(key, JSON.stringify(newValue));
      }
    } catch (err) {
      console.error(`Error saving state for key ${key}:`, err);
      setError(err.message);
    }
  }, [key]);
  
  // Clear state from storage
  const clearState = useCallback(async () => {
    try {
      setError(null);
      setState(initialValue);
      await AsyncStorage.removeItem(key);
    } catch (err) {
      console.error(`Error clearing state for key ${key}:`, err);
      setError(err.message);
    }
  }, [key, initialValue]);
  
  return [state, setPersistedState, { isLoading, error, clearState }];
};

export default usePersistedState;
```


### **Persistence Example Component**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, TextInput, Alert } from 'react-native';
import usePersistedState from '../hooks/usePersistedState';

const PersistenceExample = () => {
  const [userData, setUserData, { isLoading: userLoading, error: userError, clearState: clearUser }] = 
    usePersistedState('userData', {
      name: '',
      email: '',
      preferences: {
        theme: 'light',
        notifications: true,
      },
    });
  
  const [appSettings, setAppSettings, { isLoading: settingsLoading, error: settingsError, clearState: clearSettings }] = 
    usePersistedState('appSettings', {
      language: 'en',
      fontSize: 16,
      autoSave: true,
    });
  
  const [todos, setTodos, { isLoading: todosLoading, error: todosError, clearState: clearTodos }] = 
    usePersistedState('todos', []);
  
  const [newTodo, setNewTodo] = React.useState('');
  
  const addTodo = () => {
    if (newTodo.trim()) {
      const todo = {
        id: Date.now(),
        text: newTodo,
        completed: false,
        createdAt: new Date().toISOString(),
      };
      setTodos(prev => [...prev, todo]);
      setNewTodo('');
    }
  };
  
  const toggleTodo = (id) => {
    setTodos(prev => prev.map(todo =>
      todo.id === id ? { ...todo, completed: !todo.completed } : todo
    ));
  };
  
  const deleteTodo = (id) => {
    setTodos(prev => prev.filter(todo => todo.id !== id));
  };
  
  const clearAllData = () => {
    Alert.alert(
      'Clear All Data',
      'Are you sure you want to clear all persisted data?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Clear',
          style: 'destructive',
          onPress: () => {
            clearUser();
            clearSettings();
            clearTodos();
          },
        },
      ]
    );
  };
  
  if (userLoading || settingsLoading || todosLoading) {
    return (
      <View style={styles.loadingContainer}>
        <Text style={styles.loadingText}>Loading persisted data...</Text>
      </View>
    );
  }
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>State Persistence Example</Text>
      
      {/* User Data Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>User Data</Text>
        {userError && <Text style={styles.errorText}>Error: {userError}</Text>}
        
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
        
        <View style={styles.preferenceRow}>
          <TouchableOpacity
            style={[styles.preferenceButton, userData.preferences.theme === 'light' && styles.activeButton]}
            onPress={() => setUserData(prev => ({
              ...prev,
              preferences: { ...prev.preferences, theme: 'light' }
            }))}
          >
            <Text style={styles.preferenceButtonText}>Light</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[styles.preferenceButton, userData.preferences.theme === 'dark' && styles.activeButton]}
            onPress={() => setUserData(prev => ({
              ...prev,
              preferences: { ...prev.preferences, theme: 'dark' }
            }))}
          >
            <Text style={styles.preferenceButtonText}>Dark</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      {/* App Settings Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>App Settings</Text>
        {settingsError && <Text style={styles.errorText}>Error: {settingsError}</Text>}
        
        <Text style={styles.settingText}>Language: {appSettings.language}</Text>
        <Text style={styles.settingText}>Font Size: {appSettings.fontSize}</Text>
        <Text style={styles.settingText}>Auto Save: {appSettings.autoSave ? 'On' : 'Off'}</Text>
        
        <TouchableOpacity
          style={styles.button}
          onPress={() => setAppSettings(prev => ({ ...prev, autoSave: !prev.autoSave }))}
        >
          <Text style={styles.buttonText}>Toggle Auto Save</Text>
        </TouchableOpacity>
      </View>
      
      {/* Todos Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Todos</Text>
        {todosError && <Text style={styles.errorText}>Error: {todosError}</Text>}
        
        <View style={styles.inputRow}>
          <TextInput
            style={[styles.input, styles.flexInput]}
            placeholder="Add new todo"
            value={newTodo}
            onChangeText={setNewTodo}
          />
          <TouchableOpacity style={styles.addButton} onPress={addTodo}>
            <Text style={styles.buttonText}>Add</Text>
          </TouchableOpacity>
        </View>
        
        {todos.map(todo => (
          <View key={todo.id} style={styles.todoRow}>
            <TouchableOpacity
              style={[styles.todoButton, todo.completed && styles.completedTodo]}
              onPress={() => toggleTodo(todo.id)}
            >
              <Text style={[styles.todoText, todo.completed && styles.completedText]}>
                {todo.text}
              </Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.deleteButton}
              onPress={() => deleteTodo(todo.id)}
            >
              <Text style={styles.deleteButtonText}>×</Text>
            </TouchableOpacity>
          </View>
        ))}
      </View>
      
      {/* Clear All Button */}
      <TouchableOpacity style={[styles.button, styles.clearButton]} onPress={clearAllData}>
        <Text style={styles.buttonText}>Clear All Data</Text>
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
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    fontSize: 18,
    color: '#666',
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
  errorText: {
    color: '#FF3B30',
    fontSize: 14,
    marginBottom: 10,
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
  settingText: {
    fontSize: 16,
    color: '#333',
    marginBottom: 5,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
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
  clearButton: {
    backgroundColor: '#FF3B30',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  todoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 10,
  },
  todoButton: {
    flex: 1,
    backgroundColor: '#f0f0f0',
    padding: 15,
    borderRadius: 8,
    marginRight: 10,
  },
  completedTodo: {
    backgroundColor: '#E8F5E8',
  },
  todoText: {
    fontSize: 16,
    color: '#333',
  },
  completedText: {
    textDecorationLine: 'line-through',
    color: '#666',
  },
  deleteButton: {
    backgroundColor: '#FF3B30',
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  deleteButtonText: {
    color: 'white',
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default PersistenceExample;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Modern-State-Solutions.md" class="nav-link prev">⬅️ Previous: Modern State Solutions</a>
    <a href="../05-Lists-Performance-Optimization/01-FlatList-SectionList.md" class="nav-link next">Next: FlatList & SectionList ➡️</a>
</div>

---


*Last updated: December 2024*
