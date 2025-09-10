# Memory Optimization Best Practices in React Native

## Overview

Memory optimization is crucial for building performant React Native applications. This guide covers comprehensive best practices for managing memory efficiently, preventing leaks, and ensuring smooth user experience across different devices and platforms.

## Component-Level Optimization

### 1. Efficient Component Structure


{% raw %}
```javascript
import { memo, useMemo, useCallback } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';

// ✅ GOOD: Memoized component with optimized props
const OptimizedListItem = memo(({ item, onPress, onLongPress }) => {
  const handlePress = useCallback(() => {
    onPress(item.id);
  }, [item.id, onPress]);

  const handleLongPress = useCallback(() => {
    onLongPress(item.id);
  }, [item.id, onLongPress]);

  // Memoize expensive calculations
  const displayText = useMemo(() => {
    return `${item.name} - ${item.category}`;
  }, [item.name, item.category]);

  return (
    <TouchableOpacity onPress={handlePress} onLongPress={handleLongPress}>
      <View style={styles.itemContainer}>
        <Text style={styles.itemText}>{displayText}</Text>
        <Text style={styles.itemSubtext}>{item.description}</Text>
      </View>
    </TouchableOpacity>
  );
});

// ✅ GOOD: Optimized list container
const OptimizedList = ({ items, onItemPress, onItemLongPress }) => {
  // Memoize the render function
  const renderItem = useCallback(({ item }) => (
    <OptimizedListItem
      item={item}
      onPress={onItemPress}
      onLongPress={onItemLongPress}
    />
  ), [onItemPress, onItemLongPress]);

  // Memoize the key extractor
  const keyExtractor = useCallback((item) => item.id.toString(), []);

  return (
    <FlatList
      data={items}
      renderItem={renderItem}
      keyExtractor={keyExtractor}
      // Memory optimization props
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
      windowSize={10}
      initialNumToRender={10}
      updateCellsBatchingPeriod={50}
      getItemLayout={(data, index) => ({
        length: 80,
        offset: 80 * index,
        index,
      })}
    />
  );
};
```
{% endraw %}


### 2. State Management Optimization


{% raw %}
```javascript
import { useReducer, useCallback, useMemo } from 'react';

// ✅ GOOD: Efficient reducer with immutable updates
const listReducer = (state, action) => {
  switch (action.type) {
    case 'ADD_ITEM':
      return {
        ...state,
        items: [...state.items, action.payload],
        count: state.count + 1
      };
    
    case 'UPDATE_ITEM':
      return {
        ...state,
        items: state.items.map(item =>
          item.id === action.payload.id
            ? { ...item, ...action.payload }
            : item
        )
      };
    
    case 'REMOVE_ITEM':
      return {
        ...state,
        items: state.items.filter(item => item.id !== action.payload),
        count: state.count - 1
      };
    
    case 'CLEAR_ITEMS':
      return {
        ...state,
        items: [],
        count: 0
      };
    
    default:
      return state;
  }
};

const OptimizedStateComponent = () => {
  const [state, dispatch] = useReducer(listReducer, {
    items: [],
    count: 0,
    loading: false,
    error: null
  });

  // Memoize derived state
  const activeItems = useMemo(() => 
    state.items.filter(item => item.active), 
    [state.items]
  );

  const itemCount = useMemo(() => 
    state.items.length, 
    [state.items]
  );

  // Memoize action creators
  const addItem = useCallback((item) => {
    dispatch({ type: 'ADD_ITEM', payload: item });
  }, []);

  const updateItem = useCallback((id, updates) => {
    dispatch({ type: 'UPDATE_ITEM', payload: { id, ...updates } });
  }, []);

  const removeItem = useCallback((id) => {
    dispatch({ type: 'REMOVE_ITEM', payload: id });
  }, []);

  const clearItems = useCallback(() => {
    dispatch({ type: 'CLEAR_ITEMS' });
  }, []);

  return (
    <View>
      <Text>Items: {itemCount}</Text>
      <Text>Active: {activeItems.length}</Text>
      {/* Render optimized list */}
    </View>
  );
};
```
{% endraw %}


## Image and Media Optimization

### 1. Efficient Image Loading


{% raw %}
```javascript
import { useState, useCallback, useMemo } from 'react';
import { Image, View, Text } from 'react-native';

const OptimizedImage = ({ source, style, placeholder, ...props }) => {
  const [loaded, setLoaded] = useState(false);
  const [error, setError] = useState(false);

  const handleLoad = useCallback(() => {
    setLoaded(true);
    setError(false);
  }, []);

  const handleError = useCallback(() => {
    setError(true);
    setLoaded(false);
  }, []);

  // Memoize image source to prevent unnecessary re-renders
  const imageSource = useMemo(() => {
    if (typeof source === 'string') {
      return { uri: source };
    }
    return source;
  }, [source]);

  return (
    <View style={style}>
      {!loaded && !error && placeholder && (
        <View style={[style, styles.placeholder]}>
          {placeholder}
        </View>
      )}
      
      <Image
        source={imageSource}
        style={[style, { opacity: loaded ? 1 : 0 }]}
        onLoad={handleLoad}
        onError={handleError}
        // Memory optimization props
        resizeMode="cover"
        fadeDuration={0}
        {...props}
      />
      
      {error && (
        <View style={[style, styles.errorContainer]}>
          <Text>Failed to load image</Text>
        </View>
      )}
    </View>
  );
};

// Image cache manager
class ImageCacheManager {
  constructor(maxSize = 100) {
    this.cache = new Map();
    this.maxSize = maxSize;
  }

  get(key) {
    if (this.cache.has(key)) {
      // Move to end (LRU)
      const value = this.cache.get(key);
      this.cache.delete(key);
      this.cache.set(key, value);
      return value;
    }
    return null;
  }

  set(key, value) {
    if (this.cache.size >= this.maxSize) {
      // Remove least recently used
      const firstKey = this.cache.keys().next().value;
      this.cache.delete(firstKey);
    }
    this.cache.set(key, value);
  }

  clear() {
    this.cache.clear();
  }
}

const imageCache = new ImageCacheManager();
```
{% endraw %}


### 2. Lazy Loading and Virtualization


{% raw %}
```javascript
import { useState, useEffect, useRef, useCallback } from 'react';
import { FlatList, View, Text } from 'react-native';

const LazyLoadingList = ({ data, renderItem, itemHeight = 80 }) => {
  const [visibleItems, setVisibleItems] = useState([]);
  const [loading, setLoading] = useState(false);
  const pageSize = 20;
  const currentPageRef = useRef(0);

  const loadMoreItems = useCallback(async () => {
    if (loading) return;

    setLoading(true);
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 500));
    
    const startIndex = currentPageRef.current * pageSize;
    const endIndex = startIndex + pageSize;
    const newItems = data.slice(startIndex, endIndex);
    
    setVisibleItems(prev => [...prev, ...newItems]);
    currentPageRef.current++;
    setLoading(false);
  }, [data, loading, pageSize]);

  useEffect(() => {
    loadMoreItems();
  }, [loadMoreItems]);

  const handleEndReached = useCallback(() => {
    if (visibleItems.length < data.length) {
      loadMoreItems();
    }
  }, [visibleItems.length, data.length, loadMoreItems]);

  const getItemLayout = useCallback((data, index) => ({
    length: itemHeight,
    offset: itemHeight * index,
    index,
  }), [itemHeight]);

  return (
    <FlatList
      data={visibleItems}
      renderItem={renderItem}
      onEndReached={handleEndReached}
      onEndReachedThreshold={0.5}
      getItemLayout={getItemLayout}
      // Memory optimization
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
      windowSize={10}
      initialNumToRender={10}
      updateCellsBatchingPeriod={50}
      // Performance optimization
      keyExtractor={(item) => item.id.toString()}
      ListFooterComponent={loading ? <Text>Loading...</Text> : null}
    />
  );
};
```
{% endraw %}


## Memory-Efficient Data Handling

### 1. Efficient Data Structures


{% raw %}
```javascript
import { useMemo, useCallback } from 'react';

const EfficientDataHandling = () => {
  const [rawData, setRawData] = useState([]);

  // Use Map for O(1) lookups instead of Array.find()
  const dataMap = useMemo(() => {
    const map = new Map();
    rawData.forEach(item => {
      map.set(item.id, item);
    });
    return map;
  }, [rawData]);

  // Use Set for unique values
  const uniqueCategories = useMemo(() => {
    return new Set(rawData.map(item => item.category));
  }, [rawData]);

  // Efficient filtering with pre-computed values
  const activeItems = useMemo(() => 
    rawData.filter(item => item.active), 
    [rawData]
  );

  // Memoized search function
  const searchItems = useCallback((query) => {
    if (!query) return rawData;
    
    const lowercaseQuery = query.toLowerCase();
    return rawData.filter(item => 
      item.name.toLowerCase().includes(lowercaseQuery) ||
      item.description.toLowerCase().includes(lowercaseQuery)
    );
  }, [rawData]);

  // Efficient item retrieval
  const getItemById = useCallback((id) => {
    return dataMap.get(id);
  }, [dataMap]);

  // Check if category exists
  const hasCategory = useCallback((category) => {
    return uniqueCategories.has(category);
  }, [uniqueCategories]);

  return (
    <View>
      <Text>Efficient Data Handling</Text>
      <Text>Total Items: {rawData.length}</Text>
      <Text>Active Items: {activeItems.length}</Text>
      <Text>Unique Categories: {uniqueCategories.size}</Text>
    </View>
  );
};
```
{% endraw %}


### 2. Object Pooling for Frequent Operations


{% raw %}
```javascript
import { useRef, useCallback } from 'react';

// Object pool for frequently created/destroyed objects
class ObjectPool {
  constructor(createFn, resetFn, initialSize = 10) {
    this.createFn = createFn;
    this.resetFn = resetFn;
    this.pool = [];
    this.active = new Set();
    
    // Pre-populate pool
    for (let i = 0; i < initialSize; i++) {
      this.pool.push(this.createFn());
    }
  }

  acquire() {
    let obj = this.pool.pop();
    if (!obj) {
      obj = this.createFn();
    }
    this.active.add(obj);
    return obj;
  }

  release(obj) {
    if (this.active.has(obj)) {
      this.active.delete(obj);
      this.resetFn(obj);
      this.pool.push(obj);
    }
  }

  clear() {
    this.pool.length = 0;
    this.active.clear();
  }

  getStats() {
    return {
      poolSize: this.pool.length,
      activeCount: this.active.size,
      totalCreated: this.pool.length + this.active.size
    };
  }
}

// Usage example
const useObjectPool = () => {
  const poolRef = useRef(null);

  useEffect(() => {
    poolRef.current = new ObjectPool(
      () => ({ id: 0, data: null, timestamp: 0, active: false }),
      (obj) => {
        obj.id = 0;
        obj.data = null;
        obj.timestamp = 0;
        obj.active = false;
      }
    );

    return () => {
      poolRef.current?.clear();
    };
  }, []);

  const getObject = useCallback(() => {
    return poolRef.current?.acquire();
  }, []);

  const releaseObject = useCallback((obj) => {
    poolRef.current?.release(obj);
  }, []);

  const getPoolStats = useCallback(() => {
    return poolRef.current?.getStats();
  }, []);

  return { getObject, releaseObject, getPoolStats };
};
```
{% endraw %}


## Event Handling Optimization

### 1. Efficient Event Listeners


{% raw %}
```javascript
import { useEffect, useRef, useCallback } from 'react';
import { AppState, Dimensions, NetInfo } from 'react-native';

const OptimizedEventHandling = () => {
  const subscriptionsRef = useRef([]);
  const isMountedRef = useRef(true);

  useEffect(() => {
    // App State listener
    const appStateSubscription = AppState.addEventListener('change', (nextAppState) => {
      if (isMountedRef.current) {
        console.log('App state changed to:', nextAppState);
      }
    });

    // Dimensions listener
    const dimensionsSubscription = Dimensions.addEventListener('change', ({ window }) => {
      if (isMountedRef.current) {
        console.log('Screen dimensions changed:', window);
      }
    });

    // Network state listener
    const netInfoSubscription = NetInfo.addEventListener(state => {
      if (isMountedRef.current) {
        console.log('Network state:', state);
      }
    });

    // Store subscriptions for cleanup
    subscriptionsRef.current = [
      appStateSubscription,
      dimensionsSubscription,
      netInfoSubscription
    ];

    return () => {
      isMountedRef.current = false;
      subscriptionsRef.current.forEach(subscription => {
        subscription?.remove();
      });
      subscriptionsRef.current = [];
    };
  }, []);

  return <View>Optimized Event Handling</View>;
};
```
{% endraw %}


### 2. Debounced and Throttled Functions


{% raw %}
```javascript
import { useCallback, useRef } from 'react';

// Debounce hook
const useDebounce = (callback, delay) => {
  const timeoutRef = useRef(null);

  const debouncedCallback = useCallback((...args) => {
    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current);
    }
    
    timeoutRef.current = setTimeout(() => {
      callback(...args);
    }, delay);
  }, [callback, delay]);

  useEffect(() => {
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, []);

  return debouncedCallback;
};

// Throttle hook
const useThrottle = (callback, delay) => {
  const lastCallRef = useRef(0);
  const timeoutRef = useRef(null);

  const throttledCallback = useCallback((...args) => {
    const now = Date.now();
    
    if (now - lastCallRef.current >= delay) {
      lastCallRef.current = now;
      callback(...args);
    } else {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
      
      timeoutRef.current = setTimeout(() => {
        lastCallRef.current = Date.now();
        callback(...args);
      }, delay - (now - lastCallRef.current));
    }
  }, [callback, delay]);

  useEffect(() => {
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, []);

  return throttledCallback;
};

// Usage example
const SearchComponent = () => {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);

  const search = useCallback(async (searchQuery) => {
    if (!searchQuery.trim()) {
      setResults([]);
      return;
    }

    try {
      const response = await fetch(`/api/search?q=${encodeURIComponent(searchQuery)}`);
      const data = await response.json();
      setResults(data.results);
    } catch (error) {
      console.error('Search error:', error);
    }
  }, []);

  const debouncedSearch = useDebounce(search, 300);

  const handleQueryChange = useCallback((text) => {
    setQuery(text);
    debouncedSearch(text);
  }, [debouncedSearch]);

  return (
    <View>
      <TextInput
        value={query}
        onChangeText={handleQueryChange}
        placeholder="Search..."
      />
      {results.map(result => (
        <Text key={result.id}>{result.title}</Text>
      ))}
    </View>
  );
};
```
{% endraw %}


## Memory Monitoring and Cleanup

### 1. Automatic Cleanup Hooks


{% raw %}
```javascript
import { useEffect, useRef } from 'react';

// Custom hook for automatic cleanup
const useCleanup = () => {
  const cleanupFunctionsRef = useRef([]);

  const addCleanup = useCallback((cleanupFn) => {
    cleanupFunctionsRef.current.push(cleanupFn);
  }, []);

  const removeCleanup = useCallback((cleanupFn) => {
    const index = cleanupFunctionsRef.current.indexOf(cleanupFn);
    if (index > -1) {
      cleanupFunctionsRef.current.splice(index, 1);
    }
  }, []);

  useEffect(() => {
    return () => {
      cleanupFunctionsRef.current.forEach(cleanup => {
        try {
          cleanup();
        } catch (error) {
          console.error('Cleanup error:', error);
        }
      });
      cleanupFunctionsRef.current = [];
    };
  }, []);

  return { addCleanup, removeCleanup };
};

// Usage example
const ComponentWithCleanup = () => {
  const { addCleanup } = useCleanup();
  const intervalRef = useRef(null);
  const subscriptionRef = useRef(null);

  useEffect(() => {
    // Set up interval
    intervalRef.current = setInterval(() => {
      console.log('Interval tick');
    }, 1000);

    // Set up subscription
    subscriptionRef.current = NetInfo.addEventListener(state => {
      console.log('Network state:', state);
    });

    // Add cleanup functions
    addCleanup(() => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
      }
    });

    addCleanup(() => {
      subscriptionRef.current?.remove();
    });

  }, [addCleanup]);

  return <View>Component with Cleanup</View>;
};
```
{% endraw %}


### 2. Memory Pressure Handling


{% raw %}
```javascript
import { useEffect, useState, useCallback } from 'react';
import { AppState } from 'react-native';

const useMemoryPressure = () => {
  const [pressureLevel, setPressureLevel] = useState('normal');
  const [memoryWarnings, setMemoryWarnings] = useState(0);
  const cleanupFunctionsRef = useRef([]);

  const handleMemoryWarning = useCallback(() => {
    setMemoryWarnings(prev => prev + 1);
    setPressureLevel('high');
    
    // Execute cleanup functions
    cleanupFunctionsRef.current.forEach(cleanup => {
      try {
        cleanup();
      } catch (error) {
        console.error('Memory cleanup error:', error);
      }
    });
    
    // Force garbage collection if available
    if (global.gc) {
      global.gc();
    }
  }, []);

  const handleAppStateChange = useCallback((nextAppState) => {
    if (nextAppState === 'background') {
      setPressureLevel('low');
      // Clear non-essential data when app goes to background
      cleanupFunctionsRef.current.forEach(cleanup => {
        try {
          cleanup();
        } catch (error) {
          console.error('Background cleanup error:', error);
        }
      });
    } else if (nextAppState === 'active') {
      setPressureLevel('normal');
    }
  }, []);

  const addMemoryCleanup = useCallback((cleanupFn) => {
    cleanupFunctionsRef.current.push(cleanupFn);
  }, []);

  useEffect(() => {
    const memoryWarningSubscription = AppState.addEventListener('memoryWarning', handleMemoryWarning);
    const appStateSubscription = AppState.addEventListener('change', handleAppStateChange);

    return () => {
      memoryWarningSubscription?.remove();
      appStateSubscription?.remove();
    };
  }, [handleMemoryWarning, handleAppStateChange]);

  return {
    pressureLevel,
    memoryWarnings,
    addMemoryCleanup
  };
};
```
{% endraw %}


## Performance Testing and Monitoring

### 1. Memory Performance Tests


{% raw %}
```javascript
import { render, cleanup } from '@testing-library/react-native';

describe('Memory Performance Tests', () => {
  let initialMemory;

  beforeEach(() => {
    initialMemory = global.performance?.memory?.usedJSHeapSize || 0;
  });

  afterEach(() => {
    cleanup();
    if (global.gc) {
      global.gc();
    }
  });

  it('should not leak memory during component lifecycle', async () => {
    const { unmount } = render(<MyComponent />);
    
    // Simulate user interactions
    fireEvent.press(screen.getByText('Button'));
    fireEvent.scroll(screen.getByTestId('list'), { nativeEvent: { contentOffset: { y: 1000 } } });
    
    unmount();
    
    // Wait for GC
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    const finalMemory = global.performance?.memory?.usedJSHeapSize || 0;
    const memoryIncrease = finalMemory - initialMemory;
    
    // Allow for 1MB increase (tolerance for test overhead)
    expect(memoryIncrease).toBeLessThan(1024 * 1024);
  });

  it('should handle memory pressure gracefully', () => {
    const { getByText } = render(<MemoryPressureComponent />);
    
    // Simulate memory warning
    fireEvent(getByText('Trigger Memory Warning'), 'memoryWarning');
    
    expect(getByText('Memory pressure handled')).toBeTruthy();
  });

  it('should efficiently handle large datasets', () => {
    const largeDataset = Array.from({ length: 10000 }, (_, i) => ({
      id: i,
      name: `Item ${i}`,
      data: `Data ${i}`
    }));

    const { unmount } = render(<LargeList data={largeDataset} />);
    
    // Test scrolling performance
    const list = screen.getByTestId('large-list');
    fireEvent.scroll(list, { nativeEvent: { contentOffset: { y: 1000 } } });
    
    unmount();
  });
});
```
{% endraw %}


## Summary

Memory optimization best practices in React Native include:

1. **Component Optimization**: Memoization, efficient state management, optimized rendering
2. **Image and Media**: Efficient loading, caching, lazy loading, virtualization
3. **Data Handling**: Efficient data structures, object pooling, optimized operations
4. **Event Handling**: Proper cleanup, debouncing, throttling
5. **Memory Monitoring**: Automatic cleanup, memory pressure handling
6. **Performance Testing**: Memory leak testing, performance monitoring

## Key Takeaways

- Use memoization to prevent unnecessary re-renders and calculations
- Implement proper cleanup for event listeners, timers, and subscriptions
- Use efficient data structures (Map, Set) for better performance
- Implement object pooling for frequently created/destroyed objects
- Use lazy loading and virtualization for large datasets
- Monitor memory usage and handle memory pressure gracefully
- Test for memory leaks as part of your development workflow
- Optimize images and media to reduce memory footprint
- Use debouncing and throttling for performance-critical operations
- Implement automatic cleanup mechanisms to prevent memory leaks

