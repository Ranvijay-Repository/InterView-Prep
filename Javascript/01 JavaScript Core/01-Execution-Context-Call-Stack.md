# 🔹 Execution Context & Call Stack

*Understanding How JavaScript Code Runs*

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents
- [What is Execution Context?](#what-is-execution-context)
- [Types of Execution Contexts](#types-of-execution-contexts)
- [Execution Context Phases](#execution-context-phases)
- [Call Stack Visualization](#call-stack-visualization)
- [Detailed Examples](#detailed-examples)
- [Key Points for Interviews](#key-points-for-interviews)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 What is Execution Context?

Execution Context is the environment where JavaScript code is evaluated and executed. Think of it as a **container** that holds all the information needed to execute a piece of code. It's like a workspace where JavaScript keeps track of variables, functions, and the current execution state.

### 🔍 Simple Analogy
Imagine you're cooking in a kitchen:
- **Kitchen** = Execution Context
- **Ingredients** = Variables and functions
- **Recipe** = Code to execute
- **Cooking process** = Execution phase

---

## 🏗️ Types of Execution Contexts

### 1. Global Execution Context (GEC)
- **Created when**: Script first loads
- **Quantity**: Only one exists throughout the program
- **Contains**: Global variables, functions, and objects
- **Lifetime**: Exists until the program ends

### 2. Function Execution Context (FEC)
- **Created when**: Every time a function is called
- **Quantity**: New context for each function call
- **Contains**: Local variables, parameters, and function-specific data
- **Lifetime**: Destroyed after function execution completes

---

## ⚙️ Execution Context Phases

```
┌─────────────────────────────────────────────────────────────┐
│                    EXECUTION CONTEXT                        │
├─────────────────────────────────────────────────────────────┤
│  🟢 PHASE 1: CREATION PHASE                               │
│  ├─ Lexical Environment (Scope Chain)                      │
│  ├─ Variable Environment (var declarations)                │
│  ├─ This Binding                                           │
│  └─ Outer Environment Reference                            │
├─────────────────────────────────────────────────────────────┤
│  🟡 PHASE 2: EXECUTION PHASE                              │
│  ├─ Code Execution (line by line)                         │
│  ├─ Variable Assignment                                    │
│  └─ Function Calls                                         │
└─────────────────────────────────────────────────────────────┘
```

### 🔄 Phase Details

#### Creation Phase (Compile Time)
1. **Lexical Environment**: Creates scope chain
2. **Variable Environment**: Hoists `var` declarations
3. **This Binding**: Sets the `this` value
4. **Outer Environment**: Links to parent scope

#### Execution Phase (Runtime)
1. **Code Execution**: Runs code line by line
2. **Variable Assignment**: Assigns values to variables
3. **Function Calls**: Executes function calls

---

## 🗂️ Call Stack Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                        CALL STACK                           │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐    │
│  │ 🟢 functionC() - Line 15                            │    │
│  │    ├─ Local variables                               │   │
│  │    ├─ Parameters                                    │   │
│  │    └─ Execution context                             │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ 🟡 functionB() - Line 10                            │   │
│  │    ├─ Local variables                               │   │
│  │    ├─ Parameters                                    │   │
│  │    └─ Execution context                             │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ 🔴 functionA() - Line 5                             │   │
│  │    ├─ Local variables                               │   │
│  │    ├─ Parameters                                    │   │
│  │    └─ Execution context                             │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ 🔵 Global Context                                   │   │
│  │    ├─ Global variables                              │   │
│  │    ├─ Global functions                              │   │
│  │    └─ Global execution context                      │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 📊 Call Stack Rules
- **LIFO Principle**: Last In, First Out (like a stack of plates)
- **Function Calls**: Push new context onto stack
- **Function Returns**: Pop context off stack
- **Stack Overflow**: Occurs when stack gets too deep

---

## 💻 Detailed Examples

### Example 1: Basic Execution Context Flow
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== EXECUTION CONTEXT FLOW ===");

// Global Execution Context starts here
let globalVar = "I'm global";
const globalConst = "I'm also global";

function outerFunction(param) {
    // Function Execution Context for outerFunction starts
    let outerVar = "I'm in outer function";
    const outerConst = param;
    
    function innerFunction() {
        // Function Execution Context for innerFunction starts
        let innerVar = "I'm in inner function";
        
        console.log("=== Inner Function Context ===");
        console.log("innerVar:", innerVar);           // ✅ Own scope
        console.log("outerVar:", outerVar);           // ✅ Outer scope
        console.log("globalVar:", globalVar);         // ✅ Global scope
        console.log("param:", param);                 // ✅ Parameter from outer
    }
    
    console.log("=== Outer Function Context ===");
    console.log("outerVar:", outerVar);               // ✅ Own scope
        console.log("globalVar:", globalVar);             // ✅ Global scope
    // console.log("innerVar:", innerVar);            // ❌ Inner scope not accessible
    
    innerFunction(); // innerFunction context ends
    // outerFunction context continues
}

console.log("=== Global Context ===");
console.log("globalVar:", globalVar);                 // ✅ Own scope
// console.log("outerVar:", outerVar);                // ❌ Function scope not accessible

outerFunction("passed parameter"); // outerFunction context ends
// Global context continues
```
</div>

**Output:**
```
=== Global Context ===
globalVar: I'm global
=== Outer Function Context ===
outerVar: I'm in outer function
globalVar: I'm global
=== Inner Function Context ===
innerVar: I'm in inner function
outerVar: I'm in outer function
globalVar: I'm global
param: passed parameter
```

### Example 2: Execution Context with Variables and Hoisting
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== EXECUTION CONTEXT WITH HOISTING ===");

// Global Execution Context
console.log("1. Global context starts");
console.log("2. globalVar before declaration:", typeof globalVar); // undefined (hoisted)
console.log("3. globalLet before declaration:", typeof globalLet); // ReferenceError (TDZ)

var globalVar = "I'm var";
let globalLet = "I'm let";

function testContext() {
    // Function Execution Context
    console.log("4. Function context starts");
    
    // var is hoisted and initialized with undefined
    console.log("5. localVar before declaration:", localVar); // undefined
    
    // let is hoisted but not initialized (TDZ)
    try {
        console.log("6. localLet before declaration:", localLet); // ReferenceError
    } catch (error) {
        console.log("6. localLet TDZ error:", error.message);
    }
    
    var localVar = "I'm local var";
    let localLet = "I'm local let";
    
    console.log("7. After declarations:");
    console.log("   localVar:", localVar);
    console.log("   localLet:", localLet);
}

testContext();

console.log("8. Back to global context");
console.log("   globalVar:", globalVar);
console.log("   globalLet:", globalLet);
```
</div>

### Example 3: Nested Function Calls and Call Stack
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== NESTED FUNCTION CALLS AND CALL STACK ===");

function first() {
    console.log("🟢 First function starts");
    console.log("   Call stack depth:", new Error().stack.split('\n').length - 1);
    
    second();
    
    console.log("🟢 First function ends");
}

function second() {
    console.log("🟡 Second function starts");
    console.log("   Call stack depth:", new Error().stack.split('\n').length - 1);
    
    third();
    
    console.log("🟡 Second function ends");
}

function third() {
    console.log("🔴 Third function starts");
    console.log("   Call stack depth:", new Error().stack.split('\n').length - 1);
    
    // Simulate some work
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
        result += i;
    }
    
    console.log("🔴 Third function ends");
}

console.log("🔵 Global starts");
first();
console.log("🔵 Global ends");
```
</div>

**Call Stack Flow:**
```
1. 🔵 Global Context
2. 🔵 Global Context + 🟢 first()
3. 🔵 Global Context + 🟢 first() + 🟡 second()
4. 🔵 Global Context + 🟢 first() + 🟡 second() + 🔴 third()
5. 🔵 Global Context + 🟢 first() + 🟡 second()
6. 🔵 Global Context + 🟢 first()
7. 🔵 Global Context
```

### Example 4: Execution Context with this Binding
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== EXECUTION CONTEXT WITH THIS BINDING ===");

// Global context: this = global object (window in browser, global in Node.js)
console.log("Global this:", this);
console.log("this === global:", this === global); // Node.js
console.log("this === window:", this === window); // Browser

const user = {
    name: "John",
    greet: function() {
        // Function context: this = calling object
        console.log("Method this:", this);
        console.log("Hello, I'm", this.name);
        
        function innerFunction() {
            // Inner function context: this = global (or undefined in strict mode)
            console.log("Inner function this:", this);
            console.log("Inner function this.name:", this.name); // undefined
        }
        
        innerFunction();
        
        // Arrow function inherits this from outer scope
        const arrowFunction = () => {
            console.log("Arrow function this:", this);
            console.log("Arrow function this.name:", this.name); // "John"
        };
        
        arrowFunction();
    }
};

user.greet();

// Constructor context
function Person(name) {
    // Constructor context: this = newly created object
    console.log("Constructor this:", this);
    this.name = name;
}

const person = new Person("Jane");
console.log("Created person:", person);
```
</div>

### Example 5: Execution Context and Scope Chain
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== EXECUTION CONTEXT AND SCOPE CHAIN ===");

let globalLevel = "Global Level";

function levelOne() {
    let levelOneVar = "Level One";
    
    console.log("=== Level One Context ===");
    console.log("levelOneVar:", levelOneVar);
    console.log("globalLevel:", globalLevel);
    
    function levelTwo() {
        let levelTwoVar = "Level Two";
        
        console.log("=== Level Two Context ===");
        console.log("levelTwoVar:", levelTwoVar);
        console.log("levelOneVar:", levelOneVar);
        console.log("globalLevel:", globalLevel);
        
        function levelThree() {
            let levelThreeVar = "Level Three";
            
            console.log("=== Level Three Context ===");
            console.log("levelThreeVar:", levelThreeVar);
            console.log("levelTwoVar:", levelTwoVar);
            console.log("levelOneVar:", levelOneVar);
            console.log("globalLevel:", globalLevel);
            
            // Try to access non-existent variable
            try {
                console.log("nonExistentVar:", nonExistentVar);
            } catch (error) {
                console.log("Error accessing nonExistentVar:", error.message);
            }
        }
        
        levelThree();
    }
    
    levelTwo();
}

levelOne();
```
</div>

---

## 🎯 Key Points for Interviews

### 🔑 Core Concepts
1. **Execution Context**: Environment where code runs
2. **Two Phases**: Creation (compile time) and Execution (runtime)
3. **LIFO Stack**: Call stack follows Last In, First Out principle
4. **Scope Chain**: Each context can access variables from outer contexts
5. **This Binding**: Determined by how function is called

### 🚨 Common Mistakes
1. **Confusing creation vs execution phase**
2. **Not understanding scope chain traversal**
3. **Forgetting that function contexts are destroyed after execution**
4. **Misunderstanding this binding in different contexts**

### 💡 Advanced Concepts
1. **Lexical Environment**: Determines scope chain
2. **Variable Environment**: Handles var declarations
3. **Outer Environment Reference**: Links to parent scope
4. **Stack Overflow**: When call stack gets too deep

---

## ❓ Common Interview Questions

### Q: What is an Execution Context in JavaScript?
**A:** An Execution Context is the environment where JavaScript code is evaluated and executed. It's like a container that holds all the information needed to execute a piece of code, including variables, functions, and the current execution state.

**Key Points:**
- Created automatically by JavaScript engine
- Has two phases: Creation and Execution
- Contains scope chain, variables, and this binding
- Function contexts are created for each function call

### Q: What are the phases of Execution Context?
**A:** Execution Context has two phases:

1. **Creation Phase (Compile Time):**
   - Creates Lexical Environment (scope chain)
   - Sets up Variable Environment (hoists var declarations)
   - Establishes This binding
   - Creates Outer Environment Reference

2. **Execution Phase (Runtime):**
   - Executes code line by line
   - Assigns values to variables
   - Executes function calls
   - Manages call stack

### Q: How does the Call Stack work?
**A:** The Call Stack is a data structure that follows the LIFO (Last In, First Out) principle:

**How it works:**
- When a function is called, its execution context is pushed onto the stack
- When a function returns, its context is popped off the stack
- The current execution context is always at the top of the stack
- If the stack gets too deep, you get a "Stack Overflow" error

**Example:**
```javascript
function a() { b(); }
function b() { c(); }
function c() { console.log("Stack depth:", new Error().stack.split('\n').length); }
a(); // Shows call stack depth
```

### Q: What's the difference between Global and Function Execution Context?
**A:** 

**Global Execution Context (GEC):**
- Created once when script loads
- Contains global variables and functions
- Lives for entire program duration
- `this` refers to global object

**Function Execution Context (FEC):**
- Created each time a function is called
- Contains local variables and parameters
- Destroyed after function execution
- `this` depends on how function is called

### Q: How does scope chain work in Execution Context?
**A:** The scope chain is determined by the Lexical Environment and allows inner contexts to access variables from outer contexts:

**Process:**
1. JavaScript first looks for variable in current context
2. If not found, looks in outer context (parent scope)
3. Continues up the chain until global scope
4. If not found anywhere, throws ReferenceError

**Example:**
```javascript
let globalVar = "global";

function outer() {
    let outerVar = "outer";
    
    function inner() {
        let innerVar = "inner";
        console.log(innerVar);    // ✅ Own scope
        console.log(outerVar);    // ✅ Outer scope
        console.log(globalVar);   // ✅ Global scope
        console.log(undefinedVar); // ❌ ReferenceError
    }
    
    inner();
}

outer();
```

---

## 🧪 Practice Exercises

### Exercise 1: Trace Execution Context
```javascript
let x = 1;

function a() {
    let x = 2;
    
    function b() {
        let x = 3;
        console.log(x); // What will this print?
    }
    
    b();
    console.log(x); // What will this print?
}

a();
console.log(x); // What will this print?
```

### Exercise 2: Call Stack Analysis
```javascript
function first() {
    console.log("First");
    second();
}

function second() {
    console.log("Second");
    third();
}

function third() {
    console.log("Third");
    console.log("Stack trace:", new Error().stack);
}

first();
```

### Exercise 3: This Binding in Different Contexts
```javascript
const obj = {
    name: "Object",
    method: function() {
        console.log("Method this:", this.name);
        
        function inner() {
            console.log("Inner this:", this.name);
        }
        
        const arrow = () => {
            console.log("Arrow this:", this.name);
        };
        
        inner();
        arrow();
    }
};

obj.method();
```

---

## 📚 Additional Resources

- **MDN Web Docs**: [Execution Context](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Closures)
- **ECMAScript Specification**: [Execution Contexts](https://tc39.es/ecma262/#sec-execution-contexts)
- **JavaScript.info**: [Variable Scope and Closure](https://javascript.info/closure)

---

## 🧭 Navigation

<div class="navigation">
    <a href="../README.md" class="nav-link prev">⬅️ Previous: Introduction</a>
    <a href="./02-Hoisting.md" class="nav-link next">Next: Hoisting ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

*Last updated: December 2024*
