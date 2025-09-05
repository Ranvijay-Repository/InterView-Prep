# 📊 **Performance Profiling**

> **Master performance profiling techniques and tools to identify bottlenecks and optimize React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Performance Monitoring](#performance-monitoring)
- [Profiling Tools](#profiling-tools)
- [Memory Profiling](#memory-profiling)
- [Network Profiling](#network-profiling)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Performance profiling is essential for identifying bottlenecks and optimizing React Native applications. Understanding profiling tools and techniques helps create smooth, efficient applications.

### **Performance Profiling Overview**

```
┌─────────────────────────────────────┐
│        Performance Profiling        │
│  ┌─────────────────────────────────┐│
│  │        Monitoring Tools         ││
│  │  - Flipper                     ││
│  │  - React DevTools              ││
│  │  - Chrome DevTools             ││
│  │  - Native profilers            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Profiling Areas          ││
│  │  - JavaScript performance       ││
│  │  - Memory usage                ││
│  │  - Network requests            ││
│  │  - Native performance          ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Optimization Strategies  ││
│  │  - Code splitting              ││
│  │  - Lazy loading                ││
│  │  - Memory management           ││
│  │  - Bundle optimization         ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 📊 **Performance Monitoring**

### **Performance Monitoring Component**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState, useEffect, useRef, useCallback } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, FlatList, Alert } from 'react-native';

const PerformanceMonitor = () => {
  const [metrics, setMetrics] = useState({
    frameRate: 60,
    memoryUsage: 0,
    renderTime: 0,
    networkRequests: 0,
    errors: 0,
  });
  
  const [performanceLog, setPerformanceLog] = useState([]);
  const [isMonitoring, setIsMonitoring] = useState(false);
  const frameCount = useRef(0);
  const lastTime = useRef(Date.now());
  const animationFrame = useRef(null);
  
  // Start performance monitoring
  const startMonitoring = useCallback(() => {
    setIsMonitoring(true);
    frameCount.current = 0;
    lastTime.current = Date.now();
    
    const measureFrameRate = () => {
      if (!isMonitoring) return;
      
      frameCount.current++;
      const currentTime = Date.now();
      const deltaTime = currentTime - lastTime.current;
      
      if (deltaTime >= 1000) {
        const fps = Math.round((frameCount.current * 1000) / deltaTime);
        setMetrics(prev => ({
          ...prev,
          frameRate: fps,
        }));
        
        frameCount.current = 0;
        lastTime.current = currentTime;
      }
      
      animationFrame.current = requestAnimationFrame(measureFrameRate);
    };
    
    measureFrameRate();
  }, [isMonitoring]);
  
  // Stop performance monitoring
  const stopMonitoring = useCallback(() => {
    setIsMonitoring(false);
    if (animationFrame.current) {
      cancelAnimationFrame(animationFrame.current);
    }
  }, []);
  
  // Simulate heavy operation
  const simulateHeavyOperation = useCallback(() => {
    const startTime = performance.now();
    
    // Simulate heavy computation
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
      result += Math.random();
    }
    
    const endTime = performance.now();
    const renderTime = endTime - startTime;
    
    setMetrics(prev => ({
      ...prev,
      renderTime: Math.round(renderTime),
    }));
    
    // Log performance
    setPerformanceLog(prev => [
      ...prev,
      {
        id: Date.now(),
        operation: 'Heavy Computation',
        duration: Math.round(renderTime),
        timestamp: new Date().toLocaleTimeString(),
      },
    ]);
  }, []);
  
  // Simulate network request
  const simulateNetworkRequest = useCallback(async () => {
    const startTime = performance.now();
    
    try {
      // Simulate network delay
      await new Promise(resolve => setTimeout(resolve, Math.random() * 1000 + 500));
      
      const endTime = performance.now();
      const duration = endTime - startTime;
      
      setMetrics(prev => ({
        ...prev,
        networkRequests: prev.networkRequests + 1,
      }));
      
      // Log network performance
      setPerformanceLog(prev => [
        ...prev,
        {
          id: Date.now(),
          operation: 'Network Request',
          duration: Math.round(duration),
          timestamp: new Date().toLocaleTimeString(),
        },
      ]);
    } catch (error) {
      setMetrics(prev => ({
        ...prev,
        errors: prev.errors + 1,
      }));
    }
  }, []);
  
  // Clear performance log
  const clearLog = useCallback(() => {
    setPerformanceLog([]);
    setMetrics({
      frameRate: 60,
      memoryUsage: 0,
      renderTime: 0,
      networkRequests: 0,
      errors: 0,
    });
  }, []);
  
  // Get performance recommendations
  const getRecommendations = useCallback(() => {
    const recommendations = [];
    
    if (metrics.frameRate < 30) {
      recommendations.push('Low frame rate detected. Consider optimizing rendering.');
    }
    
    if (metrics.renderTime > 100) {
      recommendations.push('Slow render time. Check for expensive operations.');
    }
    
    if (metrics.networkRequests > 10) {
      recommendations.push('High network usage. Consider caching strategies.');
    }
    
    if (metrics.errors > 0) {
      recommendations.push('Errors detected. Check error handling.');
    }
    
    return recommendations;
  }, [metrics]);
  
  // Render performance log item
  const renderLogItem = useCallback(({ item }) => (
    <View style={styles.logItem}>
      <Text style={styles.logOperation}>{item.operation}</Text>
      <Text style={styles.logDuration}>{item.duration}ms</Text>
      <Text style={styles.logTimestamp}>{item.timestamp}</Text>
    </View>
  ), []);
  
  // Memoized key extractor
  const keyExtractor = useCallback((item) => item.id.toString(), []);
  
  useEffect(() => {
    if (isMonitoring) {
      startMonitoring();
    } else {
      stopMonitoring();
    }
    
    return () => {
      stopMonitoring();
    };
  }, [isMonitoring, startMonitoring, stopMonitoring]);
  
  const recommendations = getRecommendations();
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Performance Monitor</Text>
      
      {/* Metrics Display */}
      <View style={styles.metricsContainer}>
        <Text style={styles.metricsTitle}>Performance Metrics</Text>
        <View style={styles.metricsGrid}>
          <View style={styles.metricItem}>
            <Text style={styles.metricLabel}>Frame Rate</Text>
            <Text style={[styles.metricValue, { color: metrics.frameRate < 30 ? '#FF3B30' : '#34C759' }]}>
              {metrics.frameRate} FPS
            </Text>
          </View>
          <View style={styles.metricItem}>
            <Text style={styles.metricLabel}>Render Time</Text>
            <Text style={[styles.metricValue, { color: metrics.renderTime > 100 ? '#FF3B30' : '#34C759' }]}>
              {metrics.renderTime}ms
            </Text>
          </View>
          <View style={styles.metricItem}>
            <Text style={styles.metricLabel}>Network Requests</Text>
            <Text style={styles.metricValue}>{metrics.networkRequests}</Text>
          </View>
          <View style={styles.metricItem}>
            <Text style={styles.metricLabel}>Errors</Text>
            <Text style={[styles.metricValue, { color: metrics.errors > 0 ? '#FF3B30' : '#34C759' }]}>
              {metrics.errors}
            </Text>
          </View>
        </View>
      </View>
      
      {/* Controls */}
      <View style={styles.controlsContainer}>
        <TouchableOpacity
          style={[styles.controlButton, isMonitoring ? styles.stopButton : styles.startButton]}
          onPress={() => setIsMonitoring(!isMonitoring)}
        >
          <Text style={styles.controlButtonText}>
            {isMonitoring ? 'Stop Monitoring' : 'Start Monitoring'}
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.controlButton}
          onPress={simulateHeavyOperation}
        >
          <Text style={styles.controlButtonText}>Heavy Operation</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.controlButton}
          onPress={simulateNetworkRequest}
        >
          <Text style={styles.controlButtonText}>Network Request</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[styles.controlButton, styles.clearButton]}
          onPress={clearLog}
        >
          <Text style={styles.controlButtonText}>Clear Log</Text>
        </TouchableOpacity>
      </View>
      
      {/* Recommendations */}
      {recommendations.length > 0 && (
        <View style={styles.recommendationsContainer}>
          <Text style={styles.recommendationsTitle}>Recommendations</Text>
          {recommendations.map((recommendation, index) => (
            <Text key={index} style={styles.recommendationText}>
              • {recommendation}
            </Text>
          ))}
        </View>
      )}
      
      {/* Performance Log */}
      <View style={styles.logContainer}>
        <Text style={styles.logTitle}>Performance Log</Text>
        <FlatList
          data={performanceLog}
          renderItem={renderLogItem}
          keyExtractor={keyExtractor}
          style={styles.logList}
          showsVerticalScrollIndicator={false}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    padding: 20,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  metricsContainer: {
    backgroundColor: 'white',
    margin: 10,
    padding: 20,
    borderRadius: 10,
  },
  metricsTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#333',
  },
  metricsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  metricItem: {
    width: '48%',
    alignItems: 'center',
    marginBottom: 15,
  },
  metricLabel: {
    fontSize: 14,
    color: '#666',
    marginBottom: 5,
  },
  metricValue: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  controlsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-around',
    padding: 10,
    backgroundColor: 'white',
    margin: 10,
    borderRadius: 10,
  },
  controlButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 6,
    margin: 5,
  },
  startButton: {
    backgroundColor: '#34C759',
  },
  stopButton: {
    backgroundColor: '#FF3B30',
  },
  clearButton: {
    backgroundColor: '#FF9500',
  },
  controlButtonText: {
    color: 'white',
    fontSize: 12,
    fontWeight: 'bold',
  },
  recommendationsContainer: {
    backgroundColor: '#FFF3CD',
    margin: 10,
    padding: 15,
    borderRadius: 10,
  },
  recommendationsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#856404',
    marginBottom: 10,
  },
  recommendationText: {
    fontSize: 14,
    color: '#856404',
    marginBottom: 5,
  },
  logContainer: {
    flex: 1,
    backgroundColor: 'white',
    margin: 10,
    borderRadius: 10,
    padding: 15,
  },
  logTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#333',
  },
  logList: {
    flex: 1,
  },
  logItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  logOperation: {
    fontSize: 14,
    color: '#333',
    flex: 1,
  },
  logDuration: {
    fontSize: 14,
    color: '#007AFF',
    fontWeight: 'bold',
    marginHorizontal: 10,
  },
  logTimestamp: {
    fontSize: 12,
    color: '#666',
  },
});

export default PerformanceMonitor;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="./03-Image-Optimization-Caching.md" class="nav-link prev">⬅️ Previous: Image Optimization & Caching</a>
    <a href="../06-Animations-Gestures/01-Animated-API-LayoutAnimation.md" class="nav-link next">Next: Animated API & LayoutAnimation ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
