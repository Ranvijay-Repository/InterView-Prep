# 🚀 **Modern State Solutions**

> **Explore modern state management libraries like Zustand, Recoil, and Jotai for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Zustand](#zustand)
- [Recoil](#recoil)
- [Jotai](#jotai)
- [Comparison](#comparison)
- [Migration Strategies](#migration-strategies)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Modern state management libraries offer simpler alternatives to Redux, focusing on developer experience and performance. These solutions provide different approaches to state management with varying levels of complexity.

### **Modern State Solutions Overview**


```
┌─────────────────────────────────────┐
│        Modern State Solutions       │
│  ┌─────────────────────────────────┐│
│  │        Zustand                  ││
│  │  - Minimal boilerplate          ││
│  │  - TypeScript support           ││
│  │  - No providers needed          ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Recoil                  ││
│  │  - Atomic state                ││
│  │  - Derived state               ││
│  │  - React Suspense              ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Jotai                   ││
│  │  - Atomic approach             ││
│  │  - Bottom-up state             ││
│  │  - TypeScript first            ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 🐻 **Zustand**

### **Basic Zustand Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// store/useCounterStore.js
import { create } from 'zustand';
import { devtools, persist } from 'zustand/middleware';

interface CounterState {
  count: number;
  increment: () => void;
  decrement: () => void;
  reset: () => void;
  incrementByAmount: (amount: number) => void;
}

export const useCounterStore = create<CounterState>()(
  devtools(
    persist(
      (set) => ({
        count: 0,
        increment: () => set((state) => ({ count: state.count + 1 })),
        decrement: () => set((state) => ({ count: state.count - 1 })),
        reset: () => set({ count: 0 }),
        incrementByAmount: (amount) => set((state) => ({ count: state.count + amount })),
      }),
      {
        name: 'counter-storage', // unique name for localStorage
      }
    ),
    {
      name: 'counter-store', // name for devtools
    }
  )
);
```


### **Zustand with Async Actions**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// store/useUserStore.js
import { create } from 'zustand';
import { devtools } from 'zustand/middleware';

interface User {
  id: number;
  name: string;
  email: string;
  avatar?: string;
}

interface UserState {
  users: User[];
  currentUser: User | null;
  isLoading: boolean;
  error: string | null;
  fetchUsers: () => Promise<void>;
  createUser: (userData: Omit<User, 'id'>) => Promise<void>;
  setCurrentUser: (user: User | null) => void;
  updateUser: (id: number, userData: Partial<User>) => void;
  deleteUser: (id: number) => void;
  clearError: () => void;
}

export const useUserStore = create<UserState>()(
  devtools(
    (set, get) => ({
      users: [],
      currentUser: null,
      isLoading: false,
      error: null,
      
      fetchUsers: async () => {
        set({ isLoading: true, error: null });
        try {
          const response = await fetch('https://jsonplaceholder.typicode.com/users');
          if (!response.ok) {
            throw new Error('Failed to fetch users');
          }
          const users = await response.json();
          set({ users, isLoading: false });
        } catch (error) {
          set({ error: error.message, isLoading: false });
        }
      },
      
      createUser: async (userData) => {
        set({ isLoading: true, error: null });
        try {
          const response = await fetch('https://jsonplaceholder.typicode.com/users', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(userData),
          });
          
          if (!response.ok) {
            throw new Error('Failed to create user');
          }
          
          const newUser = await response.json();
          set((state) => ({
            users: [...state.users, newUser],
            isLoading: false,
          }));
        } catch (error) {
          set({ error: error.message, isLoading: false });
        }
      },
      
      setCurrentUser: (user) => set({ currentUser: user }),
      
      updateUser: (id, userData) => set((state) => ({
        users: state.users.map(user =>
          user.id === id ? { ...user, ...userData } : user
        ),
        currentUser: state.currentUser?.id === id 
          ? { ...state.currentUser, ...userData }
          : state.currentUser,
      })),
      
      deleteUser: (id) => set((state) => ({
        users: state.users.filter(user => user.id !== id),
        currentUser: state.currentUser?.id === id ? null : state.currentUser,
      })),
      
      clearError: () => set({ error: null }),
    }),
    {
      name: 'user-store',
    }
  )
);
```


### **Zustand Component Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React, { useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, FlatList, ActivityIndicator } from 'react-native';
import { useCounterStore } from '../store/useCounterStore';
import { useUserStore } from '../store/useUserStore';

const ZustandExample = () => {
  const { count, increment, decrement, reset, incrementByAmount } = useCounterStore();
  const { 
    users, 
    currentUser, 
    isLoading, 
    error, 
    fetchUsers, 
    setCurrentUser, 
    clearError 
  } = useUserStore();
  
  useEffect(() => {
    fetchUsers();
  }, [fetchUsers]);
  
  const renderUser = ({ item }) => (
    <TouchableOpacity
      style={[styles.userItem, currentUser?.id === item.id && styles.selectedUser]}
      onPress={() => setCurrentUser(item)}
    >
      <Text style={styles.userName}>{item.name}</Text>
      <Text style={styles.userEmail}>{item.email}</Text>
    </TouchableOpacity>
  );
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Zustand State Management</Text>
      
      {/* Counter Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Counter</Text>
        <Text style={styles.counterText}>Count: {count}</Text>
        <View style={styles.buttonRow}>
          <TouchableOpacity style={styles.button} onPress={increment}>
            <Text style={styles.buttonText}>+</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={decrement}>
            <Text style={styles.buttonText}>-</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={() => incrementByAmount(5)}>
            <Text style={styles.buttonText}>+5</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button} onPress={reset}>
            <Text style={styles.buttonText}>Reset</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      {/* Users Section */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Users</Text>
        {isLoading && <ActivityIndicator size="small" color="#007AFF" />}
        {error && (
          <View style={styles.errorContainer}>
            <Text style={styles.errorText}>{error}</Text>
            <TouchableOpacity style={styles.clearButton} onPress={clearError}>
              <Text style={styles.clearButtonText}>Clear Error</Text>
            </TouchableOpacity>
          </View>
        )}
        <FlatList
          data={users}
          renderItem={renderUser}
          keyExtractor={(item) => item.id.toString()}
          style={styles.userList}
        />
        {currentUser && (
          <View style={styles.currentUserContainer}>
            <Text style={styles.currentUserTitle}>Current User:</Text>
            <Text style={styles.currentUserName}>{currentUser.name}</Text>
            <Text style={styles.currentUserEmail}>{currentUser.email}</Text>
          </View>
        )}
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
  userList: {
    maxHeight: 200,
  },
  userItem: {
    padding: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  selectedUser: {
    backgroundColor: '#E3F2FD',
  },
  userName: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
  },
  userEmail: {
    fontSize: 14,
    color: '#666',
  },
  errorContainer: {
    backgroundColor: '#FFEBEE',
    padding: 15,
    borderRadius: 8,
    marginBottom: 15,
  },
  errorText: {
    color: '#C62828',
    fontSize: 14,
    marginBottom: 10,
  },
  clearButton: {
    backgroundColor: '#FF3B30',
    padding: 10,
    borderRadius: 5,
    alignItems: 'center',
  },
  clearButtonText: {
    color: 'white',
    fontWeight: 'bold',
  },
  currentUserContainer: {
    backgroundColor: '#E8F5E8',
    padding: 15,
    borderRadius: 8,
    marginTop: 15,
  },
  currentUserTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#2E7D32',
    marginBottom: 5,
  },
  currentUserName: {
    fontSize: 16,
    color: '#333',
    fontWeight: '600',
  },
  currentUserEmail: {
    fontSize: 14,
    color: '#666',
  },
});

export default ZustandExample;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Redux-Toolkit-RTK-Query.md" class="nav-link prev">⬅️ Previous: Redux Toolkit & RTK Query</a>
    <a href="./04-State-Persistence-Hydration.md" class="nav-link next">Next: State Persistence & Hydration ➡️</a>
</div>

---


*Last updated: December 2024*
