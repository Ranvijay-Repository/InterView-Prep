# ⚡ **Performance Optimization**

> **Complete guide to TypeScript performance optimization, including compilation speed, runtime performance, and bundle optimization**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Performance Overview](#performance-overview)
- [Compilation Performance](#compilation-performance)
- [Runtime Performance](#runtime-performance)
- [Bundle Optimization](#bundle-optimization)
- [Memory Management](#memory-management)
- [Advanced Optimization Techniques](#advanced-optimization-techniques)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Performance Overview**

TypeScript performance optimization involves multiple aspects: compilation speed, runtime performance, and bundle size.

### **Performance Areas**

```typescript
// Performance optimization areas
const performanceAreas = {
  compilation: "TypeScript compilation speed",
  runtime: "JavaScript execution performance",
  bundle: "Bundle size and loading performance",
  memory: "Memory usage and garbage collection"
};

// Performance metrics
const metrics = {
  compilationTime: "Time to compile TypeScript to JavaScript",
  bundleSize: "Size of generated JavaScript bundles",
  runtimeSpeed: "Execution speed of generated code",
  memoryUsage: "Memory consumption during execution"
};
```

### **Performance Optimization Strategies**

```typescript
// Optimization strategies
const strategies = {
  incremental: "Use incremental compilation",
  projectReferences: "Use project references for large codebases",
  treeShaking: "Remove unused code",
  codeSplitting: "Split code into smaller chunks",
  lazyLoading: "Load code on demand"
};
```

---

## 🏗️ **Compilation Performance**

Optimizing TypeScript compilation speed is crucial for developer productivity.

### **Incremental Compilation**

```json
// tsconfig.json - Enable incremental compilation
{
  "compilerOptions": {
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo"
  }
}
```

```typescript
// Benefits of incremental compilation
const incrementalBenefits = {
  fasterBuilds: "Only recompile changed files",
  buildInfo: "Store compilation metadata",
  watchMode: "Faster watch mode rebuilds"
};
```

### **Project References**

```json
// tsconfig.json - Root configuration
{
  "files": [],
  "references": [
    { "path": "./packages/core" },
    { "path": "./packages/ui" },
    { "path": "./apps/web" }
  ]
}

// packages/core/tsconfig.json
{
  "compilerOptions": {
    "composite": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"]
}
```

```bash
# Build with project references
tsc --build
tsc --build --force
tsc --build --clean
```

### **Compiler Options for Performance**

```json
// tsconfig.json - Performance-focused options
{
  "compilerOptions": {
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo",
    "skipLibCheck": true,
    "skipDefaultLibCheck": true,
    "transpileOnly": true,
    "experimentalWatchApi": true
  }
}
```

```typescript
// Performance-focused compiler options
const performanceOptions = {
  skipLibCheck: "Skip type checking of declaration files",
  transpileOnly: "Skip type checking during compilation",
  experimentalWatchApi: "Use faster watch API",
  incremental: "Enable incremental compilation"
};
```

---

## 🚀 **Runtime Performance**

Optimizing runtime performance involves efficient code generation and execution.

### **Efficient Type Definitions**

```typescript
// ✅ Good: Efficient type definitions
interface User {
  id: number;
  name: string;
  email: string;
}

// ❌ Avoid: Complex type definitions that impact runtime
interface ComplexUser {
  id: number;
  name: string;
  email: string;
  profile: {
    age: number;
    settings: {
      theme: string;
      notifications: boolean;
      preferences: {
        language: string;
        timezone: string;
        currency: string;
      };
    };
  };
}
```

### **Optimized Function Definitions**

```typescript
// ✅ Good: Optimized function definitions
const processUsers = (users: User[]): User[] =>
  users
    .filter(user => user.email.includes("@"))
    .map(user => ({ ...user, name: user.name.toUpperCase() }));

// ❌ Avoid: Inefficient function definitions
const processUsersInefficient = (users: User[]): User[] => {
  const result: User[] = [];
  for (let i = 0; i < users.length; i++) {
    if (users[i].email.includes("@")) {
      const user = { ...users[i] };
      user.name = user.name.toUpperCase();
      result.push(user);
    }
  }
  return result;
};
```

### **Memory-Efficient Data Structures**

```typescript
// ✅ Good: Memory-efficient data structures
const createUserMap = (users: User[]): Map<number, User> => {
  const map = new Map<number, User>();
  for (const user of users) {
    map.set(user.id, user);
  }
  return map;
};

// ❌ Avoid: Inefficient data structures
const createUserObject = (users: User[]): Record<number, User> => {
  const obj: Record<number, User> = {};
  for (const user of users) {
    obj[user.id] = user;
  }
  return obj;
};
```

### **Lazy Loading and Code Splitting**

```typescript
// Lazy loading with dynamic imports
const loadUserModule = async (): Promise<typeof import("./user")> => {
  return import("./user");
};

// Code splitting with React
const UserProfile = lazy(() => import("./UserProfile"));
const UserSettings = lazy(() => import("./UserSettings"));

// Usage
const App = () => (
  <Suspense fallback={<div>Loading...</div>}>
    <UserProfile />
    <UserSettings />
  </Suspense>
);
```

---

## 📦 **Bundle Optimization**

Optimizing bundle size improves loading performance and user experience.

### **Tree Shaking**

```typescript
// ✅ Good: Tree-shakable exports
export const add = (a: number, b: number): number => a + b;
export const subtract = (a: number, b: number): number => a - b;
export const multiply = (a: number, b: number): number => a * b;

// ❌ Avoid: Non-tree-shakable exports
export default {
  add: (a: number, b: number): number => a + b,
  subtract: (a: number, b: number): number => a - b,
  multiply: (a: number, b: number): number => a * b
};
```

### **Bundle Analysis**

```typescript
// Bundle analysis with webpack-bundle-analyzer
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

module.exports = {
  plugins: [
    new BundleAnalyzerPlugin({
      analyzerMode: 'static',
      openAnalyzer: false,
      reportFilename: 'bundle-report.html'
    })
  ]
};
```

### **Code Splitting Strategies**

```typescript
// Route-based code splitting
const routes = [
  {
    path: "/users",
    component: lazy(() => import("./pages/Users"))
  },
  {
    path: "/products",
    component: lazy(() => import("./pages/Products"))
  }
];

// Feature-based code splitting
const loadFeature = (featureName: string) => {
  switch (featureName) {
    case "analytics":
      return import("./features/analytics");
    case "reporting":
      return import("./features/reporting");
    default:
      throw new Error(`Unknown feature: ${featureName}`);
  }
};
```

### **Dead Code Elimination**

```typescript
// ✅ Good: Dead code elimination
const isDevelopment = process.env.NODE_ENV === "development";

if (isDevelopment) {
  console.log("Development mode");
}

// ❌ Avoid: Dead code that can't be eliminated
const debug = true;
if (debug) {
  console.log("Debug mode");
}
```

---

## 🧠 **Memory Management**

Efficient memory management prevents memory leaks and improves performance.

### **Memory Leak Prevention**

```typescript
// ✅ Good: Proper cleanup
class EventManager {
  private listeners: Map<string, Function[]> = new Map();

  addEventListener(event: string, listener: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)!.push(listener);
  }

  removeEventListener(event: string, listener: Function): void {
    const listeners = this.listeners.get(event);
    if (listeners) {
      const index = listeners.indexOf(listener);
      if (index > -1) {
        listeners.splice(index, 1);
      }
    }
  }

  cleanup(): void {
    this.listeners.clear();
  }
}

// ❌ Avoid: Memory leaks
class EventManagerBad {
  private listeners: Function[] = [];

  addEventListener(listener: Function): void {
    this.listeners.push(listener);
  }

  // No cleanup method - memory leak!
}
```

### **Efficient Object Creation**

```typescript
// ✅ Good: Efficient object creation
const createUser = (id: number, name: string, email: string): User => ({
  id,
  name,
  email
});

// ❌ Avoid: Inefficient object creation
const createUserInefficient = (id: number, name: string, email: string): User => {
  const user = {} as User;
  user.id = id;
  user.name = name;
  user.email = email;
  return user;
};
```

### **Weak References**

```typescript
// Use WeakMap for memory-efficient caching
const cache = new WeakMap<object, any>();

const getCachedData = (key: object): any => {
  if (cache.has(key)) {
    return cache.get(key);
  }
  
  const data = expensiveOperation();
  cache.set(key, data);
  return data;
};

// Use WeakSet for memory-efficient tracking
const processedObjects = new WeakSet<object>();

const processObject = (obj: object): void => {
  if (processedObjects.has(obj)) {
    return;
  }
  
  // Process object
  processedObjects.add(obj);
};
```

---

## 🚀 **Advanced Optimization Techniques**

### **Web Workers**

```typescript
// Web worker for CPU-intensive tasks
const worker = new Worker("worker.js");

const processLargeDataset = (data: any[]): Promise<any[]> => {
  return new Promise((resolve, reject) => {
    worker.postMessage(data);
    
    worker.onmessage = (event) => {
      resolve(event.data);
    };
    
    worker.onerror = (error) => {
      reject(error);
    };
  });
};

// worker.js
self.onmessage = (event) => {
  const data = event.data;
  const processed = data.map(item => {
    // CPU-intensive processing
    return processItem(item);
  });
  self.postMessage(processed);
};
```

### **Virtual Scrolling**

```typescript
// Virtual scrolling for large lists
interface VirtualScrollProps {
  items: any[];
  itemHeight: number;
  containerHeight: number;
}

const VirtualScroll: React.FC<VirtualScrollProps> = ({
  items,
  itemHeight,
  containerHeight
}) => {
  const [scrollTop, setScrollTop] = useState(0);
  
  const visibleStart = Math.floor(scrollTop / itemHeight);
  const visibleEnd = Math.min(
    visibleStart + Math.ceil(containerHeight / itemHeight),
    items.length
  );
  
  const visibleItems = items.slice(visibleStart, visibleEnd);
  
  return (
    <div
      style={{ height: containerHeight, overflow: "auto" }}
      onScroll={(e) => setScrollTop(e.currentTarget.scrollTop)}
    >
      <div style={{ height: items.length * itemHeight }}>
        <div style={{ transform: `translateY(${visibleStart * itemHeight}px)` }}>
          {visibleItems.map((item, index) => (
            <div key={visibleStart + index} style={{ height: itemHeight }}>
              {item}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
```

### **Memoization**

```typescript
// Memoization for expensive calculations
const memoize = <T extends (...args: any[]) => any>(fn: T): T => {
  const cache = new Map<string, ReturnType<T>>();
  
  return ((...args: Parameters<T>): ReturnType<T> => {
    const key = JSON.stringify(args);
    
    if (cache.has(key)) {
      return cache.get(key)!;
    }
    
    const result = fn(...args);
    cache.set(key, result);
    return result;
  }) as T;
};

// Usage
const expensiveCalculation = memoize((n: number): number => {
  // Expensive calculation
  let result = 0;
  for (let i = 0; i < n; i++) {
    result += i;
  }
  return result;
});

// First call - expensive
console.log(expensiveCalculation(1000000));

// Second call - cached
console.log(expensiveCalculation(1000000));
```

---

## ✅ **Best Practices**

### **1. Use Incremental Compilation**

```json
// ✅ Good: Enable incremental compilation
{
  "compilerOptions": {
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo"
  }
}

// ❌ Avoid: Disabling incremental compilation
{
  "compilerOptions": {
    "incremental": false
  }
}
```

### **2. Optimize Bundle Size**

```typescript
// ✅ Good: Tree-shakable exports
export const add = (a: number, b: number): number => a + b;
export const subtract = (a: number, b: number): number => a - b;

// ❌ Avoid: Non-tree-shakable exports
export default {
  add: (a: number, b: number): number => a + b,
  subtract: (a: number, b: number): number => a - b
};
```

### **3. Use Efficient Data Structures**

```typescript
// ✅ Good: Use Map for key-value pairs
const userMap = new Map<number, User>();

// ❌ Avoid: Use object for key-value pairs
const userObject: Record<number, User> = {};
```

### **4. Implement Proper Cleanup**

```typescript
// ✅ Good: Proper cleanup
class ResourceManager {
  private resources: Resource[] = [];
  
  addResource(resource: Resource): void {
    this.resources.push(resource);
  }
  
  cleanup(): void {
    this.resources.forEach(resource => resource.dispose());
    this.resources = [];
  }
}

// ❌ Avoid: No cleanup
class ResourceManagerBad {
  private resources: Resource[] = [];
  
  addResource(resource: Resource): void {
    this.resources.push(resource);
  }
  
  // No cleanup method - memory leak!
}
```

---

## ❓ **Common Interview Questions**

### **1. How do you optimize TypeScript compilation performance?**

**Answer:**
- Enable incremental compilation
- Use project references for large codebases
- Skip type checking with `transpileOnly`
- Use `skipLibCheck` to skip declaration files

### **2. What are the benefits of tree shaking?**

**Answer:**
- **Smaller bundles**: Remove unused code
- **Faster loading**: Smaller files load faster
- **Better caching**: Only changed code needs to be re-downloaded

### **3. How do you prevent memory leaks in TypeScript?**

**Answer:**
- Remove event listeners
- Clear timers and intervals
- Use WeakMap and WeakSet
- Implement proper cleanup methods

### **4. What's the difference between Map and object for key-value storage?**

**Answer:**
- **Map**: Better performance for frequent additions/deletions
- **Object**: Better performance for property access
- **Map**: Keys can be any type
- **Object**: Keys must be strings or symbols

### **5. How do you implement code splitting in TypeScript?**

**Answer:**
- Use dynamic imports: `import("./module")`
- Use React.lazy for component splitting
- Use route-based splitting
- Use feature-based splitting

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-Error-Handling-Validation.md" class="nav-button">← Previous: Error Handling & Validation</a>
  <a href="../05-TypeScript-Different-Environments/01-TypeScript-Nodejs.md" class="nav-button">Next: TypeScript with Node.js →</a>
</div>

*Last updated: December 2025*
