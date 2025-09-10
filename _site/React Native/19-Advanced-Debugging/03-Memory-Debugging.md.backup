# 🧠 **Memory Debugging**

> **Master memory debugging techniques for React Native applications, including leak detection, memory profiling, and optimization strategies**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Memory Debugging Overview](#memory-debugging-overview)
- [Memory Leak Detection](#memory-leak-detection)
- [Memory Profiling](#memory-profiling)
- [JavaScript Memory](#javascript-memory)
- [Native Memory](#native-memory)
- [Memory Optimization](#memory-optimization)
- [Memory Monitoring](#memory-monitoring)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Memory Debugging Overview**

Memory debugging involves identifying memory leaks, monitoring memory usage, and optimizing memory consumption in React Native applications.

### **Memory Debugging Framework**


```
┌─────────────────────────────────────┐
│        Memory Debugging            │
│  ┌─────────────────────────────────┐│
│  │        Detection Tools         ││
│  │  - Chrome DevTools Memory      ││
│  │  - Flipper Memory Plugin       ││
│  │  - Native Memory Profilers     ││
│  │  - Custom Memory Monitors      ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Memory Types            ││
│  │  - JavaScript Heap             ││
│  │  - Native Memory               ││
│  │  - Image Memory                ││
│  │  - Cache Memory                ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Optimization            ││
│  │  - Garbage Collection          ││
│  │  - Memory Pooling              ││
│  │  - Weak References             ││
│  │  - Memory Cleanup              ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


### **Key Memory Metrics**
- **Heap Size**: Total JavaScript memory usage
- **Memory Growth**: Rate of memory increase over time
- **Garbage Collection**: Frequency and duration of GC cycles
- **Memory Leaks**: Objects that aren't garbage collected
- **Peak Memory**: Maximum memory usage during app lifecycle

---

## 🔍 **Memory Leak Detection**

### **Memory Leak Detection Tools**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory leak detection utilities
const MemoryLeakDetector = {
  // Track object creation and destruction
  trackObject: (name, obj) => {
    if (__DEV__) {
      const id = Math.random().toString(36).substr(2, 9);
      obj._memoryTrackerId = id;
      obj._memoryTrackerName = name;
      
      console.log(`[Memory] Created ${name} (${id})`);
      
      // Track when object is garbage collected
      const weakRef = new WeakRef(obj);
      setTimeout(() => {
        if (weakRef.deref()) {
          console.log(`[Memory] ${name} (${id}) still alive after 5 seconds`);
        } else {
          console.log(`[Memory] ${name} (${id}) garbage collected`);
        }
      }, 5000);
    }
    return obj;
  },
  
  // Monitor memory growth
  monitorMemoryGrowth: (interval = 10000) => {
    let previousMemory = null;
    
    const checkMemory = () => {
      const currentMemory = performance.memory;
      if (currentMemory && previousMemory) {
        const growth = currentMemory.usedJSHeapSize - previousMemory.usedJSHeapSize;
        if (growth > 10 * 1024 * 1024) { // 10MB growth
          console.warn(`[Memory Leak] Memory grew by ${(growth / 1024 / 1024).toFixed(2)} MB`);
        }
      }
      previousMemory = currentMemory;
    };
    
    return setInterval(checkMemory, interval);
  }
};
```


### **Common Memory Leak Patterns**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Common memory leak patterns and fixes

// ❌ Memory leak: Event listeners not removed
class LeakyComponent extends React.Component {
  componentDidMount() {
    // This creates a memory leak
    DeviceEventEmitter.addListener('event', this.handleEvent);
  }
  
  handleEvent = (data) => {
    console.log('Event received:', data);
  }
}

// ✅ Fixed: Proper cleanup
class FixedComponent extends React.Component {
  componentDidMount() {
    this.eventListener = DeviceEventEmitter.addListener('event', this.handleEvent);
  }
  
  componentWillUnmount() {
    // Proper cleanup
    this.eventListener?.remove();
  }
  
  handleEvent = (data) => {
    console.log('Event received:', data);
  }
}
```


### **Memory Leak Detection in Lists**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory leak detection for FlatList
const MemoryLeakAwareFlatList = ({ data, renderItem, ...props }) => {
  const [memoryStats, setMemoryStats] = useState(null);
  
  useEffect(() => {
    const interval = setInterval(() => {
      if (performance.memory) {
        setMemoryStats({
          used: performance.memory.usedJSHeapSize,
          total: performance.memory.totalJSHeapSize,
          limit: performance.memory.jsHeapSizeLimit
        });
      }
    }, 1000);
    
    return () => clearInterval(interval);
  }, []);
  
  const optimizedRenderItem = useCallback(({ item, index }) => {
    // Track item rendering
    MemoryLeakDetector.trackObject(`ListItem-${index}`, item);
    return renderItem({ item, index });
  }, [renderItem]);
  
  return (
    <View>
      {memoryStats && (
        <Text style={styles.memoryStats}>
          Memory: {(memoryStats.used / 1024 / 1024).toFixed(2)} MB
        </Text>
      )}
      <FlatList
        data={data}
        renderItem={optimizedRenderItem}
        {...props}
      />
    </View>
  );
};
```


---

## 📊 **Memory Profiling**

### **Chrome DevTools Memory Profiling**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory profiling utilities
const MemoryProfiler = {
  // Take heap snapshots
  takeHeapSnapshot: (name) => {
    if (__DEV__ && performance.memory) {
      const snapshot = {
        name,
        timestamp: Date.now(),
        memory: {
          used: performance.memory.usedJSHeapSize,
          total: performance.memory.totalJSHeapSize,
          limit: performance.memory.jsHeapSizeLimit
        }
      };
      
      console.log(`[Memory Snapshot] ${name}:`, snapshot);
      return snapshot;
    }
  },
  
  // Compare snapshots
  compareSnapshots: (snapshot1, snapshot2) => {
    const memoryDiff = snapshot2.memory.used - snapshot1.memory.used;
    const timeDiff = snapshot2.timestamp - snapshot1.timestamp;
    
    console.log(`[Memory Comparison] ${snapshot1.name} vs ${snapshot2.name}:`, {
      memoryDifference: `${(memoryDiff / 1024 / 1024).toFixed(2)} MB`,
      timeDifference: `${timeDiff}ms`,
      memoryGrowthRate: `${(memoryDiff / timeDiff * 1000 / 1024 / 1024).toFixed(2)} MB/s`
    });
    
    return { memoryDiff, timeDiff };
  }
};
```


### **Custom Memory Profiler**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Custom memory profiler
class CustomMemoryProfiler {
  constructor() {
    this.snapshots = [];
    this.monitoring = false;
  }
  
  startMonitoring(interval = 5000) {
    this.monitoring = true;
    this.monitorInterval = setInterval(() => {
      this.takeSnapshot(`Auto-${Date.now()}`);
    }, interval);
  }
  
  stopMonitoring() {
    this.monitoring = false;
    if (this.monitorInterval) {
      clearInterval(this.monitorInterval);
    }
  }
  
  takeSnapshot(name) {
    if (performance.memory) {
      const snapshot = {
        name,
        timestamp: Date.now(),
        memory: {
          used: performance.memory.usedJSHeapSize,
          total: performance.memory.totalJSHeapSize,
          limit: performance.memory.jsHeapSizeLimit
        }
      };
      
      this.snapshots.push(snapshot);
      console.log(`[Memory Profiler] Snapshot: ${name}`, snapshot);
      return snapshot;
    }
  }
  
  getMemoryTrend() {
    if (this.snapshots.length < 2) return null;
    
    const first = this.snapshots[0];
    const last = this.snapshots[this.snapshots.length - 1];
    
    return {
      totalGrowth: last.memory.used - first.memory.used,
      averageGrowth: (last.memory.used - first.memory.used) / this.snapshots.length,
      timeSpan: last.timestamp - first.timestamp
    };
  }
}

// Global profiler instance
const memoryProfiler = new CustomMemoryProfiler();
```


---

## 🚀 **JavaScript Memory**

### **JavaScript Memory Management**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// JavaScript memory management utilities
const JavaScriptMemoryManager = {
  // Force garbage collection (if available)
  forceGC: () => {
    if (global.gc) {
      global.gc();
      console.log('[Memory] Forced garbage collection');
    } else {
      console.warn('[Memory] Garbage collection not available');
    }
  },
  
  // Monitor garbage collection
  monitorGC: () => {
    if (performance.memory) {
      let lastUsed = performance.memory.usedJSHeapSize;
      
      const checkGC = () => {
        const currentUsed = performance.memory.usedJSHeapSize;
        if (currentUsed < lastUsed) {
          console.log(`[Memory] Garbage collection freed ${(lastUsed - currentUsed) / 1024 / 1024} MB`);
        }
        lastUsed = currentUsed;
      };
      
      return setInterval(checkGC, 1000);
    }
  },
  
  // Memory usage by component
  trackComponentMemory: (componentName) => {
    const startMemory = performance.memory?.usedJSHeapSize || 0;
    
    return () => {
      const endMemory = performance.memory?.usedJSHeapSize || 0;
      const memoryDelta = endMemory - startMemory;
      
      if (memoryDelta > 1024 * 1024) { // 1MB
        console.warn(`[Memory] ${componentName} used ${(memoryDelta / 1024 / 1024).toFixed(2)} MB`);
      }
    };
  }
};
```


### **Memory-Efficient Data Structures**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory-efficient data structures
const MemoryEfficientStructures = {
  // WeakMap for automatic cleanup
  createWeakCache: () => {
    const cache = new WeakMap();
    return {
      set: (key, value) => cache.set(key, value),
      get: (key) => cache.get(key),
      has: (key) => cache.has(key)
    };
  },
  
  // Object pool for reusing objects
  createObjectPool: (createFn, resetFn) => {
    const pool = [];
    
    return {
      acquire: () => {
        if (pool.length > 0) {
          const obj = pool.pop();
          resetFn(obj);
          return obj;
        }
        return createFn();
      },
      
      release: (obj) => {
        if (pool.length < 100) { // Limit pool size
          pool.push(obj);
        }
      }
    };
  },
  
  // Lazy loading for large datasets
  createLazyLoader: (data, chunkSize = 100) => {
    let currentIndex = 0;
    
    return {
      loadNext: () => {
        const chunk = data.slice(currentIndex, currentIndex + chunkSize);
        currentIndex += chunkSize;
        return chunk;
      },
      
      hasMore: () => currentIndex < data.length,
      
      reset: () => {
        currentIndex = 0;
      }
    };
  }
};
```


---

## 📱 **Native Memory**

### **Native Memory Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Native memory monitoring
const NativeMemoryMonitor = {
  // Get native memory info
  getNativeMemoryInfo: async () => {
    try {
      const { NativeModules } = require('react-native');
      if (NativeModules.MemoryMonitor) {
        return await NativeModules.MemoryMonitor.getMemoryInfo();
      }
    } catch (error) {
      console.warn('[Memory] Native memory monitoring not available:', error);
    }
    return null;
  },
  
  // Monitor native memory usage
  monitorNativeMemory: (interval = 10000) => {
    return setInterval(async () => {
      const memoryInfo = await NativeMemoryMonitor.getNativeMemoryInfo();
      if (memoryInfo) {
        console.log('[Native Memory]', memoryInfo);
      }
    }, interval);
  }
};
```


### **Image Memory Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Image memory optimization
const ImageMemoryOptimizer = {
  // Optimize image loading
  optimizeImage: (source, style) => {
    return (
      <Image
        source={source}
        style={style}
        resizeMode="cover"
        fadeDuration={0}
        onLoadStart={() => console.log('[Image] Load started')}
        onLoad={() => console.log('[Image] Load completed')}
        onError={(error) => console.error('[Image] Load error:', error)}
      />
    );
  },
  
  // Lazy load images
  createLazyImage: (source, style, placeholder) => {
    const [loaded, setLoaded] = useState(false);
    
    return (
      <View style={style}>
        {!loaded && placeholder}
        <Image
          source={source}
          style={[style, { opacity: loaded ? 1 : 0 }]}
          onLoad={() => setLoaded(true)}
        />
      </View>
    );
  },
  
  // Image caching
  createImageCache: () => {
    const cache = new Map();
    const maxSize = 50; // Maximum cached images
    
    return {
      get: (key) => cache.get(key),
      
      set: (key, value) => {
        if (cache.size >= maxSize) {
          const firstKey = cache.keys().next().value;
          cache.delete(firstKey);
        }
        cache.set(key, value);
      },
      
      clear: () => cache.clear()
    };
  }
};
```


---

## 🔧 **Memory Optimization**

### **Memory Optimization Strategies**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory optimization strategies
const MemoryOptimizer = {
  // Debounce memory-intensive operations
  debounce: (func, delay) => {
    let timeoutId;
    return (...args) => {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(() => func.apply(null, args), delay);
    };
  },
  
  // Throttle memory-intensive operations
  throttle: (func, limit) => {
    let inThrottle;
    return (...args) => {
      if (!inThrottle) {
        func.apply(null, args);
        inThrottle = true;
        setTimeout(() => inThrottle = false, limit);
      }
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


### **Component Memory Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory-optimized component
const MemoryOptimizedComponent = ({ data, onItemPress }) => {
  const subscriptionManager = useRef(MemoryOptimizer.createSubscriptionManager());
  const [visibleItems, setVisibleItems] = useState([]);
  
  useEffect(() => {
    // Cleanup on unmount
    return () => {
      subscriptionManager.current.cleanup();
    };
  }, []);
  
  // Memoize expensive calculations
  const processedData = useMemo(() => {
    return data.map(item => ({
      ...item,
      processed: true
    }));
  }, [data]);
  
  // Memoize callbacks
  const handleItemPress = useCallback((item) => {
    onItemPress(item);
  }, [onItemPress]);
  
  // Optimize rendering
  const renderItem = useCallback(({ item }) => {
    return (
      <TouchableOpacity onPress={() => handleItemPress(item)}>
        <Text>{item.name}</Text>
      </TouchableOpacity>
    );
  }, [handleItemPress]);
  
  return (
    <FlatList
      data={processedData}
      renderItem={renderItem}
      keyExtractor={(item) => item.id.toString()}
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
      windowSize={10}
    />
  );
};
```


---

## 📈 **Memory Monitoring**

### **Real-time Memory Monitoring**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Real-time memory monitoring
const MemoryMonitor = {
  // Memory usage display
  MemoryUsageDisplay: () => {
    const [memoryInfo, setMemoryInfo] = useState(null);
    
    useEffect(() => {
      const updateMemoryInfo = () => {
        if (performance.memory) {
          setMemoryInfo({
            used: performance.memory.usedJSHeapSize,
            total: performance.memory.totalJSHeapSize,
            limit: performance.memory.jsHeapSizeLimit
          });
        }
      };
      
      updateMemoryInfo();
      const interval = setInterval(updateMemoryInfo, 1000);
      
      return () => clearInterval(interval);
    }, []);
    
    if (!memoryInfo) return null;
    
    const usedMB = (memoryInfo.used / 1024 / 1024).toFixed(2);
    const totalMB = (memoryInfo.total / 1024 / 1024).toFixed(2);
    const limitMB = (memoryInfo.limit / 1024 / 1024).toFixed(2);
    
    return (
      <View style={styles.memoryDisplay}>
        <Text style={styles.memoryText}>
          Memory: {usedMB} MB / {totalMB} MB (Limit: {limitMB} MB)
        </Text>
        <View style={styles.memoryBar}>
          <View 
            style={[
              styles.memoryBarFill, 
              { width: `${(memoryInfo.used / memoryInfo.limit) * 100}%` }
            ]} 
          />
        </View>
      </View>
    );
  },
  
  // Memory alert system
  createMemoryAlert: (threshold = 0.8) => {
    return () => {
      if (performance.memory) {
        const usage = performance.memory.usedJSHeapSize / performance.memory.jsHeapSizeLimit;
        if (usage > threshold) {
          console.warn(`[Memory Alert] Memory usage at ${(usage * 100).toFixed(1)}%`);
          return true;
        }
      }
      return false;
    };
  }
};
```


---

## ✅ **Best Practices**

### **1. Memory Management Best Practices**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory management best practices
const MemoryBestPractices = {
  // Proper cleanup in useEffect
  useCleanup: (cleanupFn) => {
    useEffect(() => {
      return cleanupFn;
    }, []);
  },
  
  // Weak references for large objects
  useWeakRef: (obj) => {
    const weakRef = useRef(new WeakRef(obj));
    return weakRef.current;
  },
  
  // Object pooling for frequent allocations
  useObjectPool: (createFn, resetFn) => {
    const pool = useRef([]);
    
    const acquire = useCallback(() => {
      if (pool.current.length > 0) {
        const obj = pool.current.pop();
        resetFn(obj);
        return obj;
      }
      return createFn();
    }, [createFn, resetFn]);
    
    const release = useCallback((obj) => {
      if (pool.current.length < 100) {
        pool.current.push(obj);
      }
    }, []);
    
    return { acquire, release };
  }
};
```


### **2. Memory Testing**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Memory testing utilities
const MemoryTester = {
  // Test for memory leaks
  testMemoryLeak: async (testFn, duration = 30000) => {
    const startMemory = performance.memory?.usedJSHeapSize || 0;
    const startTime = Date.now();
    
    // Run test function repeatedly
    const interval = setInterval(testFn, 100);
    
    // Wait for duration
    await new Promise(resolve => setTimeout(resolve, duration));
    
    clearInterval(interval);
    
    // Force garbage collection
    if (global.gc) {
      global.gc();
    }
    
    const endMemory = performance.memory?.usedJSHeapSize || 0;
    const memoryGrowth = endMemory - startMemory;
    
    console.log(`[Memory Test] Growth: ${(memoryGrowth / 1024 / 1024).toFixed(2)} MB`);
    
    return memoryGrowth;
  }
};
```


---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **How do you detect memory leaks in React Native?**
   - Use Chrome DevTools Memory tab
   - Monitor memory usage over time
   - Check for retained references
   - Use memory profilers
   - Implement custom memory tracking

2. **What are common causes of memory leaks?**
   - Event listeners not removed
   - Timers not cleared
   - Closures holding references
   - Large objects not released
   - Circular references

3. **How do you optimize memory usage?**
   - Use WeakMap and WeakSet
   - Implement object pooling
   - Clean up subscriptions
   - Optimize image loading
   - Use lazy loading

### **Intermediate Questions**
4. **How do you profile memory usage in production?**
   - Implement memory monitoring
   - Use crash reporting services
   - Monitor memory trends
   - Set memory alerts
   - Collect memory metrics

5. **What's the difference between JavaScript and native memory?**
   - JavaScript memory: Managed by V8 engine
   - Native memory: Managed by platform
   - Different garbage collection strategies
   - Different monitoring tools
   - Different optimization techniques

6. **How do you handle memory pressure on low-end devices?**
   - Implement memory budgets
   - Use adaptive quality settings
   - Optimize asset loading
   - Implement memory cleanup
   - Monitor device capabilities

### **Advanced Questions**
7. **How do you implement custom memory management?**
   - Create object pools
   - Implement weak references
   - Use memory-efficient data structures
   - Implement custom garbage collection
   - Monitor memory allocation patterns

8. **What's your strategy for debugging complex memory issues?**
   - Use multiple profiling tools
   - Implement systematic testing
   - Monitor memory trends
   - Use memory snapshots
   - Implement custom tracking

9. **How do you optimize memory for large datasets?**
   - Implement virtual scrolling
   - Use lazy loading
   - Implement data pagination
   - Use memory-efficient data structures
   - Implement data compression

---

## 🔗 **Related Topics**

- [Debugging Tools](./01-Debugging-Tools.md)
- [Performance Debugging](./02-Performance-Debugging.md)
- [Native Debugging](./04-Native-Debugging.md)
- [Memory Management](../16-Memory-Management/01-Memory-Leaks.md)
- [Performance Optimization](../05-Lists-Performance-Optimization/01-FlatList-SectionList.md)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Performance-Debugging.md" class="nav-link prev">⬅️ Previous: Performance Debugging</a>
    <a href="./04-Native-Debugging.md" class="nav-link next">Next: Native Debugging ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
