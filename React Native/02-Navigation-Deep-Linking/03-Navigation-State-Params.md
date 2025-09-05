# 📊 **Navigation State & Params**

> **Master navigation state management, parameter passing, and navigation context in React Native**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Navigation State](#navigation-state)
- [Parameter Passing](#parameter-passing)
- [Navigation Context](#navigation-context)
- [State Persistence](#state-persistence)
- [Navigation Events](#navigation-events)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Understanding navigation state and parameter management is crucial for building complex navigation flows and maintaining data consistency across screens.

### **Navigation State Overview**

```
┌─────────────────────────────────────┐
│        Navigation State             │
│  ┌─────────────────────────────────┐│
│  │        Route Parameters         ││
│  │  - Screen params                ││
│  │  - Initial params               ││
│  │  - Default params               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Navigation State         ││
│  │  - Current route                ││
│  │  - Navigation history           ││
│  │  - State persistence            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Navigation Events        ││
│  │  - Focus events                 ││
│  │  - Blur events                  ││
│  │  - State change events          ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 📊 **Navigation State**

### **Basic Navigation State Management**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, TextInput } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';
import { useNavigation, useRoute, useFocusEffect } from '@react-navigation/native';

const Stack = createStackNavigator();

// Home Screen with State Management
const HomeScreen = ({ navigation }) => {
  const [userData, setUserData] = useState({
    name: '',
    email: '',
    age: '',
  });
  
  const [navigationHistory, setNavigationHistory] = useState([]);
  
  // Track navigation events
  useFocusEffect(
    React.useCallback(() => {
      const timestamp = new Date().toLocaleTimeString();
      setNavigationHistory(prev => [...prev, `Home - ${timestamp}`]);
      
      return () => {
        // Cleanup when screen loses focus
        console.log('Home screen lost focus');
      };
    }, [])
  );
  
  const navigateToProfile = () => {
    if (userData.name && userData.email) {
      navigation.navigate('Profile', {
        userData,
        timestamp: new Date().toISOString(),
      });
    }
  };
  
  const navigateToSettings = () => {
    navigation.navigate('Settings', {
      returnTo: 'Home',
      userData,
    });
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Home Screen</Text>
      
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
      
      <TouchableOpacity
        style={[styles.button, (!userData.name || !userData.email) && styles.disabledButton]}
        onPress={navigateToProfile}
        disabled={!userData.name || !userData.email}
      >
        <Text style={styles.buttonText}>Go to Profile</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.button}
        onPress={navigateToSettings}
      >
        <Text style={styles.buttonText}>Go to Settings</Text>
      </TouchableOpacity>
      
      <View style={styles.historyContainer}>
        <Text style={styles.historyTitle}>Navigation History:</Text>
        {navigationHistory.slice(-3).map((entry, index) => (
          <Text key={index} style={styles.historyText}>{entry}</Text>
        ))}
      </View>
    </View>
  );
};

// Profile Screen with Parameter Receiving
const ProfileScreen = ({ route, navigation }) => {
  const { userData, timestamp } = route.params;
  const [screenFocusCount, setScreenFocusCount] = useState(0);
  
  useFocusEffect(
    React.useCallback(() => {
      setScreenFocusCount(prev => prev + 1);
    }, [])
  );
  
  const goBack = () => {
    navigation.goBack();
  };
  
  const navigateToSettings = () => {
    navigation.navigate('Settings', {
      returnTo: 'Profile',
      userData,
    });
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Profile Screen</Text>
      
      <View style={styles.profileContainer}>
        <Text style={styles.profileText}>Name: {userData.name}</Text>
        <Text style={styles.profileText}>Email: {userData.email}</Text>
        <Text style={styles.profileText}>Age: {userData.age}</Text>
        <Text style={styles.profileText}>Created: {new Date(timestamp).toLocaleString()}</Text>
        <Text style={styles.profileText}>Focus Count: {screenFocusCount}</Text>
      </View>
      
      <TouchableOpacity
        style={styles.button}
        onPress={goBack}
      >
        <Text style={styles.buttonText}>Go Back</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.button}
        onPress={navigateToSettings}
      >
        <Text style={styles.buttonText}>Go to Settings</Text>
      </TouchableOpacity>
    </View>
  );
};

// Settings Screen with Navigation State
const SettingsScreen = ({ route, navigation }) => {
  const { returnTo, userData } = route.params;
  const [settings, setSettings] = useState({
    notifications: true,
    darkMode: false,
    language: 'en',
  });
  
  const saveSettings = () => {
    // Simulate saving settings
    console.log('Settings saved:', settings);
    
    // Navigate back to the calling screen
    if (returnTo) {
      navigation.navigate(returnTo, { 
        userData,
        settings,
        updated: new Date().toISOString(),
      });
    } else {
      navigation.goBack();
    }
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Settings Screen</Text>
      
      <View style={styles.settingsContainer}>
        <Text style={styles.settingsText}>Return to: {returnTo}</Text>
        <Text style={styles.settingsText}>Notifications: {settings.notifications ? 'On' : 'Off'}</Text>
        <Text style={styles.settingsText}>Dark Mode: {settings.darkMode ? 'On' : 'Off'}</Text>
        <Text style={styles.settingsText}>Language: {settings.language}</Text>
      </View>
      
      <TouchableOpacity
        style={styles.button}
        onPress={() => setSettings(prev => ({ ...prev, notifications: !prev.notifications }))}
      >
        <Text style={styles.buttonText}>Toggle Notifications</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.button}
        onPress={() => setSettings(prev => ({ ...prev, darkMode: !prev.darkMode }))}
      >
        <Text style={styles.buttonText}>Toggle Dark Mode</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={[styles.button, styles.saveButton]}
        onPress={saveSettings}
      >
        <Text style={styles.buttonText}>Save Settings</Text>
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
  input: {
    width: '100%',
    height: 50,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    paddingHorizontal: 15,
    marginBottom: 15,
    fontSize: 16,
    backgroundColor: 'white',
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 15,
  },
  disabledButton: {
    backgroundColor: '#ccc',
  },
  saveButton: {
    backgroundColor: '#34C759',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  profileContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  profileText: {
    fontSize: 16,
    marginBottom: 10,
    color: '#333',
  },
  settingsContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  settingsText: {
    fontSize: 16,
    marginBottom: 10,
    color: '#333',
  },
  historyContainer: {
    backgroundColor: 'white',
    padding: 15,
    borderRadius: 10,
    marginTop: 20,
  },
  historyTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  historyText: {
    fontSize: 14,
    color: '#666',
    marginBottom: 5,
  },
});

export default HomeScreen;
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Nested-Navigators.md" class="nav-link prev">⬅️ Previous: Nested Navigators</a>
    <a href="./04-Deep-Linking-Universal-Links.md" class="nav-link next">Next: Deep Linking & Universal Links ➡️</a>
</div>

---


*Last updated: December 2024*
