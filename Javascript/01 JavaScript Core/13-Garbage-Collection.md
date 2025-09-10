# 🗑️ Garbage Collection

> **Understanding how JavaScript automatically manages memory and prevents memory leaks**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is Garbage Collection?](#what-is-garbage-collection)
- [Memory Lifecycle](#memory-lifecycle)
- [Garbage Collection Algorithms](#garbage-collection-algorithms)
- [Reference Counting](#reference-counting)
- [Mark and Sweep](#mark-and-sweep)
- [Generational Garbage Collection](#generational-garbage-collection)
- [Memory Leaks](#memory-leaks)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What is Garbage Collection?

**Garbage Collection** is JavaScript's automatic memory management system that identifies and frees memory that is no longer accessible by the program. It prevents memory leaks and manages memory allocation/deallocation automatically.

### Why Understanding This Matters:
- **Memory Management**: Write memory-efficient code
- **Performance**: Understand memory allocation patterns
- **Debugging**: Identify and fix memory leaks
- **Application Stability**: Prevent crashes from memory exhaustion
- **Scalability**: Build applications that handle large datasets

---

## 🔄 Memory Lifecycle

Memory in JavaScript follows a predictable lifecycle from allocation to garbage collection.

### ASCII Diagram: Memory Lifecycle

```
MEMORY LIFECYCLE
┌─────────────────────────────────┐
│ 1. ALLOCATION                  │
│    Memory is allocated          │
│    for variables, objects, etc. │
│    ↓                           │
│ 2. USAGE                       │
│    Memory is read/written      │
│    during program execution     │
│    ↓                           │
│ 3. RELEASE                     │
│    Memory becomes unreachable   │
│    (no references remain)       │
│    ↓                           │
│ 4. GARBAGE COLLECTION          │
│    GC identifies and frees     │
│    unreachable memory          │
└─────────────────────────────────┘
```


---

## 🧮 Garbage Collection Algorithms

JavaScript engines use different algorithms to identify and collect garbage memory.

### 1. **Reference Counting**
- Counts references to each object
- Frees memory when reference count reaches zero
- Simple but can't handle circular references

### 2. **Mark and Sweep**
- Marks all reachable objects from root
- Sweeps (frees) unmarked objects
- Handles circular references correctly
- Modern JavaScript engines use this

### 3. **Generational Collection**
- Divides memory into generations
- Young generation (new objects) collected frequently
- Old generation (surviving objects) collected less often
- Optimizes for typical object lifecycle

---

## 🔢 Reference Counting

**Reference Counting** tracks how many references point to each object.

### How It Works:
1. **Increment** reference count when object is referenced
2. **Decrement** reference count when reference is removed
3. **Free** memory when count reaches zero

### ASCII Diagram: Reference Counting

```
REFERENCE COUNTING EXAMPLE
┌─────────────────────────────────┐
│ let obj1 = { name: "John" };   │
│ let obj2 = obj1;                │
│ let obj3 = obj1;                │
│                                 │
│ obj1: { name: "John" }          │
│ Reference count: 3              │
│ (obj1, obj2, obj3 point to it) │
└─────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────┐
│ obj1 = null;                    │
│ obj2 = null;                    │
│ obj3 = null;                    │
│                                 │
│ Object becomes unreachable      │
│ Reference count: 0              │
│ Memory is freed                 │
└─────────────────────────────────┘
```


---

## 🎯 Mark and Sweep

**Mark and Sweep** is the primary garbage collection algorithm used in modern JavaScript engines.

### How It Works:
1. **Mark Phase**: Traverse from root objects, mark all reachable objects
2. **Sweep Phase**: Free memory of unmarked objects
3. **Compact Phase**: (Optional) Move objects to reduce fragmentation

### ASCII Diagram: Mark and Sweep

```
MARK AND SWEEP PROCESS
┌─────────────────────────────────┐
│ ROOT OBJECTS                    │
│ (Global, function scope)        │
│                                 │
│ global → objA → objB            │
│           ↓                     │
│         objC → objD             │
│                                 │
│ objE (unreachable)              │
│ objF (unreachable)              │
└─────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────┐
│ MARK PHASE                     │
│ global: ✓                      │
│ objA: ✓                        │
│ objB: ✓                        │
│ objC: ✓                        │
│ objD: ✓                        │
│ objE: ✗ (unmarked)            │
│ objF: ✗ (unmarked)            │
└─────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────┐
│ SWEEP PHASE                     │
│ Free objE and objF memory      │
│ Keep marked objects             │
│                                 │
│ Result: Clean memory            │
└─────────────────────────────────┘
```


---

## 🏗️ Generational Garbage Collection

**Generational Collection** optimizes garbage collection by treating different object ages differently.

### Memory Generations:
- **Young Generation (Nursery)**: Newly allocated objects
- **Old Generation**: Objects that survived multiple collections
- **Large Object Space**: Very large objects

### ASCII Diagram: Generational Collection

```
GENERATIONAL GARBAGE COLLECTION
┌─────────────────────────────────┐
│        YOUNG GENERATION         │
│      (Nursery - New Objects)    │
│  ┌─────────┐ ┌─────────┐        │
│  │ obj1    │ │ obj2    │        │
│  │ (new)   │ │ (new)   │        │
│  └─────────┘ └─────────┘        │
│                                 │
│  • Collected frequently         │
│  • Most objects die young       │
│  • Fast collection              │
└─────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────┐
│        OLD GENERATION           │
│    (Surviving Objects)          │
│  ┌─────────┐ ┌─────────┐        │
│  │ obj3    │ │ obj4    │        │
│  │ (old)   │ │ (old)   │        │
│  └─────────┘ └─────────┘        │
│                                 │
│  • Collected less frequently    │
│  • Objects likely to survive    │
│  • Slower collection            │
└─────────────────────────────────┘
```


---

## 🚨 Memory Leaks

**Memory Leaks** occur when memory is allocated but never freed, causing memory usage to grow over time.

### Common Causes:
1. **Global Variables**: Accidental global assignments
2. **Closures**: Holding references to large objects
3. **Event Listeners**: Not removing when elements are destroyed
4. **Timers**: `setInterval` without cleanup
5. **DOM References**: Holding references to removed elements

---

## 💻 Detailed Examples

### Example 1: Basic Memory Management
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== BASIC MEMORY MANAGEMENT ===");

// Memory allocation
console.log("=== Memory Allocation ===");
let largeObject = {
    data: new Array(1000000).fill("some data"),
    timestamp: Date.now()
};

console.log("Large object created with 1M elements");
console.log("Memory usage should increase");

// Memory usage (approximate)
const memoryUsage = process.memoryUsage();
console.log("Memory usage:", {
    rss: Math.round(memoryUsage.rss / 1024 / 1024) + " MB",
    heapUsed: Math.round(memoryUsage.heapUsed / 1024 / 1024) + " MB",
    heapTotal: Math.round(memoryUsage.heapTotal / 1024 / 1024) + " MB"
});

// Memory release
console.log("\n=== Memory Release ===");
largeObject = null;  // Remove reference

console.log("Reference removed, object becomes unreachable");
console.log("Garbage collection can now free this memory");

// Force garbage collection (if available)
if (global.gc) {
    global.gc();
    console.log("Garbage collection triggered");
    
    const memoryAfterGC = process.memoryUsage();
    console.log("Memory after GC:", {
        rss: Math.round(memoryAfterGC.rss / 1024 / 1024) + " MB",
        heapUsed: Math.round(memoryAfterGC.heapUsed / 1024 / 1024) + " MB",
        heapTotal: Math.round(memoryAfterGC.heapTotal / 1024 / 1024) + " MB"
    });
} else {
    console.log("Run with --expose-gc flag to enable manual GC");
}

console.log("\n=== KEY INSIGHT ===");
console.log("Setting variables to null removes references");
console.log("Unreferenced objects become eligible for GC");
console.log("Memory is freed automatically by the engine");
```

</div>

### Example 2: Circular References and Garbage Collection
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== CIRCULAR REFERENCES AND GC ===");

// Create circular reference
console.log("=== Creating Circular Reference ===");
let objA = { name: "Object A" };
let objB = { name: "Object B" };

// Create circular reference
objA.reference = objB;
objB.reference = objA;

console.log("Circular reference created:");
console.log("objA.reference === objB:", objA.reference === objB);
console.log("objB.reference === objA:", objB.reference === objA);

// Memory usage before cleanup
const memoryBefore = process.memoryUsage();
console.log("\nMemory before cleanup:", {
    heapUsed: Math.round(memoryBefore.heapUsed / 1024 / 1024) + " MB"
});

// Remove external references
console.log("\n=== Removing External References ===");
objA = null;
objB = null;

console.log("External references removed");
console.log("Objects are now only referenced by each other");

// Check if objects are still accessible
try {
    console.log("objA:", objA);  // null
    console.log("objB:", objB);  // null
} catch (error) {
    console.log("Error accessing objects:", error.message);
}

// Force garbage collection
if (global.gc) {
    global.gc();
    console.log("\nGarbage collection triggered");
    
    const memoryAfter = process.memoryUsage();
    console.log("Memory after GC:", {
        heapUsed: Math.round(memoryAfter.heapUsed / 1024 / 1024) + " MB"
    });
    
    const memoryFreed = memoryBefore.heapUsed - memoryAfter.heapUsed;
    console.log("Memory freed:", Math.round(memoryFreed / 1024 / 1024) + " MB");
} else {
    console.log("\nRun with --expose-gc flag to see memory cleanup");
}

console.log("\n=== KEY INSIGHT ===");
console.log("Circular references don't prevent garbage collection");
console.log("Mark and Sweep algorithm handles circular references");
console.log("Objects become unreachable when no external references exist");
```

</div>

### Example 3: Memory Leaks in Event Listeners
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== MEMORY LEAKS IN EVENT LISTENERS ===");

// Simulate DOM elements
console.log("=== Creating DOM-like Elements ===");
class DOMElement {
    constructor(tagName) {
        this.tagName = tagName;
        this.eventListeners = new Map();
        this.children = [];
    }
    
    addEventListener(event, callback) {
        if (!this.eventListeners.has(event)) {
            this.eventListeners.set(event, []);
        }
        this.eventListeners.get(event).push(callback);
        console.log(`Added ${event} listener to ${this.tagName}`);
    }
    
    removeEventListener(event, callback) {
        if (this.eventListeners.has(event)) {
            const listeners = this.eventListeners.get(event);
            const index = listeners.indexOf(callback);
            if (index > -1) {
                listeners.splice(index, 1);
                console.log(`Removed ${event} listener from ${this.tagName}`);
            }
        }
    }
    
    getEventListenersCount() {
        let total = 0;
        for (const [event, listeners] of this.eventListeners) {
            total += listeners.length;
        }
        return total;
    }
}

// Create elements
const button = new DOMElement("button");
const container = new DOMElement("div");

// Add event listeners
console.log("\n=== Adding Event Listeners ===");
const clickHandler = () => console.log("Button clicked");
const mouseHandler = () => console.log("Mouse moved");

button.addEventListener("click", clickHandler);
button.addEventListener("mouseover", mouseHandler);

console.log("Event listeners added");
console.log("Button listeners:", button.getEventListenersCount());

// Simulate element removal (memory leak scenario)
console.log("\n=== Simulating Element Removal (WITHOUT cleanup) ===");
let buttonRef = button;  // Keep reference to simulate memory leak
button = null;  // Remove button reference

console.log("Button reference removed but event listeners remain");
console.log("This creates a memory leak!");

// Proper cleanup (preventing memory leak)
console.log("\n=== Proper Cleanup (PREVENTING memory leak) ===");
const button2 = new DOMElement("button");
const clickHandler2 = () => console.log("Button 2 clicked");

button2.addEventListener("click", clickHandler2);
console.log("Button 2 listeners:", button2.getEventListenersCount());

// Remove event listener before removing element
button2.removeEventListener("click", clickHandler2);
console.log("Event listener removed");
console.log("Button 2 listeners:", button2.getEventListenersCount());

// Now safe to remove element
button2 = null;
console.log("Button 2 reference removed safely");

console.log("\n=== KEY INSIGHT ===");
console.log("Event listeners can cause memory leaks");
console.log("Always remove listeners before destroying elements");
console.log("Use removeEventListener() to prevent memory leaks");
```

</div>

---

## ⚠️ Common Pitfalls

### Pitfall 1: Global Variables

```javascript
// ❌ WRONG: Accidental global variable
function processData() {
    result = "processed";  // Missing 'let' or 'const'
}

// ✅ CORRECT: Proper variable declaration
function processData() {
    let result = "processed";
}
```


### Pitfall 2: Forgotten Event Listeners

```javascript
// ❌ WRONG: Event listener not removed
element.addEventListener("click", handler);
// Element removed from DOM but listener remains

// ✅ CORRECT: Remove event listener
element.addEventListener("click", handler);
element.removeEventListener("click", handler);
```


---

## 🎯 Best Practices

### ✅ Do's:
- **Use `let` and `const`** instead of `var`
- **Remove event listeners** when elements are destroyed
- **Clear timers** when they're no longer needed
- **Avoid global variables** and use proper scoping
- **Monitor memory usage** in development

### ❌ Don'ts:
- **Don't create circular references** unnecessarily
- **Don't forget to clean up** event listeners and timers
- **Don't store large objects** in closures
- **Don't ignore memory warnings** in development tools

---

## 🔑 Key Points

- **Garbage Collection** automatically manages memory in JavaScript
- **Reference Counting** tracks object references (limited use)
- **Mark and Sweep** is the primary GC algorithm (handles circular references)
- **Generational Collection** optimizes GC for different object ages
- **Memory Leaks** occur when memory is allocated but never freed
- **Event Listeners and Timers** are common sources of memory leaks
- **Closures** can hold references and cause memory leaks
- **Always clean up** resources to prevent memory leaks

---

## ❓ Common Interview Questions

### Q1: What is garbage collection in JavaScript?
**A:** Garbage collection is JavaScript's automatic memory management system that identifies and frees memory that is no longer accessible by the program. It prevents memory leaks and manages memory allocation/deallocation automatically.

### Q2: How does the Mark and Sweep algorithm work?
**A:** Mark and Sweep works in two phases: 1) Mark phase traverses from root objects and marks all reachable objects, 2) Sweep phase frees memory of unmarked (unreachable) objects. It handles circular references correctly.

### Q3: What are common causes of memory leaks in JavaScript?
**A:** Common causes include: global variables, forgotten event listeners, uncleared timers (setInterval/setTimeout), circular references in closures, and holding references to DOM elements that are no longer in the document.

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="12-Event-Loop-Concurrency.md" class="nav-link prev">← Previous: Event Loop & Concurrency</a>
    <a href="01-Execution-Context-Call-Stack.md" class="nav-link next">Back to Start: Execution Context & Call Stack →</a>
</div>

*Last updated: December 2024*
