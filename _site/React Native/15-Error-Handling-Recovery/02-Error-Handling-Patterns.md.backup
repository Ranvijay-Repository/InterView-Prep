# 🔧 **Error Handling Patterns in React Native**

> **Comprehensive guide to implementing robust error handling patterns, async error management, and error recovery strategies in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Error Handling Fundamentals](#error-handling-fundamentals)
- [Async Error Handling](#async-error-handling)
- [Network Error Patterns](#network-error-patterns)
- [State Management Error Handling](#state-management-error-handling)
- [Error Recovery Patterns](#error-recovery-patterns)
- [Error Monitoring and Analytics](#error-monitoring-and-analytics)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Error Handling Fundamentals**

Error handling in React Native requires a multi-layered approach to ensure robust applications that gracefully handle failures.

### **Error Types in React Native**


{% raw %}
```javascript
// 1. JavaScript Errors
const handleJSError = () => {
  try {
    // Code that might throw
    const result = riskyOperation();
    return result;
  } catch (error) {
    console.error('JavaScript error:', error);
    // Handle error appropriately
  }
};

// 2. Network Errors
const handleNetworkError = async () => {
  try {
    const response = await fetch('/api/data');
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    if (error.name === 'TypeError' && error.message.includes('fetch')) {
      console.error('Network error:', error);
      // Handle network connectivity issues
    } else {
      console.error('API error:', error);
      // Handle API errors
    }
  }
};

// 3. Native Module Errors
const handleNativeError = async () => {
  try {
    const result = await NativeModule.performOperation();
    return result;
  } catch (error) {
    console.error('Native module error:', error);
    // Handle native module errors
  }
};
```
{% endraw %}


### **Error Classification System**


{% raw %}
```javascript
class ErrorClassifier {
  static classify(error) {
    if (error instanceof TypeError && error.message.includes('fetch')) {
      return { type: 'NETWORK', severity: 'HIGH', recoverable: true };
    }
    
    if (error instanceof ReferenceError) {
      return { type: 'JAVASCRIPT', severity: 'HIGH', recoverable: false };
    }
    
    if (error.message.includes('timeout')) {
      return { type: 'TIMEOUT', severity: 'MEDIUM', recoverable: true };
    }
    
    if (error.message.includes('permission')) {
      return { type: 'PERMISSION', severity: 'MEDIUM', recoverable: true };
    }
    
    return { type: 'UNKNOWN', severity: 'MEDIUM', recoverable: true };
  }
}

// Usage
const handleError = (error) => {
  const classification = ErrorClassifier.classify(error);
  
  switch (classification.type) {
    case 'NETWORK':
      return handleNetworkError(error);
    case 'PERMISSION':
      return handlePermissionError(error);
    default:
      return handleGenericError(error);
  }
};
```
{% endraw %}


---

## ⚡ **Async Error Handling**

### **Promise-Based Error Handling**


{% raw %}
```javascript
import { useState, useEffect, useCallback } from 'react';

const useAsyncOperation = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const execute = useCallback(async (operation) => {
    setLoading(true);
    setError(null);
    
    try {
      const result = await operation();
      setData(result);
      return result;
    } catch (err) {
      setError(err);
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  const reset = useCallback(() => {
    setData(null);
    setError(null);
    setLoading(false);
  }, []);

  return { data, loading, error, execute, reset };
};

// Usage
const DataComponent = () => {
  const { data, loading, error, execute, reset } = useAsyncOperation();

  const fetchData = async () => {
    try {
      await execute(async () => {
        const response = await fetch('/api/data');
        if (!response.ok) {
          throw new Error(`HTTP ${response.status}`);
        }
        return await response.json();
      });
    } catch (err) {
      console.error('Failed to fetch data:', err);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  if (loading) return <Text>Loading...</Text>;
  if (error) return <Text>Error: {error.message}</Text>;
  if (data) return <Text>Data: {JSON.stringify(data)}</Text>;
  
  return null;
};
```
{% endraw %}


### **Async Error Boundary Pattern**


{% raw %}
```javascript
import React, { useState, useEffect, useCallback } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const AsyncErrorBoundary = ({ children, onError }) => {
  const [hasError, setHasError] = useState(false);
  const [error, setError] = useState(null);

  const handleAsyncError = useCallback((error) => {
    setHasError(true);
    setError(error);
    
    if (onError) {
      onError(error);
    }
  }, [onError]);

  useEffect(() => {
    const handleUnhandledRejection = (event) => {
      event.preventDefault();
      handleAsyncError(event.reason);
    };

    const handleError = (event) => {
      event.preventDefault();
      handleAsyncError(event.error);
    };

    // For React Native, we need to handle async errors differently
    const originalConsoleError = console.error;
    console.error = (...args) => {
      if (args[0] && typeof args[0] === 'object' && args[0].stack) {
        handleAsyncError(args[0]);
      }
      originalConsoleError(...args);
    };

    return () => {
      console.error = originalConsoleError;
    };
  }, [handleAsyncError]);

  const handleRetry = () => {
    setHasError(false);
    setError(null);
  };

  if (hasError) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorTitle}>Async Error Occurred</Text>
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

const styles = StyleSheet.create({
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#f8f9fa',
  },
  errorTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#dc3545',
    marginBottom: 10,
  },
  errorMessage: {
    fontSize: 16,
    color: '#6c757d',
    textAlign: 'center',
    marginBottom: 20,
  },
  retryButton: {
    backgroundColor: '#007bff',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 5,
  },
  retryButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default AsyncErrorBoundary;
```
{% endraw %}


---

## 🌐 **Network Error Patterns**

### **HTTP Client with Error Handling**


{% raw %}
```javascript
class HttpClient {
  constructor(baseURL, options = {}) {
    this.baseURL = baseURL;
    this.timeout = options.timeout || 10000;
    this.retries = options.retries || 3;
    this.retryDelay = options.retryDelay || 1000;
  }

  async request(endpoint, options = {}) {
    const url = `${this.baseURL}${endpoint}`;
    const config = {
      timeout: this.timeout,
      ...options,
    };

    for (let attempt = 0; attempt <= this.retries; attempt++) {
      try {
        const response = await this.fetchWithTimeout(url, config);
        
        if (!response.ok) {
          throw new HttpError(response.status, response.statusText);
        }
        
        return await response.json();
      } catch (error) {
        if (attempt === this.retries) {
          throw error;
        }
        
        if (this.shouldRetry(error)) {
          await this.delay(this.retryDelay * Math.pow(2, attempt));
          continue;
        }
        
        throw error;
      }
    }
  }

  async fetchWithTimeout(url, config) {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), config.timeout);

    try {
      const response = await fetch(url, {
        ...config,
        signal: controller.signal,
      });
      clearTimeout(timeoutId);
      return response;
    } catch (error) {
      clearTimeout(timeoutId);
      if (error.name === 'AbortError') {
        throw new Error('Request timeout');
      }
      throw error;
    }
  }

  shouldRetry(error) {
    if (error instanceof HttpError) {
      return error.status >= 500 || error.status === 429;
    }
    
    if (error.message.includes('timeout')) {
      return true;
    }
    
    if (error.message.includes('network')) {
      return true;
    }
    
    return false;
  }

  delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

class HttpError extends Error {
  constructor(status, statusText) {
    super(`HTTP ${status}: ${statusText}`);
    this.status = status;
    this.statusText = statusText;
    this.name = 'HttpError';
  }
}

export { HttpClient, HttpError };
```
{% endraw %}


### **Network Status Monitoring**


{% raw %}
```javascript
import NetInfo from '@react-native-netinfo/netinfo';
import { useState, useEffect } from 'react';

const useNetworkStatus = () => {
  const [isConnected, setIsConnected] = useState(true);
  const [connectionType, setConnectionType] = useState('unknown');

  useEffect(() => {
    const unsubscribe = NetInfo.addEventListener(state => {
      setIsConnected(state.isConnected);
      setConnectionType(state.type);
    });

    return unsubscribe;
  }, []);

  return { isConnected, connectionType };
};

const NetworkAwareComponent = () => {
  const { isConnected, connectionType } = useNetworkStatus();
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);

  const fetchData = async () => {
    if (!isConnected) {
      setError(new Error('No internet connection'));
      return;
    }

    try {
      const response = await fetch('/api/data');
      const result = await response.json();
      setData(result);
      setError(null);
    } catch (err) {
      setError(err);
    }
  };

  useEffect(() => {
    if (isConnected) {
      fetchData();
    }
  }, [isConnected]);

  if (!isConnected) {
    return (
      <View>
        <Text>No internet connection</Text>
        <Text>Connection type: {connectionType}</Text>
      </View>
    );
  }

  if (error) {
    return (
      <View>
        <Text>Error: {error.message}</Text>
        <TouchableOpacity onPress={fetchData}>
          <Text>Retry</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View>
      <Text>Data loaded successfully</Text>
      <Text>Connection: {connectionType}</Text>
    </View>
  );
};
```
{% endraw %}


---

## 🔄 **State Management Error Handling**

### **Redux Error Handling**


{% raw %}
```javascript
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

// Async thunk with error handling
export const fetchUserData = createAsyncThunk(
  'user/fetchData',
  async (userId, { rejectWithValue }) => {
    try {
      const response = await fetch(`/api/users/${userId}`);
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      return rejectWithValue({
        message: error.message,
        code: error.code || 'UNKNOWN_ERROR',
        timestamp: new Date().toISOString(),
      });
    }
  }
);

const userSlice = createSlice({
  name: 'user',
  initialState: {
    data: null,
    loading: false,
    error: null,
  },
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
    resetUser: (state) => {
      state.data = null;
      state.error = null;
      state.loading = false;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchUserData.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchUserData.fulfilled, (state, action) => {
        state.loading = false;
        state.data = action.payload;
        state.error = null;
      })
      .addCase(fetchUserData.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload;
      });
  },
});

export const { clearError, resetUser } = userSlice.actions;
export default userSlice.reducer;
```
{% endraw %}


### **Context API Error Handling**


{% raw %}
```javascript
import React, { createContext, useContext, useReducer, useCallback } from 'react';

const ErrorContext = createContext();

const errorReducer = (state, action) => {
  switch (action.type) {
    case 'SET_ERROR':
      return {
        ...state,
        error: action.payload,
        hasError: true,
      };
    case 'CLEAR_ERROR':
      return {
        ...state,
        error: null,
        hasError: false,
      };
    case 'ADD_ERROR_LOG':
      return {
        ...state,
        errorLogs: [...state.errorLogs, action.payload],
      };
    default:
      return state;
  }
};

const ErrorProvider = ({ children }) => {
  const [state, dispatch] = useReducer(errorReducer, {
    error: null,
    hasError: false,
    errorLogs: [],
  });

  const setError = useCallback((error) => {
    const errorData = {
      message: error.message || error,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      id: Date.now(),
    };

    dispatch({ type: 'SET_ERROR', payload: errorData });
    dispatch({ type: 'ADD_ERROR_LOG', payload: errorData });
  }, []);

  const clearError = useCallback(() => {
    dispatch({ type: 'CLEAR_ERROR' });
  }, []);

  const value = {
    ...state,
    setError,
    clearError,
  };

  return (
    <ErrorContext.Provider value={value}>
      {children}
    </ErrorContext.Provider>
  );
};

const useError = () => {
  const context = useContext(ErrorContext);
  if (!context) {
    throw new Error('useError must be used within an ErrorProvider');
  }
  return context;
};

export { ErrorProvider, useError };
```
{% endraw %}


---

## 🔄 **Error Recovery Patterns**

### **Retry with Exponential Backoff**


{% raw %}
```javascript
const useRetry = (maxRetries = 3, baseDelay = 1000) => {
  const [retryCount, setRetryCount] = useState(0);
  const [isRetrying, setIsRetrying] = useState(false);

  const retry = useCallback(async (operation) => {
    if (retryCount >= maxRetries) {
      throw new Error('Max retries exceeded');
    }

    setIsRetrying(true);
    
    try {
      const result = await operation();
      setRetryCount(0);
      setIsRetrying(false);
      return result;
    } catch (error) {
      const delay = baseDelay * Math.pow(2, retryCount);
      setRetryCount(prev => prev + 1);
      
      await new Promise(resolve => setTimeout(resolve, delay));
      setIsRetrying(false);
      
      if (retryCount >= maxRetries - 1) {
        throw error;
      }
      
      return retry(operation);
    }
  }, [retryCount, maxRetries, baseDelay]);

  const reset = useCallback(() => {
    setRetryCount(0);
    setIsRetrying(false);
  }, []);

  return { retry, reset, retryCount, isRetrying };
};
```
{% endraw %}


### **Circuit Breaker Pattern**


{% raw %}
```javascript
class CircuitBreaker {
  constructor(threshold = 5, timeout = 60000) {
    this.threshold = threshold;
    this.timeout = timeout;
    this.failureCount = 0;
    this.lastFailureTime = null;
    this.state = 'CLOSED'; // CLOSED, OPEN, HALF_OPEN
  }

  async execute(operation) {
    if (this.state === 'OPEN') {
      if (Date.now() - this.lastFailureTime > this.timeout) {
        this.state = 'HALF_OPEN';
      } else {
        throw new Error('Circuit breaker is OPEN');
      }
    }

    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }

  onSuccess() {
    this.failureCount = 0;
    this.state = 'CLOSED';
  }

  onFailure() {
    this.failureCount++;
    this.lastFailureTime = Date.now();
    
    if (this.failureCount >= this.threshold) {
      this.state = 'OPEN';
    }
  }

  getState() {
    return {
      state: this.state,
      failureCount: this.failureCount,
      lastFailureTime: this.lastFailureTime,
    };
  }
}

// Usage
const circuitBreaker = new CircuitBreaker(3, 30000);

const fetchData = async () => {
  try {
    return await circuitBreaker.execute(async () => {
      const response = await fetch('/api/data');
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }
      return await response.json();
    });
  } catch (error) {
    console.error('Circuit breaker error:', error);
    throw error;
  }
};
```
{% endraw %}


---

## 📊 **Error Monitoring and Analytics**

### **Error Analytics Service**


{% raw %}
```javascript
class ErrorAnalytics {
  constructor() {
    this.errors = [];
    this.maxErrors = 1000;
  }

  track(error, context = {}) {
    const errorData = {
      id: Date.now(),
      message: error.message || error,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      context,
      userAgent: navigator.userAgent,
      url: window.location.href,
      severity: this.calculateSeverity(error),
    };

    this.errors.push(errorData);
    
    // Keep only recent errors
    if (this.errors.length > this.maxErrors) {
      this.errors = this.errors.slice(-this.maxErrors);
    }

    // Send to analytics service
    this.sendToAnalytics(errorData);
    
    // Log to console in development
    if (__DEV__) {
      console.error('Error tracked:', errorData);
    }
  }

  calculateSeverity(error) {
    if (error.message.includes('network') || error.message.includes('timeout')) {
      return 'HIGH';
    }
    
    if (error.message.includes('permission')) {
      return 'MEDIUM';
    }
    
    if (error.message.includes('validation')) {
      return 'LOW';
    }
    
    return 'MEDIUM';
  }

  async sendToAnalytics(errorData) {
    try {
      await fetch('/api/analytics/errors', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(errorData),
      });
    } catch (err) {
      console.error('Failed to send error to analytics:', err);
    }
  }

  getErrorStats() {
    const stats = {
      total: this.errors.length,
      bySeverity: {},
      byType: {},
      recent: this.errors.slice(-10),
    };

    this.errors.forEach(error => {
      stats.bySeverity[error.severity] = (stats.bySeverity[error.severity] || 0) + 1;
      
      const type = this.getErrorType(error);
      stats.byType[type] = (stats.byType[type] || 0) + 1;
    });

    return stats;
  }

  getErrorType(error) {
    if (error.message.includes('network')) return 'NETWORK';
    if (error.message.includes('timeout')) return 'TIMEOUT';
    if (error.message.includes('permission')) return 'PERMISSION';
    if (error.message.includes('validation')) return 'VALIDATION';
    return 'UNKNOWN';
  }
}

export const errorAnalytics = new ErrorAnalytics();
```
{% endraw %}


### **Error Monitoring Hook**


{% raw %}
```javascript
import { useEffect, useCallback } from 'react';
import { errorAnalytics } from '../services/ErrorAnalytics';

const useErrorMonitoring = (componentName) => {
  const trackError = useCallback((error, context = {}) => {
    errorAnalytics.track(error, {
      component: componentName,
      ...context,
    });
  }, [componentName]);

  useEffect(() => {
    const handleError = (error) => {
      trackError(error, { type: 'javascript' });
    };

    const handleUnhandledRejection = (event) => {
      trackError(event.reason, { type: 'unhandledRejection' });
    };

    window.addEventListener('error', handleError);
    window.addEventListener('unhandledrejection', handleUnhandledRejection);

    return () => {
      window.removeEventListener('error', handleError);
      window.removeEventListener('unhandledrejection', handleUnhandledRejection);
    };
  }, [trackError]);

  return { trackError };
};

export default useErrorMonitoring;
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Error Handling Strategy**


{% raw %}
```javascript
// ✅ Good: Comprehensive error handling
const handleApiCall = async () => {
  try {
    const response = await fetch('/api/data');
    
    if (!response.ok) {
      throw new HttpError(response.status, response.statusText);
    }
    
    const data = await response.json();
    return data;
  } catch (error) {
    if (error instanceof HttpError) {
      // Handle HTTP errors
      handleHttpError(error);
    } else if (error.name === 'TypeError' && error.message.includes('fetch')) {
      // Handle network errors
      handleNetworkError(error);
    } else {
      // Handle other errors
      handleGenericError(error);
    }
    throw error;
  }
};

// ❌ Bad: Generic error handling
const handleApiCall = async () => {
  try {
    const response = await fetch('/api/data');
    return await response.json();
  } catch (error) {
    console.error('Error:', error);
    throw error;
  }
};
```
{% endraw %}


### **2. Error Recovery**


{% raw %}
```javascript
// ✅ Good: Provide recovery options
const DataComponent = () => {
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const [retryCount, setRetryCount] = useState(0);

  const fetchData = async () => {
    try {
      const result = await apiCall();
      setData(result);
      setError(null);
      setRetryCount(0);
    } catch (err) {
      setError(err);
      
      if (retryCount < 3) {
        setTimeout(() => {
          setRetryCount(prev => prev + 1);
          fetchData();
        }, 1000 * Math.pow(2, retryCount));
      }
    }
  };

  return (
    <View>
      {error && (
        <View>
          <Text>Error: {error.message}</Text>
          <TouchableOpacity onPress={fetchData}>
            <Text>Retry</Text>
          </TouchableOpacity>
        </View>
      )}
      {data && <Text>Data loaded</Text>}
    </View>
  );
};

// ❌ Bad: No recovery options
const DataComponent = () => {
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);

  const fetchData = async () => {
    try {
      const result = await apiCall();
      setData(result);
    } catch (err) {
      setError(err);
    }
  };

  return (
    <View>
      {error && <Text>Error: {error.message}</Text>}
      {data && <Text>Data loaded</Text>}
    </View>
  );
};
```
{% endraw %}


### **3. Error Logging**


{% raw %}
```javascript
// ✅ Good: Structured error logging
const logError = (error, context) => {
  const errorData = {
    message: error.message,
    stack: error.stack,
    timestamp: new Date().toISOString(),
    context,
    userAgent: navigator.userAgent,
    url: window.location.href,
  };

  // Log to console in development
  if (__DEV__) {
    console.error('Error:', errorData);
  }

  // Send to monitoring service
  sendToMonitoringService(errorData);
};

// ❌ Bad: Basic error logging
const logError = (error) => {
  console.error('Error:', error);
};
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. How would you handle errors in a React Native app?**

**Answer:**
I would implement a multi-layered error handling strategy:

1. **Error Boundaries** for catching render errors
2. **Async error handling** for promises and async operations
3. **Network error handling** with retry mechanisms
4. **Error monitoring** and analytics
5. **User-friendly error messages** and recovery options

### **2. How do you handle network errors in React Native?**

**Answer:**

{% raw %}
```javascript
const handleNetworkError = async (operation) => {
  try {
    return await operation();
  } catch (error) {
    if (error.name === 'TypeError' && error.message.includes('fetch')) {
      // Network connectivity issue
      throw new NetworkError('No internet connection');
    } else if (error.message.includes('timeout')) {
      // Request timeout
      throw new TimeoutError('Request timed out');
    } else {
      // Other network errors
      throw new NetworkError(error.message);
    }
  }
};
```
{% endraw %}


### **3. How would you implement retry logic for failed API calls?**

**Answer:**

{% raw %}
```javascript
const retryWithBackoff = async (operation, maxRetries = 3) => {
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      if (attempt === maxRetries - 1) {
        throw error;
      }
      
      const delay = 1000 * Math.pow(2, attempt);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
};
```
{% endraw %}


### **4. How do you handle errors in Redux?**

**Answer:**

{% raw %}
```javascript
const userSlice = createSlice({
  name: 'user',
  initialState: {
    data: null,
    loading: false,
    error: null,
  },
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchUser.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchUser.fulfilled, (state, action) => {
        state.loading = false;
        state.data = action.payload;
      })
      .addCase(fetchUser.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload;
      });
  },
});
```
{% endraw %}


### **5. How would you implement error monitoring in a production app?**

**Answer:**

{% raw %}
```javascript
class ErrorMonitor {
  constructor() {
    this.errors = [];
    this.maxErrors = 1000;
  }

  track(error, context) {
    const errorData = {
      message: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      context,
      severity: this.calculateSeverity(error),
    };

    this.errors.push(errorData);
    this.sendToMonitoringService(errorData);
  }

  calculateSeverity(error) {
    if (error.message.includes('network')) return 'HIGH';
    if (error.message.includes('permission')) return 'MEDIUM';
    return 'LOW';
  }

  async sendToMonitoringService(errorData) {
    try {
      await fetch('/api/monitoring/errors', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(errorData),
      });
    } catch (err) {
      console.error('Failed to send error to monitoring service:', err);
    }
  }
}
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
  <a href="01-Error-Boundaries.md" class="nav-button">← Previous: Error Boundaries</a>
  <a href="03-Error-Recovery-Strategies.md" class="nav-button">Next: Error Recovery Strategies →</a>
</div>

*Last updated: December 2024*
