# 📊 **Performance Monitoring**

> **Complete guide to monitoring and optimizing TypeScript application performance, including profiling, metrics, and best practices**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Performance Monitoring Overview](#performance-monitoring-overview)
- [Performance Metrics](#performance-metrics)
- [Profiling Tools](#profiling-tools)
- [Runtime Performance](#runtime-performance)
- [Bundle Analysis](#bundle-analysis)
- [Performance Testing](#performance-testing)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Performance Monitoring Overview**

Performance monitoring helps identify bottlenecks, optimize code, and ensure applications meet performance requirements.

### **Performance Monitoring Areas**


{% raw %}
```typescript
// Performance monitoring areas
const performanceAreas = {
  runtime: "JavaScript execution performance",
  bundle: "Bundle size and loading performance",
  memory: "Memory usage and garbage collection",
  network: "API calls and data transfer",
  rendering: "UI rendering performance"
};

// Performance monitoring tools
const monitoringTools = {
  profiling: "Chrome DevTools, Node.js profiler",
  metrics: "Performance API, custom metrics",
  testing: "Load testing, stress testing",
  analysis: "Bundle analyzers, performance budgets"
};
```
{% endraw %}


### **Performance Metrics**


{% raw %}
```typescript
// Key performance metrics
const performanceMetrics = {
  loadTime: "Time to load and render page",
  firstContentfulPaint: "Time to first contentful paint",
  largestContentfulPaint: "Time to largest contentful paint",
  firstInputDelay: "Time to first input response",
  cumulativeLayoutShift: "Visual stability metric",
  timeToInteractive: "Time until page is interactive"
};
```
{% endraw %}


---

## 📈 **Performance Metrics**

### **Web Performance API**


{% raw %}
```typescript
// Performance monitoring with Web Performance API
class PerformanceMonitor {
  private metrics: Map<string, number> = new Map();

  // Measure function execution time
  measureFunction<T>(name: string, fn: () => T): T {
    const start = performance.now();
    const result = fn();
    const end = performance.now();
    
    this.metrics.set(name, end - start);
    console.log(`${name} took ${end - start} milliseconds`);
    
    return result;
  }

  // Measure async function execution time
  async measureAsyncFunction<T>(name: string, fn: () => Promise<T>): Promise<T> {
    const start = performance.now();
    const result = await fn();
    const end = performance.now();
    
    this.metrics.set(name, end - start);
    console.log(`${name} took ${end - start} milliseconds`);
    
    return result;
  }

  // Get performance metrics
  getMetrics(): Map<string, number> {
    return new Map(this.metrics);
  }

  // Get Web Vitals
  getWebVitals(): Promise<{
    fcp: number;
    lcp: number;
    fid: number;
    cls: number;
  }> {
    return new Promise((resolve) => {
      const vitals = {
        fcp: 0,
        lcp: 0,
        fid: 0,
        cls: 0
      };

      // First Contentful Paint
      const fcpObserver = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (entry.name === 'first-contentful-paint') {
            vitals.fcp = entry.startTime;
          }
        }
      });
      fcpObserver.observe({ entryTypes: ['paint'] });

      // Largest Contentful Paint
      const lcpObserver = new PerformanceObserver((list) => {
        const entries = list.getEntries();
        const lastEntry = entries[entries.length - 1];
        vitals.lcp = lastEntry.startTime;
      });
      lcpObserver.observe({ entryTypes: ['largest-contentful-paint'] });

      // First Input Delay
      const fidObserver = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          vitals.fid = entry.processingStart - entry.startTime;
        }
      });
      fidObserver.observe({ entryTypes: ['first-input'] });

      // Cumulative Layout Shift
      const clsObserver = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (!entry.hadRecentInput) {
            vitals.cls += entry.value;
          }
        }
      });
      clsObserver.observe({ entryTypes: ['layout-shift'] });

      // Resolve after a delay to collect metrics
      setTimeout(() => resolve(vitals), 5000);
    });
  }
}

// Usage
const monitor = new PerformanceMonitor();

// Measure function performance
const result = monitor.measureFunction('expensiveCalculation', () => {
  // Expensive calculation
  return Array.from({ length: 1000000 }, (_, i) => i * i);
});

// Measure async function performance
const asyncResult = await monitor.measureAsyncFunction('apiCall', async () => {
  const response = await fetch('/api/data');
  return response.json();
});

// Get Web Vitals
const vitals = await monitor.getWebVitals();
console.log('Web Vitals:', vitals);
```
{% endraw %}


### **Custom Performance Metrics**


{% raw %}
```typescript
// Custom performance metrics
interface PerformanceMetric {
  name: string;
  value: number;
  timestamp: number;
  tags?: Record<string, string>;
}

class CustomPerformanceMonitor {
  private metrics: PerformanceMetric[] = [];
  private observers: PerformanceObserver[] = [];

  // Record custom metric
  recordMetric(name: string, value: number, tags?: Record<string, string>): void {
    this.metrics.push({
      name,
      value,
      timestamp: Date.now(),
      tags
    });
  }

  // Measure memory usage
  measureMemory(): void {
    if ('memory' in performance) {
      const memory = (performance as any).memory;
      this.recordMetric('memory.used', memory.usedJSHeapSize);
      this.recordMetric('memory.total', memory.totalJSHeapSize);
      this.recordMetric('memory.limit', memory.jsHeapSizeLimit);
    }
  }

  // Measure network performance
  measureNetworkPerformance(): void {
    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (entry.entryType === 'navigation') {
          const navEntry = entry as PerformanceNavigationTiming;
          this.recordMetric('network.dns', navEntry.domainLookupEnd - navEntry.domainLookupStart);
          this.recordMetric('network.tcp', navEntry.connectEnd - navEntry.connectStart);
          this.recordMetric('network.request', navEntry.responseStart - navEntry.requestStart);
          this.recordMetric('network.response', navEntry.responseEnd - navEntry.responseStart);
        }
      }
    });

    observer.observe({ entryTypes: ['navigation'] });
    this.observers.push(observer);
  }

  // Measure resource loading
  measureResourceLoading(): void {
    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (entry.entryType === 'resource') {
          const resourceEntry = entry as PerformanceResourceTiming;
          this.recordMetric('resource.load', resourceEntry.duration, {
            type: resourceEntry.initiatorType,
            name: resourceEntry.name
          });
        }
      }
    });

    observer.observe({ entryTypes: ['resource'] });
    this.observers.push(observer);
  }

  // Get metrics by name
  getMetricsByName(name: string): PerformanceMetric[] {
    return this.metrics.filter(metric => metric.name === name);
  }

  // Get average metric value
  getAverageMetric(name: string): number {
    const metrics = this.getMetricsByName(name);
    if (metrics.length === 0) return 0;
    
    const sum = metrics.reduce((acc, metric) => acc + metric.value, 0);
    return sum / metrics.length;
  }

  // Export metrics
  exportMetrics(): PerformanceMetric[] {
    return [...this.metrics];
  }

  // Clear metrics
  clearMetrics(): void {
    this.metrics = [];
  }

  // Cleanup observers
  cleanup(): void {
    this.observers.forEach(observer => observer.disconnect());
    this.observers = [];
  }
}

// Usage
const customMonitor = new CustomPerformanceMonitor();

// Start monitoring
customMonitor.measureMemory();
customMonitor.measureNetworkPerformance();
customMonitor.measureResourceLoading();

// Record custom metrics
customMonitor.recordMetric('user.action', 150, { action: 'click', element: 'button' });
customMonitor.recordMetric('api.response.time', 300, { endpoint: '/api/users' });

// Get metrics
const averageResponseTime = customMonitor.getAverageMetric('api.response.time');
console.log('Average response time:', averageResponseTime);
```
{% endraw %}


---

## 🔍 **Profiling Tools**

### **Chrome DevTools Profiling**


{% raw %}
```typescript
// Performance profiling utilities
class Profiler {
  private profiles: Map<string, number[]> = new Map();

  // Start profiling
  startProfile(name: string): void {
    if ('performance' in window) {
      performance.mark(`${name}-start`);
    }
  }

  // End profiling
  endProfile(name: string): number {
    if ('performance' in window) {
      performance.mark(`${name}-end`);
      performance.measure(name, `${name}-start`, `${name}-end`);
      
      const measure = performance.getEntriesByName(name)[0];
      const duration = measure.duration;
      
      // Store profile data
      if (!this.profiles.has(name)) {
        this.profiles.set(name, []);
      }
      this.profiles.get(name)!.push(duration);
      
      return duration;
    }
    return 0;
  }

  // Get profile statistics
  getProfileStats(name: string): {
    count: number;
    average: number;
    min: number;
    max: number;
    total: number;
  } | null {
    const durations = this.profiles.get(name);
    if (!durations || durations.length === 0) return null;

    const count = durations.length;
    const total = durations.reduce((sum, duration) => sum + duration, 0);
    const average = total / count;
    const min = Math.min(...durations);
    const max = Math.max(...durations);

    return { count, average, min, max, total };
  }

  // Clear profiles
  clearProfiles(): void {
    this.profiles.clear();
    if ('performance' in window) {
      performance.clearMarks();
      performance.clearMeasures();
    }
  }
}

// Usage
const profiler = new Profiler();

// Profile function execution
function expensiveFunction() {
  profiler.startProfile('expensiveFunction');
  
  // Expensive operation
  const result = Array.from({ length: 1000000 }, (_, i) => i * i);
  
  const duration = profiler.endProfile('expensiveFunction');
  console.log(`Function took ${duration}ms`);
  
  return result;
}

// Run multiple times to get statistics
for (let i = 0; i < 10; i++) {
  expensiveFunction();
}

// Get statistics
const stats = profiler.getProfileStats('expensiveFunction');
console.log('Profile statistics:', stats);
```
{% endraw %}


### **Node.js Profiling**


{% raw %}
```typescript
// Node.js performance profiling
import { performance } from 'perf_hooks';

class NodeProfiler {
  private measurements: Map<string, number[]> = new Map();

  // Measure function execution time
  measureFunction<T>(name: string, fn: () => T): T {
    const start = performance.now();
    const result = fn();
    const end = performance.now();
    
    const duration = end - start;
    this.recordMeasurement(name, duration);
    
    return result;
  }

  // Measure async function execution time
  async measureAsyncFunction<T>(name: string, fn: () => Promise<T>): Promise<T> {
    const start = performance.now();
    const result = await fn();
    const end = performance.now();
    
    const duration = end - start;
    this.recordMeasurement(name, duration);
    
    return result;
  }

  // Record measurement
  private recordMeasurement(name: string, duration: number): void {
    if (!this.measurements.has(name)) {
      this.measurements.set(name, []);
    }
    this.measurements.get(name)!.push(duration);
  }

  // Get measurement statistics
  getStats(name: string): {
    count: number;
    average: number;
    min: number;
    max: number;
    total: number;
    p50: number;
    p95: number;
    p99: number;
  } | null {
    const measurements = this.measurements.get(name);
    if (!measurements || measurements.length === 0) return null;

    const sorted = [...measurements].sort((a, b) => a - b);
    const count = measurements.length;
    const total = measurements.reduce((sum, duration) => sum + duration, 0);
    const average = total / count;
    const min = sorted[0];
    const max = sorted[sorted.length - 1];
    const p50 = sorted[Math.floor(sorted.length * 0.5)];
    const p95 = sorted[Math.floor(sorted.length * 0.95)];
    const p99 = sorted[Math.floor(sorted.length * 0.99)];

    return { count, average, min, max, total, p50, p95, p99 };
  }

  // Export all measurements
  exportMeasurements(): Record<string, number[]> {
    const result: Record<string, number[]> = {};
    for (const [name, measurements] of this.measurements) {
      result[name] = [...measurements];
    }
    return result;
  }
}

// Usage
const nodeProfiler = new NodeProfiler();

// Profile database query
const dbQuery = async () => {
  // Simulate database query
  await new Promise(resolve => setTimeout(resolve, 100));
  return { users: [] };
};

// Measure multiple queries
for (let i = 0; i < 100; i++) {
  await nodeProfiler.measureAsyncFunction('dbQuery', dbQuery);
}

// Get statistics
const stats = nodeProfiler.getStats('dbQuery');
console.log('Database query statistics:', stats);
```
{% endraw %}


---

## ⚡ **Runtime Performance**

### **Memory Monitoring**


{% raw %}
```typescript
// Memory monitoring utilities
class MemoryMonitor {
  private memorySnapshots: Array<{
    timestamp: number;
    used: number;
    total: number;
    limit: number;
  }> = [];

  // Take memory snapshot
  takeSnapshot(): void {
    if ('memory' in performance) {
      const memory = (performance as any).memory;
      this.memorySnapshots.push({
        timestamp: Date.now(),
        used: memory.usedJSHeapSize,
        total: memory.totalJSHeapSize,
        limit: memory.jsHeapSizeLimit
      });
    }
  }

  // Get memory usage
  getMemoryUsage(): {
    used: number;
    total: number;
    limit: number;
    percentage: number;
  } | null {
    if ('memory' in performance) {
      const memory = (performance as any).memory;
      return {
        used: memory.usedJSHeapSize,
        total: memory.totalJSHeapSize,
        limit: memory.jsHeapSizeLimit,
        percentage: (memory.usedJSHeapSize / memory.jsHeapSizeLimit) * 100
      };
    }
    return null;
  }

  // Monitor memory leaks
  detectMemoryLeaks(): {
    isLeaking: boolean;
    growthRate: number;
    recommendation: string;
  } {
    if (this.memorySnapshots.length < 10) {
      return {
        isLeaking: false,
        growthRate: 0,
        recommendation: 'Need more data points'
      };
    }

    const recent = this.memorySnapshots.slice(-10);
    const growth = recent[recent.length - 1].used - recent[0].used;
    const growthRate = growth / recent.length;

    const isLeaking = growthRate > 1000000; // 1MB per snapshot
    const recommendation = isLeaking 
      ? 'Potential memory leak detected. Check for circular references and event listeners.'
      : 'Memory usage appears stable.';

    return { isLeaking, growthRate, recommendation };
  }

  // Clear snapshots
  clearSnapshots(): void {
    this.memorySnapshots = [];
  }
}

// Usage
const memoryMonitor = new MemoryMonitor();

// Take snapshots periodically
setInterval(() => {
  memoryMonitor.takeSnapshot();
}, 5000);

// Check for memory leaks
setInterval(() => {
  const leakInfo = memoryMonitor.detectMemoryLeaks();
  if (leakInfo.isLeaking) {
    console.warn('Memory leak detected:', leakInfo);
  }
}, 30000);
```
{% endraw %}


### **Performance Budgets**


{% raw %}
```typescript
// Performance budget monitoring
interface PerformanceBudget {
  name: string;
  threshold: number;
  unit: 'ms' | 'bytes' | 'count';
  current: number;
  exceeded: boolean;
}

class PerformanceBudgetMonitor {
  private budgets: Map<string, PerformanceBudget> = new Map();

  // Add performance budget
  addBudget(name: string, threshold: number, unit: 'ms' | 'bytes' | 'count'): void {
    this.budgets.set(name, {
      name,
      threshold,
      unit,
      current: 0,
      exceeded: false
    });
  }

  // Update budget value
  updateBudget(name: string, value: number): void {
    const budget = this.budgets.get(name);
    if (budget) {
      budget.current = value;
      budget.exceeded = value > budget.threshold;
    }
  }

  // Check all budgets
  checkBudgets(): {
    passed: PerformanceBudget[];
    failed: PerformanceBudget[];
  } {
    const passed: PerformanceBudget[] = [];
    const failed: PerformanceBudget[] = [];

    for (const budget of this.budgets.values()) {
      if (budget.exceeded) {
        failed.push(budget);
      } else {
        passed.push(budget);
      }
    }

    return { passed, failed };
  }

  // Get budget report
  getBudgetReport(): string {
    const { passed, failed } = this.checkBudgets();
    let report = 'Performance Budget Report:\n\n';

    if (failed.length > 0) {
      report += '❌ Failed Budgets:\n';
      for (const budget of failed) {
        report += `  - ${budget.name}: ${budget.current}${budget.unit} (threshold: ${budget.threshold}${budget.unit})\n`;
      }
      report += '\n';
    }

    if (passed.length > 0) {
      report += '✅ Passed Budgets:\n';
      for (const budget of passed) {
        report += `  - ${budget.name}: ${budget.current}${budget.unit} (threshold: ${budget.threshold}${budget.unit})\n`;
      }
    }

    return report;
  }
}

// Usage
const budgetMonitor = new PerformanceBudgetMonitor();

// Set up budgets
budgetMonitor.addBudget('pageLoadTime', 2000, 'ms');
budgetMonitor.addBudget('bundleSize', 500000, 'bytes');
budgetMonitor.addBudget('apiResponseTime', 500, 'ms');
budgetMonitor.addBudget('memoryUsage', 100000000, 'bytes');

// Update budgets
budgetMonitor.updateBudget('pageLoadTime', 1500);
budgetMonitor.updateBudget('bundleSize', 600000);
budgetMonitor.updateBudget('apiResponseTime', 300);
budgetMonitor.updateBudget('memoryUsage', 80000000);

// Check budgets
const report = budgetMonitor.getBudgetReport();
console.log(report);
```
{% endraw %}


---

## 📦 **Bundle Analysis**

### **Bundle Size Monitoring**


{% raw %}
```typescript
// Bundle size monitoring
interface BundleInfo {
  name: string;
  size: number;
  gzippedSize: number;
  chunks: string[];
  dependencies: string[];
}

class BundleAnalyzer {
  private bundles: Map<string, BundleInfo> = new Map();

  // Add bundle information
  addBundle(name: string, info: BundleInfo): void {
    this.bundles.set(name, info);
  }

  // Get bundle size
  getBundleSize(name: string): number | null {
    const bundle = this.bundles.get(name);
    return bundle ? bundle.size : null;
  }

  // Get total bundle size
  getTotalSize(): number {
    let total = 0;
    for (const bundle of this.bundles.values()) {
      total += bundle.size;
    }
    return total;
  }

  // Get largest bundles
  getLargestBundles(count: number = 5): BundleInfo[] {
    return Array.from(this.bundles.values())
      .sort((a, b) => b.size - a.size)
      .slice(0, count);
  }

  // Analyze bundle composition
  analyzeComposition(): {
    totalSize: number;
    averageSize: number;
    largestBundle: BundleInfo | null;
    smallestBundle: BundleInfo | null;
    sizeDistribution: Array<{ range: string; count: number }>;
  } {
    const bundles = Array.from(this.bundles.values());
    const totalSize = this.getTotalSize();
    const averageSize = totalSize / bundles.length;
    
    const largestBundle = bundles.reduce((max, bundle) => 
      bundle.size > max.size ? bundle : max, bundles[0] || null);
    
    const smallestBundle = bundles.reduce((min, bundle) => 
      bundle.size < min.size ? bundle : min, bundles[0] || null);

    // Size distribution
    const sizeDistribution = [
      { range: '0-100KB', count: bundles.filter(b => b.size < 100000).length },
      { range: '100KB-500KB', count: bundles.filter(b => b.size >= 100000 && b.size < 500000).length },
      { range: '500KB-1MB', count: bundles.filter(b => b.size >= 500000 && b.size < 1000000).length },
      { range: '1MB+', count: bundles.filter(b => b.size >= 1000000).length }
    ];

    return {
      totalSize,
      averageSize,
      largestBundle,
      smallestBundle,
      sizeDistribution
    };
  }

  // Generate bundle report
  generateReport(): string {
    const analysis = this.analyzeComposition();
    let report = 'Bundle Analysis Report:\n\n';

    report += `Total Bundle Size: ${(analysis.totalSize / 1024 / 1024).toFixed(2)} MB\n`;
    report += `Average Bundle Size: ${(analysis.averageSize / 1024).toFixed(2)} KB\n\n`;

    if (analysis.largestBundle) {
      report += `Largest Bundle: ${analysis.largestBundle.name} (${(analysis.largestBundle.size / 1024).toFixed(2)} KB)\n`;
    }

    if (analysis.smallestBundle) {
      report += `Smallest Bundle: ${analysis.smallestBundle.name} (${(analysis.smallestBundle.size / 1024).toFixed(2)} KB)\n\n`;
    }

    report += 'Size Distribution:\n';
    for (const dist of analysis.sizeDistribution) {
      report += `  ${dist.range}: ${dist.count} bundles\n`;
    }

    report += '\nLargest Bundles:\n';
    const largestBundles = this.getLargestBundles(5);
    for (const bundle of largestBundles) {
      report += `  ${bundle.name}: ${(bundle.size / 1024).toFixed(2)} KB\n`;
    }

    return report;
  }
}

// Usage
const bundleAnalyzer = new BundleAnalyzer();

// Add bundle information
bundleAnalyzer.addBundle('main', {
  name: 'main',
  size: 500000,
  gzippedSize: 150000,
  chunks: ['main.js'],
  dependencies: ['react', 'react-dom']
});

bundleAnalyzer.addBundle('vendor', {
  name: 'vendor',
  size: 800000,
  gzippedSize: 250000,
  chunks: ['vendor.js'],
  dependencies: ['lodash', 'moment']
});

// Generate report
const report = bundleAnalyzer.generateReport();
console.log(report);
```
{% endraw %}


---

## 🧪 **Performance Testing**

### **Load Testing**


{% raw %}
```typescript
// Load testing utilities
interface LoadTestConfig {
  concurrency: number;
  duration: number;
  rampUp: number;
  target: string;
}

interface LoadTestResult {
  totalRequests: number;
  successfulRequests: number;
  failedRequests: number;
  averageResponseTime: number;
  minResponseTime: number;
  maxResponseTime: number;
  p95ResponseTime: number;
  p99ResponseTime: number;
  requestsPerSecond: number;
  errors: Array<{ error: string; count: number }>;
}

class LoadTester {
  private results: Array<{
    timestamp: number;
    responseTime: number;
    success: boolean;
    error?: string;
  }> = [];

  // Run load test
  async runLoadTest(
    config: LoadTestConfig,
    requestFn: () => Promise<Response>
  ): Promise<LoadTestResult> {
    this.results = [];
    const startTime = Date.now();
    const endTime = startTime + config.duration * 1000;

    // Create workers
    const workers = Array.from({ length: config.concurrency }, (_, i) => 
      this.createWorker(i, config, requestFn, endTime)
    );

    // Wait for all workers to complete
    await Promise.all(workers);

    return this.calculateResults();
  }

  // Create worker
  private async createWorker(
    workerId: number,
    config: LoadTestConfig,
    requestFn: () => Promise<Response>,
    endTime: number
  ): Promise<void> {
    // Ramp up delay
    const rampUpDelay = (config.rampUp / config.concurrency) * workerId;
    await this.delay(rampUpDelay);

    while (Date.now() < endTime) {
      const start = performance.now();
      try {
        const response = await requestFn();
        const end = performance.now();
        
        this.results.push({
          timestamp: Date.now(),
          responseTime: end - start,
          success: response.ok
        });
      } catch (error) {
        const end = performance.now();
        this.results.push({
          timestamp: Date.now(),
          responseTime: end - start,
          success: false,
          error: error instanceof Error ? error.message : 'Unknown error'
        });
      }
    }
  }

  // Calculate results
  private calculateResults(): LoadTestResult {
    const totalRequests = this.results.length;
    const successfulRequests = this.results.filter(r => r.success).length;
    const failedRequests = totalRequests - successfulRequests;

    const responseTimes = this.results.map(r => r.responseTime);
    const sortedResponseTimes = responseTimes.sort((a, b) => a - b);

    const averageResponseTime = responseTimes.reduce((sum, time) => sum + time, 0) / totalRequests;
    const minResponseTime = sortedResponseTimes[0] || 0;
    const maxResponseTime = sortedResponseTimes[sortedResponseTimes.length - 1] || 0;
    const p95ResponseTime = sortedResponseTimes[Math.floor(sortedResponseTimes.length * 0.95)] || 0;
    const p99ResponseTime = sortedResponseTimes[Math.floor(sortedResponseTimes.length * 0.99)] || 0;

    const testDuration = (this.results[this.results.length - 1]?.timestamp || 0) - (this.results[0]?.timestamp || 0);
    const requestsPerSecond = totalRequests / (testDuration / 1000);

    // Count errors
    const errorCounts = new Map<string, number>();
    for (const result of this.results) {
      if (!result.success && result.error) {
        errorCounts.set(result.error, (errorCounts.get(result.error) || 0) + 1);
      }
    }

    const errors = Array.from(errorCounts.entries()).map(([error, count]) => ({ error, count }));

    return {
      totalRequests,
      successfulRequests,
      failedRequests,
      averageResponseTime,
      minResponseTime,
      maxResponseTime,
      p95ResponseTime,
      p99ResponseTime,
      requestsPerSecond,
      errors
    };
  }

  // Delay utility
  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

// Usage
const loadTester = new LoadTester();

const config: LoadTestConfig = {
  concurrency: 10,
  duration: 60, // 60 seconds
  rampUp: 10, // 10 seconds
  target: 'https://api.example.com/users'
};

const requestFn = async () => {
  return fetch('https://api.example.com/users');
};

const result = await loadTester.runLoadTest(config, requestFn);
console.log('Load test results:', result);
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Monitor Key Metrics**


{% raw %}
```typescript
// ✅ Good: Monitor key metrics
const monitor = new PerformanceMonitor();

// Monitor critical functions
monitor.measureFunction('userLogin', () => {
  // Login logic
});

monitor.measureAsyncFunction('dataFetch', async () => {
  // API call
});

// ❌ Avoid: Not monitoring performance
const userLogin = () => {
  // Login logic without monitoring
};
```
{% endraw %}


### **2. Set Performance Budgets**


{% raw %}
```typescript
// ✅ Good: Set performance budgets
const budgetMonitor = new PerformanceBudgetMonitor();
budgetMonitor.addBudget('pageLoadTime', 2000, 'ms');
budgetMonitor.addBudget('bundleSize', 500000, 'bytes');

// ❌ Avoid: No performance budgets
// No performance constraints
```
{% endraw %}


### **3. Use Profiling Tools**


{% raw %}
```typescript
// ✅ Good: Use profiling tools
const profiler = new Profiler();
profiler.startProfile('expensiveOperation');
// Expensive operation
profiler.endProfile('expensiveOperation');

// ❌ Avoid: No profiling
// Expensive operation without profiling
```
{% endraw %}


### **4. Monitor Memory Usage**


{% raw %}
```typescript
// ✅ Good: Monitor memory usage
const memoryMonitor = new MemoryMonitor();
memoryMonitor.takeSnapshot();
// Check for memory leaks
const leakInfo = memoryMonitor.detectMemoryLeaks();

// ❌ Avoid: Ignoring memory usage
// No memory monitoring
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. What are the key performance metrics to monitor?**

**Answer:**
- **Load time**: Time to load and render page
- **First Contentful Paint**: Time to first contentful paint
- **Largest Contentful Paint**: Time to largest contentful paint
- **First Input Delay**: Time to first input response
- **Cumulative Layout Shift**: Visual stability metric

### **2. How do you measure performance in TypeScript applications?**

**Answer:**
- Use Web Performance API for browser metrics
- Use Node.js performance hooks for server metrics
- Implement custom performance monitoring
- Use profiling tools like Chrome DevTools

### **3. What's the difference between performance monitoring and profiling?**

**Answer:**
- **Performance monitoring**: Continuous measurement of key metrics
- **Profiling**: Detailed analysis of code execution
- **Monitoring**: Real-time performance tracking
- **Profiling**: Deep dive into performance bottlenecks

### **4. How do you set up performance budgets?**

**Answer:**
- Define thresholds for key metrics
- Monitor bundle size, load time, API response time
- Set up alerts when budgets are exceeded
- Use tools to enforce budgets in CI/CD

### **5. What are the benefits of performance monitoring?**

**Answer:**
- **Early detection**: Identify performance issues early
- **User experience**: Ensure good user experience
- **Optimization**: Guide performance optimization efforts
- **Business impact**: Performance affects user retention and conversion

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-Code-Quality-Linting.md" class="nav-button">← Previous: Code Quality & Linting</a>
  <a href="../07-TypeScript-Libraries-Ecosystem/01-Popular-TypeScript-Libraries.md" class="nav-button">Next: Popular TypeScript Libraries →</a>
</div>

*Last updated: December 2025*
