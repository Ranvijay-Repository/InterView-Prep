# 🧠 **Memory Management**

> **Complete guide to TypeScript memory management, garbage collection optimization, and memory leak prevention**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Memory Management Overview](#memory-management-overview)
- [Garbage Collection](#garbage-collection)
- [Memory Leak Prevention](#memory-leak-prevention)
- [Memory Optimization](#memory-optimization)
- [Memory Monitoring](#memory-monitoring)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Memory Management Overview**

Memory management in TypeScript applications is crucial for performance, stability, and user experience.

### **Memory Management Concepts**


{% raw %}
```typescript
// Memory management concepts
const memoryConcepts = {
  heap: "Memory area for dynamic allocation",
  stack: "Memory area for function calls and local variables",
  garbageCollection: "Automatic memory cleanup",
  memoryLeaks: "Memory that's not released",
  memoryFragmentation: "Fragmented memory allocation"
};

// Memory lifecycle
const memoryLifecycle = {
  allocation: "Memory allocation for objects",
  usage: "Object usage and manipulation",
  deallocation: "Memory deallocation and cleanup",
  garbageCollection: "Automatic memory cleanup"
};

// Memory management goals
const memoryGoals = {
  efficientAllocation: "Efficient memory allocation",
  preventLeaks: "Prevent memory leaks",
  optimizeGC: "Optimize garbage collection",
  monitorUsage: "Monitor memory usage",
  performance: "Maintain good performance"
};
```
{% endraw %}


### **JavaScript Memory Model**


{% raw %}
```typescript
// JavaScript memory model
const memoryModel = {
  primitiveTypes: "Stored in stack memory",
  referenceTypes: "Stored in heap memory",
  references: "Stack stores references to heap objects",
  garbageCollection: "Automatic cleanup of unused objects"
};

// Memory allocation examples
function memoryAllocation() {
  // Primitive types (stack)
  const number = 42;
  const string = 'hello';
  const boolean = true;
  
  // Reference types (heap)
  const object = { id: 1, name: 'John' };
  const array = [1, 2, 3, 4, 5];
  const function = () => console.log('hello');
  
  // References (stack)
  const objectRef = object;
  const arrayRef = array;
}

// Memory deallocation
function memoryDeallocation() {
  let object = { id: 1, name: 'John' };
  
  // Object is eligible for garbage collection
  object = null;
  
  // Or when function ends, local variables are cleaned up
}
```
{% endraw %}


---

## 🗑️ **Garbage Collection**

### **Garbage Collection Process**


{% raw %}
```typescript
// Garbage collection process
const gcProcess = {
  mark: "Mark reachable objects",
  sweep: "Sweep unreachable objects",
  compact: "Compact memory to reduce fragmentation",
  generational: "Use generational garbage collection"
};

// Garbage collection types
const gcTypes = {
  markAndSweep: "Mark and sweep algorithm",
  generational: "Generational garbage collection",
  incremental: "Incremental garbage collection",
  concurrent: "Concurrent garbage collection"
};

// Garbage collection optimization
const gcOptimization = {
  objectLifetime: "Minimize object lifetime",
  memoryLeaks: "Avoid memory leaks",
  weakReferences: "Use weak references",
  objectPools: "Use object pools",
  stringOptimization: "Optimize string operations"
};

// Object lifetime optimization
function optimizeObjectLifetime() {
  // ✅ Good: Short object lifetime
  function processData(data: any[]) {
    const result: any[] = [];
    
    for (const item of data) {
      const processed = {
        id: item.id,
        name: item.name,
        processed: true
      };
      result.push(processed);
    }
    
    return result;
  }
  
  // ❌ Avoid: Long object lifetime
  class DataProcessor {
    private cache = new Map();
    
    processData(data: any[]) {
      // Objects stay in cache longer than needed
      return data.map(item => {
        const processed = { ...item, processed: true };
        this.cache.set(item.id, processed);
        return processed;
      });
    }
  }
}
```
{% endraw %}


### **Garbage Collection Monitoring**


{% raw %}
```typescript
// Garbage collection monitoring
class GCMonitor {
  private measurements: Array<{ timestamp: number; memory: any }> = [];
  
  startMonitoring(): void {
    if ('memory' in performance) {
      setInterval(() => {
        this.measureMemory();
      }, 1000);
    }
  }
  
  measureMemory(): void {
    if ('memory' in performance) {
      const memory = (performance as any).memory;
      this.measurements.push({
        timestamp: Date.now(),
        memory: {
          used: memory.usedJSHeapSize,
          total: memory.totalJSHeapSize,
          limit: memory.jsHeapSizeLimit
        }
      });
    }
  }
  
  getMemoryStats(): { min: number; max: number; avg: number } {
    const usedMemory = this.measurements.map(m => m.memory.used);
    return {
      min: Math.min(...usedMemory),
      max: Math.max(...usedMemory),
      avg: usedMemory.reduce((sum, val) => sum + val, 0) / usedMemory.length
    };
  }
  
  detectMemoryLeaks(): boolean {
    const stats = this.getMemoryStats();
    const recent = this.measurements.slice(-10);
    const recentAvg = recent.reduce((sum, m) => sum + m.memory.used, 0) / recent.length;
    
    return recentAvg > stats.avg * 1.5;
  }
}

// Usage
const gcMonitor = new GCMonitor();
gcMonitor.startMonitoring();
```
{% endraw %}


### **Garbage Collection Optimization**


{% raw %}
```typescript
// Garbage collection optimization techniques
const gcOptimizationTechniques = {
  objectReuse: "Reuse objects when possible",
  arrayReuse: "Reuse arrays when possible",
  stringOptimization: "Optimize string operations",
  closureManagement: "Manage closures carefully",
  eventListenerCleanup: "Clean up event listeners"
};

// Object reuse
class ObjectPool<T> {
  private pool: T[] = [];
  
  constructor(private createFn: () => T) {}
  
  get(): T {
    return this.pool.pop() || this.createFn();
  }
  
  release(obj: T): void {
    this.pool.push(obj);
  }
  
  clear(): void {
    this.pool.length = 0;
  }
}

// Array reuse
class ArrayPool {
  private pools: Map<number, any[][]> = new Map();
  
  getArray(size: number): any[] {
    const pool = this.pools.get(size) || [];
    return pool.pop() || new Array(size);
  }
  
  releaseArray(arr: any[]): void {
    const size = arr.length;
    const pool = this.pools.get(size) || [];
    arr.length = 0; // Clear array
    pool.push(arr);
    this.pools.set(size, pool);
  }
  
  clear(): void {
    this.pools.clear();
  }
}

// String optimization
function optimizeStringOperations() {
  // ✅ Good: Use template literals
  function createMessage(name: string, age: number): string {
    return `Hello ${name}, you are ${age} years old`;
  }
  
  // ❌ Avoid: String concatenation
  function createMessageBad(name: string, age: number): string {
    return 'Hello ' + name + ', you are ' + age + ' years old';
  }
  
  // ✅ Good: Use StringBuilder for many concatenations
  class StringBuilder {
    private parts: string[] = [];
    
    append(str: string): StringBuilder {
      this.parts.push(str);
      return this;
    }
    
    toString(): string {
      return this.parts.join('');
    }
  }
}
```
{% endraw %}


---

## 🚫 **Memory Leak Prevention**

### **Common Memory Leak Sources**


{% raw %}
```typescript
// Common memory leak sources
const memoryLeakSources = {
  eventListeners: "Event listeners not removed",
  timers: "Timers and intervals not cleared",
  closures: "Circular references in closures",
  domReferences: "DOM references not cleared",
  caches: "Unbounded caches",
  globalVariables: "Global variables holding references"
};

// Event listener cleanup
class EventManager {
  private listeners = new Map<string, EventListener[]>();
  
  addEventListener(element: HTMLElement, event: string, listener: EventListener): void {
    element.addEventListener(event, listener);
    
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)!.push(listener);
  }
  
  removeEventListener(element: HTMLElement, event: string, listener: EventListener): void {
    element.removeEventListener(event, listener);
    
    const listeners = this.listeners.get(event) || [];
    const index = listeners.indexOf(listener);
    if (index > -1) {
      listeners.splice(index, 1);
    }
  }
  
  removeAllListeners(element: HTMLElement): void {
    for (const [event, listeners] of this.listeners) {
      for (const listener of listeners) {
        element.removeEventListener(event, listener);
      }
    }
    this.listeners.clear();
  }
}

// Timer cleanup
class TimerManager {
  private timers = new Set<number>();
  
  setTimeout(callback: () => void, delay: number): number {
    const id = setTimeout(callback, delay);
    this.timers.add(id);
    return id;
  }
  
  setInterval(callback: () => void, delay: number): number {
    const id = setInterval(callback, delay);
    this.timers.add(id);
    return id;
  }
  
  clearTimer(id: number): void {
    clearTimeout(id);
    clearInterval(id);
    this.timers.delete(id);
  }
  
  clearAllTimers(): void {
    for (const id of this.timers) {
      clearTimeout(id);
      clearInterval(id);
    }
    this.timers.clear();
  }
}
```
{% endraw %}


### **Closure Memory Leaks**


{% raw %}
```typescript
// Closure memory leak prevention
const closureLeakPrevention = {
  avoidCircularReferences: "Avoid circular references",
  weakReferences: "Use weak references when appropriate",
  cleanup: "Clean up closures when done",
  eventHandlers: "Remove event handlers properly"
};

// ✅ Good: Proper closure cleanup
class Component {
  private eventHandlers = new Map<string, EventListener>();
  
  addEventListener(element: HTMLElement, event: string, handler: EventListener): void {
    element.addEventListener(event, handler);
    this.eventHandlers.set(event, handler);
  }
  
  destroy(): void {
    // Clean up event handlers
    for (const [event, handler] of this.eventHandlers) {
      // Remove event listeners
    }
    this.eventHandlers.clear();
  }
}

// ❌ Avoid: Circular references
class BadComponent {
  private parent: any;
  
  constructor(parent: any) {
    this.parent = parent;
    parent.addChild(this); // Circular reference
  }
}

// Weak references
class WeakReferenceExample {
  private weakMap = new WeakMap();
  
  setReference(key: object, value: any): void {
    this.weakMap.set(key, value);
  }
  
  getReference(key: object): any {
    return this.weakMap.get(key);
  }
}
```
{% endraw %}


### **DOM Reference Cleanup**


{% raw %}
```typescript
// DOM reference cleanup
const domReferenceCleanup = {
  clearReferences: "Clear DOM references when done",
  removeEventListeners: "Remove event listeners",
  cleanup: "Clean up DOM manipulation",
  memoryLeaks: "Prevent DOM-related memory leaks"
};

// DOM cleanup utility
class DOMCleanup {
  private elements = new Set<HTMLElement>();
  private eventListeners = new Map<HTMLElement, EventListener[]>();
  
  trackElement(element: HTMLElement): void {
    this.elements.add(element);
  }
  
  addEventListener(element: HTMLElement, event: string, listener: EventListener): void {
    element.addEventListener(event, listener);
    
    if (!this.eventListeners.has(element)) {
      this.eventListeners.set(element, []);
    }
    this.eventListeners.get(element)!.push(listener);
  }
  
  cleanup(): void {
    // Remove event listeners
    for (const [element, listeners] of this.eventListeners) {
      for (const listener of listeners) {
        element.removeEventListener('click', listener);
      }
    }
    
    // Clear references
    this.elements.clear();
    this.eventListeners.clear();
  }
}

// Usage
const domCleanup = new DOMCleanup();
const button = document.getElementById('button') as HTMLButtonElement;

domCleanup.trackElement(button);
domCleanup.addEventListener(button, 'click', () => console.log('clicked'));

// Clean up when done
domCleanup.cleanup();
```
{% endraw %}


---

## ⚡ **Memory Optimization**

### **Memory-Efficient Data Structures**


{% raw %}
```typescript
// Memory-efficient data structures
const memoryEfficientStructures = {
  typedArrays: "Use typed arrays for numeric data",
  objectPools: "Use object pools for frequent allocations",
  weakMaps: "Use weak maps for object keys",
  stringOptimization: "Optimize string operations",
  arrayOptimization: "Optimize array operations"
};

// Typed arrays
function useTypedArrays() {
  // ✅ Good: Typed arrays for numeric data
  const numbers = new Float32Array(1000);
  const integers = new Int32Array(1000);
  
  // ❌ Avoid: Regular arrays for numeric data
  const numbersBad = new Array(1000);
  const integersBad = new Array(1000);
}

// Object pools
class MemoryEfficientPool<T> {
  private pool: T[] = [];
  private createFn: () => T;
  
  constructor(createFn: () => T) {
    this.createFn = createFn;
  }
  
  get(): T {
    return this.pool.pop() || this.createFn();
  }
  
  release(obj: T): void {
    this.pool.push(obj);
  }
  
  clear(): void {
    this.pool.length = 0;
  }
}

// Weak maps
class WeakMapExample {
  private weakMap = new WeakMap();
  
  set(key: object, value: any): void {
    this.weakMap.set(key, value);
  }
  
  get(key: object): any {
    return this.weakMap.get(key);
  }
  
  has(key: object): boolean {
    return this.weakMap.has(key);
  }
  
  delete(key: object): boolean {
    return this.weakMap.delete(key);
  }
}
```
{% endraw %}


### **Memory-Efficient Algorithms**


{% raw %}
```typescript
// Memory-efficient algorithms
const memoryEfficientAlgorithms = {
  inPlace: "Use in-place algorithms when possible",
  streaming: "Use streaming algorithms for large datasets",
  lazyEvaluation: "Use lazy evaluation",
  memoization: "Use memoization for expensive operations",
  caching: "Implement efficient caching strategies"
};

// In-place algorithms
function inPlaceSort(arr: number[]): void {
  // ✅ Good: In-place sorting
  arr.sort((a, b) => a - b);
}

function inPlaceReverse(arr: any[]): void {
  // ✅ Good: In-place reversal
  let left = 0;
  let right = arr.length - 1;
  
  while (left < right) {
    [arr[left], arr[right]] = [arr[right], arr[left]];
    left++;
    right--;
  }
}

// Streaming algorithms
function* streamProcess(data: any[]): Generator<any, void, unknown> {
  for (const item of data) {
    yield processItem(item);
  }
}

function processItem(item: any): any {
  // Process item
  return { ...item, processed: true };
}

// Lazy evaluation
class LazyArray<T> {
  private data: T[];
  private operations: Array<(item: T) => T> = [];
  
  constructor(data: T[]) {
    this.data = data;
  }
  
  map(fn: (item: T) => T): LazyArray<T> {
    this.operations.push(fn);
    return this;
  }
  
  filter(predicate: (item: T) => boolean): LazyArray<T> {
    this.operations.push(item => predicate(item) ? item : null as any);
    return this;
  }
  
  toArray(): T[] {
    let result = [...this.data];
    
    for (const operation of this.operations) {
      result = result.map(operation).filter(item => item !== null);
    }
    
    return result;
  }
}
```
{% endraw %}


### **Memory-Efficient Patterns**


{% raw %}
```typescript
// Memory-efficient patterns
const memoryEfficientPatterns = {
  flyweight: "Use flyweight pattern for shared state",
  objectPool: "Use object pool pattern",
  lazyLoading: "Use lazy loading pattern",
  caching: "Use efficient caching patterns",
  streaming: "Use streaming patterns"
};

// Flyweight pattern
class FlyweightFactory {
  private flyweights = new Map<string, any>();
  
  getFlyweight(key: string): any {
    if (!this.flyweights.has(key)) {
      this.flyweights.set(key, this.createFlyweight(key));
    }
    return this.flyweights.get(key);
  }
  
  private createFlyweight(key: string): any {
    // Create flyweight object
    return { key, shared: true };
  }
}

// Object pool pattern
class ObjectPool<T> {
  private pool: T[] = [];
  private createFn: () => T;
  private resetFn: (obj: T) => void;
  
  constructor(createFn: () => T, resetFn: (obj: T) => void) {
    this.createFn = createFn;
    this.resetFn = resetFn;
  }
  
  get(): T {
    const obj = this.pool.pop() || this.createFn();
    return obj;
  }
  
  release(obj: T): void {
    this.resetFn(obj);
    this.pool.push(obj);
  }
  
  clear(): void {
    this.pool.length = 0;
  }
}

// Lazy loading pattern
class LazyLoader<T> {
  private value: T | null = null;
  private loader: () => T;
  
  constructor(loader: () => T) {
    this.loader = loader;
  }
  
  get(): T {
    if (this.value === null) {
      this.value = this.loader();
    }
    return this.value;
  }
  
  reset(): void {
    this.value = null;
  }
}
```
{% endraw %}


---

## 📊 **Memory Monitoring**

### **Memory Usage Monitoring**


{% raw %}
```typescript
// Memory usage monitoring
class MemoryMonitor {
  private measurements: Array<{ timestamp: number; memory: any }> = [];
  private intervalId: number | null = null;
  
  startMonitoring(interval: number = 1000): void {
    if ('memory' in performance) {
      this.intervalId = setInterval(() => {
        this.measureMemory();
      }, interval);
    }
  }
  
  stopMonitoring(): void {
    if (this.intervalId) {
      clearInterval(this.intervalId);
      this.intervalId = null;
    }
  }
  
  measureMemory(): void {
    if ('memory' in performance) {
      const memory = (performance as any).memory;
      this.measurements.push({
        timestamp: Date.now(),
        memory: {
          used: memory.usedJSHeapSize,
          total: memory.totalJSHeapSize,
          limit: memory.jsHeapSizeLimit
        }
      });
    }
  }
  
  getMemoryUsage(): any {
    if ('memory' in performance) {
      return (performance as any).memory;
    }
    return null;
  }
  
  getMemoryStats(): { min: number; max: number; avg: number; current: number } {
    const usedMemory = this.measurements.map(m => m.memory.used);
    const current = this.measurements.length > 0 ? this.measurements[this.measurements.length - 1].memory.used : 0;
    
    return {
      min: Math.min(...usedMemory),
      max: Math.max(...usedMemory),
      avg: usedMemory.reduce((sum, val) => sum + val, 0) / usedMemory.length,
      current
    };
  }
  
  detectMemoryLeaks(): boolean {
    const stats = this.getMemoryStats();
    const recent = this.measurements.slice(-10);
    const recentAvg = recent.reduce((sum, m) => sum + m.memory.used, 0) / recent.length;
    
    return recentAvg > stats.avg * 1.5;
  }
  
  getMemoryTrend(): 'increasing' | 'decreasing' | 'stable' {
    if (this.measurements.length < 10) return 'stable';
    
    const recent = this.measurements.slice(-10);
    const first = recent[0].memory.used;
    const last = recent[recent.length - 1].memory.used;
    
    const threshold = first * 0.1; // 10% threshold
    
    if (last > first + threshold) return 'increasing';
    if (last < first - threshold) return 'decreasing';
    return 'stable';
  }
}

// Usage
const memoryMonitor = new MemoryMonitor();
memoryMonitor.startMonitoring(5000); // Monitor every 5 seconds

// Check for memory leaks
setInterval(() => {
  if (memoryMonitor.detectMemoryLeaks()) {
    console.warn('Potential memory leak detected');
  }
  
  const trend = memoryMonitor.getMemoryTrend();
  console.log(`Memory trend: ${trend}`);
}, 30000);
```
{% endraw %}


### **Memory Leak Detection**


{% raw %}
```typescript
// Memory leak detection
class MemoryLeakDetector {
  private baseline: number = 0;
  private measurements: number[] = [];
  
  setBaseline(): void {
    if ('memory' in performance) {
      this.baseline = (performance as any).memory.usedJSHeapSize;
    }
  }
  
  measure(): void {
    if ('memory' in performance) {
      const current = (performance as any).memory.usedJSHeapSize;
      this.measurements.push(current);
    }
  }
  
  detectLeak(): boolean {
    if (this.measurements.length < 5) return false;
    
    const recent = this.measurements.slice(-5);
    const trend = this.calculateTrend(recent);
    
    // If memory is consistently increasing
    return trend > 0.1; // 10% increase threshold
  }
  
  private calculateTrend(values: number[]): number {
    if (values.length < 2) return 0;
    
    const first = values[0];
    const last = values[values.length - 1];
    
    return (last - first) / first;
  }
  
  getMemoryGrowth(): number {
    if (this.measurements.length < 2) return 0;
    
    const first = this.measurements[0];
    const last = this.measurements[this.measurements.length - 1];
    
    return (last - first) / first;
  }
}

// Usage
const leakDetector = new MemoryLeakDetector();
leakDetector.setBaseline();

// Measure memory periodically
setInterval(() => {
  leakDetector.measure();
  
  if (leakDetector.detectLeak()) {
    console.warn('Memory leak detected!');
    console.log(`Memory growth: ${(leakDetector.getMemoryGrowth() * 100).toFixed(2)}%`);
  }
}, 10000);
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Prevent Memory Leaks**


{% raw %}
```typescript
// ✅ Good: Clean up event listeners
class Component {
  private eventHandlers = new Map<string, EventListener>();
  
  addEventListener(element: HTMLElement, event: string, handler: EventListener): void {
    element.addEventListener(event, handler);
    this.eventHandlers.set(event, handler);
  }
  
  destroy(): void {
    for (const [event, handler] of this.eventHandlers) {
      // Remove event listeners
    }
    this.eventHandlers.clear();
  }
}

// ❌ Avoid: Not cleaning up event listeners
class BadComponent {
  addEventListener(element: HTMLElement, event: string, handler: EventListener): void {
    element.addEventListener(event, handler);
    // No cleanup
  }
}
```
{% endraw %}


### **2. Use Object Pools**


{% raw %}
```typescript
// ✅ Good: Use object pools
class ObjectPool<T> {
  private pool: T[] = [];
  
  get(): T {
    return this.pool.pop() || this.createFn();
  }
  
  release(obj: T): void {
    this.pool.push(obj);
  }
}

// ❌ Avoid: Creating objects frequently
function processData(data: any[]) {
  return data.map(item => ({
    id: item.id,
    name: item.name,
    processed: true
  }));
}
```
{% endraw %}


### **3. Optimize Memory Usage**


{% raw %}
```typescript
// ✅ Good: Use typed arrays for numeric data
const numbers = new Float32Array(1000);

// ❌ Avoid: Regular arrays for numeric data
const numbersBad = new Array(1000);
```
{% endraw %}


### **4. Monitor Memory Usage**


{% raw %}
```typescript
// ✅ Good: Monitor memory usage
const memoryMonitor = new MemoryMonitor();
memoryMonitor.startMonitoring();

// ❌ Avoid: No memory monitoring
// No monitoring
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. How do you prevent memory leaks in TypeScript?**

**Answer:**
- **Event Listeners**: Remove event listeners when no longer needed
- **Timers**: Clear timers and intervals
- **Closures**: Avoid circular references in closures
- **DOM References**: Clear DOM references
- **Caches**: Limit cache size and implement cleanup

### **2. What are the common sources of memory leaks?**

**Answer:**
- **Event Listeners**: Not removing event listeners
- **Timers**: Not clearing timers and intervals
- **Closures**: Circular references in closures
- **DOM References**: Holding references to DOM elements
- **Caches**: Unbounded caches
- **Global Variables**: Global variables holding references

### **3. How do you optimize memory usage in TypeScript?**

**Answer:**
- **Object Pools**: Reuse objects when possible
- **Typed Arrays**: Use typed arrays for numeric data
- **Weak References**: Use weak references when appropriate
- **Lazy Loading**: Load data only when needed
- **Memory Monitoring**: Monitor memory usage

### **4. What is garbage collection and how does it work?**

**Answer:**
Garbage collection is the automatic memory management process that:
- **Marks**: Identifies reachable objects
- **Sweeps**: Removes unreachable objects
- **Compacts**: Compacts memory to reduce fragmentation
- **Generational**: Uses generational garbage collection

### **5. How do you monitor memory usage in TypeScript applications?**

**Answer:**
- **Performance API**: Use performance.memory
- **Memory Monitoring**: Implement custom memory monitoring
- **Leak Detection**: Detect memory leaks
- **Trend Analysis**: Analyze memory trends
- **Profiling**: Use memory profiling tools

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-Bundle-Size-Optimization.md" class="nav-button">← Previous: Bundle Size Optimization</a>
  <a href="../10-TypeScript-Best-Practices/01-Code-Organization-Architecture.md" class="nav-button">Next: TypeScript Best Practices →</a>
</div>

*Last updated: December 2025*
