# 🔹 Hoisting

*Understanding JavaScript's Declaration Movement*

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents
- [What is Hoisting?](#what-is-hoisting)
- [Types of Hoisting](#types-of-hoisting)
- [Hoisting Visualization](#hoisting-visualization)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points for Interviews](#key-points-for-interviews)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 What is Hoisting?

Hoisting is JavaScript's default behavior of moving declarations to the top of their scope during the compilation phase. However, **only declarations are hoisted, not initializations**. This means variables and functions can be used before they're declared in the code.

### 🔍 Simple Analogy
Think of hoisting like moving furniture:
- **Declaration** = Moving the furniture to the top floor
- **Initialization** = Actually placing the furniture in the room
- **Usage** = Using the furniture

JavaScript moves the "furniture" (declarations) to the top, but doesn't place it in the room (initialize it) until the actual line.

---

## 🏗️ Types of Hoisting

### 1. Variable Hoisting
- **var**: Hoisted and initialized with `undefined`
- **let/const**: Hoisted but not initialized (Temporal Dead Zone)
- **Function expressions**: Only variable declaration is hoisted

### 2. Function Hoisting
- **Function declarations**: Entire function is hoisted
- **Function expressions**: Only variable declaration is hoisted
- **Arrow functions**: Same as function expressions

### 3. Class Hoisting
- **Classes**: NOT hoisted (ReferenceError if used before declaration)

---

## 📊 Hoisting Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    HOISTING PROCESS                         │
├─────────────────────────────────────────────────────────────┤
│  BEFORE HOISTING:                    AFTER HOISTING:        │
│  ┌─────────────────────────────┐    ┌─────────────────────┐ │
│  │ console.log(x);             │    │ var x;              │ │
│  │ var x = 5;                  │    │ function test() {}  │ │
│  │ function test() {}          │    │ console.log(x);     │ │
│  │ console.log(x);             │    │ x = 5;              │ │
│  │                             │    │ console.log(x);     │ │
│  └─────────────────────────────┘    └─────────────────────┘ │
│                                     ↑                       │
│                              Declarations moved up          │
│                              Initializations stay put        │
└─────────────────────────────────────────────────────────────┘
```

---

## 💻 Detailed Examples

### Example 1: Variable Hoisting - var vs let/const
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
console.log("=== VARIABLE HOISTING COMPARISON ===");

// var hoisting - gets initialized with undefined
console.log("1. varVariable before declaration:", varVariable); // undefined
var varVariable = "I'm var";
console.log("2. varVariable after declaration:", varVariable);  // "I'm var"

// let hoisting - stays in Temporal Dead Zone
try {
    console.log("3. letVariable before declaration:", letVariable); // ReferenceError
} catch (error) {
    console.log("3. letVariable TDZ error:", error.message);
}
let letVariable = "I'm let";
console.log("4. letVariable after declaration:", letVariable);  // "I'm let"
```
</div>

### Example 2: Function Declaration vs Function Expression
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== FUNCTION HOISTING COMPARISON ===");

// Function Declaration - Fully hoisted
console.log("1. Function declaration type:", typeof greet); // "function"
greet("John"); // ✅ Works perfectly!

function greet(name) {
    return `Hello ${name}!`;
}

// Function Expression - Partially hoisted
console.log("2. Function expression type:", typeof greetExpr); // "undefined"
try {
    greetExpr("Jane"); // ❌ TypeError: greetExpr is not a function
} catch (error) {
    console.log("2. Function expression error:", error.message);
}

var greetExpr = function(name) {
    return `Hello ${name}!`;
};
```
</div>

---

## ⚠️ Common Pitfalls

### Pitfall 1: Expecting Initialization to be Hoisted
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== PITFALL 1: INITIALIZATION NOT HOISTED ===");

console.log("x:", x); // undefined (not ReferenceError)
var x = 5;

// What you might expect: ReferenceError
// What actually happens: undefined
// Why: Only declaration is hoisted, not initialization
```
</div>

### Pitfall 2: Function Expression vs Function Declaration
```javascript
console.log("=== PITFALL 2: FUNCTION EXPRESSION VS DECLARATION ===");

// Function declaration - works
sayHello(); // ✅ Works
function sayHello() { console.log("Hello!"); }

// Function expression - doesn't work
try {
    sayGoodbye(); // ❌ TypeError
} catch (error) {
    console.log("Function expression error:", error.message);
}

var sayGoodbye = function() { console.log("Goodbye!"); };
```

---

## ✅ Best Practices

### 1. Use let/const Instead of var
```javascript
console.log("=== BEST PRACTICE 1: USE LET/CONST ===");

// ❌ Avoid var (function-scoped, hoisted with undefined)
var oldWay = "avoid this";

// ✅ Use let/const (block-scoped, TDZ prevents errors)
let modernWay = "use this";
const constantWay = "for constants";
```

### 2. Declare Functions Before Use
```javascript
console.log("=== BEST PRACTICE 2: DECLARE FUNCTIONS FIRST ===");

// ✅ Declare functions first, then use them
function someFunction() {
    return "I'm declared first";
}

someFunction(); // Clear and predictable
```

---

## 🎯 Key Points for Interviews

### 🔑 Core Concepts
1. **Hoisting Definition**: Moving declarations to top of scope during compilation
2. **Declaration vs Initialization**: Only declarations move, values stay put
3. **var vs let/const**: var gets undefined, let/const stay uninitialized (TDZ)
4. **Function Types**: Declarations fully hoisted, expressions partially hoisted
5. **Classes**: Not hoisted at all

### 🚨 Common Mistakes
1. **Expecting initialization to be hoisted**
2. **Confusing function declaration vs expression hoisting**
3. **Not understanding TDZ for let/const**
4. **Forgetting that classes aren't hoisted**

---

## ❓ Common Interview Questions

### Q: What is hoisting in JavaScript?
**A:** Hoisting is JavaScript's default behavior of moving variable and function declarations to the top of their scope during the compilation phase. However, only declarations are moved, not initializations.

### Q: What's the difference between hoisting of var and let/const?
**A:** 

**var hoisting:**
- Declaration is hoisted to top of scope
- Variable is initialized with `undefined`
- Can be accessed before declaration (returns `undefined`)

**let/const hoisting:**
- Declaration is hoisted to top of scope
- Variable remains uninitialized
- Cannot be accessed before declaration (Temporal Dead Zone error)

### Q: How does function hoisting work?
**A:** Function hoisting depends on the type of function:

**Function Declarations:**
- Entire function is hoisted
- Can be called before declaration
- Most predictable hoisting behavior

**Function Expressions:**
- Only variable declaration is hoisted
- Function body is not hoisted
- Cannot be called before assignment

---

## 🧪 Practice Exercises

### Exercise 1: Hoisting Prediction
```javascript
console.log("Exercise 1: Predict the output");

console.log(a); // What will this print?
var a = 10;

console.log(b); // What will this print?
let b = 20;

console.log(typeof c); // What will this print?
function c() { return "function"; }
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Execution-Context-Call-Stack.md" class="nav-link prev">⬅️ Previous: Execution Context & Call Stack</a>
    <a href="./03-Scope-Lexical-Scope.md" class="nav-link next">Next: Scope & Lexical Scope ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>



*Last updated: December 2024*
