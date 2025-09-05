# ⚡ **Performance Debugging**

> **Master performance debugging techniques for React Native applications, including profiling, optimization, and performance monitoring**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Performance Debugging Overview](#performance-debugging-overview)
- [JavaScript Performance](#javascript-performance)
- [Native Performance](#native-performance)
- [Memory Performance](#memory-performance)
- [Network Performance](#network-performance)
- [UI Performance](#ui-performance)
- [Performance Monitoring](#performance-monitoring)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Performance Debugging Overview**

Performance debugging involves identifying bottlenecks, measuring performance metrics, and optimizing React Native applications for better user experience.

### **Performance Debugging Framework**

```
┌─────────────────────────────────────┐
│        Performance Debugging       │
│  ┌─────────────────────────────────┐│
│  │        Measurement Tools       ││
│  │  - Chrome DevTools             ││
│  │  - Flipper Performance         ││
│  │  - React DevTools Profiler     ││
│  │  - Native Profilers            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Performance Areas       ││
│  │  - JavaScript Execution        ││
│  │  - Native Bridge               ││
│  │  - Memory Usage                ││
│  │  - Network Operations          ││
│  │  - UI Rendering                ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Optimization            ││
│  │  - Code Splitting              ││
│  │  - Lazy Loading                ││
│  │  - Memoization                 ││
│  │  - Bundle Optimization         ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

### **Key Performance Metrics**
- **Startup Time**: App launch to first screen
- **Time to Interactive**: When app becomes responsive
- **Frame Rate**: FPS during animations
- **Memory Usage**: RAM consumption over time
- **Bundle Size**: JavaScript bundle size
- **Network Latency**: API response times

---

## 🚀 **JavaScript Performance**

### **Performance Measurement**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Performance measurement utilities
const performanceUtils = {
  measureFunction: (fn, name) => {
    const start = performance.now();
    const result = fn();
    const end = performance.now();
    console.log(`${name} took ${end - start} milliseconds`);
    return result;
  },
  
  measureAsync: async (fn, name) => {
    const start = performance.now();
    const result = await fn();
    const end = performance.now();
    console.log(`${name} took ${end - start} milliseconds`);
    return result;
  },
  
  measureRender: (componentName) => {
    const start = performance.now();
    return () => {
      const end = performance.now();
      console.log(`${componentName} render took ${end - start} milliseconds`);
    };
  }
};
```

### **React Performance Profiling**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// React Profiler for component performance
import { Profiler } from 'react';

const onRenderCallback = (id, phase, actualDuration, baseDuration, startTime, commitTime) => {
  console.log('Profiler:', {
    id,
    phase,
    actualDuration,
    baseDuration,
    startTime,
    commitTime
  });
};

const MyComponent = () => {
  return (
    <Profiler id="MyComponent" onRender={onRenderCallback}>
      <View>
        <Text>Performance monitored component</Text>
      </View>
    </Profiler>
  );
};
```

### **JavaScript Performance Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Memoization for expensive calculations
import { useMemo, useCallback } from 'react';

const ExpensiveComponent = ({ data, filter }) => {
  // Memoize expensive calculation
  const filteredData = useMemo(() => {
    console.log('Filtering data...');
    return data.filter(item => item.category === filter);
  }, [data, filter]);
  
  // Memoize callback functions
  const handlePress = useCallback((id) => {
    console.log('Item pressed:', id);
  }, []);
  
  return (
    <FlatList
      data={filteredData}
      renderItem={({ item }) => (
        <TouchableOpacity onPress={() => handlePress(item.id)}>
          <Text>{item.name}</Text>
        </TouchableOpacity>
      )}
    />
  );
};
```

### **Bundle Analysis**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Analyze bundle size
npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android-bundle.js --assets-dest android-assets

# Use bundle analyzer
npm install --save-dev react-native-bundle-visualizer
npx react-native-bundle-visualizer
```

---

## 📱 **Native Performance**

### **Native Performance Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Native performance monitoring
import { NativeModules } from 'react-native';

const PerformanceMonitor = {
  startTrace: (name) => {
    if (NativeModules.PerformanceMonitor) {
      NativeModules.PerformanceMonitor.startTrace(name);
    }
  },
  
  stopTrace: (name) => {
    if (NativeModules.PerformanceMonitor) {
      NativeModules.PerformanceMonitor.stopTrace(name);
    }
  },
  
  measureNativeOperation: async (operation, name) => {
    PerformanceMonitor.startTrace(name);
    try {
      const result = await operation();
      return result;
    } finally {
      PerformanceMonitor.stopTrace(name);
    }
  }
};
```

### **Bridge Performance**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Optimize bridge communication
const BridgeOptimizer = {
  // Batch native calls
  batchNativeCalls: (calls) => {
    return new Promise((resolve) => {
      const results = [];
      let completed = 0;
      
      calls.forEach((call, index) => {
        call().then(result => {
          results[index] = result;
          completed++;
          
          if (completed === calls.length) {
            resolve(results);
          }
        });
      });
    });
  },
  
  // Debounce frequent calls
  debounce: (func, delay) => {
    let timeoutId;
    return (...args) => {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(() => func.apply(null, args), delay);
    };
  }
};
```

### **Native Module Performance**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Optimize native module calls
const OptimizedNativeModule = {
  // Cache native module references
  getCachedModule: (() => {
    let cachedModule = null;
    return () => {
      if (!cachedModule) {
        cachedModule = NativeModules.MyNativeModule;
      }
      return cachedModule;
    };
  })(),
  
  // Use promises instead of callbacks
  asyncCall: async (params) => {
    const module = OptimizedNativeModule.getCachedModule();
    return new Promise((resolve, reject) => {
      module.asyncMethod(params, (error, result) => {
        if (error) reject(error);
        else resolve(result);
      });
    });
  }
};
```

---

## 🧠 **Memory Performance**

### **Memory Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Memory monitoring utilities
const MemoryMonitor = {
  getMemoryInfo: () => {
    if (performance.memory) {
      return {
        used: performance.memory.usedJSHeapSize,
        total: performance.memory.totalJSHeapSize,
        limit: performance.memory.jsHeapSizeLimit
      };
    }
    return null;
  },
  
  logMemoryUsage: (label) => {
    const memory = MemoryMonitor.getMemoryInfo();
    if (memory) {
      console.log(`[Memory] ${label}:`, {
        used: `${(memory.used / 1024 / 1024).toFixed(2)} MB`,
        total: `${(memory.total / 1024 / 1024).toFixed(2)} MB`,
        limit: `${(memory.limit / 1024 / 1024).toFixed(2)} MB`
      });
    }
  },
  
  monitorMemoryLeaks: (componentName) => {
    const startMemory = MemoryMonitor.getMemoryInfo();
    
    return () => {
      const endMemory = MemoryMonitor.getMemoryInfo();
      if (startMemory && endMemory) {
        const memoryIncrease = endMemory.used - startMemory.used;
        if (memoryIncrease > 10 * 1024 * 1024) { // 10MB
          console.warn(`[Memory Leak] ${componentName} increased memory by ${(memoryIncrease / 1024 / 1024).toFixed(2)} MB`);
        }
      }
    };
  }
};
```

### **Memory Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Memory optimization techniques
const MemoryOptimizer = {
  // Weak references for large objects
  createWeakCache: () => {
    const cache = new WeakMap();
    return {
      set: (key, value) => cache.set(key, value),
      get: (key) => cache.get(key),
      has: (key) => cache.has(key)
    };
  },
  
  // Cleanup subscriptions
  createSubscriptionManager: () => {
    const subscriptions = new Set();
    
    return {
      add: (subscription) => {
        subscriptions.add(subscription);
        return subscription;
      },
      
      remove: (subscription) => {
        subscriptions.delete(subscription);
      },
      
      cleanup: () => {
        subscriptions.forEach(subscription => {
          if (typeof subscription === 'function') {
            subscription();
          } else if (subscription && typeof subscription.unsubscribe === 'function') {
            subscription.unsubscribe();
          }
        });
        subscriptions.clear();
      }
    };
  }
};
```

---

## 🌐 **Network Performance**

### **Network Performance Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Network performance monitoring
const NetworkMonitor = {
  measureRequest: async (url, options = {}) => {
    const startTime = performance.now();
    const startMemory = MemoryMonitor.getMemoryInfo();
    
    try {
      const response = await fetch(url, options);
      const endTime = performance.now();
      const endMemory = MemoryMonitor.getMemoryInfo();
      
      const metrics = {
        url,
        duration: endTime - startTime,
        status: response.status,
        memoryDelta: endMemory ? endMemory.used - startMemory.used : 0
      };
      
      console.log('[Network] Request metrics:', metrics);
      return response;
    } catch (error) {
      const endTime = performance.now();
      console.error('[Network] Request failed:', {
        url,
        duration: endTime - startTime,
        error: error.message
      });
      throw error;
    }
  },
  
  // Batch network requests
  batchRequests: async (requests) => {
    const startTime = performance.now();
    const results = await Promise.allSettled(requests);
    const endTime = performance.now();
    
    console.log(`[Network] Batch of ${requests.length} requests took ${endTime - startTime}ms`);
    return results;
  }
};
```

### **Network Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Network optimization strategies
const NetworkOptimizer = {
  // Request caching
  createCache: (ttl = 300000) => { // 5 minutes default
    const cache = new Map();
    
    return {
      get: (key) => {
        const item = cache.get(key);
        if (item && Date.now() - item.timestamp < ttl) {
          return item.data;
        }
        cache.delete(key);
        return null;
      },
      
      set: (key, data) => {
        cache.set(key, {
          data,
          timestamp: Date.now()
        });
      }
    };
  },
  
  // Request deduplication
  createDeduplicator: () => {
    const pendingRequests = new Map();
    
    return (key, requestFn) => {
      if (pendingRequests.has(key)) {
        return pendingRequests.get(key);
      }
      
      const promise = requestFn().finally(() => {
        pendingRequests.delete(key);
      });
      
      pendingRequests.set(key, promise);
      return promise;
    };
  }
};
```

---

## 🎨 **UI Performance**

### **UI Performance Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// UI performance monitoring
const UIPerformanceMonitor = {
  measureRender: (componentName) => {
    const startTime = performance.now();
    
    return () => {
      const endTime = performance.now();
      const renderTime = endTime - startTime;
      
      if (renderTime > 16) { // 60fps threshold
        console.warn(`[UI Performance] ${componentName} render took ${renderTime.toFixed(2)}ms (target: <16ms)`);
      }
    };
  },
  
  measureLayout: (componentName) => {
    const startTime = performance.now();
    
    return (event) => {
      const endTime = performance.now();
      const layoutTime = endTime - startTime;
      
      console.log(`[UI Performance] ${componentName} layout took ${layoutTime.toFixed(2)}ms`);
    };
  }
};
```

### **UI Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// UI optimization techniques
const UIOptimizer = {
  // Optimize FlatList performance
  optimizeFlatList: (data, renderItem) => {
    return (
      <FlatList
        data={data}
        renderItem={renderItem}
        keyExtractor={(item) => item.id.toString()}
        getItemLayout={(data, index) => ({
          length: 80,
          offset: 80 * index,
          index
        })}
        removeClippedSubviews={true}
        maxToRenderPerBatch={10}
        windowSize={10}
        initialNumToRender={10}
        updateCellsBatchingPeriod={50}
      />
    );
  },
  
  // Optimize images
  optimizeImage: (source, style) => {
    return (
      <Image
        source={source}
        style={style}
        resizeMode="cover"
        fadeDuration={0}
        loadingIndicatorSource={require('./placeholder.png')}
      />
    );
  }
};
```

---

## 📊 **Performance Monitoring**

### **Performance Metrics Collection**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Performance metrics collection
const PerformanceMetrics = {
  metrics: new Map(),
  
  record: (name, value, metadata = {}) => {
    const metric = {
      name,
      value,
      timestamp: Date.now(),
      metadata
    };
    
    PerformanceMetrics.metrics.set(name, metric);
    console.log(`[Performance] ${name}: ${value}`, metadata);
  },
  
  getMetrics: () => {
    return Array.from(PerformanceMetrics.metrics.values());
  },
  
  clear: () => {
    PerformanceMetrics.metrics.clear();
  }
};
```

### **Performance Dashboard**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Performance dashboard component
const PerformanceDashboard = () => {
  const [metrics, setMetrics] = useState([]);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setMetrics(PerformanceMetrics.getMetrics());
    }, 1000);
    
    return () => clearInterval(interval);
  }, []);
  
  return (
    <View style={styles.dashboard}>
      <Text style={styles.title}>Performance Metrics</Text>
      {metrics.map(metric => (
        <View key={metric.name} style={styles.metric}>
          <Text style={styles.metricName}>{metric.name}</Text>
          <Text style={styles.metricValue}>{metric.value}</Text>
        </View>
      ))}
    </View>
  );
};
```

---

## ✅ **Best Practices**

### **1. Performance Testing**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Performance testing utilities
const PerformanceTester = {
  runPerformanceTest: async (testName, testFn, iterations = 100) => {
    const results = [];
    
    for (let i = 0; i < iterations; i++) {
      const start = performance.now();
      await testFn();
      const end = performance.now();
      results.push(end - start);
    }
    
    const avg = results.reduce((a, b) => a + b, 0) / results.length;
    const min = Math.min(...results);
    const max = Math.max(...results);
    
    console.log(`[Performance Test] ${testName}:`, {
      average: `${avg.toFixed(2)}ms`,
      min: `${min.toFixed(2)}ms`,
      max: `${max.toFixed(2)}ms`
    });
    
    return { average: avg, min, max, results };
  }
};
```

### **2. Performance Budgets**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Performance budgets
const PerformanceBudgets = {
  budgets: {
    renderTime: 16, // 60fps
    networkRequest: 1000, // 1 second
    bundleSize: 10 * 1024 * 1024, // 10MB
    memoryUsage: 100 * 1024 * 1024 // 100MB
  },
  
  checkBudget: (metric, value) => {
    const budget = PerformanceBudgets.budgets[metric];
    if (budget && value > budget) {
      console.warn(`[Performance Budget] ${metric} exceeded: ${value} > ${budget}`);
    }
  }
};
```

---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **How do you measure performance in React Native?**
   - Use Chrome DevTools Performance tab
   - Monitor render times and memory usage
   - Use React Profiler for component performance
   - Check native performance with platform tools

2. **What are common performance bottlenecks?**
   - Excessive re-renders
   - Large bundle sizes
   - Memory leaks
   - Inefficient list rendering
   - Network request delays

3. **How do you optimize React Native performance?**
   - Use memoization and callbacks
   - Optimize FlatList rendering
   - Implement code splitting
   - Monitor memory usage
   - Optimize images and assets

### **Intermediate Questions**
4. **How do you debug memory leaks?**
   - Use Chrome DevTools Memory tab
   - Monitor memory usage over time
   - Check for retained references
   - Use memory profilers
   - Implement proper cleanup

5. **What's your approach to optimizing network performance?**
   - Implement request caching
   - Use request deduplication
   - Batch network requests
   - Monitor network metrics
   - Optimize API responses

6. **How do you measure and optimize UI performance?**
   - Monitor render times
   - Use React Profiler
   - Optimize FlatList performance
   - Check frame rates
   - Implement lazy loading

### **Advanced Questions**
7. **How do you implement performance monitoring in production?**
   - Use crash reporting services
   - Implement performance metrics collection
   - Set up performance budgets
   - Monitor key performance indicators
   - Create performance dashboards

8. **What's your strategy for debugging complex performance issues?**
   - Systematic performance profiling
   - Isolate performance bottlenecks
   - Use multiple debugging tools
   - Implement performance testing
   - Monitor performance over time

9. **How do you optimize React Native apps for different devices?**
   - Test on various device specifications
   - Implement adaptive performance strategies
   - Use device-specific optimizations
   - Monitor performance across devices
   - Implement graceful degradation

---

## 🔗 **Related Topics**

- [Debugging Tools](./01-Debugging-Tools.md)
- [Memory Debugging](./03-Memory-Debugging.md)
- [Native Debugging](./04-Native-Debugging.md)
- [Performance Optimization](../05-Lists-Performance-Optimization/01-FlatList-SectionList.md)
- [Memory Management](../16-Memory-Management/01-Memory-Leaks.md)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Debugging-Tools.md" class="nav-link prev">⬅️ Previous: Debugging Tools</a>
    <a href="./03-Memory-Debugging.md" class="nav-link next">Next: Memory Debugging ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
