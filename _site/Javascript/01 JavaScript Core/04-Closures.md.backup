# 🔹 Closures

*Understanding Functions That Remember Their Scope*

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents
- [What are Closures?](#what-are-closures)
- [How Closures Work](#how-closures-work)
- [Closure Visualization](#closure-visualization)
- [Use Cases](#use-cases)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points for Interviews](#key-points-for-interviews)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 What are Closures?

A closure is a function that has access to variables in its outer (enclosing) scope even after the outer function has returned. In other words, a closure "remembers" the environment in which it was created, including all the variables that were in scope at that time.

### 🔍 Simple Analogy
Think of a closure like a backpack:
- **Function** = The backpack
- **Outer variables** = Items you put in the backpack
- **Memory** = The backpack remembers what's inside even when you're far from home
- **Access** = You can always reach into the backpack to get those items

---

## ⚙️ How Closures Work

### 🔑 Core Mechanism
1. **Function Creation**: A function is defined inside another function
2. **Variable Capture**: The inner function captures (remembers) variables from outer scope
3. **Scope Retention**: Even after outer function returns, inner function retains access
4. **Memory Persistence**: Variables stay in memory as long as closure exists

### 🔄 Lifecycle

```
┌─────────────────────────────────────────────────────────────┐
│                    CLOSURE LIFECYCLE                        │
├─────────────────────────────────────────────────────────────┤
│  1. 🟢 Outer function executes                            │
│  2. 🟡 Inner function is created                          │
│  3. 🔴 Outer function returns                             │
│  4. 🟢 Inner function still has access to outer variables │
│  5. 🟡 Variables persist in memory                        │
│  6. 🔴 Closure can be called multiple times               │
└─────────────────────────────────────────────────────────────┘
```


---

## 🗂️ Closure Visualization


```
┌─────────────────────────────────────────────────────────────┐
│                    CLOSURE STRUCTURE                        │
├─────────────────────────────────────────────────────────────┤
│  🌍 Global Scope                                           │
│  ├─ globalVar                                              │
│  └─ outerFunction()                                        │
│                                                             │
│  🏠 Outer Function Scope                                   │
│  ├─ outerVar                                               │
│  ├─ outerConst                                             │
│  └─ innerFunction() ← CLOSURE                              │
│      ├─ innerVar                                           │
│      ├─ Access to: outerVar, outerConst, globalVar        │
│      └─ Remembers outer scope even after outer returns     │
│                                                             │
│  🔗 Closure Chain: innerFunction → outerFunction → Global │
│  💾 Memory: outerVar and outerConst persist               │
└─────────────────────────────────────────────────────────────┘
```


### 🔍 Memory Management


```
┌─────────────────────────────────────────────────────────────┐
│                CLOSURE MEMORY MANAGEMENT                    │
├─────────────────────────────────────────────────────────────┤
│  🟢 Variables in closure scope                            │
│  ├─ Stay in memory as long as closure exists              │
│  ├─ Cannot be garbage collected                           │
│  └─ Can lead to memory leaks if not managed               │
│                                                             │
│  🟡 Variables outside closure scope                       │
│  ├─ Can be garbage collected normally                     │
│  ├─ Don't interfere with closure memory                   │
│  └─ Closure only affects what it references               │
└─────────────────────────────────────────────────────────────┘
```


---

## 💡 Use Cases

### 1. **Data Privacy**
- Encapsulate private variables
- Prevent external access to internal state
- Create private methods

### 2. **Function Factories**
- Create functions with preset parameters
- Generate specialized functions
- Configuration-based function creation

### 3. **Module Pattern**
- Organize code into modules
- Hide implementation details
- Provide clean public interface

### 4. **Event Handlers**
- Maintain state across events
- Access component data in callbacks
- Preserve context in asynchronous operations

### 5. **Memoization**
- Cache expensive calculations
- Store results for reuse
- Optimize performance

---

## 💻 Detailed Examples

### Example 1: Basic Closure
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== BASIC CLOSURE ===");

function outerFunction(outerParam) {
    // 🏠 Outer function scope
    let outerVar = "I'm from outer function";
    const outerConst = outerParam;
    
    function innerFunction(innerParam) {
        // 🏠 Inner function (closure)
        let innerVar = "I'm from inner function";
        
        console.log("=== Inner Function Access ===");
        console.log("innerVar:", innerVar);           // ✅ Own scope
        console.log("innerParam:", innerParam);       // ✅ Parameter
        console.log("outerVar:", outerVar);           // ✅ Outer scope (closure!)
        console.log("outerConst:", outerConst);       // ✅ Outer scope (closure!)
        console.log("outerParam:", outerParam);       // ✅ Outer parameter (closure!)
        
        return `Inner: ${innerVar}, Outer: ${outerVar}, Const: ${outerConst}`;
    }
    
    // Return the inner function (closure)
    return innerFunction;
}

// Create closure
const closure = outerFunction("passed parameter");

// Call closure (outer function has already returned!)
console.log("=== Calling Closure ===");
const result = closure("inner parameter");
console.log("Closure result:", result);

// Closure still has access to outer variables
console.log("=== Closure Memory ===");
console.log("Closure remembers outer variables even after outer function returned");
```

</div>

### Example 2: Data Privacy with Closures

```javascript
console.log("=== DATA PRIVACY WITH CLOSURES ===");

function createCounter(initialValue = 0) {
    // 🏠 Private variables (not accessible from outside)
    let count = initialValue;
    let secretKey = "super-secret-123";
    
    // 🏠 Private helper function
    function validateIncrement(value) {
        return value > 0 && value <= 100;
    }
    
    // 🏠 Return public interface
    return {
        increment: function(value = 1) {
            if (validateIncrement(value)) {
                count += value;
                return count;
            } else {
                throw new Error("Invalid increment value");
            }
        },
        
        decrement: function(value = 1) {
            count -= value;
            return count;
        },
        
        getValue: function() {
            return count;
        },
        
        reset: function() {
            count = initialValue;
        },
        
        // 🚫 Cannot access private variables
        // getSecretKey: function() { return secretKey; } // Would expose private data
    };
}

// Create counter instance
const counter = createCounter(10);

console.log("=== Using Counter ===");
console.log("Initial value:", counter.getValue());     // 10
console.log("After increment:", counter.increment(5)); // 15
console.log("After decrement:", counter.decrement(3)); // 12

// Try to access private variables
console.log("=== Privacy Test ===");
console.log("counter.count:", counter.count);         // undefined
console.log("counter.secretKey:", counter.secretKey); // undefined
console.log("counter.validateIncrement:", counter.validateIncrement); // undefined

// Private variables are truly private!
console.log("Private variables are completely hidden from outside access");
```


### Example 3: Function Factory with Closures

```javascript
console.log("=== FUNCTION FACTORY WITH CLOSURES ===");

function createGreeter(greeting) {
    // 🏠 Closure captures the greeting parameter
    return function(name) {
        return `${greeting}, ${name}!`;
    };
}

// Create specialized greeters
const sayHello = createGreeter("Hello");
const sayGoodbye = createGreeter("Goodbye");
const sayGoodMorning = createGreeter("Good morning");

console.log("=== Using Greeter Functions ===");
console.log(sayHello("John"));        // "Hello, John!"
console.log(sayGoodbye("Jane"));      // "Goodbye, Jane!"
console.log(sayGoodMorning("Bob"));   // "Good morning, Bob!"

// Each closure remembers its own greeting
console.log("=== Closure Memory ===");
console.log("sayHello closure remembers: 'Hello'");
console.log("sayGoodbye closure remembers: 'Goodbye'");
console.log("sayGoodMorning closure remembers: 'Good morning'");

// More complex factory
function createCalculator(operation) {
    return function(a, b) {
        switch (operation) {
            case 'add':
                return a + b;
            case 'subtract':
                return a - b;
            case 'multiply':
                return a * b;
            case 'divide':
                return b !== 0 ? a / b : 'Error: Division by zero';
            default:
                return 'Error: Unknown operation';
        }
    };
}

const add = createCalculator('add');
const multiply = createCalculator('multiply');
const divide = createCalculator('divide');

console.log("=== Calculator Functions ===");
console.log("add(5, 3):", add(5, 3));           // 8
console.log("multiply(4, 6):", multiply(4, 6)); // 24
console.log("divide(10, 2):", divide(10, 2));   // 5
```


### Example 4: Module Pattern with Closures

```javascript
console.log("=== MODULE PATTERN WITH CLOSURES ===");

const userModule = (function() {
    // 🏠 Private variables and functions
    let users = [];
    let nextId = 1;
    
    function generateId() {
        return nextId++;
    }
    
    function validateUser(user) {
        return user.name && user.email && user.age >= 0;
    }
    
    function findUserById(id) {
        return users.find(user => user.id === id);
    }
    
    // 🏠 Return public interface
    return {
        addUser: function(name, email, age) {
            if (!name || !email || age < 0) {
                throw new Error("Invalid user data");
            }
            
            const user = {
                id: generateId(),
                name,
                email,
                age,
                createdAt: new Date()
            };
            
            users.push(user);
            return user;
        },
        
        getUser: function(id) {
            const user = findUserById(id);
            if (!user) {
                throw new Error("User not found");
            }
            return { ...user }; // Return copy, not reference
        },
        
        getAllUsers: function() {
            return users.map(user => ({ ...user })); // Return copies
        },
        
        updateUser: function(id, updates) {
            const user = findUserById(id);
            if (!user) {
                throw new Error("User not found");
            }
            
            if (updates.name) user.name = updates.name;
            if (updates.email) user.email = updates.email;
            if (updates.age !== undefined) user.age = updates.age;
            
            return { ...user };
        },
        
        deleteUser: function(id) {
            const index = users.findIndex(user => user.id === id);
            if (index === -1) {
                throw new Error("User not found");
            }
            
            const deletedUser = users.splice(index, 1)[0];
            return { ...deletedUser };
        },
        
        getUserCount: function() {
            return users.length;
        }
    };
})();

console.log("=== Using User Module ===");

// Add users
const user1 = userModule.addUser("John Doe", "john@example.com", 30);
const user2 = userModule.addUser("Jane Smith", "jane@example.com", 25);

console.log("Added users:", user1, user2);
console.log("User count:", userModule.getUserCount());

// Get user
const retrievedUser = userModule.getUser(user1.id);
console.log("Retrieved user:", retrievedUser);

// Update user
const updatedUser = userModule.updateUser(user1.id, { age: 31 });
console.log("Updated user:", updatedUser);

// Private variables are not accessible
console.log("=== Privacy Test ===");
console.log("users:", userModule.users);           // undefined
console.log("nextId:", userModule.nextId);         // undefined
console.log("generateId:", userModule.generateId); // undefined
```


### Example 5: Event Handlers and Closures

```javascript
console.log("=== EVENT HANDLERS AND CLOSURES ===");

// Simulating DOM elements
const button1 = { id: "btn1", text: "Button 1" };
const button2 = { id: "btn2", text: "Button 2" };

// Function to create event handlers with closures
function createButtonHandler(buttonId, buttonText) {
    // 🏠 Closure captures buttonId and buttonText
    let clickCount = 0;
    
    return function(event) {
        clickCount++;
        console.log(`=== Button Click Event ===`);
        console.log(`Button ID: ${buttonId}`);
        console.log(`Button Text: ${buttonText}`);
        console.log(`Click Count: ${clickCount}`);
        console.log(`Event Type: ${event.type}`);
        
        // Closure remembers clickCount between calls
        if (clickCount === 1) {
            console.log("First click!");
        } else if (clickCount === 5) {
            console.log("5th click! Special message!");
        }
    };
}

// Create handlers for different buttons
const handler1 = createButtonHandler("btn1", "Button 1");
const handler2 = createButtonHandler("btn2", "Button 2");

console.log("=== Simulating Button Clicks ===");

// Simulate clicks on button 1
console.log("Clicking Button 1:");
handler1({ type: "click" });
handler1({ type: "click" });
handler1({ type: "click" });

// Simulate clicks on button 2
console.log("Clicking Button 2:");
handler2({ type: "click" });
handler2({ type: "click" });

// Each handler maintains its own clickCount
console.log("=== Closure Independence ===");
console.log("Each button handler has its own click count");
console.log("Handler 1 and Handler 2 are completely independent");
```


### Example 6: Memoization with Closures

```javascript
console.log("=== MEMOIZATION WITH CLOSURES ===");

function createMemoizedFunction(fn) {
    // 🏠 Private cache object
    const cache = new Map();
    
    return function(...args) {
        // Create cache key from arguments
        const key = JSON.stringify(args);
        
        // Check if result is already cached
        if (cache.has(key)) {
            console.log("Cache hit for:", key);
            return cache.get(key);
        }
        
        // Calculate result and cache it
        console.log("Cache miss for:", key);
        const result = fn.apply(this, args);
        cache.set(key, result);
        
        return result;
    };
}

// Expensive calculation function
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// Create memoized version
const memoizedFibonacci = createMemoizedFunction(fibonacci);

console.log("=== Testing Memoization ===");

// First call (cache miss)
console.time("First call");
const result1 = memoizedFibonacci(10);
console.timeEnd("First call");
console.log("Result 1:", result1);

// Second call with same input (cache hit)
console.time("Second call");
const result2 = memoizedFibonacci(10);
console.timeEnd("Second call");
console.log("Result 2:", result2);

// Different input (cache miss)
console.time("Different input");
const result3 = memoizedFibonacci(5);
console.timeEnd("Different input");
console.log("Result 3:", result3);

// Same input again (cache hit)
console.time("Same input again");
const result4 = memoizedFibonacci(5);
console.timeEnd("Same input again");
console.log("Result 4:", result4);

console.log("=== Memoization Benefits ===");
console.log("1. Expensive calculations are cached");
console.log("2. Subsequent calls with same input are fast");
console.log("3. Cache persists between function calls");
console.log("4. Memory usage increases with cache size");
```


---

## ⚠️ Common Pitfalls

### Pitfall 1: Creating Closures in Loops

```javascript
console.log("=== PITFALL 1: CLOSURES IN LOOPS ===");

// ❌ Problem: All closures reference the same variable
function createProblematicHandlers() {
    const handlers = [];
    
    for (var i = 0; i < 3; i++) {
        handlers.push(function() {
            console.log("Button", i, "clicked"); // All print "Button 3 clicked"
        });
    }
    
    return handlers;
}

const problematicHandlers = createProblematicHandlers();
console.log("=== Problematic Handlers ===");
problematicHandlers.forEach((handler, index) => {
    console.log(`Handler ${index}:`);
    handler();
});

// ✅ Solution 1: Use let (block scope)
function createFixedHandlers1() {
    const handlers = [];
    
    for (let i = 0; i < 3; i++) {
        handlers.push(function() {
            console.log("Button", i, "clicked"); // Each prints different value
        });
    }
    
    return handlers;
}

const fixedHandlers1 = createFixedHandlers1();
console.log("=== Fixed Handlers (let) ===");
fixedHandlers1.forEach((handler, index) => {
    console.log(`Handler ${index}:`);
    handler();
});

// ✅ Solution 2: IIFE (Immediately Invoked Function Expression)
function createFixedHandlers2() {
    const handlers = [];
    
    for (var i = 0; i < 3; i++) {
        handlers.push((function(index) {
            return function() {
                console.log("Button", index, "clicked");
            };
        })(i));
    }
    
    return handlers;
}

const fixedHandlers2 = createFixedHandlers2();
console.log("=== Fixed Handlers (IIFE) ===");
fixedHandlers2.forEach((handler, index) => {
    console.log(`Handler ${index}:`);
    handler();
});
```


### Pitfall 2: Memory Leaks

```javascript
console.log("=== PITFALL 2: MEMORY LEAKS ===");

// ❌ Problem: Closure holds reference to large object
function createMemoryLeak() {
    const largeData = new Array(1000000).fill("data");
    
    return function() {
        console.log("Large data length:", largeData.length);
        // largeData stays in memory even if we don't need it
    };
}

const leakyClosure = createMemoryLeak();

// ✅ Solution: Only capture what you need
function createMemoryEfficient() {
    const largeData = new Array(1000000).fill("data");
    
    return function() {
        // Only capture the length, not the entire array
        const length = largeData.length;
        console.log("Data length:", length);
        // largeData can be garbage collected
    };
}

const efficientClosure = createMemoryEfficient();
```


---

## ✅ Best Practices

### 1. Only Capture What You Need

```javascript
console.log("=== BEST PRACTICE 1: CAPTURE ONLY WHAT YOU NEED ===");

// ❌ Don't capture large objects unnecessarily
function badPractice() {
    const hugeObject = { /* lots of data */ };
    
    return function() {
        // Only need one property
        return hugeObject.someProperty;
    };
}

// ✅ Only capture what you actually use
function goodPractice() {
    const hugeObject = { /* lots of data */ };
    const neededProperty = hugeObject.someProperty;
    
    return function() {
        return neededProperty;
    };
}
```


### 2. Use Closures for Data Privacy

```javascript
console.log("=== BEST PRACTICE 2: USE CLOSURES FOR PRIVACY ===");

// ✅ Module pattern for data privacy
const privateModule = (function() {
    let privateData = "secret";
    
    return {
        getData: function() {
            return privateData;
        },
        setData: function(newData) {
            privateData = newData;
        }
    };
})();

// Private data is truly private
console.log("Public access:", privateModule.getData());
// console.log("Private access:", privateModule.privateData); // undefined
```


### 3. Be Mindful of Memory

```javascript
console.log("=== BEST PRACTICE 3: BE MINDFUL OF MEMORY ===");

// ✅ Clear references when done
function createTemporaryClosure() {
    const data = "temporary data";
    
    const closure = function() {
        console.log(data);
    };
    
    // Clear reference when done
    return {
        use: closure,
        cleanup: function() {
            // Clear the closure reference
            closure = null;
        }
    };
}
```


---

## 🎯 Key Points for Interviews

### 🔑 Core Concepts
1. **Closure Definition**: Function that remembers its outer scope
2. **Scope Retention**: Variables persist even after outer function returns
3. **Memory Management**: Closures can prevent garbage collection
4. **Data Privacy**: Excellent for encapsulation and hiding implementation
5. **Function Factory**: Create specialized functions with preset parameters

### 🚨 Common Mistakes
1. **Creating closures in loops with var**
2. **Memory leaks from capturing large objects**
3. **Not understanding closure scope chain**
4. **Forgetting that closures persist in memory**

### 💡 Advanced Concepts
1. **Module Pattern**: Using closures for module organization
2. **Currying**: Partial function application with closures
3. **Memoization**: Caching with closures
4. **Event Handling**: Maintaining state across events

---

## ❓ Common Interview Questions

### Q: What is a closure in JavaScript?
**A:** A closure is a function that has access to variables in its outer (enclosing) scope even after the outer function has returned. The inner function "remembers" the environment in which it was created.

**Key Points:**
- Function defined inside another function
- Captures variables from outer scope
- Variables persist in memory
- Can access outer variables even after outer function returns

### Q: How do closures work?
**A:** Closures work through JavaScript's scope chain mechanism:

**Process:**
1. Inner function is created inside outer function
2. Inner function captures variables from outer scope
3. Outer function returns inner function
4. Inner function retains access to captured variables
5. Variables stay in memory as long as closure exists

**Example:**

```javascript
function outer() {
    let x = 10;
    
    function inner() {
        return x; // Captures x from outer scope
    }
    
    return inner;
}

const closure = outer();
console.log(closure()); // 10 (x is still accessible)
```


### Q: What are the main use cases for closures?
**A:** Closures are used for:

**1. Data Privacy:**
- Encapsulate private variables
- Hide implementation details
- Create private methods

**2. Function Factories:**
- Generate specialized functions
- Preset parameters
- Configuration-based functions

**3. Module Pattern:**
- Organize code into modules
- Provide clean public interface
- Maintain private state

**4. Event Handlers:**
- Maintain state across events
- Access component data
- Preserve context

### Q: How can closures cause memory leaks?
**A:** Closures can cause memory leaks by:

**Mechanism:**
- Variables captured by closure stay in memory
- Cannot be garbage collected while closure exists
- Large objects captured unnecessarily consume memory

**Examples:**

```javascript
// ❌ Memory leak: capturing large object
function leaky() {
    const hugeData = new Array(1000000).fill("data");
    
    return function() {
        console.log(hugeData.length); // Captures entire array
    };
}

// ✅ Efficient: only capture what you need
function efficient() {
    const hugeData = new Array(1000000).fill("data");
    const length = hugeData.length;
    
    return function() {
        console.log(length); // Only captures number
    };
}
```


### Q: How do you fix the closure-in-loop problem?
**A:** The closure-in-loop problem occurs when all closures reference the same variable. Here are solutions:

**Problem:**

```javascript
for (var i = 0; i < 3; i++) {
    setTimeout(() => console.log(i), 100); // All print 3
}
```


**Solutions:**

**1. Use let (block scope):**

```javascript
for (let i = 0; i < 3; i++) {
    setTimeout(() => console.log(i), 100); // 0, 1, 2
}
```


**2. IIFE (Immediately Invoked Function Expression):**

```javascript
for (var i = 0; i < 3; i++) {
    (function(index) {
        setTimeout(() => console.log(index), 100);
    })(i);
}
```


**3. bind() method:**

```javascript
for (var i = 0; i < 3; i++) {
    setTimeout(function(index) {
        console.log(index);
    }.bind(null, i), 100);
}
```


---

## 🧪 Practice Exercises

### Exercise 1: Basic Closure Understanding

```javascript
console.log("Exercise 1: Predict the output");

function createCounter() {
    let count = 0;
    
    return function() {
        count++;
        return count;
    };
}

const counter1 = createCounter();
const counter2 = createCounter();

console.log(counter1()); // What will this print?
console.log(counter1()); // What will this print?
console.log(counter2()); // What will this print?
console.log(counter1()); // What will this print?
```


### Exercise 2: Closure in Loop Fix

```javascript
console.log("Exercise 2: Fix the closure in loop");

// Fix this code so each button prints its correct index
function createButtons() {
    const buttons = [];
    
    for (var i = 0; i < 3; i++) {
        buttons.push(function() {
            console.log("Button", i, "clicked");
        });
    }
    
    return buttons;
}

// Your fix here...
```


### Exercise 3: Module Pattern Implementation

```javascript
console.log("Exercise 3: Implement a module pattern");

// Create a bank account module with private balance
// Public methods: deposit, withdraw, getBalance
// Private variables: balance, transactionHistory

// Your implementation here...
```


---

## 📚 Additional Resources

- **MDN Web Docs**: [Closures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures)
- **JavaScript.info**: [Variable Scope and Closure](https://javascript.info/closure)
- **ECMAScript Specification**: [Lexical Environments](https://tc39.es/ecma262/#sec-lexical-environments)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Scope-Lexical-Scope.md" class="nav-link prev">⬅️ Previous: Scope & Lexical Scope</a>
    <a href="./05-Temporal-Dead-Zone.md" class="nav-link next">Next: Temporal Dead Zone (TDZ) ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

*Last updated: December 2024*
