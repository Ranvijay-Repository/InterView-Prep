# Memory Profiling Tools for React Native

## Overview

Memory profiling tools are essential for identifying memory leaks, optimizing performance, and understanding memory usage patterns in React Native applications. This guide covers various tools and techniques for effective memory profiling.

## Built-in React Native Tools

### 1. Flipper Integration

```javascript
import { useEffect, useState } from 'react';
import { View, Text, Button } from 'react-native';

const FlipperMemoryProfiler = () => {
  const [memoryData, setMemoryData] = useState(null);

  useEffect(() => {
    // Flipper memory plugin integration
    if (global.__flipper) {
      const memoryPlugin = global.__flipper.getPlugin('Memory');
      
      if (memoryPlugin) {
        const startProfiling = () => {
          memoryPlugin.startProfiling();
        };

        const stopProfiling = () => {
          const data = memoryPlugin.stopProfiling();
          setMemoryData(data);
        };

        // Expose functions to Flipper
        global.__flipperMemoryProfiler = {
          startProfiling,
          stopProfiling,
          getMemoryData: () => memoryData
        };
      }
    }
  }, []);

  return (
    <View style={{ padding: 20 }}>
      <Text>Flipper Memory Profiler</Text>
      {memoryData && (
        <Text>Memory Data: {JSON.stringify(memoryData, null, 2)}</Text>
      )}
    </View>
  );
};
```

### 2. React DevTools Profiler

```javascript
import { Profiler } from 'react';
import { View, Text } from 'react-native';

const ProfilerExample = () => {
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

  return (
    <Profiler id="MyComponent" onRender={onRenderCallback}>
      <View>
        <Text>Profiled Component</Text>
      </View>
    </Profiler>
  );
};
```

## Custom Memory Monitoring

### 1. Memory Usage Tracker

```javascript
import { useEffect, useState, useRef } from 'react';
import { View, Text, ScrollView } from 'react-native';

const MemoryTracker = () => {
  const [memoryHistory, setMemoryHistory] = useState([]);
  const [currentMemory, setCurrentMemory] = useState(null);
  const intervalRef = useRef(null);

  useEffect(() => {
    const trackMemory = () => {
      if (global.performance && global.performance.memory) {
        const memory = global.performance.memory;
        const memoryInfo = {
          timestamp: Date.now(),
          used: Math.round(memory.usedJSHeapSize / 1024 / 1024),
          total: Math.round(memory.totalJSHeapSize / 1024 / 1024),
          limit: Math.round(memory.jsHeapSizeLimit / 1024 / 1024),
          percentage: Math.round((memory.usedJSHeapSize / memory.jsHeapSizeLimit) * 100)
        };

        setCurrentMemory(memoryInfo);
        setMemoryHistory(prev => [...prev.slice(-50), memoryInfo]); // Keep last 50 entries
      }
    };

    intervalRef.current = setInterval(trackMemory, 1000);
    trackMemory(); // Initial measurement

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
      }
    };
  }, []);

  const getMemoryTrend = () => {
    if (memoryHistory.length < 2) return 'stable';
    
    const recent = memoryHistory.slice(-5);
    const older = memoryHistory.slice(-10, -5);
    
    const recentAvg = recent.reduce((sum, m) => sum + m.used, 0) / recent.length;
    const olderAvg = older.reduce((sum, m) => sum + m.used, 0) / older.length;
    
    if (recentAvg > olderAvg * 1.1) return 'increasing';
    if (recentAvg < olderAvg * 0.9) return 'decreasing';
    return 'stable';
  };

  return (
    <ScrollView style={{ padding: 20 }}>
      <Text style={{ fontSize: 18, fontWeight: 'bold' }}>Memory Tracker</Text>
      
      {currentMemory && (
        <View style={{ marginTop: 10 }}>
          <Text>Current Memory Usage:</Text>
          <Text>Used: {currentMemory.used} MB</Text>
          <Text>Total: {currentMemory.total} MB</Text>
          <Text>Limit: {currentMemory.limit} MB</Text>
          <Text>Percentage: {currentMemory.percentage}%</Text>
          <Text>Trend: {getMemoryTrend()}</Text>
        </View>
      )}

      <View style={{ marginTop: 20 }}>
        <Text style={{ fontWeight: 'bold' }}>Memory History:</Text>
        {memoryHistory.slice(-10).map((entry, index) => (
          <Text key={index}>
            {new Date(entry.timestamp).toLocaleTimeString()}: {entry.used}MB ({entry.percentage}%)
          </Text>
        ))}
      </View>
    </ScrollView>
  );
};
```

### 2. Component Memory Profiler

```javascript
import { useEffect, useRef, useState } from 'react';
import { View, Text, Button } from 'react-native';

const ComponentMemoryProfiler = () => {
  const [components, setComponents] = useState(new Map());
  const [isProfiling, setIsProfiling] = useState(false);
  const profilerRef = useRef(null);

  useEffect(() => {
    profilerRef.current = {
      startProfiling: (componentName) => {
        const startMemory = global.performance?.memory?.usedJSHeapSize || 0;
        const startTime = Date.now();
        
        setComponents(prev => new Map(prev.set(componentName, {
          startMemory,
          startTime,
          endMemory: null,
          endTime: null,
          memoryDelta: null,
          duration: null
        })));
      },
      
      endProfiling: (componentName) => {
        const endMemory = global.performance?.memory?.usedJSHeapSize || 0;
        const endTime = Date.now();
        
        setComponents(prev => {
          const component = prev.get(componentName);
          if (component) {
            const updated = {
              ...component,
              endMemory,
              endTime,
              memoryDelta: endMemory - component.startMemory,
              duration: endTime - component.startTime
            };
            return new Map(prev.set(componentName, updated));
          }
          return prev;
        });
      }
    };
  }, []);

  const startProfiling = () => {
    setIsProfiling(true);
    profilerRef.current?.startProfiling('MyComponent');
  };

  const endProfiling = () => {
    setIsProfiling(false);
    profilerRef.current?.endProfiling('MyComponent');
  };

  return (
    <View style={{ padding: 20 }}>
      <Text>Component Memory Profiler</Text>
      
      <View style={{ marginTop: 20 }}>
        <Button
          title={isProfiling ? "Stop Profiling" : "Start Profiling"}
          onPress={isProfiling ? endProfiling : startProfiling}
        />
      </View>

      <View style={{ marginTop: 20 }}>
        {Array.from(components.entries()).map(([name, data]) => (
          <View key={name} style={{ marginBottom: 10 }}>
            <Text style={{ fontWeight: 'bold' }}>{name}:</Text>
            <Text>Start Memory: {data.startMemory} bytes</Text>
            <Text>End Memory: {data.endMemory || 'N/A'} bytes</Text>
            <Text>Memory Delta: {data.memoryDelta || 'N/A'} bytes</Text>
            <Text>Duration: {data.duration || 'N/A'} ms</Text>
          </View>
        ))}
      </View>
    </View>
  );
};
```

## Advanced Memory Profiling

### 1. Heap Snapshot Analysis

```javascript
import { useEffect, useRef } from 'react';

const HeapSnapshotProfiler = () => {
  const snapshotRef = useRef(null);

  useEffect(() => {
    const takeHeapSnapshot = () => {
      if (global.performance && global.performance.memory) {
        const memory = global.performance.memory;
        const snapshot = {
          timestamp: Date.now(),
          usedJSHeapSize: memory.usedJSHeapSize,
          totalJSHeapSize: memory.totalJSHeapSize,
          jsHeapSizeLimit: memory.jsHeapSizeLimit,
          // Additional context
          userAgent: global.navigator?.userAgent,
          platform: global.Platform?.OS,
          version: global.Platform?.Version
        };
        
        snapshotRef.current = snapshot;
        console.log('Heap Snapshot:', snapshot);
        
        return snapshot;
      }
      return null;
    };

    const compareSnapshots = (snapshot1, snapshot2) => {
      if (!snapshot1 || !snapshot2) return null;
      
      return {
        memoryDelta: snapshot2.usedJSHeapSize - snapshot1.usedJSHeapSize,
        timeDelta: snapshot2.timestamp - snapshot1.timestamp,
        percentageChange: ((snapshot2.usedJSHeapSize - snapshot1.usedJSHeapSize) / snapshot1.usedJSHeapSize) * 100
      };
    };

    // Expose functions globally for debugging
    global.__heapProfiler = {
      takeSnapshot: takeHeapSnapshot,
      compareSnapshots,
      getCurrentSnapshot: () => snapshotRef.current
    };
  }, []);

  return <View>Heap Snapshot Profiler</View>;
};
```

### 2. Memory Leak Detector

```javascript
import { useEffect, useRef, useState } from 'react';
import { View, Text, Button } from 'react-native';

const MemoryLeakDetector = () => {
  const [leakReport, setLeakReport] = useState(null);
  const memoryHistoryRef = useRef([]);
  const componentRefsRef = useRef(new Set());
  const timerRefsRef = useRef(new Set());

  useEffect(() => {
    const trackMemory = () => {
      if (global.performance && global.performance.memory) {
        const memory = global.performance.memory;
        const memoryInfo = {
          timestamp: Date.now(),
          used: memory.usedJSHeapSize,
          total: memory.totalJSHeapSize
        };
        
        memoryHistoryRef.current.push(memoryInfo);
        
        // Keep only last 100 entries
        if (memoryHistoryRef.current.length > 100) {
          memoryHistoryRef.current.shift();
        }
      }
    };

    const interval = setInterval(trackMemory, 1000);
    trackMemory();

    return () => clearInterval(interval);
  }, []);

  const detectLeaks = () => {
    const history = memoryHistoryRef.current;
    if (history.length < 10) {
      setLeakReport({ error: 'Not enough data for leak detection' });
      return;
    }

    // Analyze memory trend
    const recent = history.slice(-5);
    const older = history.slice(-10, -5);
    
    const recentAvg = recent.reduce((sum, m) => sum + m.used, 0) / recent.length;
    const olderAvg = older.reduce((sum, m) => sum + m.used, 0) / older.length;
    
    const growthRate = (recentAvg - olderAvg) / olderAvg;
    const isLeaking = growthRate > 0.1; // 10% growth threshold
    
    const report = {
      isLeaking,
      growthRate: Math.round(growthRate * 100),
      recentAverage: Math.round(recentAvg / 1024 / 1024),
      olderAverage: Math.round(olderAvg / 1024 / 1024),
      componentRefs: componentRefsRef.current.size,
      timerRefs: timerRefsRef.current.size,
      recommendations: []
    };

    if (isLeaking) {
      report.recommendations.push('Memory usage is increasing - check for memory leaks');
    }
    
    if (componentRefsRef.current.size > 100) {
      report.recommendations.push('High number of component references - consider cleanup');
    }
    
    if (timerRefsRef.current.size > 10) {
      report.recommendations.push('High number of timers - ensure proper cleanup');
    }

    setLeakReport(report);
  };

  const clearReferences = () => {
    componentRefsRef.current.clear();
    timerRefsRef.current.clear();
    memoryHistoryRef.current = [];
    setLeakReport(null);
  };

  return (
    <View style={{ padding: 20 }}>
      <Text style={{ fontSize: 18, fontWeight: 'bold' }}>Memory Leak Detector</Text>
      
      <View style={{ marginTop: 20 }}>
        <Button title="Detect Leaks" onPress={detectLeaks} />
        <Button title="Clear References" onPress={clearReferences} />
      </View>

      {leakReport && (
        <View style={{ marginTop: 20 }}>
          <Text style={{ fontWeight: 'bold' }}>Leak Report:</Text>
          <Text>Is Leaking: {leakReport.isLeaking ? 'Yes' : 'No'}</Text>
          <Text>Growth Rate: {leakReport.growthRate}%</Text>
          <Text>Recent Average: {leakReport.recentAverage} MB</Text>
          <Text>Older Average: {leakReport.olderAverage} MB</Text>
          <Text>Component Refs: {leakReport.componentRefs}</Text>
          <Text>Timer Refs: {leakReport.timerRefs}</Text>
          
          {leakReport.recommendations.length > 0 && (
            <View style={{ marginTop: 10 }}>
              <Text style={{ fontWeight: 'bold' }}>Recommendations:</Text>
              {leakReport.recommendations.map((rec, index) => (
                <Text key={index}>• {rec}</Text>
              ))}
            </View>
          )}
        </View>
      )}
    </View>
  );
};
```

## Performance Monitoring

### 1. Frame Rate Monitor

```javascript
import { useEffect, useState, useRef } from 'react';
import { View, Text } from 'react-native';

const FrameRateMonitor = () => {
  const [fps, setFps] = useState(0);
  const [frameDrops, setFrameDrops] = useState(0);
  const frameCountRef = useRef(0);
  const lastTimeRef = useRef(Date.now());
  const frameTimesRef = useRef([]);

  useEffect(() => {
    const measureFrameRate = () => {
      const now = Date.now();
      const deltaTime = now - lastTimeRef.current;
      
      frameCountRef.current++;
      frameTimesRef.current.push(deltaTime);
      
      // Keep only last 60 frame times
      if (frameTimesRef.current.length > 60) {
        frameTimesRef.current.shift();
      }
      
      // Calculate FPS every second
      if (frameCountRef.current % 60 === 0) {
        const avgFrameTime = frameTimesRef.current.reduce((sum, time) => sum + time, 0) / frameTimesRef.current.length;
        const currentFps = Math.round(1000 / avgFrameTime);
        setFps(currentFps);
        
        // Count frame drops (frames taking longer than 16.67ms for 60fps)
        const drops = frameTimesRef.current.filter(time => time > 16.67).length;
        setFrameDrops(drops);
      }
      
      lastTimeRef.current = now;
      requestAnimationFrame(measureFrameRate);
    };

    const rafId = requestAnimationFrame(measureFrameRate);
    
    return () => {
      cancelAnimationFrame(rafId);
    };
  }, []);

  const getPerformanceStatus = () => {
    if (fps >= 55) return { status: 'Excellent', color: 'green' };
    if (fps >= 45) return { status: 'Good', color: 'orange' };
    if (fps >= 30) return { status: 'Fair', color: 'red' };
    return { status: 'Poor', color: 'darkred' };
  };

  const performance = getPerformanceStatus();

  return (
    <View style={{ padding: 20 }}>
      <Text style={{ fontSize: 18, fontWeight: 'bold' }}>Frame Rate Monitor</Text>
      <Text style={{ color: performance.color }}>FPS: {fps}</Text>
      <Text>Frame Drops: {frameDrops}</Text>
      <Text>Status: {performance.status}</Text>
    </View>
  );
};
```

### 2. Memory Pressure Monitor

```javascript
import { useEffect, useState } from 'react';
import { AppState, View, Text } from 'react-native';

const MemoryPressureMonitor = () => {
  const [pressureLevel, setPressureLevel] = useState('normal');
  const [memoryWarnings, setMemoryWarnings] = useState(0);

  useEffect(() => {
    const handleMemoryWarning = () => {
      setMemoryWarnings(prev => prev + 1);
      setPressureLevel('high');
      
      // Log memory warning
      console.warn('Memory warning received');
      
      // Clear non-essential data
      if (global.gc) {
        global.gc();
      }
    };

    const handleAppStateChange = (nextAppState) => {
      if (nextAppState === 'background') {
        setPressureLevel('low');
      } else if (nextAppState === 'active') {
        setPressureLevel('normal');
      }
    };

    // Listen for memory warnings
    const memoryWarningSubscription = AppState.addEventListener('memoryWarning', handleMemoryWarning);
    const appStateSubscription = AppState.addEventListener('change', handleAppStateChange);

    return () => {
      memoryWarningSubscription?.remove();
      appStateSubscription?.remove();
    };
  }, []);

  const getPressureColor = () => {
    switch (pressureLevel) {
      case 'low': return 'green';
      case 'normal': return 'blue';
      case 'high': return 'red';
      default: return 'gray';
    }
  };

  return (
    <View style={{ padding: 20 }}>
      <Text style={{ fontSize: 18, fontWeight: 'bold' }}>Memory Pressure Monitor</Text>
      <Text style={{ color: getPressureColor() }}>Pressure Level: {pressureLevel}</Text>
      <Text>Memory Warnings: {memoryWarnings}</Text>
    </View>
  );
};
```

## Integration with Development Tools

### 1. Metro Bundle Analyzer

```javascript
// metro.config.js
const { getDefaultConfig } = require('metro-config');

module.exports = (async () => {
  const {
    resolver: { sourceExts, assetExts },
  } = await getDefaultConfig();

  return {
    transformer: {
      babelTransformerPath: require.resolve('react-native-svg-transformer'),
    },
    resolver: {
      assetExts: assetExts.filter(ext => ext !== 'svg'),
      sourceExts: [...sourceExts, 'svg'],
    },
    // Enable bundle analysis
    serializer: {
      createModuleIdFactory: function () {
        return function (path) {
          // Log module paths for analysis
          console.log('Module:', path);
          return path;
        };
      },
    },
  };
})();
```

### 2. Custom Dev Menu Integration

```javascript
import { DevSettings } from 'react-native';

const DevMenuIntegration = () => {
  useEffect(() => {
    // Add custom dev menu items
    DevSettings.addMenuItem('Memory Profile', () => {
      if (global.__heapProfiler) {
        const snapshot = global.__heapProfiler.takeSnapshot();
        console.log('Memory Snapshot:', snapshot);
      }
    });

    DevSettings.addMenuItem('Force GC', () => {
      if (global.gc) {
        global.gc();
        console.log('Garbage collection forced');
      }
    });

    DevSettings.addMenuItem('Clear Caches', () => {
      // Clear various caches
      if (global.__clearCaches) {
        global.__clearCaches();
      }
    });
  }, []);

  return <View>Dev Menu Integration</View>;
};
```

## Testing Memory Profiling

### 1. Memory Test Suite

```javascript
import { render, cleanup } from '@testing-library/react-native';

describe('Memory Profiling Tests', () => {
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
});
```

## Summary

Memory profiling tools for React Native include:

1. **Built-in Tools**: Flipper, React DevTools, Metro Bundle Analyzer
2. **Custom Monitoring**: Memory trackers, component profilers, leak detectors
3. **Performance Monitoring**: Frame rate monitoring, memory pressure detection
4. **Development Integration**: Dev menu integration, automated testing
5. **Advanced Analysis**: Heap snapshots, memory trend analysis

## Key Takeaways

- Use Flipper for comprehensive memory profiling during development
- Implement custom memory monitoring for production insights
- Monitor frame rates and memory pressure in real-time
- Test for memory leaks as part of your test suite
- Integrate memory profiling tools into your development workflow
- Use heap snapshots to analyze memory usage patterns
- Monitor memory trends to detect potential leaks early

