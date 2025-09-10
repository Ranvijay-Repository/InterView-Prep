# 🔄 Event Loop & Concurrency

> **Understanding how JavaScript handles asynchronous operations and manages concurrency**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is the Event Loop?](#what-is-the-event-loop)
- [JavaScript Runtime Architecture](#javascript-runtime-architecture)
- [Call Stack](#call-stack)
- [Web APIs](#web-apis)
- [Callback Queue](#callback-queue)
- [Microtask Queue](#microtask-queue)
- [Execution Order](#execution-order)
- [Node.js Event Loop](#nodejs-event-loop)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What is the Event Loop?

**The Event Loop** is JavaScript's mechanism for handling asynchronous operations. It continuously monitors the call stack and callback queues, ensuring that JavaScript can perform non-blocking I/O operations while maintaining a single-threaded execution model.

### Why Understanding This Matters:
- **Asynchronous Programming**: Write non-blocking code effectively
- **Performance**: Understand execution order and timing
- **Debugging**: Trace async execution flow
- **Web Development**: Handle user interactions and API calls
- **Node.js**: Build scalable server applications

---

## 🏗️ JavaScript Runtime Architecture

JavaScript runtime consists of several components that work together to execute code.

### ASCII Diagram: JavaScript Runtime

```
JAVASCRIPT RUNTIME ARCHITECTURE
┌─────────────────────────────────────────────────────────┐
│                    JAVASCRIPT ENGINE                    │
│  ┌─────────────────┐    ┌─────────────────────────────┐ │
│  │   CALL STACK    │    │        HEAP                 │ │
│  │                 │    │   (Memory Allocation)       │ │
│  │ function calls  │    │                             │ │
│  │ execution       │    │                             │ │
│  └─────────────────┘    └─────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    WEB APIs                             │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐ │
│  │  setTimeout │ │   fetch    │ │   DOM Events        │ │
│  │   setInterval│ │   XMLHttp  │ │   File System       │ │
│  └─────────────┘ └─────────────┘ └─────────────────────┘ │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    EVENT LOOP                           │
│  ┌─────────────────┐    ┌─────────────────────────────┐ │
│  │ CALLBACK QUEUE  │    │     MICROTASK QUEUE         │ │
│  │ (Macrotasks)    │    │     (Promises, etc.)        │ │
│  │                 │    │                             │ │
│  └─────────────────┘    └─────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```


---

## 📚 Call Stack

The **Call Stack** is a data structure that tracks function calls during execution.

### Characteristics:
- **LIFO (Last In, First Out)**: Functions are executed in reverse order of calling
- **Single-threaded**: Only one function executes at a time
- **Blocking**: Long-running functions block the entire stack

### ASCII Diagram: Call Stack

```
CALL STACK OPERATION
┌─────────────────────────────────┐
│           CALL STACK            │
├─────────────────────────────────┤
│ functionC()                     │ ← Top (currently executing)
├─────────────────────────────────┤
│ functionB()                     │
├─────────────────────────────────┤
│ functionA()                     │
├─────────────────────────────────┤
│ main()                          │ ← Bottom
└─────────────────────────────────┘

EXECUTION FLOW:
1. main() calls functionA()
2. functionA() calls functionB()
3. functionB() calls functionC()
4. functionC() executes and returns
5. functionB() continues and returns
6. functionA() continues and returns
7. main() continues
```


---

## 🌐 Web APIs

**Web APIs** are browser-provided interfaces that allow JavaScript to perform asynchronous operations.

### Common Web APIs:
- **Timers**: `setTimeout`, `setInterval`
- **Network**: `fetch`, `XMLHttpRequest`
- **DOM**: Event listeners, `requestAnimationFrame`
- **Storage**: `localStorage`, `IndexedDB`
- **Media**: Audio, Video APIs

### ASCII Diagram: Web API Operation

```
WEB API OPERATION FLOW
┌─────────────────────────────────┐
│ 1. Call setTimeout(fn, 1000)   │
│    ↓                           │
│ 2. Web API starts timer        │
│    ↓                           │
│ 3. Call stack continues        │
│    ↓                           │
│ 4. Timer completes             │
│    ↓                           │
│ 5. Callback goes to queue      │
│    ↓                           │
│ 6. Event loop picks it up      │
│    ↓                           │
│ 7. Callback executes           │
└─────────────────────────────────┘
```


---

## 📋 Callback Queue

The **Callback Queue** (also called Task Queue or Macrotask Queue) holds callbacks from Web APIs.

### Characteristics:
- **FIFO (First In, First Out)**: Callbacks execute in order of arrival
- **Macrotasks**: Large, discrete units of work
- **Lower Priority**: Executes after microtasks

### ASCII Diagram: Callback Queue

```
CALLBACK QUEUE OPERATION
┌─────────────────────────────────┐
│        CALLBACK QUEUE           │
├─────────────────────────────────┤
│ setTimeout callback 1           │ ← First in
├─────────────────────────────────┤
│ fetch callback                  │
├─────────────────────────────────┤
│ DOM event callback              │
├─────────────────────────────────┤
│ setTimeout callback 2           │ ← Last in
└─────────────────────────────────┘

EXECUTION ORDER:
1. setTimeout callback 1 executes first
2. fetch callback executes second
3. DOM event callback executes third
4. setTimeout callback 2 executes last
```


---

## ⚡ Microtask Queue

The **Microtask Queue** holds higher-priority callbacks that execute before the next render.

### Characteristics:
- **Higher Priority**: Executes before macrotasks
- **Microtasks**: Small, quick operations
- **Examples**: Promise callbacks, `queueMicrotask()`, `process.nextTick()` (Node.js)

### ASCII Diagram: Microtask Queue

```
MICROTASK QUEUE OPERATION
┌─────────────────────────────────┐
│       MICROTASK QUEUE           │
├─────────────────────────────────┤
│ Promise.then() callback         │ ← First in
├─────────────────────────────────┤
│ queueMicrotask() callback       │
├─────────────────────────────────┤
│ Promise.catch() callback        │
├─────────────────────────────────┤
│ process.nextTick() callback     │ ← Last in
└─────────────────────────────────┘

EXECUTION PRIORITY:
1. All microtasks execute first
2. Then next macrotask from callback queue
3. Then all microtasks again
4. Repeat...
```


---

## 🏃 Execution Order

The Event Loop follows a specific order when processing tasks.

### ASCII Diagram: Execution Order Priority

```
EXECUTION ORDER PRIORITY
┌─────────────────────────────────┐
│ 1. EXECUTE CALL STACK           │
│    (Synchronous code)           │
│    ↓                           │
│ 2. CHECK MICROTASK QUEUE       │
│    (Execute ALL microtasks)     │
│    ↓                           │
│ 3. CHECK CALLBACK QUEUE        │
│    (Execute ONE macrotask)      │
│    ↓                           │
│ 4. RENDER (if needed)          │
│    ↓                           │
│ 5. REPEAT FROM STEP 2          │
└─────────────────────────────────┘

KEY RULES:
• Microtasks have higher priority than macrotasks
• All microtasks execute before next macrotask
• Only one macrotask executes per loop iteration
• Render happens after microtasks complete
```


---

## 🖥️ Node.js Event Loop

Node.js has additional phases in its event loop beyond the browser's simpler model.

### Node.js Event Loop Phases:
1. **Timers**: `setTimeout`, `setInterval` callbacks
2. **Pending callbacks**: Deferred I/O callbacks
3. **Idle, prepare**: Internal use
4. **Poll**: New I/O events, I/O callbacks
5. **Check**: `setImmediate()` callbacks
6. **Close callbacks**: Close event callbacks

---

## 💻 Detailed Examples

### Example 1: Basic Event Loop Demonstration
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== BASIC EVENT LOOP DEMONSTRATION ===");

console.log("1. Start of script");

setTimeout(() => {
    console.log("2. setTimeout callback (0ms)");
}, 0);

setTimeout(() => {
    console.log("3. setTimeout callback (100ms)");
}, 100);

Promise.resolve().then(() => {
    console.log("4. Promise.then() callback");
});

console.log("5. End of script");

// Expected output:
// 1. Start of script
// 5. End of script
// 4. Promise.then() callback
// 2. setTimeout callback (0ms)
// 3. setTimeout callback (100ms)

console.log("\n=== EXPLANATION ===");
console.log("1. Synchronous code executes first");
console.log("2. Microtasks (Promises) execute next");
console.log("3. Macrotasks (setTimeout) execute last");
console.log("4. Even 0ms setTimeout is a macrotask");
```

</div>

### Example 2: Microtask vs Macrotask Priority
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== MICROTASK VS MACROTASK PRIORITY ===");

console.log("1. Script start");

setTimeout(() => {
    console.log("2. setTimeout 1 (0ms)");
    
    Promise.resolve().then(() => {
        console.log("3. Promise inside setTimeout 1");
    });
}, 0);

setTimeout(() => {
    console.log("4. setTimeout 2 (0ms)");
    
    Promise.resolve().then(() => {
        console.log("5. Promise inside setTimeout 2");
    });
}, 0);

Promise.resolve().then(() => {
    console.log("6. Promise 1");
    
    Promise.resolve().then(() => {
        console.log("7. Nested Promise 1");
    });
});

Promise.resolve().then(() => {
    console.log("8. Promise 2");
});

console.log("9. Script end");

// Expected output:
// 1. Script start
// 9. Script end
// 6. Promise 1
// 8. Promise 2
// 7. Nested Promise 1
// 2. setTimeout 1 (0ms)
// 3. Promise inside setTimeout 1
// 4. setTimeout 2 (0ms)
// 5. Promise inside setTimeout 2

console.log("\n=== KEY INSIGHTS ===");
console.log("• All microtasks execute before any macrotask");
console.log("• Nested microtasks execute immediately");
console.log("• Macrotasks execute one at a time");
console.log("• Each macrotask can spawn new microtasks");
```

</div>

### Example 3: Complex Async Operations
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== COMPLEX ASYNC OPERATIONS ===");

async function asyncFunction() {
    console.log("2. Async function start");
    
    await Promise.resolve();
    console.log("4. After await");
    
    return "Async result";
}

function regularFunction() {
    console.log("3. Regular function");
    
    return new Promise(resolve => {
        setTimeout(() => {
            console.log("6. setTimeout in regular function");
            resolve("Regular result");
        }, 0);
    });
}

console.log("1. Script start");

// Start async operations
asyncFunction().then(result => {
    console.log("5. Async function result:", result);
});

regularFunction().then(result => {
    console.log("7. Regular function result:", result);
});

setTimeout(() => {
    console.log("8. Final setTimeout");
}, 0);

console.log("9. Script end");

// Expected output:
// 1. Script start
// 2. Async function start
// 3. Regular function
// 9. Script end
// 4. After await
// 5. Async function result: Async result
// 6. setTimeout in regular function
// 7. Regular function result: Regular result
// 8. Final setTimeout

console.log("\n=== EXPLANATION ===");
console.log("• async/await is syntactic sugar for Promises");
console.log("• await pauses execution until Promise resolves");
console.log("• The function after await becomes a microtask");
console.log("• setTimeout callbacks are always macrotasks");
```

</div>

### Example 4: Event Loop Blocking
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== EVENT LOOP BLOCKING ===");

console.log("1. Start");

setTimeout(() => {
    console.log("2. setTimeout callback");
}, 0);

Promise.resolve().then(() => {
    console.log("3. Promise callback");
});

// Blocking operation
console.log("4. Starting blocking operation");
const start = Date.now();

// Simulate heavy computation
while (Date.now() - start < 1000) {
    // Block for 1 second
}

console.log("5. Blocking operation complete");

// Expected output:
// 1. Start
// 4. Starting blocking operation
// 5. Blocking operation complete
// 3. Promise callback
// 2. setTimeout callback

console.log("\n=== WHAT HAPPENED ===");
console.log("• setTimeout was scheduled but couldn't execute");
console.log("• Promise callback was queued but couldn't execute");
console.log("• Event loop was blocked by synchronous code");
console.log("• Only after blocking code finished did async code run");

console.log("\n=== PREVENTION ===");
console.log("• Use Web Workers for heavy computations");
console.log("• Break large operations into smaller chunks");
console.log("• Use requestIdleCallback for non-critical work");
console.log("• Avoid blocking the main thread");
```

</div>

### Example 5: Real-World Event Loop Scenarios
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== REAL-WORLD EVENT LOOP SCENARIOS ===");

// Scenario 1: User interaction with async operations
console.log("=== SCENARIO 1: User Interaction ===");

function handleUserClick() {
    console.log("1. User clicked button");
    
    // Simulate API call
    fetch('https://api.example.com/data')
        .then(response => response.json())
        .then(data => {
            console.log("3. API data received:", data);
            
            // Update DOM
            setTimeout(() => {
                console.log("4. DOM updated");
            }, 0);
        });
    
    console.log("2. Click handler finished");
}

// Simulate user click
handleUserClick();

// Scenario 2: Multiple async operations
console.log("\n=== SCENARIO 2: Multiple Async Operations ===");

async function loadUserData() {
    console.log("1. Loading user data...");
    
    const userPromise = fetch('https://api.example.com/user');
    const postsPromise = fetch('https://api.example.com/posts');
    
    const [user, posts] = await Promise.all([userPromise, postsPromise]);
    
    console.log("3. All data loaded");
    
    return { user: await user.json(), posts: await posts.json() };
}

loadUserData().then(data => {
    console.log("4. Data processing complete");
    
    // Schedule UI update
    requestAnimationFrame(() => {
        console.log("5. UI updated in next frame");
    });
});

console.log("2. Async operations started");

// Scenario 3: Error handling in async operations
console.log("\n=== SCENARIO 3: Error Handling ===");

Promise.resolve()
    .then(() => {
        console.log("1. First operation");
        throw new Error("Something went wrong");
    })
    .catch(error => {
        console.log("2. Error caught:", error.message);
        
        // Schedule recovery operation
        setTimeout(() => {
            console.log("3. Recovery operation completed");
        }, 0);
    })
    .finally(() => {
        console.log("4. Cleanup completed");
    });

console.log("5. Error handling setup complete");

console.log("\n=== KEY INSIGHTS ===");
console.log("• User interactions create immediate microtasks");
console.log("• API calls create macrotasks when they complete");
console.log("• Promise.all waits for all operations");
console.log("• Error handling follows the same event loop rules");
console.log("• requestAnimationFrame is a special macrotask");
```

</div>

---

## ⚠️ Common Pitfalls

### Pitfall 1: Blocking the Event Loop

```javascript
// ❌ WRONG: Blocking operation
function heavyComputation() {
    const start = Date.now();
    while (Date.now() - start < 5000) {
        // Block for 5 seconds
    }
}

// ✅ CORRECT: Non-blocking operation
function heavyComputation() {
    return new Promise(resolve => {
        setTimeout(() => {
            // Do work in chunks
            resolve("Computation complete");
        }, 0);
    });
}
```


### Pitfall 2: Ignoring Microtask Priority

```javascript
// ❌ WRONG: Assuming setTimeout executes before Promise
setTimeout(() => console.log("Timeout"), 0);
Promise.resolve().then(() => console.log("Promise"));

// Output: Promise, then Timeout (not the other way around!)
```


### Pitfall 3: Infinite Microtask Loops

```javascript
// ❌ WRONG: Infinite microtask loop
function infiniteMicrotasks() {
    Promise.resolve().then(infiniteMicrotasks);
}

// This will block the event loop forever!
```


---

## 🎯 Best Practices

### ✅ Do's:
- **Use Web Workers** for heavy computations
- **Break large operations** into smaller chunks
- **Understand execution order** (microtasks vs macrotasks)
- **Use `requestIdleCallback`** for non-critical work
- **Handle errors properly** in async operations

### ❌ Don'ts:
- **Don't block** the main thread with heavy operations
- **Don't assume** execution order without understanding the event loop
- **Don't create infinite loops** in microtasks
- **Don't ignore** the performance impact of async operations

---

## 🔑 Key Points

- **Event Loop** manages asynchronous operations in JavaScript
- **Call Stack** executes synchronous code (LIFO)
- **Web APIs** handle async operations outside the main thread
- **Callback Queue** holds macrotasks (setTimeout, fetch, etc.)
- **Microtask Queue** holds high-priority tasks (Promises)
- **Microtasks execute before macrotasks** in each loop iteration
- **Only one macrotask executes** per loop iteration
- **Event Loop is single-threaded** but handles concurrency through queues

---

## ❓ Common Interview Questions

### Q1: What is the Event Loop in JavaScript?
**A:** The Event Loop is JavaScript's mechanism for handling asynchronous operations. It continuously monitors the call stack and callback queues, ensuring that JavaScript can perform non-blocking I/O operations while maintaining a single-threaded execution model.

### Q2: What's the difference between microtasks and macrotasks?
**A:** Microtasks (like Promise callbacks) have higher priority and execute before macrotasks. All microtasks in the queue execute before the next macrotask. Macrotasks (like setTimeout callbacks) execute one at a time and have lower priority.

### Q3: How does setTimeout(0) work?
**A:** `setTimeout(0)` doesn't execute immediately. It schedules the callback to be added to the callback queue after the current execution context finishes. The callback will execute after all microtasks and when the event loop processes the callback queue.

### Q4: What happens when you block the Event Loop?
**A:** When the Event Loop is blocked by synchronous code, no asynchronous operations (setTimeout, Promise callbacks, etc.) can execute. The browser becomes unresponsive, and user interactions are delayed until the blocking operation completes.

### Q5: How can you prevent blocking the Event Loop?
**A:** Use Web Workers for heavy computations, break large operations into smaller chunks using `setTimeout` or `requestAnimationFrame`, use `requestIdleCallback` for non-critical work, and avoid long-running synchronous operations in the main thread.

---

## 🏋️ Practice Exercises

### Exercise 1: Event Loop Simulator
Create a function that simulates the Event Loop and demonstrates execution order.

### Exercise 2: Async Operation Manager
Build a utility that manages multiple async operations and ensures proper execution order.

### Exercise 3: Performance Monitor
Implement a tool that detects when the Event Loop is being blocked and provides warnings.

---

## 📚 Additional Resources

- [MDN: Concurrency model and Event Loop](https://developer.mozilla.org/en-US/docs/Web/JavaScript/EventLoop)
- [JavaScript.info: Event loop: microtasks and macrotasks](https://javascript.info/event-loop)
- [Node.js: Event Loop](https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick/)
- [Philip Roberts: What the heck is the event loop?](https://www.youtube.com/watch?v=8aGhZQkoFbQ)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="11-Prototype-Prototypal-Inheritance.md" class="nav-link prev">← Previous: Prototype & Prototypal Inheritance</a>
    <a href="13-Garbage-Collection.md" class="nav-link next">Next: Garbage Collection →</a>
</div>

*Last updated: December 2024*
