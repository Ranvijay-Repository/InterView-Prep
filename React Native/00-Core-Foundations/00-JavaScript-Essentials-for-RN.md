# 🚀 **JavaScript Essentials for React Native**

> **Master the JavaScript concepts that are crucial for React Native development, including closures, event loop, async/await, and modern ES6+ features**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Closures in React Native](#closures-in-react-native)
- [Event Loop & Asynchronous JavaScript](#event-loop--asynchronous-javascript)
- [Async/Await Patterns](#asyncawait-patterns)
- [Modern JavaScript Features](#modern-javascript-features)
- [Memory Management](#memory-management)
- [Common Pitfalls](#common-pitfalls)
- [Interview Questions](#interview-questions)
- [Code Examples](#code-examples)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

JavaScript is the foundation of React Native development. Understanding core JavaScript concepts is essential for building performant, maintainable React Native applications. This guide covers the JavaScript concepts that are most relevant to React Native development.

### **Why JavaScript Matters in React Native**

React Native runs JavaScript code in a JavaScript engine (Hermes or JavaScriptCore), making JavaScript knowledge crucial for:
- **Performance optimization**
- **Memory management**
- **Asynchronous operations**
- **State management**
- **Error handling**

---

## 🔒 **Closures in React Native**

### **What are Closures?**

A closure is a function that has access to variables in its outer (enclosing) scope even after the outer function has returned. This is fundamental to React Native development.

### **Closure Diagram**


```
┌─────────────────────────────────────┐
│           Outer Function            │
│  ┌─────────────────────────────────┐│
│  │        Inner Function           ││
│  │  ┌─────────────────────────────┐││
│  │  │     Closure Scope           │││
│  │  │  - Access to outer vars     │││
│  │  │  - Access to inner vars     │││
│  │  │  - Persistent state         │││
│  │  └─────────────────────────────┘││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


### **Closure Examples in React Native**

#### **1. Event Handlers with Closures**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// ❌ Common mistake - closure capturing wrong value
const BadExample = () => {
  const [items, setItems] = useState([]);
  
  const addItem = (item) => {
    // This closure captures the initial empty array
    setItems(prevItems => [...prevItems, item]);
  };
  
  return (
    <View>
      {items.map((item, index) => (
        <TouchableOpacity 
          key={index}
          onPress={() => addItem(`Item ${index}`)}
        >
          <Text>Add Item {index}</Text>
        </TouchableOpacity>
      ))}
    </View>
  );
};

// ✅ Correct approach - using functional updates
const GoodExample = () => {
  const [items, setItems] = useState([]);
  
  const addItem = (item) => {
    // This closure properly updates state
    setItems(prevItems => [...prevItems, item]);
  };
  
  return (
    <View>
      {items.map((item, index) => (
        <TouchableOpacity 
          key={index}
          onPress={() => addItem(`Item ${index}`)}
        >
          <Text>Add Item {index}</Text>
        </TouchableOpacity>
      ))}
    </View>
  );
};
```


#### **2. API Calls with Closures**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// ✅ Proper closure usage for API calls
const useApiCall = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  
  const fetchData = useCallback(async (url) => {
    setLoading(true);
    try {
      const response = await fetch(url);
      const result = await response.json();
      setData(result);
    } catch (error) {
      console.error('API call failed:', error);
    } finally {
      setLoading(false);
    }
  }, []); // Empty dependency array - closure captures current state
  
  return { data, loading, fetchData };
};
```


---

## ⚡ **Event Loop & Asynchronous JavaScript**

### **Event Loop in React Native**

React Native uses the same event loop as web JavaScript, but with some mobile-specific considerations:


```
┌─────────────────────────────────────┐
│           Call Stack                │
│  ┌─────────────────────────────────┐│
│  │        Current Function         ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
           ↑                    ↓
┌─────────────────────────────────────┐
│           Event Loop                │
│  ┌─────────────────────────────────┐│
│  │     Check Call Stack            ││
│  │     Move from Queue             ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
           ↑                    ↓
┌─────────────────────────────────────┐
│        Task Queue                   │
│  ┌─────────────────────────────────┐│
│  │  setTimeout, setInterval        ││
│  │  Network requests               ││
│  │  User interactions              ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


### **Asynchronous Patterns in React Native**

#### **1. Promises vs Callbacks**


```javascript
// ❌ Callback hell
const fetchUserData = (userId, callback) => {
  fetch(`/api/users/${userId}`, (userError, userData) => {
    if (userError) {
      callback(userError, null);
      return;
    }
    
    fetch(`/api/posts/${userId}`, (postsError, postsData) => {
      if (postsError) {
        callback(postsError, null);
        return;
      }
      
      fetch(`/api/comments/${userId}`, (commentsError, commentsData) => {
        if (commentsError) {
          callback(commentsError, null);
          return;
        }
        
        callback(null, {
          user: userData,
          posts: postsData,
          comments: commentsData
        });
      });
    });
  });
};

// ✅ Promise-based approach
const fetchUserData = async (userId) => {
  try {
    const [userData, postsData, commentsData] = await Promise.all([
      fetch(`/api/users/${userId}`),
      fetch(`/api/posts/${userId}`),
      fetch(`/api/comments/${userId}`)
    ]);
    
    return {
      user: await userData.json(),
      posts: await postsData.json(),
      comments: await commentsData.json()
    };
  } catch (error) {
    console.error('Failed to fetch user data:', error);
    throw error;
  }
};
```


#### **2. Async/Await in React Native Components**


```javascript
// ✅ Proper async/await usage in React Native
const UserProfile = ({ userId }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    const loadUser = async () => {
      try {
        setLoading(true);
        setError(null);
        
        const userData = await fetchUserData(userId);
        setUser(userData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    
    loadUser();
  }, [userId]);
  
  if (loading) return <ActivityIndicator size="large" />;
  if (error) return <Text>Error: {error}</Text>;
  if (!user) return <Text>No user found</Text>;
  
  return (
    <View>
      <Text>{user.name}</Text>
      <Text>{user.email}</Text>
    </View>
  );
};
```


---

## 🔄 **Async/Await Patterns**

### **Error Handling Patterns**



```javascript
// ✅ Comprehensive error handling
const apiCall = async (url, options = {}) => {
  try {
    const response = await fetch(url, {
      timeout: 10000,
      ...options
    });
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    
    const data = await response.json();
    return { success: true, data };
  } catch (error) {
    if (error.name === 'AbortError') {
      return { success: false, error: 'Request was cancelled' };
    }
    
    if (error.name === 'TypeError' && error.message.includes('fetch')) {
      return { success: false, error: 'Network error' };
    }
    
    return { success: false, error: error.message };
  }
};

// Usage in component
const MyComponent = () => {
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  
  const handleApiCall = async () => {
    const result = await apiCall('/api/data');
    
    if (result.success) {
      setData(result.data);
      setError(null);
    } else {
      setError(result.error);
      setData(null);
    }
  };
  
  return (
    <View>
      <TouchableOpacity onPress={handleApiCall}>
        <Text>Fetch Data</Text>
      </TouchableOpacity>
      {error && <Text style={{#123;{{#123;color: 'red'}}#125;}}#125;>{error}</Text>}
      {data && <Text>{JSON.stringify(data)}</Text>}
    </View>
  );
};
```


### **Cancellation Patterns**


```javascript
// ✅ Request cancellation with AbortController
const useApiCall = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  const makeRequest = useCallback(async (url) => {
    const controller = new AbortController();
    
    try {
      setLoading(true);
      setError(null);
      
      const response = await fetch(url, {
        signal: controller.signal
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }
      
      const result = await response.json();
      setData(result);
    } catch (err) {
      if (err.name !== 'AbortError') {
        setError(err.message);
      }
    } finally {
      setLoading(false);
    }
    
    return () => controller.abort();
  }, []);
  
  return { data, loading, error, makeRequest };
};
```


---

## 🆕 **Modern JavaScript Features**

### **Destructuring in React Native**



```javascript
// ✅ Object destructuring
const UserCard = ({ user, onPress, style }) => {
  const { name, email, avatar, isOnline } = user;
  
  return (
    <TouchableOpacity style={style} onPress={onPress}>
      <Image source={{#123;{{#123; uri: avatar }}#125;}}#125; />
      <Text>{name}</Text>
      <Text>{email}</Text>
      {isOnline && <View style={styles.onlineIndicator} />}
    </TouchableOpacity>
  );
};

// ✅ Array destructuring
const [first, second, ...rest] = items;
const [loading, setLoading] = useState(false);
const [data, setData] = useState(null);
```


### **Template Literals**


```javascript
// ✅ Dynamic styling with template literals
const getStyle = (isActive, theme) => ({
  backgroundColor: isActive ? theme.primary : theme.secondary,
  padding: `${theme.spacing.small}px`,
  borderRadius: `${theme.borderRadius}px`,
  shadowColor: theme.shadow,
  shadowOffset: {
    width: 0,
    height: `${theme.shadowOffset}px`
  }
});

// ✅ Dynamic API URLs
const buildApiUrl = (endpoint, params) => {
  const baseUrl = 'https://api.example.com';
  const queryString = Object.entries(params)
    .map(([key, value]) => `${key}=${encodeURIComponent(value)}`)
    .join('&');
  
  return `${baseUrl}/${endpoint}?${queryString}`;
};
```


### **Arrow Functions & Higher-Order Functions**


```javascript
// ✅ Arrow functions in React Native
const MyComponent = () => {
  const handlePress = (item) => {
    console.log('Pressed:', item);
  };
  
  const renderItem = ({ item }) => (
    <TouchableOpacity onPress={() => handlePress(item)}>
      <Text>{item.title}</Text>
    </TouchableOpacity>
  );
  
  return (
    <FlatList
      data={items}
      renderItem={renderItem}
      keyExtractor={(item) => item.id.toString()}
    />
  );
};

// ✅ Higher-order functions
const withLoading = (WrappedComponent) => {
  return (props) => {
    const [loading, setLoading] = useState(false);
    
    return (
      <View>
        {loading && <ActivityIndicator />}
        <WrappedComponent {...props} setLoading={setLoading} />
      </View>
    );
  };
};
```


---

## 🧠 **Memory Management**

### **Memory Leaks in React Native**


```javascript
// ❌ Memory leak - not cleaning up subscriptions
const BadComponent = () => {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    const subscription = someObservable.subscribe(setData);
    // Missing cleanup!
  }, []);
  
  return <Text>{data}</Text>;
};

// ✅ Proper cleanup
const GoodComponent = () => {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    const subscription = someObservable.subscribe(setData);
    
    return () => {
      subscription.unsubscribe();
    };
  }, []);
  
  return <Text>{data}</Text>;
};
```


### **Event Listener Cleanup**


```javascript
// ✅ Proper event listener cleanup
const useDeviceOrientation = () => {
  const [orientation, setOrientation] = useState('portrait');
  
  useEffect(() => {
    const handleOrientationChange = (event) => {
      setOrientation(event.orientation);
    };
    
    Dimensions.addEventListener('change', handleOrientationChange);
    
    return () => {
      Dimensions.removeEventListener('change', handleOrientationChange);
    };
  }, []);
  
  return orientation;
};
```


---

## ⚠️ **Common Pitfalls**

### **1. Stale Closures**


```javascript
// ❌ Stale closure problem
const BadExample = () => {
  const [count, setCount] = useState(0);
  
  const increment = () => {
    setTimeout(() => {
      setCount(count + 1); // This will always use the initial count value
    }, 1000);
  };
  
  return (
    <TouchableOpacity onPress={increment}>
      <Text>Count: {count}</Text>
    </TouchableOpacity>
  );
};

// ✅ Fix with functional updates
const GoodExample = () => {
  const [count, setCount] = useState(0);
  
  const increment = () => {
    setTimeout(() => {
      setCount(prevCount => prevCount + 1); // Always uses latest count
    }, 1000);
  };
  
  return (
    <TouchableOpacity onPress={increment}>
      <Text>Count: {count}</Text>
    </TouchableOpacity>
  );
};
```


### **2. Infinite Re-renders**


```javascript
// ❌ Infinite re-render
const BadExample = () => {
  const [data, setData] = useState([]);
  
  useEffect(() => {
    // This creates a new array on every render
    setData([...data, newItem]);
  }, [data]); // This dependency causes infinite loop
  
  return <FlatList data={data} renderItem={renderItem} />;
};

// ✅ Fix with proper dependencies
const GoodExample = () => {
  const [data, setData] = useState([]);
  
  useEffect(() => {
    setData(prevData => [...prevData, newItem]);
  }, []); // Empty dependency array
  
  return <FlatList data={data} renderItem={renderItem} />;
};
```


---

## 🎯 **Interview Questions**

### **Basic Level**

1. **What is a closure and how is it used in React Native?**
2. **Explain the difference between `let`, `const`, and `var` in React Native context.**
3. **How does the event loop work in React Native?**

### **Intermediate Level**

4. **How would you handle memory leaks in React Native components?**
5. **Explain the difference between `Promise.all()` and `Promise.allSettled()`.**
6. **What are the benefits of using async/await over callbacks?**

### **Advanced Level**

7. **How would you implement a custom hook that manages API calls with cancellation?**
8. **Explain how JavaScript's garbage collection affects React Native performance.**
9. **How would you optimize a component that makes multiple API calls?**

---

## 💡 **Best Practices**

### **1. Use Functional Updates**


```javascript
// ✅ Always use functional updates for state
const [count, setCount] = useState(0);

// Instead of: setCount(count + 1)
setCount(prevCount => prevCount + 1);
```


### **2. Proper Dependency Arrays**


```javascript
// ✅ Be explicit about dependencies
useEffect(() => {
  fetchData(userId);
}, [userId]); // Only re-run when userId changes
```


### **3. Error Boundaries**


```javascript
// ✅ Implement error boundaries with functional components
import React, { useState, useEffect } from 'react';
import { Text } from 'react-native';

const ErrorBoundary = ({ children }) => {
  const [hasError, setHasError] = useState(false);
  const [error, setError] = useState(null);
  const [errorInfo, setErrorInfo] = useState(null);
  
  useEffect(() => {
    const handleError = (error, errorInfo) => {
      setHasError(true);
      setError(error);
      setErrorInfo(errorInfo);
      console.error('Error caught by boundary:', error, errorInfo);
    };
    
    // Set up error handling
    const originalConsoleError = console.error;
    console.error = (...args) => {
      if (args[0]?.includes?.('Error')) {
        handleError(args[0], args[1]);
      }
      originalConsoleError(...args);
    };
    
    return () => {
      console.error = originalConsoleError;
    };
  }, []);
  
  if (hasError) {
    return <Text>Something went wrong.</Text>;
  }
  
  return children;
};

export default ErrorBoundary;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="../React-Native.md" class="nav-link prev">⬅️ Previous: React Native Master Index</a>
    <a href="./01-React-Essentials-for-RN.md" class="nav-link next">Next: React Essentials for RN ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
