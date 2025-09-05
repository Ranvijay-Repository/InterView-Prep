# ⚛️ **React Essentials for React Native**

> **Master the React concepts that are essential for React Native development, including hooks, context, memoization, and component lifecycle**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [React Hooks in React Native](#react-hooks-in-react-native)
- [Context API](#context-api)
- [Component Lifecycle](#component-lifecycle)
- [Memoization & Performance](#memoization--performance)
- [State Management Patterns](#state-management-patterns)
- [Error Handling](#error-handling)
- [Custom Hooks](#custom-hooks)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

React Native is built on top of React, making React knowledge fundamental to React Native development. Understanding React concepts like hooks, context, and component lifecycle is crucial for building efficient React Native applications.

### **React vs React Native Differences**

| Aspect | React | React Native |
|--------|-------|--------------|
| **DOM** | Uses DOM elements | Uses native components |
| **Styling** | CSS | StyleSheet API |
| **Navigation** | React Router | React Navigation |
| **Platform** | Web browsers | Mobile devices |

---

## 🪝 **React Hooks in React Native**

### **Core Hooks Overview**

```
┌─────────────────────────────────────┐
│           React Hooks               │
│  ┌─────────────────────────────────┐│
│  │        State Hooks              ││
│  │  - useState                     ││
│  │  - useReducer                   ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Effect Hooks             ││
│  │  - useEffect                    ││
│  │  - useLayoutEffect              ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Context Hooks            ││
│  │  - useContext                   ││
│  │  - useMemo                      ││
│  │  - useCallback                  ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

### **useState Hook**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// ✅ Basic useState usage
const Counter = () => {
  const [count, setCount] = useState(0);
  const [isVisible, setIsVisible] = useState(true);
  
  const increment = () => setCount(prev => prev + 1);
  const decrement = () => setCount(prev => prev - 1);
  
  return (
    <View style={styles.container}>
      <Text style={styles.count}>{count}</Text>
      <View style={styles.buttonContainer}>
        <TouchableOpacity style={styles.button} onPress={increment}>
          <Text style={styles.buttonText}>+</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.button} onPress={decrement}>
          <Text style={styles.buttonText}>-</Text>
        </TouchableOpacity>
      </View>
      <TouchableOpacity onPress={() => setIsVisible(!isVisible)}>
        <Text>{isVisible ? 'Hide' : 'Show'}</Text>
      </TouchableOpacity>
    </View>
  );
};
```

### **useEffect Hook**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// ✅ useEffect for API calls
const UserProfile = ({ userId }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        setError(null);
        
        const response = await fetch(`/api/users/${userId}`);
        if (!response.ok) {
          throw new Error('Failed to fetch user');
        }
        
        const userData = await response.json();
        setUser(userData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    
    if (userId) {
      fetchUser();
    }
  }, [userId]); // Dependency array
  
  if (loading) return <ActivityIndicator size="large" />;
  if (error) return <Text style={styles.error}>Error: {error}</Text>;
  if (!user) return <Text>No user found</Text>;
  
  return (
    <View style={styles.container}>
      <Text style={styles.name}>{user.name}</Text>
      <Text style={styles.email}>{user.email}</Text>
    </View>
  );
};
```

### **useReducer Hook**

```javascript
// ✅ useReducer for complex state
const initialState = {
  items: [],
  loading: false,
  error: null,
  filter: 'all'
};

const itemsReducer = (state, action) => {
  switch (action.type) {
    case 'FETCH_START':
      return { ...state, loading: true, error: null };
    case 'FETCH_SUCCESS':
      return { ...state, loading: false, items: action.payload };
    case 'FETCH_ERROR':
      return { ...state, loading: false, error: action.payload };
    case 'SET_FILTER':
      return { ...state, filter: action.payload };
    case 'ADD_ITEM':
      return { ...state, items: [...state.items, action.payload] };
    case 'REMOVE_ITEM':
      return { 
        ...state, 
        items: state.items.filter(item => item.id !== action.payload) 
      };
    default:
      return state;
  }
};

const ItemsList = () => {
  const [state, dispatch] = useReducer(itemsReducer, initialState);
  
  const fetchItems = async () => {
    dispatch({ type: 'FETCH_START' });
    try {
      const response = await fetch('/api/items');
      const items = await response.json();
      dispatch({ type: 'FETCH_SUCCESS', payload: items });
    } catch (error) {
      dispatch({ type: 'FETCH_ERROR', payload: error.message });
    }
  };
  
  const addItem = (item) => {
    dispatch({ type: 'ADD_ITEM', payload: item });
  };
  
  const removeItem = (id) => {
    dispatch({ type: 'REMOVE_ITEM', payload: id });
  };
  
  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={fetchItems}>
        <Text>Fetch Items</Text>
      </TouchableOpacity>
      
      {state.loading && <ActivityIndicator />}
      {state.error && <Text style={styles.error}>{state.error}</Text>}
      
      <FlatList
        data={state.items}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.item}>
            <Text>{item.name}</Text>
            <TouchableOpacity onPress={() => removeItem(item.id)}>
              <Text style={styles.removeButton}>Remove</Text>
            </TouchableOpacity>
          </View>
        )}
      />
    </View>
  );
};
```

---

## 🌐 **Context API**

### **Creating Context**

```javascript
// ✅ Theme Context
const ThemeContext = createContext();

const ThemeProvider = ({ children }) => {
  const [theme, setTheme] = useState('light');
  
  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };
  
  const value = {
    theme,
    toggleTheme,
    colors: theme === 'light' ? lightColors : darkColors
  };
  
  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
};

// ✅ User Context
const UserContext = createContext();

const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  
  const login = async (credentials) => {
    try {
      setLoading(true);
      const response = await fetch('/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(credentials)
      });
      
      if (!response.ok) {
        throw new Error('Login failed');
      }
      
      const userData = await response.json();
      setUser(userData);
    } catch (error) {
      throw error;
    } finally {
      setLoading(false);
    }
  };
  
  const logout = () => {
    setUser(null);
  };
  
  const value = {
    user,
    loading,
    login,
    logout,
    isAuthenticated: !!user
  };
  
  return (
    <UserContext.Provider value={value}>
      {children}
    </UserContext.Provider>
  );
};
```

### **Using Context**

```javascript
// ✅ Custom hooks for context
const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within ThemeProvider');
  }
  return context;
};

const useUser = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within UserProvider');
  }
  return context;
};

// ✅ Using context in components
const ThemedButton = ({ title, onPress }) => {
  const { colors } = useTheme();
  
  return (
    <TouchableOpacity 
      style={[styles.button, { backgroundColor: colors.primary }]}
      onPress={onPress}
    >
      <Text style={[styles.buttonText, { color: colors.text }]}>
        {title}
      </Text>
    </TouchableOpacity>
  );
};

const UserProfile = () => {
  const { user, logout } = useUser();
  
  if (!user) {
    return <Text>Please log in</Text>;
  }
  
  return (
    <View style={styles.container}>
      <Text>Welcome, {user.name}!</Text>
      <ThemedButton title="Logout" onPress={logout} />
    </View>
  );
};
```

---

## 🔄 **Component Lifecycle**

### **Lifecycle in Functional Components**

```javascript
// ✅ Component lifecycle with hooks
const LifecycleExample = ({ userId }) => {
  const [data, setData] = useState(null);
  const [mounted, setMounted] = useState(true);
  
  // Component did mount
  useEffect(() => {
    console.log('Component mounted');
    
    // Cleanup function (component will unmount)
    return () => {
      console.log('Component will unmount');
      setMounted(false);
    };
  }, []);
  
  // Component did update
  useEffect(() => {
    console.log('Component updated');
  });
  
  // Component did update (specific dependency)
  useEffect(() => {
    if (userId) {
      fetchUserData(userId);
    }
  }, [userId]);
  
  // Cleanup on unmount
  useEffect(() => {
    const timer = setInterval(() => {
      console.log('Timer tick');
    }, 1000);
    
    return () => {
      clearInterval(timer);
    };
  }, []);
  
  return (
    <View>
      <Text>Lifecycle Example</Text>
      {data && <Text>{JSON.stringify(data)}</Text>}
    </View>
  );
};
```

### **Lifecycle Diagram**

```
┌─────────────────────────────────────┐
│        Component Lifecycle          │
│  ┌─────────────────────────────────┐│
│  │         Mounting                ││
│  │  - useState initialization      ││
│  │  - useEffect (mount)            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │         Updating                ││
│  │  - State changes                ││
│  │  - Props changes                ││
│  │  - useEffect (update)           ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │         Unmounting              ││
│  │  - Cleanup functions            ││
│  │  - Memory cleanup               ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🚀 **Memoization & Performance**

### **useMemo Hook**

```javascript
// ✅ useMemo for expensive calculations
const ExpensiveComponent = ({ items, filter }) => {
  const filteredItems = useMemo(() => {
    console.log('Filtering items...');
    return items.filter(item => 
      item.name.toLowerCase().includes(filter.toLowerCase())
    );
  }, [items, filter]); // Only recalculate when items or filter change
  
  const sortedItems = useMemo(() => {
    console.log('Sorting items...');
    return [...filteredItems].sort((a, b) => a.name.localeCompare(b.name));
  }, [filteredItems]);
  
  return (
    <FlatList
      data={sortedItems}
      keyExtractor={(item) => item.id.toString()}
      renderItem={({ item }) => (
        <View style={styles.item}>
          <Text>{item.name}</Text>
        </View>
      )}
    />
  );
};
```

### **useCallback Hook**

```javascript
// ✅ useCallback for function memoization
const ParentComponent = () => {
  const [count, setCount] = useState(0);
  const [items, setItems] = useState([]);
  
  // Memoized function - only recreates when count changes
  const handleIncrement = useCallback(() => {
    setCount(prev => prev + 1);
  }, []);
  
  // Memoized function - only recreates when items change
  const handleAddItem = useCallback((item) => {
    setItems(prev => [...prev, item]);
  }, []);
  
  return (
    <View>
      <Text>Count: {count}</Text>
      <TouchableOpacity onPress={handleIncrement}>
        <Text>Increment</Text>
      </TouchableOpacity>
      
      <ChildComponent 
        items={items} 
        onAddItem={handleAddItem} 
      />
    </View>
  );
};

const ChildComponent = React.memo(({ items, onAddItem }) => {
  console.log('ChildComponent rendered');
  
  return (
    <View>
      {items.map((item, index) => (
        <Text key={index}>{item}</Text>
      ))}
      <TouchableOpacity onPress={() => onAddItem(`Item ${items.length}`)}>
        <Text>Add Item</Text>
      </TouchableOpacity>
    </View>
  );
});
```

### **React.memo**

```javascript
// ✅ React.memo for component memoization
const ExpensiveChild = React.memo(({ data, onPress }) => {
  console.log('ExpensiveChild rendered');
  
  return (
    <TouchableOpacity onPress={onPress}>
      <Text>{data.title}</Text>
      <Text>{data.description}</Text>
    </TouchableOpacity>
  );
}, (prevProps, nextProps) => {
  // Custom comparison function
  return prevProps.data.id === nextProps.data.id;
});

const ParentComponent = () => {
  const [data, setData] = useState({ id: 1, title: 'Title', description: 'Description' });
  const [count, setCount] = useState(0);
  
  const handlePress = useCallback(() => {
    console.log('Item pressed');
  }, []);
  
  return (
    <View>
      <Text>Count: {count}</Text>
      <TouchableOpacity onPress={() => setCount(prev => prev + 1)}>
        <Text>Increment</Text>
      </TouchableOpacity>
      
      <ExpensiveChild data={data} onPress={handlePress} />
    </View>
  );
};
```

---

## 🎯 **State Management Patterns**

### **Lifting State Up**

```javascript
// ✅ Lifting state up pattern
const SearchInput = ({ value, onChangeText, placeholder }) => (
  <TextInput
    style={styles.input}
    value={value}
    onChangeText={onChangeText}
    placeholder={placeholder}
  />
);

const SearchResults = ({ results, onItemPress }) => (
  <FlatList
    data={results}
    keyExtractor={(item) => item.id.toString()}
    renderItem={({ item }) => (
      <TouchableOpacity onPress={() => onItemPress(item)}>
        <Text>{item.title}</Text>
      </TouchableOpacity>
    )}
  />
);

const SearchScreen = () => {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);
  
  const handleSearch = async (searchQuery) => {
    if (!searchQuery.trim()) return;
    
    setLoading(true);
    try {
      const response = await fetch(`/api/search?q=${encodeURIComponent(searchQuery)}`);
      const data = await response.json();
      setResults(data.results);
    } catch (error) {
      console.error('Search failed:', error);
    } finally {
      setLoading(false);
    }
  };
  
  const handleItemPress = (item) => {
    // Navigate to item detail
    console.log('Item pressed:', item);
  };
  
  return (
    <View style={styles.container}>
      <SearchInput
        value={query}
        onChangeText={setQuery}
        placeholder="Search..."
      />
      <TouchableOpacity onPress={() => handleSearch(query)}>
        <Text>Search</Text>
      </TouchableOpacity>
      
      {loading && <ActivityIndicator />}
      <SearchResults results={results} onItemPress={handleItemPress} />
    </View>
  );
};
```

---

## 🚨 **Error Handling**

### **Error Boundaries**

```javascript
// ✅ Error boundary for React Native with functional components
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const ErrorBoundary = ({ children, onError }) => {
  const [hasError, setHasError] = useState(false);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    const handleError = (error, errorInfo) => {
      setHasError(true);
      setError(error);
      console.error('Error caught by boundary:', error, errorInfo);
      
      // Log to crash reporting service
      if (onError) {
        onError(error, errorInfo);
      }
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
  }, [onError]);
  
  const handleRetry = () => {
    setHasError(false);
    setError(null);
  };
  
  if (hasError) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorTitle}>Something went wrong</Text>
        <Text style={styles.errorMessage}>
          {error?.message || 'An unexpected error occurred'}
        </Text>
        <TouchableOpacity 
          style={styles.retryButton}
          onPress={handleRetry}
        >
          <Text style={styles.retryButtonText}>Try Again</Text>
        </TouchableOpacity>
      </View>
    );
  }
  
  return children;
};

// Usage
const App = () => (
  <ErrorBoundary onError={(error, errorInfo) => {
    // Log to crash reporting service
    console.error('App error:', error, errorInfo);
  }}>
    <MainApp />
  </ErrorBoundary>
);
```

---

## 🪝 **Custom Hooks**

### **API Hook**

```javascript
// ✅ Custom hook for API calls
const useApi = (url, options = {}) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  const execute = useCallback(async (customUrl = url, customOptions = options) => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch(customUrl, customOptions);
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const result = await response.json();
      setData(result);
      return result;
    } catch (err) {
      setError(err.message);
      throw err;
    } finally {
      setLoading(false);
    }
  }, [url, options]);
  
  return { data, loading, error, execute };
};

// Usage
const UserProfile = ({ userId }) => {
  const { data: user, loading, error, execute } = useApi(`/api/users/${userId}`);
  
  useEffect(() => {
    if (userId) {
      execute();
    }
  }, [userId, execute]);
  
  if (loading) return <ActivityIndicator />;
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

### **Local Storage Hook**

```javascript
// ✅ Custom hook for local storage
const useAsyncStorage = (key, initialValue) => {
  const [storedValue, setStoredValue] = useState(initialValue);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    const loadStoredValue = async () => {
      try {
        const item = await AsyncStorage.getItem(key);
        if (item !== null) {
          setStoredValue(JSON.parse(item));
        }
      } catch (error) {
        console.error('Error loading from AsyncStorage:', error);
      } finally {
        setLoading(false);
      }
    };
    
    loadStoredValue();
  }, [key]);
  
  const setValue = useCallback(async (value) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      await AsyncStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error('Error saving to AsyncStorage:', error);
    }
  }, [key, storedValue]);
  
  return [storedValue, setValue, loading];
};

// Usage
const SettingsScreen = () => {
  const [theme, setTheme, loading] = useAsyncStorage('theme', 'light');
  const [notifications, setNotifications, notificationsLoading] = useAsyncStorage('notifications', true);
  
  if (loading || notificationsLoading) {
    return <ActivityIndicator />;
  }
  
  return (
    <View style={styles.container}>
      <Text>Theme: {theme}</Text>
      <TouchableOpacity onPress={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
        <Text>Toggle Theme</Text>
      </TouchableOpacity>
      
      <Text>Notifications: {notifications ? 'On' : 'Off'}</Text>
      <TouchableOpacity onPress={() => setNotifications(!notifications)}>
        <Text>Toggle Notifications</Text>
      </TouchableOpacity>
    </View>
  );
};
```

---

## 🎯 **Interview Questions**

### **Basic Level**

1. **What is the difference between useState and useReducer?**
2. **How do you handle side effects in functional components?**
3. **What is the purpose of the dependency array in useEffect?**

### **Intermediate Level**

4. **How would you optimize a component that re-renders frequently?**
5. **Explain the difference between useMemo and useCallback.**
6. **How do you handle errors in React Native components?**

### **Advanced Level**

7. **How would you implement a custom hook that manages form state?**
8. **Explain the benefits and drawbacks of using Context API.**
9. **How would you prevent memory leaks in React Native components?**

---

## 💡 **Best Practices**

### **1. Use Functional Updates**

```javascript
// ✅ Always use functional updates
const [count, setCount] = useState(0);

// Instead of: setCount(count + 1)
setCount(prev => prev + 1);
```

### **2. Proper Dependency Arrays**

```javascript
// ✅ Be explicit about dependencies
useEffect(() => {
  fetchData(userId);
}, [userId]); // Only re-run when userId changes
```

### **3. Memoization Strategy**

```javascript
// ✅ Memoize expensive calculations
const expensiveValue = useMemo(() => {
  return heavyCalculation(data);
}, [data]);

// ✅ Memoize functions passed to children
const handlePress = useCallback(() => {
  onItemPress(item);
}, [item, onItemPress]);
```

### **4. Error Boundaries**

```javascript
// ✅ Always wrap components in error boundaries
<ErrorBoundary>
  <MyComponent />
</ErrorBoundary>
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./00-JavaScript-Essentials-for-RN.md" class="nav-link prev">⬅️ Previous: JavaScript Essentials for RN</a>
    <a href="./02-TypeScript-Essentials-for-RN.md" class="nav-link next">Next: TypeScript Essentials for RN ➡️</a>
</div>

---


*Last updated: December 2024*
