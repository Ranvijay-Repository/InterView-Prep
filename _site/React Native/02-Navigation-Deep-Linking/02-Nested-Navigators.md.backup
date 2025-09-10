# 🔗 **Nested Navigators**

> **Master nested navigation patterns to create complex navigation structures with multiple navigator types**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Basic Nested Navigation](#basic-nested-navigation)
- [Stack + Tab Navigation](#stack--tab-navigation)
- [Tab + Drawer Navigation](#tab--drawer-navigation)
- [Complex Nested Structures](#complex-nested-structures)
- [Navigation State Management](#navigation-state-management)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Nested navigators allow you to combine different navigation patterns to create sophisticated navigation experiences. This is essential for building complex applications with multiple navigation contexts.

### **Nested Navigation Overview**


```
┌─────────────────────────────────────┐
│        Nested Navigation            │
│  ┌─────────────────────────────────┐│
│  │        Root Stack               ││
│  │  ┌─────────────────────────────┐││
│  │  │        Tab Navigator        │││
│  │  │  ┌─────────────────────────┐│││
│  │  │  │        Stack Navigator  ││││
│  │  │  │  - Home Stack           ││││
│  │  │  │  - Profile Stack        ││││
│  │  │  │  - Settings Stack       ││││
│  │  │  └─────────────────────────┘│││
│  │  └─────────────────────────────┘││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 🔗 **Basic Nested Navigation**

### **Stack + Tab Navigation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';

const Stack = createStackNavigator();
const Tab = createBottomTabNavigator();

// Home Stack
const HomeStack = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen 
        name="HomeMain" 
        component={HomeScreen}
        options={{#123;{{#123; title: 'Home' }}#125;}}#125;
      />
      <Stack.Screen 
        name="HomeDetails" 
        component={HomeDetailsScreen}
        options={{#123;{{#123; title: 'Home Details' }}#125;}}#125;
      />
    </Stack.Navigator>
  );
};

// Profile Stack
const ProfileStack = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen 
        name="ProfileMain" 
        component={ProfileScreen}
        options={{#123;{{#123; title: 'Profile' }}#125;}}#125;
      />
      <Stack.Screen 
        name="ProfileEdit" 
        component={ProfileEditScreen}
        options={{#123;{{#123; title: 'Edit Profile' }}#125;}}#125;
      />
    </Stack.Navigator>
  );
};

// Tab Navigator
const TabNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarIcon: ({ focused, color, size }) => {
          let iconName;
          
          if (route.name === 'HomeTab') {
            iconName = focused ? 'home' : 'home-outline';
          } else if (route.name === 'ProfileTab') {
            iconName = focused ? 'person' : 'person-outline';
          }
          
          return <Ionicons name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: '#007AFF',
        tabBarInactiveTintColor: 'gray',
      })}
    >
      <Tab.Screen 
        name="HomeTab" 
        component={HomeStack}
        options={{#123;{{#123; headerShown: false }}#125;}}#125;
      />
      <Tab.Screen 
        name="ProfileTab" 
        component={ProfileStack}
        options={{#123;{{#123; headerShown: false }}#125;}}#125;
      />
    </Tab.Navigator>
  );
};

// Root Stack Navigator
const RootNavigator = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen 
        name="MainTabs" 
        component={TabNavigator}
        options={{#123;{{#123; headerShown: false }}#125;}}#125;
      />
      <Stack.Screen 
        name="Modal" 
        component={ModalScreen}
        options={{#123;{{#123; 
          presentation: 'modal',
          title: 'Modal Screen'
        }}#125;}}#125;
      />
    </Stack.Navigator>
  );
};

// Screen Components
const HomeScreen = ({ navigation }) => (
  <View style={styles.container}>
    <Text style={styles.title}>Home Screen</Text>
    <TouchableOpacity
      style={styles.button}
      onPress={() => navigation.navigate('HomeDetails')}
    >
      <Text style={styles.buttonText}>Go to Home Details</Text>
    </TouchableOpacity>
    <TouchableOpacity
      style={styles.button}
      onPress={() => navigation.navigate('Modal')}
    >
      <Text style={styles.buttonText}>Open Modal</Text>
    </TouchableOpacity>
  </View>
);

const HomeDetailsScreen = ({ navigation }) => (
  <View style={styles.container}>
    <Text style={styles.title}>Home Details</Text>
    <TouchableOpacity
      style={styles.button}
      onPress={() => navigation.goBack()}
    >
      <Text style={styles.buttonText}>Go Back</Text>
    </TouchableOpacity>
  </View>
);

const ProfileScreen = ({ navigation }) => (
  <View style={styles.container}>
    <Text style={styles.title}>Profile Screen</Text>
    <TouchableOpacity
      style={styles.button}
      onPress={() => navigation.navigate('ProfileEdit')}
    >
      <Text style={styles.buttonText}>Edit Profile</Text>
    </TouchableOpacity>
  </View>
);

const ProfileEditScreen = ({ navigation }) => (
  <View style={styles.container}>
    <Text style={styles.title}>Edit Profile</Text>
    <TouchableOpacity
      style={styles.button}
      onPress={() => navigation.goBack()}
    >
      <Text style={styles.buttonText}>Save & Go Back</Text>
    </TouchableOpacity>
  </View>
);

const ModalScreen = ({ navigation }) => (
  <View style={styles.container}>
    <Text style={styles.title}>Modal Screen</Text>
    <TouchableOpacity
      style={styles.button}
      onPress={() => navigation.goBack()}
    >
      <Text style={styles.buttonText}>Close Modal</Text>
    </TouchableOpacity>
  </View>
);

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
    minWidth: 200,
    alignItems: 'center',
    marginBottom: 15,
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
});

export default RootNavigator;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-React-Navigation-Basics.md" class="nav-link prev">⬅️ Previous: React Navigation Basics</a>
    <a href="./03-Navigation-State-Params.md" class="nav-link next">Next: Navigation State & Params ➡️</a>
</div>

---


*Last updated: December 2024*
