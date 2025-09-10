# 🧭 **React Navigation Basics**

> **Master the fundamentals of React Navigation for building intuitive navigation experiences in React Native**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Installation & Setup](#installation--setup)
- [Stack Navigator](#stack-navigator)
- [Tab Navigator](#tab-navigator)
- [Drawer Navigator](#drawer-navigator)
- [Navigation Props](#navigation-props)
- [Screen Options](#screen-options)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

React Navigation is the most popular navigation library for React Native. It provides a comprehensive solution for handling navigation in mobile applications with support for stack, tab, and drawer navigation patterns.

### **Navigation Types Overview**


```
┌─────────────────────────────────────┐
│        React Navigation Types       │
│  ┌─────────────────────────────────┐│
│  │        Stack Navigator          ││
│  │  - Push/Pop navigation          ││
│  │  - Modal presentations          ││
│  │  - Header customization         ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Tab Navigator            ││
│  │  - Bottom tabs                  ││
│  │  - Top tabs                     ││
│  │  - Tab bar customization        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Drawer Navigator         ││
│  │  - Side drawer                  ││
│  │  - Custom drawer content        ││
│  │  - Gesture handling             ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 📦 **Installation & Setup**

### **Basic Installation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Install React Navigation
npm install @react-navigation/native

# Install dependencies
npm install react-native-screens react-native-safe-area-context

# For stack navigator
npm install @react-navigation/stack

# For tab navigator
npm install @react-navigation/bottom-tabs

# For drawer navigator
npm install @react-navigation/drawer
```


### **Basic App Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// App.js
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import HomeScreen from './src/screens/HomeScreen';
import DetailsScreen from './src/screens/DetailsScreen';

const Stack = createStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen 
          name="Home" 
          component={HomeScreen}
          options={{#123;{{#123; title: 'Home' }}#125;}}#125;
        />
        <Stack.Screen 
          name="Details" 
          component={DetailsScreen}
          options={{#123;{{#123; title: 'Details' }}#125;}}#125;
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;
```


---

## 📚 **Stack Navigator**

Stack Navigator provides a way for your app to transition between screens where each new screen is placed on top of a stack.

### **Basic Stack Navigator**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

// Home Screen
const HomeScreen = ({ navigation }) => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Home Screen</Text>
      <TouchableOpacity
        style={styles.button}
        onPress={() => navigation.navigate('Details')}
      >
        <Text style={styles.buttonText}>Go to Details</Text>
      </TouchableOpacity>
    </View>
  );
};

// Details Screen
const DetailsScreen = ({ navigation }) => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Details Screen</Text>
      <TouchableOpacity
        style={styles.button}
        onPress={() => navigation.goBack()}
      >
        <Text style={styles.buttonText}>Go Back</Text>
      </TouchableOpacity>
    </View>
  );
};

// Stack Navigator
const StackNavigator = () => {
  return (
    <Stack.Navigator
      initialRouteName="Home"
      screenOptions={{#123;{{#123;
        headerStyle: {
          backgroundColor: '#007AFF',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}#125;}}#125;
    >
      <Stack.Screen 
        name="Home" 
        component={HomeScreen}
        options={{#123;{{#123; title: 'Home' }}#125;}}#125;
      />
      <Stack.Screen 
        name="Details" 
        component={DetailsScreen}
        options={{#123;{{#123; title: 'Details' }}#125;}}#125;
      />
    </Stack.Navigator>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    minWidth: 150,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
});

export default StackNavigator;
```


### **Stack Navigator with Parameters**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, TextInput, useState } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

// Home Screen with Parameter Passing
const HomeScreen = ({ navigation }) => {
  const [userName, setUserName] = useState('');
  
  const navigateToProfile = () => {
    if (userName.trim()) {
      navigation.navigate('Profile', { 
        name: userName,
        userId: Math.floor(Math.random() * 1000)
      });
    }
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Welcome</Text>
      <TextInput
        style={styles.input}
        placeholder="Enter your name"
        value={userName}
        onChangeText={setUserName}
      />
      <TouchableOpacity
        style={[styles.button, !userName.trim() && styles.disabledButton]}
        onPress={navigateToProfile}
        disabled={!userName.trim()}
      >
        <Text style={styles.buttonText}>View Profile</Text>
      </TouchableOpacity>
    </View>
  );
};

// Profile Screen with Parameter Receiving
const ProfileScreen = ({ route, navigation }) => {
  const { name, userId } = route.params;
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Profile</Text>
      <Text style={styles.profileText}>Name: {name}</Text>
      <Text style={styles.profileText}>User ID: {userId}</Text>
      <TouchableOpacity
        style={styles.button}
        onPress={() => navigation.goBack()}
      >
        <Text style={styles.buttonText}>Go Back</Text>
      </TouchableOpacity>
    </View>
  );
};

const StackNavigatorWithParams = () => {
  return (
    <Stack.Navigator
      initialRouteName="Home"
      screenOptions={{#123;{{#123;
        headerStyle: {
          backgroundColor: '#007AFF',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}#125;}}#125;
    >
      <Stack.Screen 
        name="Home" 
        component={HomeScreen}
        options={{#123;{{#123; title: 'Home' }}#125;}}#125;
      />
      <Stack.Screen 
        name="Profile" 
        component={ProfileScreen}
        options={{#123;{{#123; title: 'Profile' }}#125;}}#125;
      />
    </Stack.Navigator>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 30,
    textAlign: 'center',
  },
  input: {
    width: '100%',
    height: 50,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    paddingHorizontal: 15,
    marginBottom: 20,
    fontSize: 16,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    minWidth: 150,
    alignItems: 'center',
  },
  disabledButton: {
    backgroundColor: '#ccc',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  profileText: {
    fontSize: 18,
    marginBottom: 10,
    color: '#333',
  },
});

export default StackNavigatorWithParams;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="../01-React-Native-Fundamentals/06-DevMenu-Metro-Debugging.md" class="nav-link prev">⬅️ Previous: DevMenu Metro Debugging</a>
    <a href="./02-Nested-Navigators.md" class="nav-link next">Next: Nested Navigators ➡️</a>
</div>

---


*Last updated: December 2024*
