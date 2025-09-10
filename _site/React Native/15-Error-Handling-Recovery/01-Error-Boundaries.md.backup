# 🛡️ **Error Boundaries in React Native**

> **Comprehensive guide to implementing error boundaries, error handling patterns, and recovery strategies in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Understanding Error Boundaries](#understanding-error-boundaries)
- [Functional Error Boundary Implementation](#functional-error-boundary-implementation)
- [Error Boundary Patterns](#error-boundary-patterns)
- [Error Recovery Strategies](#error-recovery-strategies)
- [Error Logging and Monitoring](#error-logging-and-monitoring)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Understanding Error Boundaries**

Error boundaries are React components that catch JavaScript errors anywhere in their child component tree, log those errors, and display a fallback UI instead of the component tree that crashed.

### **Key Concepts**


```javascript
// Error boundaries catch errors in:
// - Render methods
// - Lifecycle methods
// - Constructors of the whole tree below them

// Error boundaries DON'T catch errors in:
// - Event handlers
// - Asynchronous code (setTimeout, promises)
// - Server-side rendering
// - Errors thrown in the error boundary itself
```


### **Error Boundary Lifecycle**


```mermaid
graph TD
    A[Component Renders] --> B{Error Occurs?}
    B -->|No| C[Normal Render]
    B -->|Yes| D[Error Boundary Catches]
    D --> E[getDerivedStateFromError]
    E --> F[componentDidCatch]
    F --> G[Fallback UI Rendered]
    G --> H[Error Logged]
```


---

## 🔧 **Functional Error Boundary Implementation**

### **Basic Error Boundary with Hooks**


```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const ErrorBoundary = ({ children, onError }) => {
  const [hasError, setHasError] = useState(false);
  const [error, setError] = useState(null);
  const [errorInfo, setErrorInfo] = useState(null);

  useEffect(() => {
    const handleError = (error, errorInfo) => {
      setHasError(true);
      setError(error);
      setErrorInfo(errorInfo);
      console.error('Error caught by boundary:', error, errorInfo);

      if (onError) {
        onError(error, errorInfo);
      }
    };

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
    setErrorInfo(null);
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

export default ErrorBoundary;
```


### **Advanced Error Boundary with Context**


```javascript
import React, { createContext, useContext, useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const ErrorContext = createContext();

export const useError = () => {
  const context = useContext(ErrorContext);
  if (!context) {
    throw new Error('useError must be used within an ErrorProvider');
  }
  return context;
};

const ErrorProvider = ({ children }) => {
  const [errors, setErrors] = useState([]);
  const [hasError, setHasError] = useState(false);

  const addError = (error, errorInfo) => {
    const errorData = {
      id: Date.now(),
      error: error.message || error,
      stack: error.stack || errorInfo?.componentStack,
      timestamp: new Date().toISOString(),
    };
    
    setErrors(prev => [...prev, errorData]);
    setHasError(true);
    
    // Log to external service
    console.error('Error logged:', errorData);
  };

  const clearErrors = () => {
    setErrors([]);
    setHasError(false);
  };

  const value = {
    errors,
    hasError,
    addError,
    clearErrors,
  };

  return (
    <ErrorContext.Provider value={value}>
      {children}
    </ErrorContext.Provider>
  );
};

const ErrorBoundary = ({ children, fallback: FallbackComponent }) => {
  const { addError, clearErrors } = useError();
  const [hasError, setHasError] = useState(false);

  useEffect(() => {
    const handleError = (error, errorInfo) => {
      setHasError(true);
      addError(error, errorInfo);
    };

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
  }, [addError]);

  const handleRetry = () => {
    setHasError(false);
    clearErrors();
  };

  if (hasError) {
    if (FallbackComponent) {
      return <FallbackComponent onRetry={handleRetry} />;
    }
    
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorTitle}>Something went wrong</Text>
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

export { ErrorProvider, ErrorBoundary };
```


---

## 🎨 **Error Boundary Patterns**

### **Route-Level Error Boundaries**


```javascript
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import ErrorBoundary from '../components/ErrorBoundary';

const Stack = createStackNavigator();

const AppNavigator = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen name="Home">
        {() => (
          <ErrorBoundary>
            <HomeScreen />
          </ErrorBoundary>
        )}
      </Stack.Screen>
      <Stack.Screen name="Profile">
        {() => (
          <ErrorBoundary>
            <ProfileScreen />
          </ErrorBoundary>
        )}
      </Stack.Screen>
    </Stack.Navigator>
  );
};
```


### **Feature-Level Error Boundaries**


```javascript
import React from 'react';
import ErrorBoundary from '../components/ErrorBoundary';

const FeatureWrapper = ({ children, featureName }) => {
  const handleError = (error, errorInfo) => {
    // Log feature-specific errors
    console.error(`Error in ${featureName}:`, error, errorInfo);
    
    // Send to analytics
    analytics.track('Feature Error', {
      feature: featureName,
      error: error.message,
      stack: error.stack,
    });
  };

  return (
    <ErrorBoundary onError={handleError}>
      {children}
    </ErrorBoundary>
  );
};

// Usage
const App = () => {
  return (
    <View>
      <FeatureWrapper featureName="UserProfile">
        <UserProfile />
      </FeatureWrapper>
      
      <FeatureWrapper featureName="ProductList">
        <ProductList />
      </FeatureWrapper>
    </View>
  );
};
```


### **Async Error Boundary**


```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const AsyncErrorBoundary = ({ children, onAsyncError }) => {
  const [hasError, setHasError] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const handleUnhandledRejection = (event) => {
      setHasError(true);
      setError(event.reason);
      
      if (onAsyncError) {
        onAsyncError(event.reason);
      }
    };

    const handleError = (event) => {
      setHasError(true);
      setError(event.error);
      
      if (onAsyncError) {
        onAsyncError(event.error);
      }
    };

    window.addEventListener('unhandledrejection', handleUnhandledRejection);
    window.addEventListener('error', handleError);

    return () => {
      window.removeEventListener('unhandledrejection', handleUnhandledRejection);
      window.removeEventListener('error', handleError);
    };
  }, [onAsyncError]);

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
```


---

## 🔄 **Error Recovery Strategies**

### **Automatic Retry with Exponential Backoff**


```javascript
import React, { useState, useEffect, useCallback } from 'react';

const useErrorRecovery = (maxRetries = 3, baseDelay = 1000) => {
  const [retryCount, setRetryCount] = useState(0);
  const [isRetrying, setIsRetrying] = useState(false);

  const retry = useCallback(async (operation) => {
    if (retryCount >= maxRetries) {
      console.error('Max retries reached');
      return false;
    }

    setIsRetrying(true);
    
    try {
      await operation();
      setRetryCount(0);
      setIsRetrying(false);
      return true;
    } catch (error) {
      const delay = baseDelay * Math.pow(2, retryCount);
      setRetryCount(prev => prev + 1);
      
      setTimeout(() => {
        setIsRetrying(false);
      }, delay);
      
      return false;
    }
  }, [retryCount, maxRetries, baseDelay]);

  const reset = useCallback(() => {
    setRetryCount(0);
    setIsRetrying(false);
  }, []);

  return { retry, reset, retryCount, isRetrying };
};

// Usage in component
const DataComponent = () => {
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const { retry, reset, retryCount, isRetrying } = useErrorRecovery();

  const fetchData = async () => {
    try {
      const response = await fetch('/api/data');
      const result = await response.json();
      setData(result);
      setError(null);
      reset();
    } catch (err) {
      setError(err);
      const success = await retry(fetchData);
      if (!success) {
        console.error('Failed to fetch data after retries');
      }
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  if (error && !isRetrying) {
    return (
      <View>
        <Text>Error: {error.message}</Text>
        <Text>Retry attempts: {retryCount}</Text>
      </View>
    );
  }

  return (
    <View>
      {isRetrying && <Text>Retrying... ({retryCount})</Text>}
      {data && <Text>Data loaded successfully</Text>}
    </View>
  );
};
```


### **Graceful Degradation**


```javascript
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet } from 'react-native';

const GracefulDegradation = () => {
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const [fallbackMode, setFallbackMode] = useState(false);

  useEffect(() => {
    const loadData = async () => {
      try {
        // Try to load full data
        const response = await fetch('/api/full-data');
        const result = await response.json();
        setData(result);
      } catch (err) {
        console.warn('Full data failed, trying fallback');
        
        try {
          // Try to load minimal data
          const response = await fetch('/api/minimal-data');
          const result = await response.json();
          setData(result);
          setFallbackMode(true);
        } catch (fallbackErr) {
          setError(fallbackErr);
          setFallbackMode(true);
        }
      }
    };

    loadData();
  }, []);

  if (error) {
    return (
      <View style={styles.container}>
        <Text style={styles.errorText}>
          Unable to load data. Please check your connection.
        </Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {fallbackMode && (
        <Text style={styles.warningText}>
          Limited functionality available
        </Text>
      )}
      {data && (
        <View>
          <Text>Data loaded successfully</Text>
          {!fallbackMode && <Text>Full functionality available</Text>}
        </View>
      )}
    </View>
  );
};
```


---

## 📊 **Error Logging and Monitoring**

### **Error Logger Service**


```javascript
class ErrorLogger {
  constructor() {
    this.errors = [];
    this.maxErrors = 100;
  }

  log(error, context = {}) {
    const errorData = {
      id: Date.now(),
      message: error.message || error,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      context,
      userAgent: navigator.userAgent,
      url: window.location.href,
    };

    this.errors.push(errorData);
    
    // Keep only recent errors
    if (this.errors.length > this.maxErrors) {
      this.errors = this.errors.slice(-this.maxErrors);
    }

    // Send to external service
    this.sendToExternalService(errorData);
    
    // Log to console in development
    if (__DEV__) {
      console.error('Error logged:', errorData);
    }
  }

  async sendToExternalService(errorData) {
    try {
      await fetch('/api/errors', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(errorData),
      });
    } catch (err) {
      console.error('Failed to send error to external service:', err);
    }
  }

  getErrors() {
    return this.errors;
  }

  clearErrors() {
    this.errors = [];
  }
}

export const errorLogger = new ErrorLogger();
```


### **Error Monitoring Hook**


```javascript
import { useEffect } from 'react';
import { errorLogger } from '../services/ErrorLogger';

const useErrorMonitoring = (componentName) => {
  useEffect(() => {
    const handleError = (error) => {
      errorLogger.log(error, {
        component: componentName,
        timestamp: new Date().toISOString(),
      });
    };

    const handleUnhandledRejection = (event) => {
      errorLogger.log(event.reason, {
        component: componentName,
        type: 'unhandledRejection',
        timestamp: new Date().toISOString(),
      });
    };

    window.addEventListener('error', handleError);
    window.addEventListener('unhandledrejection', handleUnhandledRejection);

    return () => {
      window.removeEventListener('error', handleError);
      window.removeEventListener('unhandledrejection', handleUnhandledRejection);
    };
  }, [componentName]);
};

export default useErrorMonitoring;
```


---

## ✅ **Best Practices**

### **1. Error Boundary Placement**


```javascript
// ✅ Good: Place error boundaries at strategic levels
const App = () => {
  return (
    <ErrorBoundary>
      <NavigationContainer>
        <Stack.Navigator>
          <Stack.Screen name="Home">
            {() => (
              <ErrorBoundary>
                <HomeScreen />
              </ErrorBoundary>
            )}
          </Stack.Screen>
        </Stack.Navigator>
      </NavigationContainer>
    </ErrorBoundary>
  );
};

// ❌ Bad: Too many error boundaries
const App = () => {
  return (
    <ErrorBoundary>
      <ErrorBoundary>
        <ErrorBoundary>
          <HomeScreen />
        </ErrorBoundary>
      </ErrorBoundary>
    </ErrorBoundary>
  );
};
```


### **2. Error Information**


```javascript
// ✅ Good: Provide useful error information
const ErrorBoundary = ({ children }) => {
  const [error, setError] = useState(null);

  const handleError = (error, errorInfo) => {
    setError({
      message: error.message,
      stack: error.stack,
      componentStack: errorInfo.componentStack,
      timestamp: new Date().toISOString(),
    });
  };

  // ... rest of component
};

// ❌ Bad: Generic error handling
const ErrorBoundary = ({ children }) => {
  const [hasError, setHasError] = useState(false);

  const handleError = () => {
    setHasError(true);
  };

  // ... rest of component
};
```


### **3. Recovery Mechanisms**


```javascript
// ✅ Good: Provide recovery options
const ErrorFallback = ({ error, resetError }) => {
  return (
    <View style={styles.errorContainer}>
      <Text style={styles.errorTitle}>Something went wrong</Text>
      <Text style={styles.errorMessage}>{error.message}</Text>
      <TouchableOpacity onPress={resetError}>
        <Text>Try Again</Text>
      </TouchableOpacity>
    </View>
  );
};

// ❌ Bad: No recovery options
const ErrorFallback = ({ error }) => {
  return (
    <View style={styles.errorContainer}>
      <Text>Error: {error.message}</Text>
    </View>
  );
};
```


---

## ❓ **Common Interview Questions**

### **1. What are error boundaries and when should you use them?**

**Answer:**
Error boundaries are React components that catch JavaScript errors anywhere in their child component tree. They should be used to:
- Prevent the entire app from crashing
- Provide fallback UI for broken components
- Log errors for debugging
- Implement recovery mechanisms

### **2. What types of errors do error boundaries catch and not catch?**

**Answer:**
**Catch:**
- Errors in render methods
- Errors in lifecycle methods
- Errors in constructors

**Don't Catch:**
- Errors in event handlers
- Errors in asynchronous code
- Errors in server-side rendering
- Errors thrown in the error boundary itself

### **3. How would you implement error boundaries in a React Native app?**

**Answer:**

```javascript
const ErrorBoundary = ({ children }) => {
  const [hasError, setHasError] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const handleError = (error, errorInfo) => {
      setHasError(true);
      setError(error);
      // Log error to monitoring service
    };

    // Set up error handling
    return () => {
      // Cleanup
    };
  }, []);

  if (hasError) {
    return <ErrorFallback error={error} />;
  }

  return children;
};
```


### **4. How would you handle async errors in React Native?**

**Answer:**
Async errors require additional handling since error boundaries don't catch them:


```javascript
const useAsyncError = () => {
  const [error, setError] = useState(null);

  const handleAsyncError = useCallback((error) => {
    setError(error);
  }, []);

  useEffect(() => {
    const handleUnhandledRejection = (event) => {
      handleAsyncError(event.reason);
    };

    window.addEventListener('unhandledrejection', handleUnhandledRejection);
    return () => {
      window.removeEventListener('unhandledrejection', handleUnhandledRejection);
    };
  }, [handleAsyncError]);

  return { error, handleAsyncError };
};
```


### **5. How would you implement error recovery strategies?**

**Answer:**
Implement retry mechanisms with exponential backoff:


```javascript
const useErrorRecovery = (maxRetries = 3) => {
  const [retryCount, setRetryCount] = useState(0);

  const retry = useCallback(async (operation) => {
    if (retryCount >= maxRetries) return false;

    try {
      await operation();
      setRetryCount(0);
      return true;
    } catch (error) {
      const delay = 1000 * Math.pow(2, retryCount);
      setRetryCount(prev => prev + 1);
      
      setTimeout(() => {
        retry(operation);
      }, delay);
      
      return false;
    }
  }, [retryCount, maxRetries]);

  return { retry, retryCount };
};
```


---

## 🧭 Navigation

<div class="navigation">
  <a href="../14-Expo-vs-Bare-Workflow/04-Migration-Strategies.md" class="nav-button">← Previous: Migration Strategies</a>
  <a href="02-Error-Handling-Patterns.md" class="nav-button">Next: Error Handling Patterns →</a>
</div>

*Last updated: December 2024*
