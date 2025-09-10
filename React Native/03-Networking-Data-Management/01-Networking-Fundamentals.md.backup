# 🌐 **Networking Fundamentals**

> **Master networking in React Native including fetch API, HTTP methods, error handling, and network optimization**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Fetch API](#fetch-api)
- [HTTP Methods](#http-methods)
- [Error Handling](#error-handling)
- [Request Configuration](#request-configuration)
- [Response Handling](#response-handling)
- [Network Optimization](#network-optimization)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Networking is a crucial aspect of mobile applications. React Native provides the Fetch API and other networking capabilities to communicate with web services and APIs.

### **Networking Overview**


{% raw %}
```
┌─────────────────────────────────────┐
│        Networking System            │
│  ┌─────────────────────────────────┐│
│  │        HTTP Methods             ││
│  │  - GET (retrieve data)          ││
│  │  - POST (create data)           ││
│  │  - PUT (update data)            ││
│  │  - DELETE (remove data)         ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Request Handling         ││
│  │  - Headers                      ││
│  │  - Authentication               ││
│  │  - Request body                 ││
│  │  - Timeout handling             ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Response Handling        ││
│  │  - Status codes                 ││
│  │  - Error handling               ││
│  │  - Data parsing                 ││
│  │  - Caching                      ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```
{% endraw %}


---

## 🌐 **Fetch API**

### **Basic Fetch Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ActivityIndicator, Alert } from 'react-native';

const BasicFetchExample = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  const fetchData = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('https://jsonplaceholder.typicode.com/posts/1');
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err.message);
      Alert.alert('Error', `Failed to fetch data: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };
  
  const fetchMultipleData = async () => {
    setLoading(true);
    setError(null);
    
    try {
      // Fetch multiple resources in parallel
      const [postsResponse, usersResponse, commentsResponse] = await Promise.all([
        fetch('https://jsonplaceholder.typicode.com/posts'),
        fetch('https://jsonplaceholder.typicode.com/users'),
        fetch('https://jsonplaceholder.typicode.com/comments')
      ]);
      
      // Check if all requests were successful
      if (!postsResponse.ok || !usersResponse.ok || !commentsResponse.ok) {
        throw new Error('One or more requests failed');
      }
      
      const [posts, users, comments] = await Promise.all([
        postsResponse.json(),
        usersResponse.json(),
        commentsResponse.json()
      ]);
      
      setData({
        posts: posts.slice(0, 5), // Limit to first 5 posts
        users: users.slice(0, 3), // Limit to first 3 users
        comments: comments.slice(0, 10) // Limit to first 10 comments
      });
    } catch (err) {
      setError(err.message);
      Alert.alert('Error', `Failed to fetch multiple data: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };
  
  const clearData = () => {
    setData(null);
    setError(null);
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Basic Fetch API</Text>
      
      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={styles.button}
          onPress={fetchData}
          disabled={loading}
        >
          <Text style={styles.buttonText}>Fetch Single Post</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.button}
          onPress={fetchMultipleData}
          disabled={loading}
        >
          <Text style={styles.buttonText}>Fetch Multiple Data</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[styles.button, styles.clearButton]}
          onPress={clearData}
        >
          <Text style={styles.buttonText}>Clear Data</Text>
        </TouchableOpacity>
      </View>
      
      {loading && (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#007AFF" />
          <Text style={styles.loadingText}>Loading...</Text>
        </View>
      )}
      
      {error && (
        <View style={styles.errorContainer}>
          <Text style={styles.errorText}>Error: {error}</Text>
        </View>
      )}
      
      {data && (
        <View style={styles.dataContainer}>
          <Text style={styles.dataTitle}>Fetched Data:</Text>
          <Text style={styles.dataText}>
            {JSON.stringify(data, null, 2)}
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
  clearButton: {
    backgroundColor: '#FF3B30',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  loadingContainer: {
    alignItems: 'center',
    marginBottom: 20,
  },
  loadingText: {
    marginTop: 10,
    fontSize: 16,
    color: '#007AFF',
  },
  errorContainer: {
    backgroundColor: '#FFEBEE',
    padding: 15,
    borderRadius: 8,
    marginBottom: 20,
  },
  errorText: {
    color: '#C62828',
    fontSize: 16,
  },
  dataContainer: {
    backgroundColor: 'white',
    padding: 15,
    borderRadius: 8,
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
});

export default BasicFetchExample;
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
    <a href="../02-Navigation-Deep-Linking/04-Deep-Linking-Universal-Links.md" class="nav-link prev">⬅️ Previous: Deep Linking & Universal Links</a>
    <a href="./02-GraphQL-Integration.md" class="nav-link next">Next: GraphQL Integration ➡️</a>
</div>

---


*Last updated: December 2024*
