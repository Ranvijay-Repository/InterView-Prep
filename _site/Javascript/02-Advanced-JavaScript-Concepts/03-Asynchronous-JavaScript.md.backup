# ⚡ Asynchronous JavaScript

> **Mastering async programming, promises, promises, async/await, and the event loop**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is Asynchronous Programming?](#what-is-asynchronous-programming)
- [Callbacks & Callback Hell](#callbacks--callback-hell)
- [Promises](#promises)
- [Async/Await](#asyncawait)
- [Event Loop & Concurrency](#event-loop--concurrency)
- [Error Handling](#error-handling)
- [Advanced Async Patterns](#advanced-async-patterns)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What is Asynchronous Programming?

**Asynchronous Programming** is a programming paradigm that allows code to run in the background without blocking the execution of other code. In JavaScript, this is essential for handling operations like API calls, file operations, and user interactions.

### Why Asynchronous Programming Matters:
- **Non-blocking**: Code continues to run while waiting for operations to complete
- **Better User Experience**: UI remains responsive during long operations
- **Efficient Resource Usage**: Can handle multiple operations concurrently
- **Real-world Operations**: Most real operations (API calls, file I/O) are asynchronous

### Synchronous vs Asynchronous:

{% raw %}
```javascript
// ❌ SYNCHRONOUS (Blocking)
function syncOperation() {
    const start = Date.now();
    // Simulate long operation
    while (Date.now() - start < 3000) {
        // Block for 3 seconds
    }
    return "Operation completed";
}

console.log("Starting...");
const result = syncOperation(); // Blocks here for 3 seconds
console.log(result);
console.log("Finished!");

// ✅ ASYNCHRONOUS (Non-blocking)
function asyncOperation() {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve("Operation completed");
        }, 3000);
    });
}

console.log("Starting...");
asyncOperation().then(result => {
    console.log(result);
    console.log("Finished!");
});
console.log("This runs immediately!");
```
{% endraw %}


### ASCII Diagram: Sync vs Async Execution

{% raw %}
```
SYNCHRONOUS EXECUTION
┌─────────────────────────────────┐
│ Start                           │
│ ↓                               │
│ Operation 1 (3s)                │
│ ↓                               │
│ Operation 2 (2s)                │
│ ↓                               │
│ Operation 3 (1s)                │
│ ↓                               │
│ End                             │
│ Total Time: 6 seconds           │
└─────────────────────────────────┘

ASYNCHRONOUS EXECUTION
┌─────────────────────────────────┐
│ Start                           │
│ ↓                               │
│ Operation 1 (3s) ──────────────┐│
│ Operation 2 (2s) ──────────────┐││
│ Operation 3 (1s) ──────────────┐││
│ ↓                               │││
│ End                             │││
│ Total Time: 3 seconds           │││
└─────────────────────────────────┘││
                                   ││
                                   └┘
                                   └┘
```
{% endraw %}


---

## 🔄 Callbacks & Callback Hell

**Callbacks** are functions passed as arguments to other functions, which are executed once the asynchronous operation completes. While callbacks are fundamental to async JavaScript, they can lead to "callback hell" when nested deeply.

### Basic Callback Pattern:

{% raw %}
```javascript
// Simple callback example
function fetchUserData(userId, callback) {
    // Simulate API call
    setTimeout(() => {
        const user = {
            id: userId,
            name: "John Doe",
            email: "john@example.com"
        };
        callback(null, user);
    }, 1000);
}

// Usage
fetchUserData(123, (error, user) => {
    if (error) {
        console.error("Error:", error);
        return;
    }
    console.log("User:", user);
});
```
{% endraw %}


---

## 🤝 Promises

**Promises** are objects that represent the eventual completion (or failure) of an asynchronous operation. They provide a cleaner way to handle asynchronous code compared to callbacks.

### Promise States:
- **Pending**: Initial state, neither fulfilled nor rejected
- **Fulfilled**: Operation completed successfully
- **Rejected**: Operation failed

### Basic Promise Usage:

{% raw %}
```javascript
// Creating a promise
const myPromise = new Promise((resolve, reject) => {
    // Simulate async operation
    setTimeout(() => {
        const random = Math.random();
        
        if (random > 0.5) {
            resolve(`Success! Random number: ${random}`);
        } else {
            reject(new Error(`Failed! Random number: ${random}`));
        }
    }, 1000);
});

// Using the promise
myPromise
    .then(result => {
        console.log("Promise resolved:", result);
    })
    .catch(error => {
        console.error("Promise rejected:", error.message);
    })
    .finally(() => {
        console.log("Promise completed (success or failure)");
    });
```
{% endraw %}


---

## ⏳ Async/Await

**Async/Await** is syntactic sugar over promises that makes asynchronous code look and behave more like synchronous code. It's built on top of promises and provides a cleaner, more readable way to handle asynchronous operations.

### Basic Async/Await Syntax:

{% raw %}
```javascript
// Basic async function
async function fetchUserData(userId) {
    try {
        // Simulate API call
        const response = await new Promise((resolve, reject) => {
            setTimeout(() => {
                if (userId <= 0) {
                    reject(new Error('Invalid user ID'));
                    return;
                }
                
                const user = {
                    id: userId,
                    name: `User ${userId}`,
                    email: `user${userId}@example.com`
                };
                
                resolve(user);
            }, 1000);
        });
        
        return response;
    } catch (error) {
        throw error;
    }
}

// Usage
async function main() {
    try {
        const user = await fetchUserData(123);
        console.log('User:', user);
    } catch (error) {
        console.error('Error:', error.message);
    }
}

main();
```
{% endraw %}


### ASCII Diagram: Async/Await vs Promises

{% raw %}
```
PROMISE CHAINING                    ASYNC/AWAIT
┌─────────────────────────────┐    ┌─────────────────────────────┐
│ fetchUserData(123)          │    │ async function main() {     │
│   .then(user => {           │    │   try {                     │
│     return fetchPosts(user) │    │     const user = await      │
│   })                        │    │       fetchUserData(123);   │
│   .then(posts => {          │    │     const posts = await     │
│     return fetchFriends(user)│   │       fetchPosts(user);    │
│   })                        │    │     const friends = await   │
│   .then(friends => {        │    │       fetchFriends(user);   │
│     console.log(friends);   │    │     console.log(friends);   │
│   })                        │    │   } catch (error) {         │
│   .catch(error => {         │    │     console.error(error);   │
│     console.error(error);   │    │   }                        │
│   });                       │    │ }                          │
└─────────────────────────────┘    └─────────────────────────────┘

ADVANTAGES:
• More readable and intuitive
• Better error handling with try/catch
• Easier to debug
• Sequential execution is clearer
```
{% endraw %}


### Sequential vs Parallel Execution:

#### 1. **Sequential Execution (Default)**

{% raw %}
```javascript
async function fetchUserProfile(userId) {
    console.time('Sequential');
    
    try {
        // These run one after another
        const user = await fetchUserData(userId);
        console.log('User fetched');
        
        const posts = await fetchUserPosts(userId);
        console.log('Posts fetched');
        
        const friends = await fetchUserFriends(userId);
        console.log('Friends fetched');
        
        const settings = await fetchUserSettings(userId);
        console.log('Settings fetched');
        
        console.timeEnd('Sequential');
        
        return { user, posts, friends, settings };
        
    } catch (error) {
        console.error('Error:', error.message);
        throw error;
    }
}
```
{% endraw %}


#### 2. **Parallel Execution**

{% raw %}
```javascript
async function fetchUserProfileParallel(userId) {
    console.time('Parallel');
    
    try {
        // These run simultaneously
        const [user, posts, friends, settings] = await Promise.all([
            fetchUserData(userId),
            fetchUserPosts(userId),
            fetchUserFriends(userId),
            fetchUserSettings(userId)
        ]);
        
        console.log('All data fetched simultaneously');
        console.timeEnd('Parallel');
        
        return { user, posts, friends, settings };
        
    } catch (error) {
        console.error('Error:', error.message);
        throw error;
    }
}
```
{% endraw %}


#### 3. **Mixed Approach**

{% raw %}
```javascript
async function fetchUserProfileMixed(userId) {
    console.time('Mixed');
    
    try {
        // Fetch user first (required for other calls)
        const user = await fetchUserData(userId);
        console.log('User fetched');
        
        // Fetch other data in parallel
        const [posts, friends, settings] = await Promise.all([
            fetchUserPosts(userId),
            fetchUserFriends(userId),
            fetchUserSettings(userId)
        ]);
        
        console.log('Remaining data fetched in parallel');
        console.timeEnd('Mixed');
        
        return { user, posts, friends, settings };
        
    } catch (error) {
        console.error('Error:', error.message);
        throw error;
    }
}
```
{% endraw %}


### Error Handling with Async/Await:

{% raw %}
```javascript
// Multiple ways to handle errors
async function robustErrorHandling() {
    try {
        // Method 1: Try-catch with await
        const user = await fetchUserData(123);
        
        // Method 2: Promise.catch() with await
        const posts = await fetchUserPosts(123).catch(error => {
            console.log('Posts fetch failed, using default:', error.message);
            return []; // Return default value
        });
        
        // Method 3: Conditional error handling
        let friends;
        try {
            friends = await fetchUserFriends(123);
        } catch (error) {
            if (error.message.includes('rate limit')) {
                // Retry after delay
                await new Promise(resolve => setTimeout(resolve, 1000));
                friends = await fetchUserFriends(123);
            } else {
                friends = []; // Default value
            }
        }
        
        return { user, posts, friends };
        
    } catch (error) {
        // Handle any uncaught errors
        console.error('Unexpected error:', error.message);
        throw error;
    }
}
```
{% endraw %}


### Advanced Async/Await Patterns:

#### 1. **Async Iterators**

{% raw %}
```javascript
async function* asyncGenerator() {
    const items = ['apple', 'banana', 'cherry'];
    
    for (const item of items) {
        // Simulate async operation
        await new Promise(resolve => setTimeout(resolve, 1000));
        yield item;
    }
}

// Usage with for-await-of
async function consumeAsyncGenerator() {
    for await (const item of asyncGenerator()) {
        console.log('Received:', item);
    }
}

consumeAsyncGenerator();
```
{% endraw %}


#### 2. **Async Functions in Loops**

{% raw %}
```javascript
// ❌ WRONG: Sequential execution in loop
async function processItemsSequential(items) {
    const results = [];
    
    for (const item of items) {
        const result = await processItem(item); // Waits for each
        results.push(result);
    }
    
    return results;
}

// ✅ CORRECT: Parallel execution in loop
async function processItemsParallel(items) {
    const promises = items.map(item => processItem(item));
    const results = await Promise.all(promises);
    return results;
}

// ✅ CORRECT: Controlled concurrency
async function processItemsWithConcurrency(items, concurrency = 3) {
    const results = [];
    
    for (let i = 0; i < items.length; i += concurrency) {
        const batch = items.slice(i, i + concurrency);
        const batchPromises = batch.map(item => processItem(item));
        const batchResults = await Promise.all(batchPromises);
        results.push(...batchResults);
    }
    
    return results;
}
```
{% endraw %}


#### 3. **Async Class Methods**

{% raw %}
```javascript
class UserService {
    constructor() {
        this.cache = new Map();
    }
    
    async getUser(userId) {
        // Check cache first
        if (this.cache.has(userId)) {
            console.log('Returning cached user');
            return this.cache.get(userId);
        }
        
        // Fetch from API
        const user = await this.fetchFromAPI(userId);
        
        // Cache the result
        this.cache.set(userId, user);
        
        return user;
    }
    
    async fetchFromAPI(userId) {
        // Simulate API call
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        return {
            id: userId,
            name: `User ${userId}`,
            email: `user${userId}@example.com`
        };
    }
    
    async clearCache() {
        this.cache.clear();
        console.log('Cache cleared');
    }
    
    // Static async method
    static async validateUser(userId) {
        if (userId <= 0) {
            throw new Error('Invalid user ID');
        }
        return true;
    }
}

// Usage
const userService = new UserService();

async function main() {
    try {
        // Validate first
        await UserService.validateUser(123);
        
        // Get user (will be cached on subsequent calls)
        const user1 = await userService.getUser(123);
        console.log('User 1:', user1);
        
        const user2 = await userService.getUser(123); // From cache
        console.log('User 2:', user2);
        
        // Clear cache
        await userService.clearCache();
        
    } catch (error) {
        console.error('Error:', error.message);
    }
}

main();
```
{% endraw %}


#### 4. **Async Function Composition**

{% raw %}
```javascript
// Compose async functions
const composeAsync = (...fns) => async (x) => {
    let result = x;
    for (const fn of fns) {
        result = await fn(result);
    }
    return result;
};

// Async utility functions
const fetchUser = async (id) => {
    await new Promise(resolve => setTimeout(resolve, 500));
    return { id, name: `User ${id}` };
};

const fetchPosts = async (user) => {
    await new Promise(resolve => setTimeout(resolve, 300));
    return { ...user, posts: [`Post 1 by ${user.name}`, `Post 2 by ${user.name}`] };
};

const fetchFriends = async (user) => {
    await new Promise(resolve => setTimeout(resolve, 200));
    return { ...user, friends: ['Friend 1', 'Friend 2'] };
};

const formatProfile = async (user) => {
    return {
        id: user.id,
        name: user.name,
        postCount: user.posts.length,
        friendCount: user.friends.length,
        summary: `${user.name} has ${user.posts.length} posts and ${user.friends.length} friends`
    };
};

// Compose and execute
const getUserProfile = composeAsync(
    fetchUser,
    fetchPosts,
    fetchFriends,
    formatProfile
);

// Usage
getUserProfile(123)
    .then(profile => console.log('Profile:', profile))
    .catch(error => console.error('Error:', error.message));
```
{% endraw %}


---

## 🔄 Event Loop & Concurrency

**The Event Loop** is the mechanism that allows JavaScript to perform non-blocking operations despite being single-threaded. It continuously checks the call stack and processes tasks from the callback queue.

### How the Event Loop Works:

{% raw %}
```javascript
// Event Loop demonstration
console.log('1. Start');

setTimeout(() => {
    console.log('2. Timeout callback');
}, 0);

Promise.resolve().then(() => {
    console.log('3. Promise microtask');
});

console.log('4. End');

// Output order:
// 1. Start
// 4. End
// 3. Promise microtask
// 2. Timeout callback
```
{% endraw %}


### ASCII Diagram: Event Loop Architecture

{% raw %}
```
EVENT LOOP ARCHITECTURE
┌─────────────────────────────────┐
│ Call Stack                      │
│ ├─ main()                      │
│ ├─ setTimeout()                │
│ └─ console.log()               │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│ Web APIs                        │
│ ├─ setTimeout                  │
│ ├─ fetch                       │
│ ├─ DOM events                  │
│ └─ ...                        │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│ Callback Queue (Macrotasks)     │
│ ├─ setTimeout callbacks         │
│ ├─ DOM event handlers           │
│ └─ fetch callbacks              │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│ Microtask Queue                 │
│ ├─ Promise callbacks            │
│ ├─ queueMicrotask()            │
│ └─ process.nextTick() (Node)   │
└─────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│ Event Loop                      │
│ 1. Check call stack            │
│ 2. If empty, check microtasks  │
│ 3. If empty, check macrotasks  │
│ 4. Repeat                      │
└─────────────────────────────────┘
```
{% endraw %}


### Task Types and Priority:

{% raw %}
```javascript
// Microtasks (highest priority)
Promise.resolve().then(() => console.log('Microtask 1'));
queueMicrotask(() => console.log('Microtask 2'));

// Macrotasks (lower priority)
setTimeout(() => console.log('Macrotask 1'), 0);
setImmediate(() => console.log('Macrotask 2')); // Node.js only

// Synchronous code (immediate)
console.log('Synchronous');

// Output order:
// Synchronous
// Microtask 1
// Microtask 2
// Macrotask 1
// Macrotask 2
```
{% endraw %}


---

## ⚠️ Error Handling

**Error handling** in asynchronous JavaScript is crucial for building robust applications. Different patterns require different error handling approaches.

### Error Handling Patterns:

#### 1. **Try-Catch with Async/Await**

{% raw %}
```javascript
async function fetchUserData(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const user = await response.json();
        return user;
        
    } catch (error) {
        console.error('Failed to fetch user:', error.message);
        throw error; // Re-throw to let caller handle
    }
}

// Usage
async function main() {
    try {
        const user = await fetchUserData(123);
        console.log('User:', user);
    } catch (error) {
        console.error('Error in main:', error.message);
        // Handle error appropriately
    }
}
```
{% endraw %}


#### 2. **Promise Error Handling**

{% raw %}
```javascript
function fetchUserData(userId) {
    return fetch(`/api/users/${userId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .catch(error => {
            console.error('Failed to fetch user:', error.message);
            throw error;
        });
}

// Usage
fetchUserData(123)
    .then(user => {
        console.log('User:', user);
    })
    .catch(error => {
        console.error('Error:', error.message);
    });
```
{% endraw %}


#### 3. **Global Error Handling**

{% raw %}
```javascript
// Global unhandled promise rejection handler
window.addEventListener('unhandledrejection', event => {
    console.error('Unhandled promise rejection:', event.reason);
    event.preventDefault(); // Prevent default browser behavior
});

// Global error handler
window.addEventListener('error', event => {
    console.error('Global error:', event.error);
});

// Node.js global handlers
process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

process.on('uncaughtException', (error) => {
    console.error('Uncaught Exception:', error);
    process.exit(1); // Exit on uncaught exceptions
});
```
{% endraw %}


---

## 🚀 Advanced Async Patterns

### 1. **Async Retry with Exponential Backoff**

{% raw %}
```javascript
async function retryWithBackoff(fn, maxAttempts = 3, baseDelay = 1000) {
    for (let attempt = 1; attempt <= maxAttempts; attempt++) {
        try {
            return await fn();
        } catch (error) {
            if (attempt === maxAttempts) {
                throw error;
            }
            
            const delay = baseDelay * Math.pow(2, attempt - 1);
            console.log(`Attempt ${attempt} failed, retrying in ${delay}ms...`);
            
            await new Promise(resolve => setTimeout(resolve, delay));
        }
    }
}

// Usage
const unreliableOperation = async () => {
    const random = Math.random();
    if (random > 0.8) {
        return "Success!";
    }
    throw new Error("Operation failed");
};

retryWithBackoff(unreliableOperation, 5, 1000)
    .then(result => console.log("Final result:", result))
    .catch(error => console.error("All attempts failed:", error.message));
```
{% endraw %}


### 2. **Async Pool (Concurrency Control)**

{% raw %}
```javascript
class AsyncPool {
    constructor(concurrency = 3) {
        this.concurrency = concurrency;
        this.running = 0;
        this.queue = [];
    }
    
    async add(task) {
        return new Promise((resolve, reject) => {
            this.queue.push({ task, resolve, reject });
            this.process();
        });
    }
    
    async process() {
        if (this.running >= this.concurrency || this.queue.length === 0) {
            return;
        }
        
        this.running++;
        const { task, resolve, reject } = this.queue.shift();
        
        try {
            const result = await task();
            resolve(result);
        } catch (error) {
            reject(error);
        } finally {
            this.running--;
            this.process(); // Process next item
        }
    }
    
    async waitForAll() {
        while (this.queue.length > 0 || this.running > 0) {
            await new Promise(resolve => setTimeout(resolve, 10));
        }
    }
}

// Usage
const pool = new AsyncPool(2);

const tasks = [
    () => new Promise(resolve => setTimeout(() => resolve("Task 1"), 1000)),
    () => new Promise(resolve => setTimeout(() => resolve("Task 2"), 500)),
    () => new Promise(resolve => setTimeout(() => resolve("Task 3"), 800)),
    () => new Promise(resolve => setTimeout(() => resolve("Task 4"), 300)),
    () => new Promise(resolve => setTimeout(() => resolve("Task 5"), 600))
];

// Add all tasks
const promises = tasks.map(task => pool.add(task));

// Wait for all to complete
await pool.waitForAll();
const results = await Promise.all(promises);
console.log("All tasks completed:", results);
```
{% endraw %}


---

## 💻 Detailed Examples

### Example 1: Building a Complete Async API Client
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== BUILDING A COMPLETE ASYNC API CLIENT ===");

class APIClient {
    constructor(baseURL, options = {}) {
        this.baseURL = baseURL;
        this.timeout = options.timeout || 5000;
        this.retries = options.retries || 3;
        this.retryDelay = options.retryDelay || 1000;
        this.headers = {
            'Content-Type': 'application/json',
            ...options.headers
        };
        
        // Request interceptor
        this.requestInterceptor = options.requestInterceptor || (config => config);
        this.responseInterceptor = options.responseInterceptor || (response => response);
    }
    
    async request(endpoint, options = {}) {
        const config = this.requestInterceptor({
            url: `${this.baseURL}${endpoint}`,
            timeout: this.timeout,
            headers: { ...this.headers, ...options.headers },
            ...options
        });
        
        return this.executeWithRetry(config);
    }
    
    async executeWithRetry(config, attempt = 1) {
        try {
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), config.timeout);
            
            const response = await fetch(config.url, {
                method: config.method || 'GET',
                headers: config.headers,
                body: config.body,
                signal: controller.signal
            });
            
            clearTimeout(timeoutId);
            
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            
            const data = await response.json();
            return this.responseInterceptor(data);
            
        } catch (error) {
            if (error.name === 'AbortError') {
                error.message = `Request timed out after ${config.timeout}ms`;
            }
            
            if (attempt < this.retries && this.isRetryableError(error)) {
                const delay = this.retryDelay * Math.pow(2, attempt - 1);
                console.log(`Attempt ${attempt} failed, retrying in ${delay}ms...`);
                
                await new Promise(resolve => setTimeout(resolve, delay));
                return this.executeWithRetry(config, attempt + 1);
            }
            
            throw error;
        }
    }
    
    isRetryableError(error) {
        // Retry on network errors, 5xx status codes, and timeouts
        return error.name === 'TypeError' || // Network error
               error.message.includes('timeout') ||
               (error.message.includes('HTTP 5'));
    }
    
    // Convenience methods
    async get(endpoint, options = {}) {
        return this.request(endpoint, { ...options, method: 'GET' });
    }
    
    async post(endpoint, data, options = {}) {
        return this.request(endpoint, {
            ...options,
            method: 'POST',
            body: JSON.stringify(data)
        });
    }
    
    async put(endpoint, data, options = {}) {
        return this.request(endpoint, {
            ...options,
            method: 'PUT',
            body: JSON.stringify(data)
        });
    }
    
    async delete(endpoint, options = {}) {
        return this.request(endpoint, { ...options, method: 'DELETE' });
    }
}

// Enhanced API client with caching and rate limiting
class EnhancedAPIClient extends APIClient {
    constructor(baseURL, options = {}) {
        super(baseURL, options);
        this.cache = new Map();
        this.cacheTTL = options.cacheTTL || 5 * 60 * 1000; // 5 minutes
        this.rateLimiter = new RateLimiter(options.rateLimit || { requests: 100, window: 60000 });
    }
    
    async get(endpoint, options = {}) {
        const cacheKey = `${endpoint}-${JSON.stringify(options)}`;
        
        // Check cache first
        if (options.useCache !== false && this.cache.has(cacheKey)) {
            const cached = this.cache.get(cacheKey);
            if (Date.now() - cached.timestamp < this.cacheTTL) {
                console.log('Returning cached response for:', endpoint);
                return cached.data;
            }
            this.cache.delete(cacheKey);
        }
        
        // Wait for rate limiter
        await this.rateLimiter.waitForSlot();
        
        // Make request
        const data = await super.get(endpoint, options);
        
        // Cache response
        if (options.useCache !== false) {
            this.cache.set(cacheKey, {
                data,
                timestamp: Date.now()
            });
        }
        
        return data;
    }
    
    clearCache(pattern = null) {
        if (pattern) {
            for (const key of this.cache.keys()) {
                if (key.includes(pattern)) {
                    this.cache.delete(key);
                }
            }
        } else {
            this.cache.clear();
        }
    }
}

// Rate limiter implementation
class RateLimiter {
    constructor({ requests, window }) {
        this.requests = requests;
        this.window = window;
        this.tokens = requests;
        this.lastRefill = Date.now();
    }
    
    async waitForSlot() {
        this.refillTokens();
        
        if (this.tokens > 0) {
            this.tokens--;
            return;
        }
        
        // Wait for next refill
        const waitTime = this.window - (Date.now() - this.lastRefill);
        if (waitTime > 0) {
            console.log(`Rate limited, waiting ${waitTime}ms...`);
            await new Promise(resolve => setTimeout(resolve, waitTime));
            this.refillTokens();
            this.tokens--;
        }
    }
    
    refillTokens() {
        const now = Date.now();
        const timePassed = now - this.lastRefill;
        const refillAmount = Math.floor(timePassed / this.window) * this.requests;
        
        if (refillAmount > 0) {
            this.tokens = Math.min(this.requests, this.tokens + refillAmount);
            this.lastRefill = now;
        }
    }
}

// Usage example
const apiClient = new EnhancedAPIClient('https://api.example.com', {
    timeout: 10000,
    retries: 3,
    cacheTTL: 10 * 60 * 1000, // 10 minutes
    rateLimit: { requests: 50, window: 60000 } // 50 requests per minute
});

// Add interceptors
apiClient.requestInterceptor = (config) => {
    console.log(`Making ${config.method} request to ${config.url}`);
    return config;
};

apiClient.responseInterceptor = (data) => {
    console.log('Response received:', data);
    return data;
};

// Use the client
async function main() {
    try {
        // These will be cached and rate-limited
        const users = await apiClient.get('/users');
        const posts = await apiClient.get('/posts');
        
        // Create new user
        const newUser = await apiClient.post('/users', {
            name: 'John Doe',
            email: 'john@example.com'
        });
        
        console.log('All operations completed successfully');
        
    } catch (error) {
        console.error('API operation failed:', error.message);
    }
}

main();
```
{% endraw %}


---

## ⚠️ Common Pitfalls

### Pitfall 1: Forgetting `await` Keyword

{% raw %}
```javascript
// ❌ WRONG: Missing await
async function fetchData() {
    const data = fetch('/api/data'); // Missing await!
    return data.json(); // Error: data is a Promise, not Response
}

// ✅ CORRECT: With await
async function fetchData() {
    const response = await fetch('/api/data');
    return response.json();
}
```
{% endraw %}


### Pitfall 2: Not Handling Promise Rejections

{% raw %}
```javascript
// ❌ WRONG: Unhandled promise rejection
async function riskyOperation() {
    const result = await someAsyncFunction();
    // If someAsyncFunction rejects, this will cause unhandled rejection
}

// ✅ CORRECT: Proper error handling
async function riskyOperation() {
    try {
        const result = await someAsyncFunction();
        return result;
    } catch (error) {
        console.error('Operation failed:', error);
        throw error; // Re-throw if you want caller to handle
    }
}
```
{% endraw %}


### Pitfall 3: Blocking the Event Loop

{% raw %}
```javascript
// ❌ WRONG: Blocking operation
async function blockingOperation() {
    const start = Date.now();
    while (Date.now() - start < 5000) {
        // This blocks the event loop for 5 seconds
    }
    return "Done";
}

// ✅ CORRECT: Non-blocking operation
async function nonBlockingOperation() {
    await new Promise(resolve => setTimeout(resolve, 5000));
    return "Done";
}
```
{% endraw %}


---

## 🎯 Best Practices

### ✅ Do's:
- **Use async/await** for cleaner, more readable code
- **Handle errors properly** with try-catch blocks
- **Use Promise.all()** for parallel operations when possible
- **Implement proper retry logic** for unreliable operations
- **Add timeouts** to prevent hanging requests
- **Use appropriate concurrency limits** to avoid overwhelming systems

### ❌ Don'ts:
- **Don't forget error handling** in async functions
- **Don't block the event loop** with long-running synchronous code
- **Don't create callback hell** - use promises or async/await
- **Don't ignore unhandled promise rejections**
- **Don't mix async patterns** unnecessarily

---

## 🔑 Key Points

- **Asynchronous programming** allows non-blocking operations
- **Callbacks** are fundamental but can lead to callback hell
- **Promises** provide better error handling and chaining
- **Async/await** makes async code look synchronous
- **Event Loop** manages task execution order
- **Microtasks** have higher priority than macrotasks
- **Error handling** is crucial for robust async applications
- **Use appropriate patterns** for different use cases

---

## ❓ Common Interview Questions

<div class="interview-question">
    <h4>Q1: What is the difference between synchronous and asynchronous code?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> Synchronous code executes line by line, blocking execution until each operation completes. Asynchronous code allows operations to run in the background while other code continues to execute. Async operations use callbacks, promises, or async/await to handle completion, making applications more responsive and efficient.</p>
    </div>
</div>

<div class="interview-question">
    <h4>Q2: How does the Event Loop work in JavaScript?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> The Event Loop continuously checks if the call stack is empty. When empty, it processes tasks from the microtask queue first (promises, queueMicrotask), then from the macrotask queue (setTimeout, DOM events, fetch callbacks). This ensures JavaScript remains non-blocking while maintaining proper execution order.</p>
    </div>
</div>

<div class="interview-question">
    <h4>Q3: What's the difference between Promise.all() and Promise.allSettled()?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> Promise.all() waits for all promises to resolve and rejects immediately if any promise rejects. Promise.allSettled() waits for all promises to complete (resolve or reject) and returns an array of results with status and value/reason for each promise, regardless of success or failure.</p>
    </div>
</div>

<div class="interview-question">
    <h4>Q4: How do you handle errors in async/await functions?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> Use try-catch blocks around await expressions, handle specific errors with conditional logic, or use Promise.catch() with await. Always handle errors appropriately to prevent unhandled promise rejections and provide fallback behavior when operations fail.</p>
    </div>
</div>

<div class="interview-question">
    <h4>Q5: What are microtasks and macrotasks?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> Microtasks (promises, queueMicrotask) have higher priority and execute before the next render. Macrotasks (setTimeout, setInterval, DOM events) have lower priority and execute after microtasks. The Event Loop processes all microtasks before moving to macrotasks, ensuring proper execution order.</p>
    </div>
</div>

---

## 🏋️ Practice Exercises

<div class="practice-exercise">
    <h4>Exercise 1: Implement a Promise-based Retry Mechanism</h4>
    <p>Create a function that retries a promise-based operation with configurable attempts, delays, and backoff strategies.</p>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <div style="position: relative;">
            <button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
            <pre><code>function retry(operation, options = {}) {
    const {
        maxAttempts = 3,
        baseDelay = 1000,
        maxDelay = 10000,
        backoff = 'exponential',
        shouldRetry = () => true
    } = options;
    
    return new Promise((resolve, reject) => {
        let attempts = 0;
        
        function attempt() {
            attempts++;
            
            operation()
                .then(resolve)
                .catch(error => {
                    if (attempts >= maxAttempts || !shouldRetry(error)) {
                        reject(new Error(`Failed after ${attempts} attempts: ${error.message}`));
                        return;
                    }
                    
                    const delay = calculateDelay(attempts, baseDelay, maxDelay, backoff);
                    console.log(`Attempt ${attempts} failed, retrying in ${delay}ms...`);
                    
                    setTimeout(attempt, delay);
                });
        }
        
        attempt();
    });
}

function calculateDelay(attempt, baseDelay, maxDelay, backoff) {
    let delay;
    
    switch (backoff) {
        case 'linear':
            delay = baseDelay * attempt;
            break;
        case 'exponential':
            delay = baseDelay * Math.pow(2, attempt - 1);
            break;
        case 'fibonacci':
            delay = baseDelay * getFibonacci(attempt);
            break;
        default:
            delay = baseDelay;
    }
    
    return Math.min(delay, maxDelay);
}

function getFibonacci(n) {
    if (n <= 1) return 1;
    return getFibonacci(n - 1) + getFibonacci(n - 2);
}

// Usage examples
const unreliableOperation = () => {
    return new Promise((resolve, reject) => {
        const random = Math.random();
        if (random > 0.7) {
            resolve("Operation succeeded!");
        } else {
            reject(new Error("Operation failed"));
        }
    });
};

// Test different retry strategies
retry(unreliableOperation, {
    maxAttempts: 5,
    baseDelay: 500,
    backoff: 'exponential'
})
.then(result => console.log("Success:", result))
.catch(error => console.error("Failed:", error.message));

// Custom retry condition
retry(unreliableOperation, {
    maxAttempts: 10,
    baseDelay: 200,
    backoff: 'linear',
    shouldRetry: (error) => !error.message.includes('fatal')
})
.then(result => console.log("Success:", result))
.catch(error => console.error("Failed:", error.message));</code></pre>
        </div>
    </div>
</div>

<div class="practice-exercise">
    <h4>Exercise 2: Create an Async Queue with Priority</h4>
    <p>Implement a queue system that processes async tasks with different priority levels and concurrency control.</p>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <div style="position: relative;">
            <button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
            <pre><code>class PriorityAsyncQueue {
    constructor(concurrency = 3) {
        this.concurrency = concurrency;
        this.running = 0;
        this.queues = {
            high: [],
            normal: [],
            low: []
        };
        this.processing = false;
    }
    
    add(task, priority = 'normal') {
        return new Promise((resolve, reject) => {
            const queueItem = { task, resolve, reject, priority, timestamp: Date.now() };
            
            if (!this.queues[priority]) {
                priority = 'normal'; // Default to normal if invalid priority
            }
            
            this.queues[priority].push(queueItem);
            this.process();
        });
    }
    
    async process() {
        if (this.processing || this.running >= this.concurrency) {
            return;
        }
        
        this.processing = true;
        
        while (this.running < this.concurrency && this.hasTasks()) {
            const task = this.getNextTask();
            if (task) {
                this.running++;
                this.executeTask(task);
            }
        }
        
        this.processing = false;
    }
    
    hasTasks() {
        return this.queues.high.length > 0 || 
               this.queues.normal.length > 0 || 
               this.queues.low.length > 0;
    }
    
    getNextTask() {
        // Priority order: high > normal > low
        if (this.queues.high.length > 0) {
            return this.queues.high.shift();
        }
        if (this.queues.normal.length > 0) {
            return this.queues.normal.shift();
        }
        if (this.queues.low.length > 0) {
            return this.queues.low.shift();
        }
        return null;
    }
    
    async executeTask(queueItem) {
        try {
            const result = await queueItem.task();
            queueItem.resolve(result);
        } catch (error) {
            queueItem.reject(error);
        } finally {
            this.running--;
            this.process(); // Process next task
        }
    }
    
    getStats() {
        return {
            running: this.running,
            queued: {
                high: this.queues.high.length,
                normal: this.queues.normal.length,
                low: this.queues.low.length
            },
            total: this.queues.high.length + this.queues.normal.length + this.queues.low.length
        };
    }
    
    clear() {
        this.queues.high = [];
        this.queues.normal = [];
        this.queues.low = [];
    }
}

// Usage example
const queue = new PriorityAsyncQueue(2);

// Add tasks with different priorities
const tasks = [
    { task: () => new Promise(resolve => setTimeout(() => resolve("High priority"), 100)), priority: 'high' },
    { task: () => new Promise(resolve => setTimeout(() => resolve("Normal priority"), 200)), priority: 'normal' },
    { task: () => new Promise(resolve => setTimeout(() => resolve("Low priority"), 300)), priority: 'low' },
    { task: () => new Promise(resolve => setTimeout(() => resolve("Another high"), 150)), priority: 'high' },
    { task: () => new Promise(resolve => setTimeout(() => resolve("Another normal"), 250)), priority: 'normal' }
];

// Add all tasks
const promises = tasks.map(({ task, priority }) => 
    queue.add(task, priority)
);

// Monitor progress
const interval = setInterval(() => {
    const stats = queue.getStats();
    console.log('Queue stats:', stats);
    
    if (stats.total === 0 && stats.running === 0) {
        clearInterval(interval);
        console.log('All tasks completed');
    }
}, 100);

// Wait for all tasks
Promise.all(promises)
    .then(results => {
        console.log('All results:', results);
    })
    .catch(error => {
        console.error('Task failed:', error);
    });</code></pre>
        </div>
    </div>
</div>

<div class="practice-exercise">
    <h4>Exercise 3: Build a Promise-based Event Emitter</h4>
    <p>Create an event emitter that supports both synchronous and asynchronous event handlers with proper error handling.</p>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <div style="position: relative;">
            <button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
            <pre><code>class AsyncEventEmitter {
    constructor() {
        this.events = new Map();
        this.onceEvents = new Map();
    }
    
    on(event, handler) {
        if (!this.events.has(event)) {
            this.events.set(event, []);
        }
        this.events.get(event).push(handler);
        return this; // For chaining
    }
    
    once(event, handler) {
        if (!this.onceEvents.has(event)) {
            this.onceEvents.set(event, []);
        }
        this.onceEvents.get(event).push(handler);
        return this;
    }
    
    off(event, handler) {
        if (this.events.has(event)) {
            const handlers = this.events.get(event);
            const index = handlers.indexOf(handler);
            if (index > -1) {
                handlers.splice(index, 1);
            }
        }
        
        if (this.onceEvents.has(event)) {
            const handlers = this.onceEvents.get(event);
            const index = handlers.indexOf(handler);
            if (index > -1) {
                handlers.splice(index, 1);
            }
        }
        
        return this;
    }
    
    async emit(event, ...args) {
        const results = [];
        const errors = [];
        
        // Execute regular event handlers
        if (this.events.has(event)) {
            const handlers = this.events.get(event);
            for (const handler of handlers) {
                try {
                    const result = await this.executeHandler(handler, args);
                    results.push(result);
                } catch (error) {
                    errors.push(error);
                }
            }
        }
        
        // Execute once event handlers and remove them
        if (this.onceEvents.has(event)) {
            const handlers = this.onceEvents.get(event);
            for (const handler of handlers) {
                try {
                    const result = await this.executeHandler(handler, args);
                    results.push(result);
                } catch (error) {
                    errors.push(error);
                }
            }
            this.onceEvents.delete(event);
        }
        
        // Throw error if any handlers failed
        if (errors.length > 0) {
            throw new Error(`Event ${event} had ${errors.length} handler errors: ${errors.map(e => e.message).join(', ')}`);
        }
        
        return results;
    }
    
    async executeHandler(handler, args) {
        if (typeof handler === 'function') {
            const result = handler(...args);
            if (result instanceof Promise) {
                return await result;
            }
            return result;
        }
        return undefined;
    }
    
    // Utility methods
    async emitAsync(event, ...args) {
        try {
            return await this.emit(event, ...args);
        } catch (error) {
            console.error(`Error emitting event ${event}:`, error);
            return [];
        }
    }
    
    emitSync(event, ...args) {
        const results = [];
        
        // Execute regular handlers synchronously
        if (this.events.has(event)) {
            const handlers = this.events.get(event);
            for (const handler of handlers) {
                try {
                    const result = handler(...args);
                    results.push(result);
                } catch (error) {
                    console.error(`Handler error for event ${event}:`, error);
                }
            }
        }
        
        // Execute once handlers
        if (this.onceEvents.has(event)) {
            const handlers = this.onceEvents.get(event);
            for (const handler of handlers) {
                try {
                    const result = handler(...args);
                    results.push(result);
                } catch (error) {
                    console.error(`Once handler error for event ${event}:`, error);
                }
            }
            this.onceEvents.delete(event);
        }
        
        return results;
    }
    
    // Event counting and monitoring
    listenerCount(event) {
        const regularCount = this.events.has(event) ? this.events.get(event).length : 0;
        const onceCount = this.onceEvents.has(event) ? this.onceEvents.get(event).length : 0;
        return regularCount + onceCount;
    }
    
    eventNames() {
        const regularEvents = Array.from(this.events.keys());
        const onceEvents = Array.from(this.onceEvents.keys());
        return [...new Set([...regularEvents, ...onceEvents])];
    }
    
    removeAllListeners(event) {
        if (event) {
            this.events.delete(event);
            this.onceEvents.delete(event);
        } else {
            this.events.clear();
            this.onceEvents.clear();
        }
        return this;
    }
}

// Usage example
const emitter = new AsyncEventEmitter();

// Add async event handlers
emitter.on('userCreated', async (user) => {
    await new Promise(resolve => setTimeout(resolve, 100));
    console.log('Async handler: User created:', user.name);
    return `Processed ${user.name}`;
});

emitter.on('userCreated', (user) => {
    console.log('Sync handler: User created:', user.name);
    return `Synced ${user.name}`;
});

emitter.once('userCreated', async (user) => {
    await new Promise(resolve => setTimeout(resolve, 50));
    console.log('Once handler: Welcome email sent to:', user.email);
    return `Email sent to ${user.email}`;
});

// Emit events
async function main() {
    try {
        // Emit async (waits for all handlers)
        const results = await emitter.emit('userCreated', {
            name: 'John Doe',
            email: 'john@example.com'
        });
        console.log('Async emit results:', results);
        
        // Emit sync (doesn't wait)
        const syncResults = emitter.emitSync('userCreated', {
            name: 'Jane Smith',
            email: 'jane@example.com'
        });
        console.log('Sync emit results:', syncResults);
        
        // Check listener count
        console.log('Listener count for userCreated:', emitter.listenerCount('userCreated'));
        
    } catch (error) {
        console.error('Event emission failed:', error.message);
    }
}

main();</code></pre>
        </div>
    </div>
</div>

---

## 📚 Additional Resources

- [MDN: Using Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises)
- [MDN: async function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)
- [JavaScript.info: Promises, async/await](https://javascript.info/async)
- [Node.js: Event Loop](https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick/)
- [You Don't Know JS: Async & Performance](https://github.com/getify/You-Dont-Know-JS/blob/2nd-ed/async-performance/README.md)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>



---

## 🧭 Navigation

<div class="navigation">
    <a href="02-Object-Oriented-JavaScript.md" class="nav-link prev">← Previous: Object-Oriented JavaScript</a>
    <a href="04-Modules.md" class="nav-link next">Next: Modules →</a>
</div>

*Last updated: December 2024*
