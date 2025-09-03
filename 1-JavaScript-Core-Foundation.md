# JavaScript Core Foundations 🚀
*Complete Interview Preparation Guide*

---

## 🔹 1. Execution Context & Call Stack

### What is Execution Context?
Execution Context is the environment where JavaScript code is evaluated and executed. Think of it as a container that holds all the information needed to execute a piece of code.

### Types of Execution Contexts

#### 1. Global Execution Context (GEC)
- Created when the script first loads
- Only one GEC exists throughout the program
- Contains global variables and functions

#### 2. Function Execution Context (FEC)
- Created every time a function is called
- Each function gets its own execution context
- Destroyed after function execution completes

### Execution Context Phases

```
┌─────────────────────────────────────────────────────────────┐
│                    EXECUTION CONTEXT                        │
├─────────────────────────────────────────────────────────────┤
│  PHASE 1: CREATION PHASE                                   │
│  ├─ Lexical Environment (Scope Chain)                      │
│  ├─ Variable Environment (var declarations)                │
│  ├─ This Binding                                           │
│  └─ Outer Environment Reference                            │
├─────────────────────────────────────────────────────────────┤
│  PHASE 2: EXECUTION PHASE                                  │
│  ├─ Code Execution (line by line)                         │
│  ├─ Variable Assignment                                    │
│  └─ Function Calls                                         │
└─────────────────────────────────────────────────────────────┘
```

### Call Stack Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                        CALL STACK                          │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐   │
│  │ functionC() - Line 15                               │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ functionB() - Line 10                               │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ functionA() - Line 5                                │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Global Context                                      │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: Basic Execution Context
```javascript
// Global Execution Context starts here
let globalVar = "I'm global";

function outerFunction() {
    // Function Execution Context for outerFunction starts
    let outerVar = "I'm in outer function";
    
    function innerFunction() {
        // Function Execution Context for innerFunction starts
        let innerVar = "I'm in inner function";
        console.log(globalVar);    // Can access global
        console.log(outerVar);     // Can access outer
        console.log(innerVar);     // Can access own
    }
    
    innerFunction(); // innerFunction context ends
    // outerFunction context continues
}

outerFunction(); // outerFunction context ends
// Global context continues
```

#### Example 2: Execution Context with Variables
```javascript
console.log(x); // undefined (hoisting)
console.log(y); // ReferenceError: Cannot access 'y' before initialization

var x = 10;
let y = 20;

function testContext() {
    console.log(x); // 10 (from global scope)
    console.log(y); // 20 (from global scope)
    
    var localVar = "local";
    console.log(localVar); // "local"
}

testContext();
console.log(localVar); // ReferenceError: localVar is not defined
```

#### Example 3: Nested Function Calls and Call Stack
```javascript
function first() {
    console.log("First function starts");
    second();
    console.log("First function ends");
}

function second() {
    console.log("Second function starts");
    third();
    console.log("Second function ends");
}

function third() {
    console.log("Third function starts");
    console.log("Third function ends");
}

console.log("Global starts");
first();
console.log("Global ends");
```

**Output:**
```
Global starts
First function starts
Second function starts
Third function starts
Third function ends
Second function ends
First function ends
Global ends
```

**Call Stack Flow:**
```
1. Global Context
2. Global Context + first()
3. Global Context + first() + second()
4. Global Context + first() + second() + third()
5. Global Context + first() + second()
6. Global Context + first()
7. Global Context
```

### Key Points to Remember for Interviews

1. **Creation Phase Happens First**: Variables are declared (but not assigned) and functions are hoisted
2. **Execution Phase Second**: Code runs line by line, assignments happen
3. **LIFO Principle**: Call stack follows Last In, First Out (like a stack of plates)
4. **Context Destruction**: Function contexts are destroyed after execution
5. **Scope Chain**: Each context can access variables from outer contexts

### Common Interview Questions

**Q: What happens when you call a function inside another function?**
A: A new Function Execution Context is created and pushed onto the call stack. The inner function can access variables from outer contexts through the scope chain.

**Q: How does JavaScript handle multiple function calls?**
A: Each function call creates a new execution context that gets pushed onto the call stack. When a function completes, its context is popped off the stack.

**Q: What's the difference between global and function execution context?**
A: Global context is created once when the script loads and contains global variables. Function contexts are created each time a function is called and contain local variables and parameters.

---

## 🔹 2. Hoisting

### What is Hoisting?
Hoisting is JavaScript's default behavior of moving declarations to the top of their scope during the compilation phase. However, **only declarations are hoisted, not initializations**.

### Hoisting Visualization

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
│  └─────────────────────────────┘    │ console.log(x);     │ │
│                                     └─────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### How Different Declarations Behave

#### 1. var Hoisting
```javascript
console.log(x); // undefined (not ReferenceError!)
var x = 5;
console.log(x); // 5

// What actually happens:
// var x;           ← Declaration is hoisted
// console.log(x);  ← x is undefined
// x = 5;          ← Assignment happens here
// console.log(x);  ← x is 5
```

#### 2. let and const Hoisting (Temporal Dead Zone)
```javascript
console.log(x); // ReferenceError: Cannot access 'x' before initialization
let x = 5;

// What happens:
// let x;           ← Declaration is hoisted but not initialized
// console.log(x);  ← TDZ error - x exists but can't be accessed
// x = 5;          ← Initialization happens here
```

#### 3. Function Declarations (Fully Hoisted)
```javascript
sayHello(); // "Hello!" - Works perfectly!

function sayHello() {
    console.log("Hello!");
}

// What happens:
// function sayHello() { ... } ← Entire function is hoisted
// sayHello();                 ← Function call works
```

#### 4. Function Expressions (Partially Hoisted)
```javascript
sayHello(); // TypeError: sayHello is not a function

var sayHello = function() {
    console.log("Hello!");
};

// What happens:
// var sayHello;               ← Variable declaration hoisted
// sayHello();                 ← sayHello is undefined, not a function
// sayHello = function() {...} ← Assignment happens here
```

### Detailed Examples

#### Example 1: var vs let Hoisting
```javascript
console.log("=== var hoisting ===");
console.log(varVariable); // undefined
var varVariable = "I'm var";

console.log("=== let hoisting ===");
try {
    console.log(letVariable); // ReferenceError
} catch (error) {
    console.log("Error:", error.message);
}
let letVariable = "I'm let";

console.log("=== After initialization ===");
console.log(varVariable); // "I'm var"
console.log(letVariable); // "I'm let"
```

#### Example 2: Function Declaration vs Expression
```javascript
// Function Declaration - Fully hoisted
console.log("Function declaration result:", typeof greet); // "function"
greet("John"); // "Hello John"

function greet(name) {
    return `Hello ${name}`;
}

// Function Expression - Partially hoisted
console.log("Function expression result:", typeof greetExpr); // "undefined"
try {
    greetExpr("Jane"); // TypeError
} catch (error) {
    console.log("Error:", error.message);
}

var greetExpr = function(name) {
    return `Hello ${name}`;
};

console.log("After assignment:", typeof greetExpr); // "function"
greetExpr("Jane"); // "Hello Jane"
```

#### Example 3: Complex Hoisting Scenario
```javascript
var x = 1;

function test() {
    console.log("x in function:", x); // undefined (not 1!)
    
    var x = 2;
    console.log("x after declaration:", x); // 2
}

test();
console.log("x in global:", x); // 1

// What actually happens:
// 1. Global: var x = 1
// 2. Function test() {
//      var x;           ← Local x is hoisted (shadows global)
//      console.log(x);  ← undefined (local x, not assigned yet)
//      x = 2;          ← Local x gets assigned
//      console.log(x);  ← 2
//    }
// 3. Global x remains 1
```

#### Example 4: Class Hoisting
```javascript
// Classes are NOT hoisted
try {
    const obj = new MyClass(); // ReferenceError
} catch (error) {
    console.log("Error:", error.message);
}

class MyClass {
    constructor() {
        this.name = "MyClass";
    }
}

const obj = new MyClass(); // Works fine
console.log(obj.name); // "MyClass"
```

### Hoisting Order and Priority

```
┌─────────────────────────────────────────────────────────────┐
│                    HOISTING PRIORITY                        │
├─────────────────────────────────────────────────────────────┤
│  1. Function Declarations (highest priority)               │
│  2. Variable Declarations (var, let, const)               │
│  3. Function Expressions                                    │
│  4. Class Declarations (not hoisted)                       │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Only Declarations Move**: Initializations stay in place
2. **var vs let/const**: var gets initialized with undefined, let/const stay uninitialized (TDZ)
3. **Function Declarations**: Entire function body is hoisted
4. **Function Expressions**: Only variable declaration is hoisted
5. **Classes**: Not hoisted at all
6. **Hoisting Order**: Functions first, then variables

### Common Interview Questions

**Q: What is hoisting and how does it work?**
A: Hoisting is JavaScript's behavior of moving variable and function declarations to the top of their scope during compilation. Only declarations are moved, not initializations.

**Q: What's the difference between hoisting of var and let?**
A: var declarations are hoisted and initialized with undefined, while let declarations are hoisted but remain uninitialized, causing a Temporal Dead Zone error if accessed before initialization.

**Q: Can you call a function before it's declared?**
A: Yes, if it's a function declaration (fully hoisted). No, if it's a function expression (only variable declaration is hoisted).

**Q: What is the Temporal Dead Zone?**
A: The TDZ is the period between entering a scope and the actual declaration of a let/const variable, during which the variable exists but cannot be accessed.

---

## 🔹 3. Scope & Lexical Scope

### What is Scope?
Scope determines the accessibility (visibility) of variables, functions, and objects in your code. It's like a set of rules that determines where you can access variables and where you can't.

### Types of Scope

#### 1. Global Scope
- Variables declared outside any function or block
- Accessible from anywhere in the code
- Lives for the entire duration of the program

#### 2. Function Scope (Local Scope)
- Variables declared inside a function
- Only accessible within that function
- Destroyed when function execution ends

#### 3. Block Scope
- Variables declared inside a block (if, for, while, etc.)
- Only accessible within that block
- Introduced with ES6 (let and const)

### Scope Chain Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    SCOPE CHAIN                              │
├─────────────────────────────────────────────────────────────┤
│  Global Scope                                              │
│  ├─ globalVar                                              │
│  └─ outerFunction()                                        │
│      ├─ outerVar                                           │
│      └─ innerFunction()                                    │
│          ├─ innerVar                                       │
│          └─ Access to: innerVar, outerVar, globalVar      │
│                                                             │
│  Scope Chain: innerFunction → outerFunction → Global       │
└─────────────────────────────────────────────────────────────┘
```

### Lexical Scope (Static Scope)
Lexical scope means that the scope of a variable is determined by its location within the source code, not by where it's called from.

### Detailed Examples

#### Example 1: Basic Scope Types
```javascript
// Global Scope
let globalVar = "I'm global";

function outerFunction() {
    // Function Scope
    let outerVar = "I'm in outer function";
    
    function innerFunction() {
        // Function Scope
        let innerVar = "I'm in inner function";
        
        console.log("Inner function can access:");
        console.log("- innerVar:", innerVar);     // ✅ Own scope
        console.log("- outerVar:", outerVar);     // ✅ Outer scope
        console.log("- globalVar:", globalVar);   // ✅ Global scope
    }
    
    innerFunction();
    
    console.log("Outer function can access:");
    console.log("- outerVar:", outerVar);         // ✅ Own scope
    console.log("- globalVar:", globalVar);       // ✅ Global scope
    // console.log("- innerVar:", innerVar);      // ❌ Error - inner scope not accessible
}

outerFunction();

console.log("Global can access:");
console.log("- globalVar:", globalVar);           // ✅ Own scope
// console.log("- outerVar:", outerVar);          // ❌ Error - function scope not accessible
// console.log("- innerVar:", innerVar);          // ❌ Error - function scope not accessible
```

#### Example 2: Block Scope vs Function Scope
```javascript
function scopeTest() {
    var functionScopedVar = "I'm function scoped";
    let blockScopedVar = "I'm block scoped";
    
    if (true) {
        // Block scope
        var functionScopedInBlock = "I'm function scoped (in block)";
        let blockScopedInBlock = "I'm block scoped (in block)";
        
        console.log("Inside block:");
        console.log("- functionScopedVar:", functionScopedVar);           // ✅ Accessible
        console.log("- blockScopedVar:", blockScopedVar);               // ✅ Accessible
        console.log("- functionScopedInBlock:", functionScopedInBlock);  // ✅ Accessible
        console.log("- blockScopedInBlock:", blockScopedInBlock);       // ✅ Accessible
    }
    
    console.log("Outside block:");
    console.log("- functionScopedVar:", functionScopedVar);           // ✅ Accessible
    console.log("- blockScopedVar:", blockScopedVar);               // ✅ Accessible
    console.log("- functionScopedInBlock:", functionScopedInBlock);  // ✅ Accessible (var is function scoped)
    // console.log("- blockScopedInBlock:", blockScopedInBlock);    // ❌ Error - let is block scoped
}
```

#### Example 3: Variable Shadowing
```javascript
let name = "Global Name";

function outer() {
    let name = "Outer Name";
    
    function inner() {
        let name = "Inner Name";
        
        console.log("Inner function name:", name); // "Inner Name"
    }
    
    inner();
    console.log("Outer function name:", name); // "Outer Name"
}

outer();
console.log("Global name:", name); // "Global Name"

// Shadowing creates a new variable that "hides" the outer one
// Each scope has its own 'name' variable
```

#### Example 4: Scope Chain in Practice
```javascript
let globalValue = 100;

function firstLevel() {
    let firstValue = 200;
    
    function secondLevel() {
        let secondValue = 300;
        
        function thirdLevel() {
            let thirdValue = 400;
            
            // Can access all levels through scope chain
            console.log("Third level accessing:");
            console.log("- thirdValue:", thirdValue);    // 400 (own)
            console.log("- secondValue:", secondValue);  // 300 (second level)
            console.log("- firstValue:", firstValue);    // 200 (first level)
            console.log("- globalValue:", globalValue);  // 100 (global)
        }
        
        thirdLevel();
    }
    
    secondLevel();
}

firstLevel();
```

#### Example 5: Common Scope Mistakes
```javascript
// ❌ Problem: var in loops (function scoped)
for (var i = 0; i < 3; i++) {
    setTimeout(() => {
        console.log("var i:", i); // All print 3!
    }, 100);
}

// ✅ Solution: let in loops (block scoped)
for (let j = 0; j < 3; j++) {
    setTimeout(() => {
        console.log("let j:", j); // 0, 1, 2
    }, 100);
}

// ❌ Problem: var hoisting in blocks
if (true) {
    var blockVar = "I'm in a block";
}
console.log(blockVar); // "I'm in a block" (var is function scoped)

// ✅ Solution: let/const for block scope
if (true) {
    let blockLet = "I'm in a block";
}
// console.log(blockLet); // ReferenceError (let is block scoped)
```

### Scope Resolution Process

```
┌─────────────────────────────────────────────────────────────┐
│                SCOPE RESOLUTION PROCESS                     │
├─────────────────────────────────────────────────────────────┤
│  1. Check current scope for variable                        │
│  2. If not found, check outer scope                         │
│  3. Continue up the scope chain                             │
│  4. If not found in global scope → ReferenceError          │
│  5. If found, use that variable                             │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Lexical Scope**: Scope is determined by code location, not call location
2. **Scope Chain**: Inner functions can access outer variables, not vice versa
3. **var vs let/const**: var is function-scoped, let/const are block-scoped
4. **Variable Shadowing**: Inner scope variables can hide outer scope variables
5. **Scope Resolution**: JavaScript searches up the scope chain until it finds the variable

### Common Interview Questions

**Q: What is the difference between function scope and block scope?**
A: Function scope (var) is accessible throughout the entire function, while block scope (let/const) is only accessible within the specific block where it's declared.

**Q: How does the scope chain work?**
A: When a variable is accessed, JavaScript first looks in the current scope. If not found, it looks in the outer scope, continuing up the chain until it reaches the global scope or throws a ReferenceError.

**Q: What is variable shadowing?**
A: Variable shadowing occurs when a variable in an inner scope has the same name as a variable in an outer scope, effectively "hiding" the outer variable within the inner scope.

**Q: Why does var in loops cause issues with setTimeout?**
A: var is function-scoped, so all iterations of the loop share the same variable. When setTimeout executes, the loop has already finished and the variable contains the final value. let creates a new variable for each iteration.

---

## 🔹 4. Closures

### What is a Closure?
A closure is a function that has access to variables in its outer (enclosing) scope even after the outer function has returned. It's like a function that "remembers" the environment in which it was created.

### Closure Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                        CLOSURE                              │
├─────────────────────────────────────────────────────────────┤
│  Outer Function                                            │
│  ├─ outerVariable                                          │
│  └─ Inner Function (Closure)                               │
│      ├─ innerVariable                                      │
│      └─ Access to outerVariable (even after outer returns) │
│                                                             │
│  The inner function "closes over" the outer scope          │
└─────────────────────────────────────────────────────────────┘
```

### How Closures Work

1. **Function Creation**: Inner function is created inside outer function
2. **Scope Chain**: Inner function has access to outer function's variables
3. **Function Return**: Outer function returns inner function
4. **Closure Formation**: Inner function maintains access to outer variables
5. **Memory Retention**: Outer variables stay in memory as long as closure exists

### Detailed Examples

#### Example 1: Basic Closure
```javascript
function outerFunction(x) {
    // This variable will be "closed over" by the inner function
    let outerVariable = x;
    
    // Inner function (closure)
    function innerFunction() {
        console.log("Outer variable:", outerVariable);
        return outerVariable * 2;
    }
    
    // Return the inner function
    return innerFunction;
}

// Create closure
const closure1 = outerFunction(10);
const closure2 = outerFunction(20);

// Use closures
console.log(closure1()); // "Outer variable: 10" then returns 20
console.log(closure2()); // "Outer variable: 20" then returns 40

// Each closure has its own copy of outerVariable
console.log(closure1()); // "Outer variable: 10" then returns 20
```

#### Example 2: Data Privacy with Closures
```javascript
function createCounter() {
    // Private variable - not accessible from outside
    let count = 0;
    
    // Public methods that can access private variable
    return {
        increment: function() {
            count++;
            return count;
        },
        decrement: function() {
            count--;
            return count;
        },
        getCount: function() {
            return count;
        },
        reset: function() {
            count = 0;
            return count;
        }
    };
}

const counter = createCounter();

console.log(counter.getCount());  // 0
console.log(counter.increment()); // 1
console.log(counter.increment()); // 2
console.log(counter.decrement()); // 1
console.log(counter.reset());     // 0

// Can't access count directly
// console.log(counter.count);   // undefined
// count = 100;                  // ReferenceError (count is not in scope)
```

#### Example 3: Memoization with Closures
```javascript
function createMemoizedFunction(fn) {
    // Private cache object
    const cache = {};
    
    return function(...args) {
        // Create a key from the arguments
        const key = JSON.stringify(args);
        
        // Check if result is already cached
        if (cache[key]) {
            console.log("Returning cached result for:", args);
            return cache[key];
        }
        
        // Calculate and cache the result
        console.log("Calculating new result for:", args);
        const result = fn(...args);
        cache[key] = result;
        
        return result;
    };
}

// Expensive function to memoize
function expensiveCalculation(n) {
    console.log("Performing expensive calculation for:", n);
    return n * n * n; // Simulating expensive operation
}

const memoizedCalculation = createMemoizedFunction(expensiveCalculation);

console.log(memoizedCalculation(5)); // "Calculating new result for: [5]" then 125
console.log(memoizedCalculation(5)); // "Returning cached result for: [5]" then 125
console.log(memoizedCalculation(3)); // "Calculating new result for: [3]" then 27
console.log(memoizedCalculation(5)); // "Returning cached result for: [5]" then 125
```

#### Example 4: Currying with Closures
```javascript
function curry(fn) {
    return function curried(...args) {
        if (args.length >= fn.length) {
            return fn.apply(this, args);
        }
        
        return function(...moreArgs) {
            return curried.apply(this, args.concat(moreArgs));
        };
    };
}

// Function to curry
function add(a, b, c) {
    return a + b + c;
}

const curriedAdd = curry(add);

console.log(curriedAdd(1)(2)(3));     // 6
console.log(curriedAdd(1, 2)(3));    // 6
console.log(curriedAdd(1)(2, 3));    // 6
console.log(curriedAdd(1, 2, 3));    // 6

// Practical use case
const addTen = curriedAdd(10);
const addTenAndFive = addTen(5);

console.log(addTenAndFive(3));        // 18 (10 + 5 + 3)
```

#### Example 5: Module Pattern with Closures
```javascript
const calculatorModule = (function() {
    // Private variables and functions
    let result = 0;
    
    function validateNumber(num) {
        return typeof num === 'number' && !isNaN(num);
    }
    
    // Public API
    return {
        add: function(num) {
            if (validateNumber(num)) {
                result += num;
                return this;
            }
            throw new Error('Invalid number');
        },
        
        subtract: function(num) {
            if (validateNumber(num)) {
                result -= num;
                return this;
            }
            throw new Error('Invalid number');
        },
        
        multiply: function(num) {
            if (validateNumber(num)) {
                result *= num;
                return this;
            }
            throw new Error('Invalid number');
        },
        
        getResult: function() {
            return result;
        },
        
        reset: function() {
            result = 0;
            return this;
        }
    };
})();

// Usage
calculatorModule.add(5).multiply(2).subtract(3);
console.log(calculatorModule.getResult()); // 7

// Private variables are not accessible
// console.log(calculatorModule.result);        // undefined
// calculatorModule.validateNumber(5);          // TypeError
```

#### Example 6: Common Closure Interview Trap
```javascript
// ❌ Problem: Closure in loops with var
function createFunctions() {
    const functions = [];
    
    for (var i = 0; i < 3; i++) {
        functions.push(function() {
            return i;
        });
    }
    
    return functions;
}

const funcs = createFunctions();
console.log(funcs[0]()); // 3 (not 0!)
console.log(funcs[1]()); // 3 (not 1!)
console.log(funcs[2]()); // 3 (not 2!)

// ✅ Solution 1: Use let (block scope)
function createFunctionsFixed1() {
    const functions = [];
    
    for (let i = 0; i < 3; i++) {
        functions.push(function() {
            return i;
        });
    }
    
    return functions;
}

const funcsFixed1 = createFunctionsFixed1();
console.log(funcsFixed1[0]()); // 0
console.log(funcsFixed1[1]()); // 1
console.log(funcsFixed1[2]()); // 2

// ✅ Solution 2: Use IIFE to create new scope
function createFunctionsFixed2() {
    const functions = [];
    
    for (var i = 0; i < 3; i++) {
        functions.push((function(index) {
            return function() {
                return index;
            };
        })(i));
    }
    
    return functions;
}

const funcsFixed2 = createFunctionsFixed2();
console.log(funcsFixed2[0]()); // 0
console.log(funcsFixed2[1]()); // 1
console.log(funcsFixed2[2]()); // 2
```

### Closure Memory Management

```
┌─────────────────────────────────────────────────────────────┐
│                CLOSURE MEMORY MANAGEMENT                    │
├─────────────────────────────────────────────────────────────┤
│  When closure is created:                                  │
│  ├─ Outer function variables are kept in memory            │
│  ├─ Inner function maintains reference to outer scope      │
│  └─ Memory is not garbage collected                        │
│                                                             │
│  When closure is destroyed:                                │
│  ├─ No more references to closure                          │
│  ├─ Outer variables can be garbage collected               │
│  └─ Memory is freed                                        │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Definition**: Closure is a function that has access to variables in its outer scope
2. **Data Privacy**: Closures can create private variables and methods
3. **Memory Retention**: Outer variables stay in memory as long as closure exists
4. **Common Use Cases**: Data privacy, memoization, currying, module pattern
5. **Loop Trap**: Be careful with closures in loops (use let or IIFE)

### Common Interview Questions

**Q: What is a closure and how does it work?**
A: A closure is a function that has access to variables in its outer scope even after the outer function has returned. It works by maintaining a reference to the outer scope's variables.

**Q: How can you use closures for data privacy?**
A: By returning an object with methods that access private variables from the outer scope, you can create an API that hides internal implementation details.

**Q: What is the closure loop trap and how do you fix it?**
A: When creating closures in loops with var, all closures reference the same variable. Fix by using let (block scope) or IIFE to create new scope for each iteration.

**Q: How do closures affect memory management?**
A: Closures keep outer variables in memory as long as the closure exists, preventing garbage collection until the closure is destroyed.

---

## 🔹 5. Temporal Dead Zone (TDZ)

### What is the Temporal Dead Zone?
The Temporal Dead Zone (TDZ) is the period between entering a scope and the actual declaration of a `let` or `const` variable. During this time, the variable exists but cannot be accessed, resulting in a `ReferenceError`.

### TDZ Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                TEMPORAL DEAD ZONE (TDZ)                     │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Scope Entry Point                                  │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ TEMPORAL DEAD ZONE                                 │   │
│  │ ├─ Variable exists but uninitialized               │   │
│  │ ├─ Accessing causes ReferenceError                 │   │
│  │ └─ let/const declarations are hoisted here         │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  ┌─────────────────────────────────────────────────────┘   │
│  │ Variable Declaration Line                            │   │
│  │ ├─ Variable gets initialized                        │   │
│  │ └─ Can now be accessed safely                       │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Why TDZ Exists

The TDZ was introduced in ES6 to prevent accessing variables before they're declared, making the code more predictable and catching potential bugs early.

### var vs let/const Hoisting Behavior

```
┌─────────────────────────────────────────────────────────────┐
│                HOISTING COMPARISON                          │
├─────────────────────────────────────────────────────────────┤
│  var:                                                      │
│  ├─ Declaration: Hoisted                                   │
│  ├─ Initialization: undefined                             │
│  └─ Access: undefined (no error)                          │
│                                                             │
│  let/const:                                                │
│  ├─ Declaration: Hoisted                                   │
│  ├─ Initialization: Uninitialized (TDZ)                   │
│  └─ Access: ReferenceError (TDZ)                          │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: Basic TDZ Demonstration
```javascript
console.log("=== TDZ with let ===");
try {
    console.log(letVar); // ReferenceError: Cannot access 'letVar' before initialization
} catch (error) {
    console.log("Error:", error.message);
}

let letVar = "I'm let";

console.log("After declaration:", letVar); // "I'm let"

console.log("=== No TDZ with var ===");
console.log(varVar); // undefined (no error)

var varVar = "I'm var";
console.log("After declaration:", varVar); // "I'm var"
```

#### Example 2: TDZ in Different Scopes
```javascript
function testTDZ() {
    console.log("Function starts");
    
    // TDZ starts here
    try {
        console.log(blockVar); // ReferenceError
    } catch (error) {
        console.log("TDZ Error:", error.message);
    }
    
    if (true) {
        // TDZ continues in block scope
        try {
            console.log(blockVar); // ReferenceError
        } catch (error) {
            console.log("Block TDZ Error:", error.message);
        }
        
        let blockVar = "Block variable";
        console.log("After declaration:", blockVar); // "Block variable"
    }
    
    // TDZ ends, variable accessible
    console.log("Outside block:", blockVar); // "Block variable"
}

testTDZ();
```

#### Example 3: TDZ with Function Parameters
```javascript
function testParameterTDZ(param1, param2) {
    console.log("Parameters:", param1, param2);
    
    // TDZ for let/const in function body
    try {
        console.log(functionVar); // ReferenceError
    } catch (error) {
        console.log("Function TDZ Error:", error.message);
    }
    
    let functionVar = "Function variable";
    console.log("After declaration:", functionVar);
}

testParameterTDZ("hello", "world");
```

#### Example 4: TDZ in Loops and Blocks
```javascript
console.log("=== TDZ in for loop ===");

for (let i = 0; i < 3; i++) {
    // Each iteration has its own 'i' variable
    // No TDZ issues because 'i' is declared in the loop header
    console.log("Loop iteration:", i);
}

console.log("=== TDZ in block ===");

{
    // TDZ starts
    try {
        console.log(blockLet); // ReferenceError
    } catch (error) {
        console.log("Block TDZ Error:", error.message);
    }
    
    let blockLet = "Block let";
    console.log("After declaration:", blockLet);
    
    // TDZ ends
}

// console.log(blockLet); // ReferenceError - blockLet is not in scope
```

#### Example 5: TDZ with const and Object Destructuring
```javascript
console.log("=== TDZ with const ===");

try {
    console.log(constVar); // ReferenceError
} catch (error) {
    console.log("Const TDZ Error:", error.message);
}

const constVar = "I'm const";
console.log("After declaration:", constVar);

console.log("=== TDZ with destructuring ===");

const obj = { x: 1, y: 2 };

try {
    console.log(x, y); // ReferenceError
} catch (error) {
    console.log("Destructuring TDZ Error:", error.message);
}

const { x, y } = obj;
console.log("After destructuring:", x, y);
```

#### Example 6: TDZ vs Hoisting in Complex Scenarios
```javascript
function complexTDZ() {
    console.log("Function starts");
    
    // var is hoisted and initialized with undefined
    console.log("varVar:", varVar); // undefined
    
    // let is hoisted but not initialized (TDZ)
    try {
        console.log("letVar:", letVar); // ReferenceError
    } catch (error) {
        console.log("letVar TDZ Error:", error.message);
    }
    
    // Function declaration is fully hoisted
    console.log("Function type:", typeof hoistedFunc); // "function"
    hoistedFunc(); // "I'm hoisted"
    
    // Function expression (var) is partially hoisted
    console.log("Function expression type:", typeof funcExpr); // "undefined"
    try {
        funcExpr(); // TypeError
    } catch (error) {
        console.log("funcExpr Error:", error.message);
    }
    
    // Declarations
    var varVar = "I'm var";
    let letVar = "I'm let";
    
    function hoistedFunc() {
        console.log("I'm hoisted");
    }
    
    var funcExpr = function() {
        console.log("I'm function expression");
    };
    
    console.log("After all declarations:");
    console.log("varVar:", varVar);
    console.log("letVar:", letVar);
    funcExpr(); // Now works
}

complexTDZ();
```

### TDZ in Different JavaScript Environments

```
┌─────────────────────────────────────────────────────────────┐
│                TDZ BEHAVIOR BY ENVIRONMENT                  │
├─────────────────────────────────────────────────────────────┤
│  Modern Browsers (ES6+):                                   │
│  ├─ let/const: TDZ enforced                               │
│  └─ var: No TDZ                                           │
│                                                             │
│  Node.js (ES6+):                                           │
│  ├─ let/const: TDZ enforced                               │
│  └─ var: No TDZ                                           │
│                                                             │
│  Legacy Browsers (ES5):                                    │
│  ├─ let/const: Not supported                              │
│  └─ var: No TDZ                                           │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **TDZ Definition**: Period between scope entry and variable declaration where let/const exist but can't be accessed
2. **Purpose**: Prevents accessing variables before declaration, making code more predictable
3. **var vs let/const**: var has no TDZ, let/const have TDZ
4. **Hoisting**: All declarations are hoisted, but let/const remain uninitialized
5. **Scope Specific**: TDZ exists in the specific scope where the variable is declared

### Common Interview Questions

**Q: What is the Temporal Dead Zone?**
A: The TDZ is the period between entering a scope and the actual declaration of a let or const variable, during which the variable exists but cannot be accessed, resulting in a ReferenceError.

**Q: Why was the Temporal Dead Zone introduced?**
A: TDZ was introduced to prevent accessing variables before they're declared, making the code more predictable and catching potential bugs early in development.

**Q: What's the difference between var and let/const regarding TDZ?**
A: var declarations are hoisted and initialized with undefined (no TDZ), while let/const declarations are hoisted but remain uninitialized, creating a TDZ until the actual declaration line.

**Q: How does TDZ affect function parameters?**
A: Function parameters don't have TDZ issues because they're initialized when the function is called, before the function body execution begins.

**Q: Can you access a let variable before its declaration in the same scope?**
A: No, accessing a let variable before its declaration in the same scope will throw a ReferenceError due to the Temporal Dead Zone.

---

## 🔹 6. Primitive vs Reference Types

### What are Primitive and Reference Types?
JavaScript has two main categories of data types: **Primitive Types** and **Reference Types**. Understanding the difference is crucial for avoiding common bugs and understanding how data is stored and passed around.

### Data Type Categories

```
┌─────────────────────────────────────────────────────────────┐
│                    JAVASCRIPT DATA TYPES                    │
├─────────────────────────────────────────────────────────────┤
│  PRIMITIVE TYPES (7 types):                                │
│  ├─ String, Number, Boolean                                │
│  ├─ null, undefined                                        │
│  ├─ Symbol, BigInt                                         │
│  └─ Stored in STACK memory                                 │
│                                                             │
│  REFERENCE TYPES:                                           │
│  ├─ Object, Array, Function                                │
│  ├─ Date, RegExp, Error                                    │
│  ├─ Custom Classes                                          │
│  └─ Stored in HEAP memory                                  │
└─────────────────────────────────────────────────────────────┘
```

### Memory Storage Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    MEMORY STORAGE                          │
├─────────────────────────────────────────────────────────────┤
│  STACK (Primitive Types):                                  │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Variable: name = "John"                             │   │
│  │ Value: "John" (stored directly)                     │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Variable: age = 25                                  │   │
│  │ Value: 25 (stored directly)                         │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  HEAP (Reference Types):                                   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Variable: person = 0x1234                           │   │
│  │ Reference: 0x1234 (pointer to heap)                │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  HEAP Memory Location 0x1234:                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ { name: "John", age: 25 }                          │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: Primitive Types - Direct Value Storage
```javascript
// Primitive types store values directly
let name = "John";
let age = 25;
let isStudent = true;
let score = null;
let grade = undefined;

console.log("=== Primitive Types ===");
console.log("name:", name, "type:", typeof name);           // "John" string
console.log("age:", age, "type:", typeof age);             // 25 number
console.log("isStudent:", isStudent, "type:", typeof isStudent); // true boolean
console.log("score:", score, "type:", typeof score);        // null object (typeof bug)
console.log("grade:", grade, "type:", typeof grade);        // undefined undefined

// Primitive types are immutable
let originalString = "Hello";
let upperString = originalString.toUpperCase();
console.log("Original:", originalString);  // "Hello" (unchanged)
console.log("Upper:", upperString);        // "HELLO" (new string)
```

#### Example 2: Reference Types - Pointer Storage
```javascript
// Reference types store references (pointers) to heap memory
let person = { name: "John", age: 25 };
let numbers = [1, 2, 3, 4, 5];
let greet = function() { return "Hello!"; };

console.log("=== Reference Types ===");
console.log("person:", person, "type:", typeof person);     // object
console.log("numbers:", numbers, "type:", typeof numbers);  // object (arrays are objects)
console.log("greet:", greet, "type:", typeof greet);        // function

// Reference types are mutable
person.age = 26;
numbers.push(6);
console.log("Modified person:", person);  // { name: "John", age: 26 }
console.log("Modified numbers:", numbers); // [1, 2, 3, 4, 5, 6]
```

#### Example 3: Assignment and Copying Behavior
```javascript
console.log("=== Primitive Assignment ===");

// Primitive types: Copy by value
let originalNumber = 42;
let copiedNumber = originalNumber;

console.log("Original:", originalNumber);  // 42
console.log("Copied:", copiedNumber);      // 42

// Modifying the copy doesn't affect the original
copiedNumber = 100;
console.log("Original after copy change:", originalNumber);  // 42 (unchanged)
console.log("Copied after change:", copiedNumber);           // 100

console.log("=== Reference Assignment ===");

// Reference types: Copy by reference
let originalArray = [1, 2, 3];
let copiedArray = originalArray;

console.log("Original:", originalArray);  // [1, 2, 3]
console.log("Copied:", copiedArray);      // [1, 2, 3]

// Modifying the copy affects the original (same reference)
copiedArray.push(4);
console.log("Original after copy change:", originalArray);  // [1, 2, 3, 4] (changed!)
console.log("Copied after change:", copiedArray);           // [1, 2, 3, 4]
```

#### Example 4: Function Parameters - Pass by Value vs Reference
```javascript
function modifyPrimitive(value) {
    value = value * 2;
    console.log("Inside function:", value);
}

function modifyReference(obj) {
    obj.value = obj.value * 2;
    console.log("Inside function:", obj.value);
}

console.log("=== Primitive Parameter ===");
let num = 10;
console.log("Before function call:", num);  // 10
modifyPrimitive(num);                       // Inside function: 20
console.log("After function call:", num);   // 10 (unchanged)

console.log("=== Reference Parameter ===");
let numberObj = { value: 10 };
console.log("Before function call:", numberObj.value);  // 10
modifyReference(numberObj);                             // Inside function: 20
console.log("After function call:", numberObj.value);   // 20 (changed!)
```

#### Example 5: Comparison Behavior
```javascript
console.log("=== Primitive Comparison ===");

// Primitives are compared by value
let str1 = "hello";
let str2 = "hello";
let str3 = "world";

console.log("str1 === str2:", str1 === str2);  // true (same value)
console.log("str1 === str3:", str1 === str3);  // false (different value)

console.log("=== Reference Comparison ===");

// References are compared by reference (memory location)
let obj1 = { name: "John" };
let obj2 = { name: "John" };
let obj3 = obj1;

console.log("obj1 === obj2:", obj1 === obj2);  // false (different references)
console.log("obj1 === obj3:", obj1 === obj3);  // true (same reference)

// Even with same content, different objects are not equal
let arr1 = [1, 2, 3];
let arr2 = [1, 2, 3];
console.log("arr1 === arr2:", arr1 === arr2);  // false (different references)
```

#### Example 6: Common Pitfalls and Solutions
```javascript
console.log("=== Common Pitfall: Unexpected Mutations ===");

// Problem: Modifying shared references
let originalConfig = { theme: "dark", language: "en" };
let userConfig = originalConfig;

userConfig.theme = "light";
console.log("Original config:", originalConfig);  // { theme: "light", language: "en" }
console.log("User config:", userConfig);          // { theme: "light", language: "en" }

// Solution 1: Create a new object
let safeConfig = { ...originalConfig };  // Spread operator (shallow copy)
safeConfig.theme = "blue";
console.log("Original config:", originalConfig);  // { theme: "light", language: "en" }
console.log("Safe config:", safeConfig);          // { theme: "blue", language: "en" }

// Solution 2: Object.assign (shallow copy)
let anotherConfig = Object.assign({}, originalConfig);
anotherConfig.language = "es";
console.log("Original config:", originalConfig);      // { theme: "light", language: "en" }
console.log("Another config:", anotherConfig);        // { theme: "light", language: "es" }

console.log("=== Primitive Wrapper Objects ===");

// JavaScript automatically wraps primitives when calling methods
let primitiveString = "hello";
console.log("Type:", typeof primitiveString);           // "string"
console.log("Length:", primitiveString.length);         // 5 (auto-wrapped to String object)

// But primitives are not objects
console.log("Is object?", primitiveString instanceof String);  // false
console.log("Is string?", typeof primitiveString === "string"); // true
```

### Type Checking Methods

```
┌─────────────────────────────────────────────────────────────┐
│                    TYPE CHECKING METHODS                    │
├─────────────────────────────────────────────────────────────┤
│  Primitive Types:                                          │
│  ├─ typeof operator                                        │
│  ├─ instanceof (for wrapper objects)                       │
│  └─ Direct comparison                                      │
│                                                             │
│  Reference Types:                                           │
│  ├─ instanceof operator                                    │
│  ├─ Array.isArray()                                        │
│  ├─ Object.prototype.toString.call()                       │
│  └─ Constructor property                                    │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Primitive Types**: Stored directly in stack, immutable, copied by value
2. **Reference Types**: Stored in heap, referenced by pointer, copied by reference
3. **Memory Location**: Primitives in stack, references in heap
4. **Assignment**: Primitives copy value, references copy pointer
5. **Comparison**: Primitives compare by value, references by memory location
6. **Mutability**: Primitives are immutable, references are mutable

### Common Interview Questions

**Q: What's the difference between primitive and reference types in JavaScript?**
A: Primitive types (string, number, boolean, null, undefined, symbol, bigint) store values directly in stack memory and are immutable. Reference types (objects, arrays, functions) store references to heap memory and are mutable.

**Q: How does memory storage differ between primitives and references?**
A: Primitives are stored directly in the stack with their values, while references store pointers in the stack that point to the actual data in the heap memory.

**Q: What happens when you assign a primitive vs a reference type?**
A: Primitives are copied by value (new copy), while references are copied by reference (same memory location, so modifying one affects the other).

**Q: How do you check if a variable is a primitive or reference type?**
A: Use `typeof` for primitives, `instanceof` for reference types, or `Array.isArray()` specifically for arrays.

**Q: Why are primitives immutable in JavaScript?**
A: Primitives are immutable because they're stored directly in the stack. When you "modify" a primitive, you're actually creating a new value and reassigning the variable.

---

## 🔹 7. Deep Copy vs Shallow Copy

### What are Deep Copy and Shallow Copy?
When working with reference types (objects, arrays), copying can be done in two ways: **Shallow Copy** and **Deep Copy**. Understanding the difference is crucial for preventing unintended mutations and data corruption.

### Copy Types Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    COPY TYPES COMPARISON                     │
├─────────────────────────────────────────────────────────────┤
│  SHALLOW COPY:                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Original Object                                      │   │
│  │ ├─ name: "John"                                     │   │
│  │ ├─ age: 25                                          │   │
│  │ └─ address: [0x5678] ←───┐                         │   │
│  └─────────────────────────────────────────────────────┘   │
│                              │                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Shallow Copied Object                               │   │
│  │ ├─ name: "John" (copied)                           │   │
│  │ ├─ age: 25 (copied)                                │   │
│  │ └─ address: [0x5678] ←───┘                         │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  DEEP COPY:                                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Original Object                                      │   │
│  │ ├─ name: "John"                                     │   │
│  │ ├─ age: 25                                          │   │
│  │ └─ address: [0x5678]                                │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Deep Copied Object                                  │   │
│  │ ├─ name: "John" (copied)                           │   │
│  │ ├─ age: 25 (copied)                                │   │
│  │ └─ address: [0x9999] (new reference)               │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Shallow Copy Methods

#### 1. Spread Operator (...)
#### 2. Object.assign()
#### 3. Array.slice() (for arrays)
#### 4. Array.from() (for arrays)

### Deep Copy Methods

#### 1. JSON.parse(JSON.stringify())
#### 2. structuredClone() (modern browsers)
#### 3. Custom recursive function
#### 4. Third-party libraries (lodash.cloneDeep)

### Detailed Examples

#### Example 1: Shallow Copy - Basic Objects
```javascript
console.log("=== SHALLOW COPY - Basic Objects ===");

// Original object
const originalPerson = {
    name: "John",
    age: 25,
    hobbies: ["reading", "gaming"]
};

// Shallow copy using spread operator
const shallowCopy1 = { ...originalPerson };

// Shallow copy using Object.assign
const shallowCopy2 = Object.assign({}, originalPerson);

console.log("Original:", originalPerson);
console.log("Shallow Copy 1:", shallowCopy1);
console.log("Shallow Copy 2:", shallowCopy2);

// Modifying primitive properties (safe)
shallowCopy1.name = "Jane";
shallowCopy1.age = 30;

console.log("After modifying primitives:");
console.log("Original:", originalPerson);      // { name: "John", age: 25, hobbies: ["reading", "gaming"] }
console.log("Shallow Copy 1:", shallowCopy1); // { name: "Jane", age: 30, hobbies: ["reading", "gaming"] }

// Modifying nested reference properties (DANGEROUS!)
shallowCopy1.hobbies.push("swimming");

console.log("After modifying nested reference:");
console.log("Original:", originalPerson);      // { name: "John", age: 25, hobbies: ["reading", "gaming", "swimming"] }
console.log("Shallow Copy 1:", shallowCopy1); // { name: "Jane", age: 30, hobbies: ["reading", "gaming", "swimming"] }
```

#### Example 2: Shallow Copy - Arrays
```javascript
console.log("=== SHALLOW COPY - Arrays ===");

// Original array
const originalArray = [1, 2, { x: 10, y: 20 }, [3, 4]];

// Shallow copy methods for arrays
const shallowCopy1 = [...originalArray];           // Spread operator
const shallowCopy2 = originalArray.slice();        // slice() method
const shallowCopy3 = Array.from(originalArray);    // Array.from()

console.log("Original:", originalArray);
console.log("Shallow Copy 1:", shallowCopy1);

// Modifying primitive elements (safe)
shallowCopy1[0] = 100;
console.log("After modifying primitive:");
console.log("Original:", originalArray);  // [1, 2, { x: 10, y: 20 }, [3, 4]]
console.log("Shallow Copy 1:", shallowCopy1); // [100, 2, { x: 10, y: 20 }, [3, 4]]

// Modifying nested objects (DANGEROUS!)
shallowCopy1[2].x = 999;
shallowCopy1[3].push(5);

console.log("After modifying nested references:");
console.log("Original:", originalArray);  // [1, 2, { x: 999, y: 20 }, [3, 4, 5]]
console.log("Shallow Copy 1:", shallowCopy1); // [100, 2, { x: 999, y: 20 }, [3, 4, 5]]
```

#### Example 3: Deep Copy - JSON Method
```javascript
console.log("=== DEEP COPY - JSON Method ===");

// Original object with nested structures
const originalData = {
    name: "John",
    age: 25,
    address: {
        street: "123 Main St",
        city: "New York",
        coordinates: [40.7128, -74.0060]
    },
    hobbies: ["reading", "gaming"],
    metadata: {
        createdAt: new Date(),
        tags: ["user", "active"]
    }
};

// Deep copy using JSON method
const deepCopy = JSON.parse(JSON.stringify(originalData));

console.log("Original:", originalData);
console.log("Deep Copy:", deepCopy);

// Modifying nested properties (safe)
deepCopy.address.city = "Los Angeles";
deepCopy.hobbies.push("cooking");
deepCopy.address.coordinates[0] = 34.0522;

console.log("After modifying deep copy:");
console.log("Original:", originalData);  // Unchanged
console.log("Deep Copy:", deepCopy);     // Modified

// JSON method limitations
console.log("=== JSON Method Limitations ===");

const problematicObj = {
    func: function() { return "hello"; },
    undef: undefined,
    sym: Symbol("test"),
    date: new Date(),
    regex: /test/g,
    bigint: BigInt(123)
};

try {
    const jsonCopy = JSON.parse(JSON.stringify(problematicObj));
    console.log("JSON copy result:", jsonCopy);
    // Functions, undefined, symbols, dates, regex, bigint are lost or converted
} catch (error) {
    console.log("JSON copy error:", error.message);
}
```

#### Example 4: Deep Copy - structuredClone() Method
```javascript
console.log("=== DEEP COPY - structuredClone() ===");

// Check if structuredClone is available
if (typeof structuredClone === 'function') {
    const originalData = {
        name: "John",
        age: 25,
        address: {
            street: "123 Main St",
            city: "New York"
        },
        hobbies: ["reading", "gaming"],
        metadata: {
            createdAt: new Date(),
            tags: new Set(["user", "active"]),
            flags: new Map([["verified", true], ["premium", false]])
        }
    };

    // Deep copy using structuredClone (handles more types than JSON)
    const deepCopy = structuredClone(originalData);

    console.log("Original:", originalData);
    console.log("Deep Copy:", deepCopy);

    // Modifying nested properties (safe)
    deepCopy.address.city = "Los Angeles";
    deepCopy.hobbies.push("cooking");
    deepCopy.metadata.tags.add("vip");

    console.log("After modifying deep copy:");
    console.log("Original:", originalData);  // Unchanged
    console.log("Deep Copy:", deepCopy);     // Modified

    // structuredClone handles more types than JSON
    console.log("Date preserved:", deepCopy.metadata.createdAt instanceof Date); // true
    console.log("Set preserved:", deepCopy.metadata.tags instanceof Set);       // true
    console.log("Map preserved:", deepCopy.metadata.flags instanceof Map);     // true
} else {
    console.log("structuredClone not available in this environment");
}
```

#### Example 5: Custom Deep Copy Function
```javascript
console.log("=== DEEP COPY - Custom Function ===");

function deepClone(obj, hash = new WeakMap()) {
    // Handle null, undefined, and primitives
    if (obj === null || typeof obj !== 'object') {
        return obj;
    }

    // Handle Date objects
    if (obj instanceof Date) {
        return new Date(obj.getTime());
    }

    // Handle Array objects
    if (Array.isArray(obj)) {
        return obj.map(item => deepClone(item, hash));
    }

    // Handle RegExp objects
    if (obj instanceof RegExp) {
        return new RegExp(obj.source, obj.flags);
    }

    // Handle circular references
    if (hash.has(obj)) {
        return hash.get(obj);
    }

    // Handle plain objects
    const clonedObj = {};
    hash.set(obj, clonedObj);

    for (let key in obj) {
        if (obj.hasOwnProperty(key)) {
            clonedObj[key] = deepClone(obj[key], hash);
        }
    }

    return clonedObj;
}

// Test custom deep clone
const testObj = {
    name: "John",
    age: 25,
    address: {
        street: "123 Main St",
        city: "New York"
    },
    hobbies: ["reading", "gaming"],
    metadata: {
        createdAt: new Date(),
        tags: ["user", "active"]
    }
};

// Add circular reference
testObj.self = testObj;

const customDeepCopy = deepClone(testObj);

console.log("Original:", testObj);
console.log("Custom Deep Copy:", customDeepCopy);

// Verify it's a true deep copy
customDeepCopy.address.city = "Los Angeles";
customDeepCopy.hobbies.push("cooking");

console.log("After modifying custom deep copy:");
console.log("Original address city:", testObj.address.city);        // "New York"
console.log("Deep copy address city:", customDeepCopy.address.city); // "Los Angeles"
console.log("Original hobbies:", testObj.hobbies);                  // ["reading", "gaming"]
console.log("Deep copy hobbies:", customDeepCopy.hobbies);          // ["reading", "gaming", "cooking"]
```

#### Example 6: Performance Comparison and Best Practices
```javascript
console.log("=== PERFORMANCE COMPARISON ===");

// Large object for testing
const largeObject = {
    users: Array.from({ length: 1000 }, (_, i) => ({
        id: i,
        name: `User${i}`,
        profile: {
            email: `user${i}@example.com`,
            preferences: {
                theme: i % 2 === 0 ? 'dark' : 'light',
                notifications: i % 3 === 0
            }
        },
        data: Array.from({ length: 100 }, (_, j) => ({
            value: i * j,
            timestamp: new Date()
        }))
    }))
};

// Performance test function
function performanceTest(copyFunction, name) {
    const start = performance.now();
    const result = copyFunction(largeObject);
    const end = performance.now();
    console.log(`${name}: ${(end - start).toFixed(2)}ms`);
    return result;
}

// Test different copy methods
console.log("Testing copy performance with large object...");

const shallowCopy = performanceTest(() => ({ ...largeObject }), "Shallow Copy");
const jsonDeepCopy = performanceTest(() => JSON.parse(JSON.stringify(largeObject)), "JSON Deep Copy");

if (typeof structuredClone === 'function') {
    const structuredDeepCopy = performanceTest(() => structuredClone(largeObject), "structuredClone Deep Copy");
}

const customDeepCopy = performanceTest(() => deepClone(largeObject), "Custom Deep Copy");

console.log("=== BEST PRACTICES SUMMARY ===");
console.log("1. Use shallow copy when you only need to copy top-level properties");
console.log("2. Use JSON method for simple objects (no functions, dates, etc.)");
console.log("3. Use structuredClone for modern browsers (handles more types)");
console.log("4. Use custom function for complex requirements or circular references");
console.log("5. Consider performance implications for large objects");
```

### Copy Method Comparison Table

```
┌─────────────────────────────────────────────────────────────┐
│                    COPY METHOD COMPARISON                   │
├─────────────────────────────────────────────────────────────┤
│  Method              │ Shallow │ Deep │ Performance │ Types │
├──────────────────────┼─────────┼──────┼─────────────┼───────┤
│  Spread (...)        │   ✅    │  ❌   │    Fast     │ All   │
│  Object.assign()     │   ✅    │  ❌   │    Fast     │ All   │
│  Array.slice()       │   ✅    │  ❌   │    Fast     │ Arrays│
│  JSON method         │   ❌    │  ✅   │   Medium    │ Simple│
│  structuredClone()   │   ❌    │  ✅   │   Medium    │ Most  │
│  Custom function     │   ❌    │  ✅   │    Slow     │ All   │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Shallow Copy**: Only copies top-level properties, nested references are shared
2. **Deep Copy**: Creates completely independent copies of all nested structures
3. **JSON Method**: Simple but limited (loses functions, dates, etc.)
4. **structuredClone()**: Modern, handles most types, but not available everywhere
5. **Custom Function**: Most flexible but slower, can handle circular references
6. **Performance**: Shallow copy is fastest, deep copy is slower but safer

### Common Interview Questions

**Q: What's the difference between shallow copy and deep copy?**
A: Shallow copy only copies top-level properties, while deep copy creates completely independent copies of all nested structures, including nested objects and arrays.

**Q: What are the limitations of using JSON.parse(JSON.stringify()) for deep copying?**
A: It loses functions, undefined values, symbols, dates become strings, regex becomes objects, and it can't handle circular references.

**Q: When would you use shallow copy vs deep copy?**
A: Use shallow copy when you only need to copy top-level properties and won't modify nested structures. Use deep copy when you need completely independent copies or will modify nested structures.

**Q: How does the spread operator (...) work for copying objects?**
A: The spread operator creates a shallow copy by copying all enumerable properties from the source object to a new object, but nested references are still shared.

**Q: What is structuredClone() and when should you use it?**
A: structuredClone() is a modern browser API that creates deep copies and handles more types than JSON methods, but it's not available in older browsers.

---

## 🔹 8. Pass by Value vs Pass by Reference

### What is Pass by Value vs Pass by Reference?
Understanding how JavaScript passes data to functions is crucial for writing correct code. JavaScript uses **Pass by Value** for all data types, but the behavior can be confusing because of how reference types work.

### Important Note: JavaScript is Always Pass by Value
JavaScript **always** passes by value, but when you pass a reference type, you're passing the value of the reference (memory address), not the actual object.

### Memory Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                PASS BY VALUE EXPLANATION                    │
├─────────────────────────────────────────────────────────────┤
│  PRIMITIVE TYPES:                                           │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Global Scope                                        │   │
│  │ let number = 42                                     │   │
│  │ Value: 42 (stored directly)                         │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼ (copy value)                   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Function Parameter                                   │   │
│  │ function test(value) {                              │   │
│  │   value = 100; // Changes local copy                │   │
│  │ }                                                    │   │
│  │ Value: 42 (independent copy)                        │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  REFERENCE TYPES:                                           │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Global Scope                                        │   │
│  │ let obj = { x: 10 }                                 │   │
│  │ Value: 0x1234 (reference to heap)                  │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼ (copy reference value)         │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Function Parameter                                   │   │
│  │ function test(obj) {                                │   │
│  │   obj.x = 20; // Modifies shared object             │   │
│  │ }                                                    │   │
│  │ Value: 0x1234 (same reference)                      │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  HEAP Memory Location 0x1234:                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ { x: 10 } → { x: 20 } (shared object)              │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: Primitive Types - True Pass by Value
```javascript
console.log("=== PRIMITIVE TYPES - Pass by Value ===");

function modifyPrimitive(value) {
    console.log("Inside function - before modification:", value);
    value = value * 2;  // Modifying local copy
    console.log("Inside function - after modification:", value);
}

let number = 10;
console.log("Before function call:", number);  // 10

modifyPrimitive(number);
// Inside function - before modification: 10
// Inside function - after modification: 20

console.log("After function call:", number);   // 10 (unchanged!)

// What happened:
// 1. number (10) was copied to the function parameter
// 2. Function modified its local copy (20)
// 3. Original variable remains unchanged (10)
```

#### Example 2: Reference Types - Pass by Value of Reference
```javascript
console.log("=== REFERENCE TYPES - Pass by Value of Reference ===");

function modifyObject(obj) {
    console.log("Inside function - before modification:", obj);
    
    // Modifying the shared object (not the reference)
    obj.name = "Modified";
    obj.age = 999;
    
    console.log("Inside function - after modification:", obj);
    
    // Attempting to reassign the reference (won't affect original)
    obj = { name: "New Object", age: 0 };
    console.log("Inside function - after reassignment:", obj);
}

let person = { name: "John", age: 25 };
console.log("Before function call:", person);  // { name: "John", age: 25 }

modifyObject(person);
// Inside function - before modification: { name: "John", age: 25 }
// Inside function - after modification: { name: "Modified", age: 999 }
// Inside function - after reassignment: { name: "New Object", age: 0 }

console.log("After function call:", person);   // { name: "Modified", age: 999 }

// What happened:
// 1. Reference to person object was copied to function parameter
// 2. Function modified the shared object (name: "Modified", age: 999)
// 3. Function tried to reassign parameter (obj = new object) - this doesn't affect original
// 4. Original person still points to the modified object
```

#### Example 3: Arrays - Pass by Value of Reference
```javascript
console.log("=== ARRAYS - Pass by Value of Reference ===");

function modifyArray(arr) {
    console.log("Inside function - before modification:", arr);
    
    // Modifying the shared array
    arr.push(4);
    arr[0] = 100;
    
    console.log("Inside function - after modification:", arr);
    
    // Attempting to reassign the reference
    arr = [999, 888, 777];
    console.log("Inside function - after reassignment:", arr);
}

let numbers = [1, 2, 3];
console.log("Before function call:", numbers);  // [1, 2, 3]

modifyArray(numbers);
// Inside function - before modification: [1, 2, 3]
// Inside function - after modification: [100, 2, 3, 4]
// Inside function - after reassignment: [999, 888, 777]

console.log("After function call:", numbers);   // [100, 2, 3, 4]

// What happened:
// 1. Reference to numbers array was copied to function parameter
// 2. Function modified the shared array ([100, 2, 3, 4])
// 3. Function tried to reassign parameter (arr = new array) - doesn't affect original
// 4. Original numbers still points to the modified array
```

#### Example 4: Functions - Pass by Value of Reference
```javascript
console.log("=== FUNCTIONS - Pass by Value of Reference ===");

function modifyFunction(func) {
    console.log("Inside function - before modification:", func);
    
    // We can call the passed function
    console.log("Calling passed function:", func());
    
    // But we can't reassign the reference to affect the original
    func = function() { return "Modified function"; };
    console.log("After reassignment:", func());
}

let originalFunction = function() { return "Original function"; };
console.log("Before function call:", originalFunction());  // "Original function"

modifyFunction(originalFunction);
// Inside function - before modification: [Function: originalFunction]
// Calling passed function: Original function
// After reassignment: Modified function

console.log("After function call:", originalFunction());   // "Original function"

// What happened:
// 1. Reference to originalFunction was copied to function parameter
// 2. Function could call the passed function
// 3. Function tried to reassign parameter - doesn't affect original
// 4. Original function remains unchanged
```

#### Example 5: Demonstrating the Difference with Object Reassignment
```javascript
console.log("=== OBJECT REASSIGNMENT DEMONSTRATION ===");

function reassignObject(obj) {
    console.log("Inside function - original obj:", obj);
    
    // This creates a new object and assigns it to the local parameter
    obj = { name: "New Object", value: 999 };
    
    console.log("Inside function - reassigned obj:", obj);
}

let originalObj = { name: "Original Object", value: 100 };
console.log("Before function call:", originalObj);  // { name: "Original Object", value: 100 }

reassignObject(originalObj);
// Inside function - original obj: { name: "Original Object", value: 100 }
// Inside function - reassigned obj: { name: "New Object", value: 999 }

console.log("After function call:", originalObj);   // { name: "Original Object", value: 100 }

// What happened:
// 1. Reference to originalObj was copied to function parameter
// 2. Function created a new object and assigned it to local parameter
// 3. This doesn't affect the original reference
// 4. Original object remains unchanged
```

#### Example 6: Practical Implications and Common Mistakes
```javascript
console.log("=== PRACTICAL IMPLICATIONS ===");

// Common mistake: Expecting objects to be passed by reference
function updateUserProfile(user) {
    // This modifies the shared object
    user.lastLogin = new Date();
    
    // This doesn't affect the original reference
    user = { name: "New User", lastLogin: new Date() };
}

let currentUser = { name: "John Doe", email: "john@example.com" };
console.log("Before update:", currentUser);

updateUserProfile(currentUser);
console.log("After update:", currentUser);  // lastLogin added, but name unchanged

// Correct way to create a new user object
function createNewUser(user) {
    // Return a new object instead of trying to reassign
    return {
        ...user,
        lastLogin: new Date(),
        isNew: true
    };
}

let newUser = createNewUser(currentUser);
console.log("New user:", newUser);        // Completely new object
console.log("Current user:", currentUser); // Original unchanged
```

#### Example 7: Advanced Scenarios - Nested Objects and Arrays
```javascript
console.log("=== NESTED OBJECTS AND ARRAYS ===");

function modifyNestedStructure(data) {
    console.log("Inside function - before modification:", JSON.stringify(data, null, 2));
    
    // Modifying nested properties (affects shared object)
    data.user.profile.age = 999;
    data.settings.theme = "dark";
    data.tags.push("modified");
    
    console.log("Inside function - after modification:", JSON.stringify(data, null, 2));
    
    // Attempting to reassign nested references
    data.user = { name: "New User", profile: { age: 0 } };
    data.settings = { theme: "light" };
    data.tags = ["new"];
    
    console.log("Inside function - after reassignment:", JSON.stringify(data, null, 2));
}

let complexData = {
    user: {
        name: "John",
        profile: { age: 25 }
    },
    settings: {
        theme: "light"
    },
    tags: ["user", "active"]
};

console.log("Before function call:", JSON.stringify(complexData, null, 2));

modifyNestedStructure(complexData);

console.log("After function call:", JSON.stringify(complexData, null, 2));

// What happened:
// 1. Nested modifications (age: 999, theme: "dark", tags.push) affected shared object
// 2. Nested reassignments (data.user = new object) only affected local parameter
// 3. Original complexData still has the modified nested properties
```

### Key Points to Remember for Interviews

1. **JavaScript is Always Pass by Value**: Never pass by reference
2. **Primitive Types**: Values are copied, modifications don't affect original
3. **Reference Types**: References are copied, but point to same object
4. **Object Modifications**: Modify shared object through copied reference
5. **Object Reassignment**: Reassigning parameter doesn't affect original reference
6. **Immutability**: To avoid mutations, create new objects/arrays

### Common Interview Questions

**Q: Does JavaScript pass by value or pass by reference?**
A: JavaScript always passes by value. However, when you pass a reference type, you're passing the value of the reference (memory address), which can make it seem like pass by reference.

**Q: What happens when you pass an object to a function?**
A: The reference to the object is copied to the function parameter. The function can modify the shared object, but reassigning the parameter won't affect the original reference.

**Q: How can you prevent a function from modifying the original object?**
A: Create a deep copy of the object before passing it, or use Object.freeze() to make the object immutable (though this only prevents top-level modifications).

**Q: What's the difference between modifying an object property and reassigning an object parameter?**
A: Modifying properties (obj.prop = value) affects the shared object. Reassigning the parameter (obj = newObject) only affects the local parameter, not the original reference.

**Q: How do primitive types behave differently from reference types when passed to functions?**
A: Primitives are copied by value, so modifications inside the function don't affect the original. References are copied by value of reference, so modifications to the shared object affect the original.

---

## 🔹 9. Type Coercion

### What is Type Coercion?
Type coercion is JavaScript's automatic conversion of values from one data type to another. It happens implicitly when operators expect certain types or when functions require specific types. Understanding type coercion is crucial for avoiding unexpected bugs and writing predictable code.

### Types of Type Coercion

```
┌─────────────────────────────────────────────────────────────┐
│                    TYPE COERCION TYPES                      │
├─────────────────────────────────────────────────────────────┤
│  1. IMPLICIT COERCION (Automatic)                          │
│     ├─ Arithmetic operators (+, -, *, /, %)               │
│     ├─ Comparison operators (==, !=, <, >, <=, >=)        │
│     ├─ Logical operators (&&, ||, !)                       │
│     ├─ Template literals                                   │
│     └─ if statements                                       │
│                                                             │
│  2. EXPLICIT COERCION (Manual)                             │
│     ├─ String(), Number(), Boolean()                       │
│     ├─ parseInt(), parseFloat()                            │
│     ├─ toString(), valueOf()                               │
│     └─ Unary operators (+, -, !)                           │
└─────────────────────────────────────────────────────────────┘
```

### Coercion Rules Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    COERCION PRIORITY                        │
├─────────────────────────────────────────────────────────────┤
│  STRING COERCION (highest priority):                       │
│  ├─ If either operand is string → convert both to string  │
│  └─ Example: "5" + 3 = "53"                               │
│                                                             │
│  NUMBER COERCION:                                           │
│  ├─ If no strings → convert both to numbers               │
│  └─ Example: "5" - 3 = 2                                  │
│                                                             │
│  BOOLEAN COERCION:                                         │
│  ├─ In logical contexts → convert to boolean              │
│  └─ Example: if (0) → false                               │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: String Coercion (Highest Priority)
```javascript
console.log("=== STRING COERCION ===");

// Addition operator (+) with strings
console.log("5" + 3);           // "53" (string concatenation)
console.log(5 + "3");           // "53" (string concatenation)
console.log("5" + "3");         // "53" (string concatenation)
console.log(5 + 3);             // 8 (number addition)

// String coercion in mixed operations
console.log("Hello" + 42);      // "Hello42"
console.log("Result: " + 10);   // "Result: 10"
console.log(10 + " is a number"); // "10 is a number"

// Template literals (explicit string coercion)
console.log(`The answer is ${42}`); // "The answer is 42"
console.log(`Sum: ${5 + 3}`);       // "Sum: 8"

// String coercion with objects
console.log("Object: " + {});       // "Object: [object Object]"
console.log("Array: " + [1, 2, 3]); // "Array: 1,2,3"
console.log("Function: " + function(){}); // "Function: function(){}"
```

#### Example 2: Number Coercion
```javascript
console.log("=== NUMBER COERCION ===");

// Subtraction, multiplication, division (no string coercion)
console.log("5" - 3);           // 2 (number subtraction)
console.log("5" * 3);           // 15 (number multiplication)
console.log("10" / 2);          // 5 (number division)
console.log("10" % 3);          // 1 (number modulo)

// Mixed number operations
console.log("5" - "3");         // 2 (both converted to numbers)
console.log("10" * "2");        // 20 (both converted to numbers)
console.log("15" / "3");        // 5 (both converted to numbers)

// Number coercion with invalid numbers
console.log("abc" - 5);         // NaN (can't convert "abc" to number)
console.log("" - 5);            // -5 (empty string converts to 0)
console.log(" " - 5);           // -5 (space string converts to 0)
console.log("5abc" - 3);        // NaN (can't convert "5abc" to number)

// Number coercion with booleans
console.log(true - false);      // 1 (true=1, false=0)
console.log(true + true);       // 2 (both converted to numbers)
console.log(false * 5);         // 0 (false=0)
```

#### Example 3: Boolean Coercion (Falsy vs Truthy)
```javascript
console.log("=== BOOLEAN COERCION ===");

// Falsy values (convert to false)
console.log("Falsy values:");
console.log(Boolean(false));        // false
console.log(Boolean(0));            // false
console.log(Boolean(-0));           // false
console.log(Boolean(0n));           // false (BigInt)
console.log(Boolean(""));           // false
console.log(Boolean(null));         // false
console.log(Boolean(undefined));    // false
console.log(Boolean(NaN));          // false

// Truthy values (convert to true)
console.log("Truthy values:");
console.log(Boolean(true));         // true
console.log(Boolean(42));           // true
console.log(Boolean(-42));          // true
console.log(Boolean("hello"));      // true
console.log(Boolean("0"));          // true (non-empty string)
console.log(Boolean("false"));      // true (non-empty string)
console.log(Boolean([]));           // true (empty array)
console.log(Boolean({}));           // true (empty object)
console.log(Boolean(function(){})); // true (function)

// Boolean coercion in logical contexts
console.log("=== LOGICAL CONTEXTS ===");

// if statements
if (0) console.log("This won't print");           // 0 is falsy
if (1) console.log("This will print");            // 1 is truthy
if ("") console.log("This won't print");          // Empty string is falsy
if ("hello") console.log("This will print");      // Non-empty string is truthy
if ([]) console.log("This will print");           // Empty array is truthy
if ({}) console.log("This will print");           // Empty object is truthy

// Logical operators
console.log("Logical AND (&&):");
console.log(0 && "hello");         // 0 (first falsy value)
console.log("hello" && "world");   // "world" (last truthy value)
console.log("" && "hello");        // "" (first falsy value)

console.log("Logical OR (||):");
console.log(0 || "hello");         // "hello" (first truthy value)
console.log("hello" || "world");   // "hello" (first truthy value)
console.log("" || "world");        // "world" (first truthy value)
```

#### Example 4: Comparison Operators and Coercion
```javascript
console.log("=== COMPARISON OPERATORS ===");

// Loose equality (==) - allows type coercion
console.log("Loose equality (==):");
console.log(5 == "5");             // true (string "5" coerced to number 5)
console.log(0 == false);           // true (false coerced to 0)
console.log(1 == true);            // true (true coerced to 1)
console.log("" == 0);              // true (empty string coerced to 0)
console.log("" == false);          // true (both coerced to 0)
console.log(null == undefined);    // true (special case)
console.log(null == 0);            // false (null doesn't coerce to 0)
console.log(undefined == 0);       // false (undefined doesn't coerce to 0)

// Strict equality (===) - no type coercion
console.log("Strict equality (===):");
console.log(5 === "5");            // false (different types)
console.log(0 === false);          // false (different types)
console.log(1 === true);           // false (different types)
console.log("" === 0);             // false (different types)
console.log(null === undefined);   // false (different types)

// Relational operators (<, >, <=, >=)
console.log("Relational operators:");
console.log("5" < 10);             // true ("5" coerced to 5)
console.log("10" > 5);             // true ("10" coerced to 10)
console.log("abc" < "def");        // true (lexicographic comparison)
console.log("10" < "2");           // true (lexicographic comparison!)
console.log("10" < 2);             // false ("10" coerced to 10, 10 < 2 is false)
```

#### Example 5: Complex Coercion Scenarios
```javascript
console.log("=== COMPLEX COERCION SCENARIOS ===");

// Array coercion
console.log("Array coercion:");
console.log([] + []);              // "" (empty arrays convert to empty strings)
console.log([] + {});              // "[object Object]" (array to "", object to "[object Object]")
console.log({} + []);              // "[object Object]" (same as above)
console.log({} + {});              // "[object Object][object Object]"

// Function coercion
console.log("Function coercion:");
console.log(function(){} + "");     // "function(){}" (function converted to string)
console.log(function(){} + 1);      // "function(){}1" (function to string, then concatenation)

// Object coercion in arithmetic
console.log("Object arithmetic:");
console.log({} - []);              // NaN (can't subtract strings)
console.log({} * []);              // NaN (can't multiply strings)
console.log({} / []);              // NaN (can't divide strings)

// Mixed type operations
console.log("Mixed operations:");
console.log(1 + "2" + "3");        // "123" (left to right: 1+"2"="12", "12"+"3"="123")
console.log(1 + +"2" + "3");       // "33" (left to right: 1+(+"2")=3, 3+"3"="33")
console.log(1 + -"2" + "3");       // "23" (left to right: 1+(-"2")=-1, -1+"3"="-13")
console.log(+"1" + +"2" + "3");    // "33" (left to right: +"1"=1, +"2"=2, 1+2=3, 3+"3"="33")
```

#### Example 6: Explicit Type Coercion
```javascript
console.log("=== EXPLICIT TYPE COERCION ===");

// String conversion
console.log("String conversion:");
console.log(String(42));           // "42"
console.log(String(true));         // "true"
console.log(String(false));        // "false"
console.log(String(null));         // "null"
console.log(String(undefined));    // "undefined"
console.log(String({}));           // "[object Object]"
console.log(String([1, 2, 3]));   // "1,2,3"

// Number conversion
console.log("Number conversion:");
console.log(Number("42"));         // 42
console.log(Number("42.5"));       // 42.5
console.log(Number("42abc"));      // NaN
console.log(Number(""));           // 0
console.log(Number(" "));          // 0
console.log(Number(true));         // 1
console.log(Number(false));        // 0
console.log(Number(null));         // 0
console.log(Number(undefined));    // NaN

// Boolean conversion
console.log("Boolean conversion:");
console.log(Boolean(0));           // false
console.log(Boolean(1));           // true
console.log(Boolean(""));          // false
console.log(Boolean("hello"));     // true
console.log(Boolean([]));          // true
console.log(Boolean({}));          // true
console.log(Boolean(null));        // false
console.log(Boolean(undefined));   // false

// Unary operators
console.log("Unary operators:");
console.log(+"42");                // 42 (unary plus)
console.log(+"42.5");              // 42.5
console.log(+"abc");               // NaN
console.log(+"0");                 // 0
console.log(+"true");              // NaN
console.log(+"false");             // NaN

console.log(-"42");                // -42 (unary minus)
console.log(-"42.5");              // -42.5
console.log(-"abc");               // NaN

console.log(!"hello");             // false (logical NOT)
console.log(!!"hello");            // true (double logical NOT)
console.log(!!0);                  // false
console.log(!!1);                  // true
```

#### Example 7: Common Coercion Pitfalls and Best Practices
```javascript
console.log("=== COMMON PITFALLS ===");

// Pitfall 1: String concatenation vs addition
console.log("Pitfall 1 - String vs Addition:");
let a = "5";
let b = 10;
console.log(a + b);                // "510" (string concatenation)
console.log(+a + b);               // 15 (number addition)
console.log(parseInt(a) + b);      // 15 (explicit conversion)

// Pitfall 2: Comparison with different types
console.log("Pitfall 2 - Loose vs Strict Comparison:");
let value = "0";
console.log(value == false);       // true (both coerced to 0)
console.log(value === false);      // false (no coercion)
console.log(value == 0);           // true (string coerced to number)
console.log(value === 0);          // false (no coercion)

// Pitfall 3: Array comparison
console.log("Pitfall 3 - Array Comparison:");
let arr1 = [1, 2, 3];
let arr2 = [1, 2, 3];
console.log(arr1 == arr2);         // false (different references)
console.log(arr1 == "1,2,3");      // true (array coerced to string)
console.log(arr1 === "1,2,3");     // false (no coercion)

// Best practices
console.log("=== BEST PRACTICES ===");

// 1. Use strict equality (===) and strict inequality (!==)
console.log("Use === instead of ==");
console.log(5 === "5");            // false (clear and predictable)
console.log(5 == "5");             // true (unexpected)

// 2. Explicit type conversion when needed
console.log("Explicit conversion:");
let userInput = "42";
let number = parseInt(userInput, 10);  // Explicit base-10 conversion
console.log(number, typeof number);    // 42 "number"

// 3. Use template literals for string concatenation
console.log("Template literals:");
let name = "John";
let age = 25;
console.log(`Name: ${name}, Age: ${age}`); // Clear and readable

// 4. Check for NaN properly
console.log("NaN checking:");
let result = parseInt("abc");
console.log(result);                    // NaN
console.log(isNaN(result));             // true
console.log(Number.isNaN(result));      // true (more reliable)
```

### Type Coercion Summary Table

```
┌─────────────────────────────────────────────────────────────┐
│                    TYPE COERCION SUMMARY                    │
├─────────────────────────────────────────────────────────────┤
│  Operator │ String │ Number │ Boolean │ Result              │
├───────────┼────────┼────────┼─────────┼─────────────────────┤
│     +     │   ✅    │   ❌    │   ❌     │ String concatenation │
│     -     │   ❌    │   ✅    │   ❌     │ Number subtraction   │
│     *     │   ❌    │   ✅    │   ❌     │ Number multiplication │
│     /     │   ❌    │   ✅    │   ❌     │ Number division      │
│     %     │   ❌    │   ✅    │   ❌     │ Number modulo        │
│     ==    │   ✅    │   ✅    │   ✅     │ Loose equality       │
│     ===   │   ❌    │   ❌    │   ❌     │ Strict equality      │
│     &&    │   ❌    │   ❌    │   ✅     │ Logical AND          │
│     ||    │   ❌    │   ❌    │   ✅     │ Logical OR           │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **String Coercion Priority**: Addition (+) with strings triggers string concatenation
2. **Number Coercion**: Other arithmetic operators convert to numbers
3. **Boolean Coercion**: Falsy values (0, "", null, undefined, NaN, false)
4. **Loose vs Strict**: == allows coercion, === prevents it
5. **Predictable Code**: Use explicit conversion and strict equality
6. **Common Pitfalls**: Array comparison, string vs number addition

### Common Interview Questions

**Q: What is type coercion in JavaScript?**
A: Type coercion is JavaScript's automatic conversion of values from one data type to another. It happens implicitly when operators expect certain types or when functions require specific types.

**Q: What's the difference between == and ===?**
A: == (loose equality) allows type coercion and compares values after conversion, while === (strict equality) requires both value and type to be the same without any coercion.

**Q: Why does "5" + 3 equal "53" but "5" - 3 equals 2?**
A: The + operator with strings triggers string concatenation (coercing both to strings), while - operator always converts operands to numbers for arithmetic.

**Q: What are falsy values in JavaScript?**
A: Falsy values are: false, 0, -0, 0n (BigInt), "" (empty string), null, undefined, and NaN. All other values are truthy.

**Q: How can you avoid unexpected type coercion?**
A: Use strict equality (===), explicit type conversion functions (Number(), String(), Boolean()), and be aware of operator precedence and coercion rules.

---

## 🔹 10. The `this` Keyword

### What is the `this` Keyword?
The `this` keyword in JavaScript refers to the context in which a function is executed. It's a dynamic binding that can change depending on how the function is called, not where it's defined. Understanding `this` is crucial for object-oriented programming and avoiding common pitfalls.

### `this` Binding Rules Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    THIS BINDING RULES                       │
├─────────────────────────────────────────────────────────────┤
│  1. DEFAULT BINDING (lowest priority)                      │
│     ├─ Function called in global scope                     │
│     ├─ this = global object (window/global)               │
│     └─ 'use strict' → this = undefined                    │
│                                                             │
│  2. IMPLICIT BINDING                                        │
│     ├─ Function called as object method                    │
│     ├─ this = object that owns the method                 │
│     └─ Method call: obj.method()                           │
│                                                             │
│  3. EXPLICIT BINDING                                        │
│     ├─ call(), apply(), bind()                             │
│     ├─ this = explicitly specified object                  │
│     └─ Forced binding                                       │
│                                                             │
│  4. NEW BINDING (highest priority)                         │
│     ├─ Function called with new keyword                    │
│     ├─ this = newly created object                         │
│     └─ Constructor function                                 │
│                                                             │
│  5. ARROW FUNCTIONS                                         │
│     ├─ this = lexical scope (where defined)               │
│     ├─ Cannot be changed with call/apply/bind             │
│     └─ Always inherits from enclosing scope                │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: Default Binding (Global Context)
```javascript
console.log("=== DEFAULT BINDING ===");

// In non-strict mode
function globalFunction() {
    console.log("this in global function:", this);
    console.log("this === window:", this === window);
    console.log("this === global:", this === global);
}

// In strict mode
function strictFunction() {
    'use strict';
    console.log("this in strict function:", this);
    console.log("this === undefined:", this === undefined);
}

// Global function calls
console.log("Calling globalFunction():");
globalFunction();
// this in global function: Window {...} (or global in Node.js)
// this === window: true (or false in Node.js)
// this === global: false (or true in Node.js)

console.log("Calling strictFunction():");
strictFunction();
// this in strict function: undefined
// this === undefined: true

// Default binding in callbacks
setTimeout(function() {
    console.log("this in setTimeout callback:", this);
    // In browser: this = window
    // In Node.js: this = Timeout object
}, 100);
```

#### Example 2: Implicit Binding (Object Methods)
```javascript
console.log("=== IMPLICIT BINDING ===");

const user = {
    name: "John",
    age: 25,
    
    // Method with implicit binding
    greet: function() {
        console.log(`Hello, I'm ${this.name} and I'm ${this.age} years old`);
        console.log("this object:", this);
    },
    
    // Method that calls another method
    introduce: function() {
        console.log("Introducing myself...");
        this.greet(); // this refers to user object
    },
    
    // Nested object with method
    profile: {
        title: "Developer",
        showTitle: function() {
            console.log(`My title is: ${this.title}`);
            console.log("this in nested method:", this);
        }
    }
};

// Method calls - implicit binding
console.log("Calling user.greet():");
user.greet(); // this = user object

console.log("Calling user.introduce():");
user.introduce(); // this = user object

console.log("Calling user.profile.showTitle():");
user.profile.showTitle(); // this = profile object, not user!

// Common pitfall: losing implicit binding
console.log("=== LOSING IMPLICIT BINDING ===");

const greetFunction = user.greet;
console.log("Calling greetFunction():");
greetFunction(); // this = global object (default binding)

// Solution: bind the function
const boundGreet = user.greet.bind(user);
console.log("Calling boundGreet():");
boundGreet(); // this = user object
```

#### Example 3: Explicit Binding (call, apply, bind)
```javascript
console.log("=== EXPLICIT BINDING ===");

function introduce(greeting, punctuation) {
    console.log(`${greeting}, I'm ${this.name} and I'm ${this.age} years old${punctuation}`);
    console.log("this object:", this);
}

const person1 = { name: "Alice", age: 30 };
const person2 = { name: "Bob", age: 35 };

// Using call() - arguments passed individually
console.log("Using call():");
introduce.call(person1, "Hi there", "!");
introduce.call(person2, "Hello", ".");

// Using apply() - arguments passed as array
console.log("Using apply():");
introduce.apply(person1, ["Hey", "?"]);
introduce.apply(person2, ["Good morning", "!"]);

// Using bind() - creates new function with bound this
console.log("Using bind():");
const aliceIntro = introduce.bind(person1);
const bobIntro = introduce.bind(person2);

aliceIntro("Hi", "!");
bobIntro("Hello", ".");

// bind() with partial arguments
const aliceGreeting = introduce.bind(person1, "Hi there");
aliceGreeting("!"); // Only need to pass punctuation now

// bind() with specific context but call later
const boundFunction = introduce.bind(person1, "Hello", "!");
setTimeout(boundFunction, 1000); // this will still be person1
```

#### Example 4: New Binding (Constructor Functions)
```javascript
console.log("=== NEW BINDING ===");

// Constructor function
function Person(name, age) {
    console.log("Constructor called with this:", this);
    
    // this refers to the newly created object
    this.name = name;
    this.age = age;
    
    console.log("After setting properties, this:", this);
}

// Creating new instances
console.log("Creating person1:");
const person1 = new Person("Alice", 30);
console.log("person1 instance:", person1);

console.log("Creating person2:");
const person2 = new Person("Bob", 35);
console.log("person2 instance:", person2);

// Constructor with methods
function Car(brand, model) {
    this.brand = brand;
    this.model = model;
    
    this.getInfo = function() {
        return `${this.brand} ${this.model}`;
    };
    
    this.start = function() {
        console.log(`Starting ${this.getInfo()}`);
    };
}

const myCar = new Car("Toyota", "Camry");
console.log("Car info:", myCar.getInfo());
myCar.start();

// What happens with new:
// 1. Creates new empty object
// 2. Sets this to point to new object
// 3. Executes function body
// 4. Returns new object (unless function returns something else)
```

#### Example 5: Arrow Functions and Lexical `this`
```javascript
console.log("=== ARROW FUNCTIONS AND LEXICAL THIS ===");

const user = {
    name: "John",
    age: 25,
    
    // Regular method
    regularGreet: function() {
        console.log(`Regular: Hello, I'm ${this.name}`);
        
        // Nested function loses this binding
        setTimeout(function() {
            console.log(`Nested function: Hello, I'm ${this.name}`);
            // this = global object (default binding)
        }, 100);
    },
    
    // Arrow method (inherits this from enclosing scope)
    arrowGreet: function() {
        console.log(`Arrow: Hello, I'm ${this.name}`);
        
        // Arrow function preserves this binding
        setTimeout(() => {
            console.log(`Arrow function: Hello, I'm ${this.name}`);
            // this = user object (lexical binding)
        }, 100);
    },
    
    // Arrow method (different behavior)
    arrowMethod: () => {
        console.log(`Arrow method: Hello, I'm ${this.name}`);
        // this = global object (lexical binding from global scope)
    }
};

console.log("Testing regular method:");
user.regularGreet();

console.log("Testing arrow method:");
user.arrowGreet();

console.log("Testing arrow method (different behavior):");
user.arrowMethod();

// Arrow functions in constructors (don't work as expected)
function BadConstructor() {
    this.value = 42;
    
    // Arrow function as method
    this.getValue = () => {
        return this.value;
    };
}

const badInstance = new BadConstructor();
console.log("Bad constructor value:", badInstance.getValue());

// Arrow functions cannot be used as constructors
try {
    const ArrowConstructor = () => {
        this.value = 42;
    };
    const instance = new ArrowConstructor(); // TypeError
} catch (error) {
    console.log("Arrow constructor error:", error.message);
}
```

#### Example 6: Complex `this` Scenarios
```javascript
console.log("=== COMPLEX THIS SCENARIOS ===");

// Scenario 1: Method passed as callback
const calculator = {
    value: 0,
    
    add: function(num) {
        this.value += num;
        console.log(`Added ${num}, new value: ${this.value}`);
    },
    
    multiply: function(num) {
        this.value *= num;
        console.log(`Multiplied by ${num}, new value: ${this.value}`);
    }
};

// Problem: losing this binding in callbacks
console.log("Problem with callbacks:");
const numbers = [1, 2, 3];

// This won't work as expected
numbers.forEach(calculator.add); // this = global object

// Solutions:
console.log("Solution 1 - bind():");
numbers.forEach(calculator.add.bind(calculator));

console.log("Solution 2 - arrow function:");
numbers.forEach(num => calculator.add(num));

console.log("Solution 3 - call/apply:");
numbers.forEach(function(num) {
    calculator.add.call(calculator, num);
});

// Scenario 2: this in event handlers
console.log("=== EVENT HANDLER THIS ===");

// Simulating DOM event
const button = {
    text: "Click me",
    click: function() {
        console.log(`Button "${this.text}" was clicked`);
    }
};

// Regular function call
button.click(); // this = button

// Simulating event handler (loses this binding)
const clickHandler = button.click;
clickHandler(); // this = global object

// Solution with bind
const boundClickHandler = button.click.bind(button);
boundClickHandler(); // this = button
```

#### Example 7: `this` in Classes and Modern JavaScript
```javascript
console.log("=== THIS IN CLASSES ===");

class User {
    constructor(name, age) {
        this.name = name;
        this.age = age;
        
        // Binding methods in constructor to preserve this
        this.greet = this.greet.bind(this);
        
        // Alternative: using arrow function for automatic binding
        this.introduce = () => {
            console.log(`I'm ${this.name}, ${this.age} years old`);
        };
    }
    
    // Regular method (needs binding)
    greet() {
        console.log(`Hello, I'm ${this.name}`);
    }
    
    // Static method (this refers to class, not instance)
    static create(name, age) {
        return new User(name, age);
    }
}

const user = new User("John", 25);

// Method calls work correctly
user.greet();      // this = user instance
user.introduce();  // this = user instance

// But if we extract the method
const greetFunction = user.greet;
greetFunction();   // this = undefined (in strict mode)

// Static method
const newUser = User.create("Jane", 30);
console.log("New user:", newUser);

// Modern solution: class fields with arrow functions
class ModernUser {
    name;
    age;
    
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    // Arrow function method (automatically bound)
    greet = () => {
        console.log(`Hello, I'm ${this.name}`);
    }
    
    // Regular method
    introduce() {
        console.log(`I'm ${this.name}, ${this.age} years old`);
    }
}

const modernUser = new ModernUser("Bob", 40);
const extractedGreet = modernUser.greet;
extractedGreet(); // this = modernUser instance (arrow function preserves this)
```

### `this` Binding Priority Summary

```
┌─────────────────────────────────────────────────────────────┐
│                    THIS BINDING PRIORITY                    │
├─────────────────────────────────────────────────────────────┤
│  1. NEW BINDING (highest)                                  │
│     ├─ new Constructor()                                   │
│     └─ this = new object                                  │
│                                                             │
│  2. EXPLICIT BINDING                                        │
│     ├─ call(), apply(), bind()                             │
│     └─ this = specified object                             │
│                                                             │
│  3. IMPLICIT BINDING                                        │
│     ├─ obj.method()                                         │
│     └─ this = owning object                                │
│                                                             │
│  4. DEFAULT BINDING (lowest)                                │
│     ├─ function()                                           │
│     └─ this = global/undefined                             │
│                                                             │
│  ARROW FUNCTIONS:                                           │
│  ├─ Always inherit from enclosing scope                    │
│  └─ Cannot be changed with explicit binding                │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Dynamic Binding**: `this` is determined by how a function is called, not where it's defined
2. **Binding Priority**: new > explicit > implicit > default
3. **Arrow Functions**: Always inherit `this` from enclosing scope, cannot be changed
4. **Common Pitfalls**: Losing `this` binding in callbacks, event handlers
5. **Solutions**: bind(), arrow functions, call/apply, or preserving context
6. **Strict Mode**: Default binding becomes `undefined` instead of global object

### Common Interview Questions

**Q: What is the `this` keyword in JavaScript?**
A: `this` is a dynamic binding that refers to the context in which a function is executed. It's determined by how the function is called, not where it's defined.

**Q: What are the different ways `this` can be bound?**
A: `this` can be bound through: 1) new binding (constructor functions), 2) explicit binding (call/apply/bind), 3) implicit binding (object methods), 4) default binding (global scope), and 5) lexical binding (arrow functions).

**Q: How do arrow functions handle `this`?**
A: Arrow functions inherit `this` from their enclosing scope (lexical binding) and cannot be changed with call/apply/bind. They're useful for preserving `this` context in callbacks.

**Q: What happens when you lose `this` binding in a callback?**
A: When a method is passed as a callback, it loses its implicit `this` binding and falls back to default binding (global object or undefined in strict mode). Solutions include bind(), arrow functions, or preserving the context.

**Q: How does `this` work in constructor functions?**
A: When a function is called with `new`, `this` is automatically bound to the newly created object. The constructor function can then set properties and methods on this new object.

---

## 🔹 11. Prototype & Prototypal Inheritance

### What is Prototypal Inheritance?
JavaScript uses prototypal inheritance, where objects can inherit properties and methods from other objects through a prototype chain. Unlike classical inheritance, JavaScript objects have a prototype object that they can inherit from, creating a chain of inheritance.

### Prototype Chain Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    PROTOTYPE CHAIN                          │
├─────────────────────────────────────────────────────────────┤
│  Object Instance                                           │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ person = { name: "John", age: 25 }                 │   │
│  │ ├─ name: "John"                                    │   │
│  │ ├─ age: 25                                         │   │
│  │ └─ __proto__ → Person.prototype                     │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  Person.prototype                                         │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Person.prototype = {                               │   │
│  │   constructor: Person,                             │   │
│  │   greet: function() { ... },                       │   │
│  │   introduce: function() { ... }                    │   │
│  │   __proto__ → Object.prototype                     │   │
│  │ }                                                   │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  Object.prototype                                         │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Object.prototype = {                               │   │
│  │   constructor: Object,                              │   │
│  │   toString: function() { ... },                     │   │
│  │   hasOwnProperty: function() { ... },               │   │
│  │   __proto__ → null                                  │   │
│  │ }                                                   │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│                          null                              │
└─────────────────────────────────────────────────────────────┘
```

### Key Concepts

- **`__proto__`**: Points to the prototype object (deprecated, use Object.getPrototypeOf())
- **`prototype`**: Property of constructor functions that becomes the prototype of instances
- **Prototype Chain**: The chain of objects that JavaScript follows to find properties
- **Classes**: Syntactic sugar over prototypal inheritance

### Detailed Examples

#### Example 1: Basic Prototype Chain
```javascript
console.log("=== BASIC PROTOTYPE CHAIN ===");

// Constructor function
function Person(name, age) {
    this.name = name;
    this.age = age;
}

// Adding methods to prototype
Person.prototype.greet = function() {
    return `Hello, I'm ${this.name}`;
};

Person.prototype.introduce = function() {
    return `I'm ${this.name} and I'm ${this.age} years old`;
};

// Creating instances
const person1 = new Person("John", 25);
const person2 = new Person("Jane", 30);

console.log("Person 1:", person1.name, person1.age);
console.log("Person 1 greet:", person1.greet());
console.log("Person 1 introduce:", person1.introduce());

console.log("Person 2:", person2.name, person2.age);
console.log("Person 2 greet:", person2.greet());

// Checking prototype chain
console.log("=== PROTOTYPE CHAIN INSPECTION ===");
console.log("person1.__proto__ === Person.prototype:", person1.__proto__ === Person.prototype);
console.log("Person.prototype.constructor === Person:", Person.prototype.constructor === Person);
console.log("Object.getPrototypeOf(person1) === Person.prototype:", Object.getPrototypeOf(person1) === Person.prototype);

// Prototype chain traversal
console.log("Prototype chain:");
console.log("1. person1:", person1);
console.log("2. Person.prototype:", Person.prototype);
console.log("3. Object.prototype:", Object.prototype);
console.log("4. null:", null);
```

#### Example 2: Property Lookup in Prototype Chain
```javascript
console.log("=== PROPERTY LOOKUP IN PROTOTYPE CHAIN ===");

function Animal(name) {
    this.name = name;
}

Animal.prototype.species = "Unknown";
Animal.prototype.makeSound = function() {
    return "Some sound";
};

const dog = new Animal("Buddy");

console.log("Direct property:", dog.name);                    // "Buddy" (own property)
console.log("Prototype property:", dog.species);              // "Unknown" (inherited)
console.log("Prototype method:", dog.makeSound());            // "Some sound" (inherited)

// Property lookup order
console.log("=== PROPERTY LOOKUP ORDER ===");
console.log("1. dog.hasOwnProperty('name'):", dog.hasOwnProperty('name'));           // true
console.log("2. dog.hasOwnProperty('species'):", dog.hasOwnProperty('species'));     // false
console.log("3. dog.hasOwnProperty('makeSound'):", dog.hasOwnProperty('makeSound')); // false

// Checking if property exists (anywhere in chain)
console.log("4. 'name' in dog:", 'name' in dog);             // true
console.log("5. 'species' in dog:", 'species' in dog);       // true
console.log("6. 'makeSound' in dog:", 'makeSound' in dog);   // true
console.log("7. 'nonExistent' in dog:", 'nonExistent' in dog); // false

// Shadowing (hiding prototype properties)
console.log("=== PROPERTY SHADOWING ===");
dog.species = "Canine";  // Creates own property, shadows prototype
console.log("After shadowing:");
console.log("dog.species:", dog.species);                    // "Canine" (own property)
console.log("dog.hasOwnProperty('species'):", dog.hasOwnProperty('species')); // true
console.log("Animal.prototype.species:", Animal.prototype.species); // "Unknown" (unchanged)

// Deleting shadowed property reveals prototype property
delete dog.species;
console.log("After deleting shadowed property:");
console.log("dog.species:", dog.species);                    // "Unknown" (prototype property again)
console.log("dog.hasOwnProperty('species'):", dog.hasOwnProperty('species')); // false
```

#### Example 3: Inheritance and Method Overriding
```javascript
console.log("=== INHERITANCE AND METHOD OVERRIDING ===");

// Base constructor
function Vehicle(brand, model) {
    this.brand = brand;
    this.model = model;
}

Vehicle.prototype.getInfo = function() {
    return `${this.brand} ${this.model}`;
};

Vehicle.prototype.start = function() {
    return "Vehicle starting...";
};

// Derived constructor
function Car(brand, model, year) {
    // Call parent constructor
    Vehicle.call(this, brand, model);
    this.year = year;
}

// Set up inheritance
Car.prototype = Object.create(Vehicle.prototype);
Car.prototype.constructor = Car;  // Fix constructor reference

// Override method
Car.prototype.start = function() {
    return `Car ${this.getInfo()} (${this.year}) starting...`;
};

// Add new method
Car.prototype.getYear = function() {
    return this.year;
};

const myCar = new Car("Toyota", "Camry", 2020);
console.log("Car info:", myCar.getInfo());      // Inherited from Vehicle
console.log("Car start:", myCar.start());       // Overridden method
console.log("Car year:", myCar.getYear());      // New method

// Check inheritance
console.log("=== INHERITANCE VERIFICATION ===");
console.log("myCar instanceof Car:", myCar instanceof Car);           // true
console.log("myCar instanceof Vehicle:", myCar instanceof Vehicle);   // true
console.log("myCar instanceof Object:", myCar instanceof Object);     // true

console.log("Prototype chain:");
console.log("1. Car.prototype:", Car.prototype);
console.log("2. Vehicle.prototype:", Vehicle.prototype);
console.log("3. Object.prototype:", Object.prototype);
```

#### Example 4: Modern Class Syntax (Syntactic Sugar)
```javascript
console.log("=== MODERN CLASS SYNTAX ===");

// ES6 Class (syntactic sugar over prototypes)
class Animal {
    constructor(name) {
        this.name = name;
    }
    
    // Instance method (goes to prototype)
    speak() {
        return `${this.name} makes a sound`;
    }
    
    // Static method (goes to class, not prototype)
    static create(name) {
        return new Animal(name);
    }
    
    // Getter (goes to prototype)
    get description() {
        return `Animal named ${this.name}`;
    }
}

// Inheritance with extends
class Dog extends Animal {
    constructor(name, breed) {
        super(name);  // Call parent constructor
        this.breed = breed;
    }
    
    // Override method
    speak() {
        return `${this.name} barks`;
    }
    
    // New method
    fetch() {
        return `${this.name} fetches the ball`;
    }
}

const dog = new Dog("Buddy", "Golden Retriever");
console.log("Dog speak:", dog.speak());         // "Buddy barks"
console.log("Dog fetch:", dog.fetch());         // "Buddy fetches the ball"
console.log("Dog description:", dog.description); // "Animal named Buddy"

// Static method
const newAnimal = Animal.create("Generic");
console.log("Static method result:", newAnimal.speak());

// Check that classes are just syntactic sugar
console.log("=== CLASSES ARE PROTOTYPES ===");
console.log("typeof Animal:", typeof Animal);                           // "function"
console.log("Animal.prototype.speak:", Animal.prototype.speak);         // function
console.log("dog.__proto__ === Dog.prototype:", dog.__proto__ === Dog.prototype); // true
console.log("Dog.prototype.__proto__ === Animal.prototype:", Dog.prototype.__proto__ === Animal.prototype); // true
```

#### Example 5: Object.create() and Pure Prototypal Inheritance
```javascript
console.log("=== OBJECT.CREATE() AND PURE PROTOTYPAL INHERITANCE ===");

// Base object (prototype)
const animalPrototype = {
    init(name) {
        this.name = name;
        return this;
    },
    
    speak() {
        return `${this.name} makes a sound`;
    },
    
    getInfo() {
        return `Animal: ${this.name}`;
    }
};

// Create objects using Object.create()
const dog = Object.create(animalPrototype);
dog.init("Buddy");
dog.breed = "Golden Retriever";
dog.speak = function() {
    return `${this.name} barks`;
};

const cat = Object.create(animalPrototype);
cat.init("Whiskers");
cat.speak = function() {
    return `${this.name} meows`;
};

console.log("Dog:", dog.getInfo(), "-", dog.speak());
console.log("Cat:", cat.getInfo(), "-", cat.speak());

// Inheritance chain
console.log("=== INHERITANCE CHAIN ===");
console.log("dog.__proto__ === animalPrototype:", dog.__proto__ === animalPrototype);
console.log("cat.__proto__ === animalPrototype:", cat.__proto__ === animalPrototype);

// Creating specialized prototypes
const dogPrototype = Object.create(animalPrototype);
dogPrototype.breed = "Unknown";
dogPrototype.getInfo = function() {
    return `Dog: ${this.name}, Breed: ${this.breed}`;
};

const myDog = Object.create(dogPrototype);
myDog.init("Max");
myDog.breed = "Labrador";

console.log("My dog:", myDog.getInfo(), "-", myDog.speak());

// Multiple inheritance simulation
const flyingPrototype = {
    fly() {
        return `${this.name} is flying`;
    }
};

const birdPrototype = Object.create(animalPrototype);
Object.assign(birdPrototype, flyingPrototype);

const eagle = Object.create(birdPrototype);
eagle.init("Freedom");

console.log("Eagle:", eagle.getInfo(), "-", eagle.speak(), "-", eagle.fly());
```

#### Example 6: Prototype Pollution and Safety
```javascript
console.log("=== PROTOTYPE POLLUTION AND SAFETY ===");

// Dangerous: Modifying Object.prototype
console.log("=== DANGEROUS: MODIFYING OBJECT.PROTOTYPE ===");

// This is dangerous and should be avoided
Object.prototype.dangerousMethod = function() {
    return "This affects ALL objects!";
};

const safeObject = {};
console.log("Safe object has dangerous method:", safeObject.dangerousMethod());

// Even arrays and strings are affected
const arr = [1, 2, 3];
console.log("Array has dangerous method:", arr.dangerousMethod());

const str = "hello";
console.log("String has dangerous method:", str.dangerousMethod());

// Safe alternatives
console.log("=== SAFE ALTERNATIVES ===");

// 1. Use Object.create(null) for pure objects
const pureObject = Object.create(null);
pureObject.name = "Pure";
console.log("Pure object:", pureObject);
console.log("Pure object has toString:", 'toString' in pureObject); // false

// 2. Use hasOwnProperty safely
const obj = { name: "Test" };
console.log("Safe hasOwnProperty check:", Object.prototype.hasOwnProperty.call(obj, 'name'));

// 3. Use Object.getOwnPropertyDescriptor
const descriptor = Object.getOwnPropertyDescriptor(obj, 'name');
console.log("Property descriptor:", descriptor);

// 4. Check if property is enumerable
console.log("Is enumerable:", descriptor.enumerable);

// 5. Use Object.defineProperty for controlled property creation
const controlledObj = {};
Object.defineProperty(controlledObj, 'readOnly', {
    value: 42,
    writable: false,
    enumerable: true,
    configurable: false
});

console.log("Controlled object:", controlledObj);
controlledObj.readOnly = 100; // Won't work
console.log("After attempt to change:", controlledObj.readOnly); // Still 42
```

#### Example 7: Advanced Prototype Patterns
```javascript
console.log("=== ADVANCED PROTOTYPE PATTERNS ===");

// Mixin pattern
console.log("=== MIXIN PATTERN ===");

const eventMixin = {
    on(event, handler) {
        if (!this._eventHandlers) this._eventHandlers = {};
        if (!this._eventHandlers[event]) this._eventHandlers[event] = [];
        this._eventHandlers[event].push(handler);
    },
    
    off(event, handler) {
        if (!this._eventHandlers || !this._eventHandlers[event]) return;
        this._eventHandlers[event] = this._eventHandlers[event].filter(h => h !== handler);
    },
    
    trigger(event, ...args) {
        if (!this._eventHandlers || !this._eventHandlers[event]) return;
        this._eventHandlers[event].forEach(handler => handler.apply(this, args));
    }
};

// Apply mixin to object
const user = { name: "John" };
Object.assign(user, eventMixin);

user.on('login', function() {
    console.log(`${this.name} logged in`);
});

user.trigger('login');

// Factory pattern with prototypes
console.log("=== FACTORY PATTERN ===");

function createUser(type, name) {
    const user = Object.create(userPrototype);
    user.name = name;
    user.type = type;
    return user;
}

const userPrototype = {
    getInfo() {
        return `${this.type} user: ${this.name}`;
    },
    
    greet() {
        return `Hello, I'm ${this.name}`;
    }
};

const admin = createUser('admin', 'Alice');
const regular = createUser('regular', 'Bob');

console.log("Admin:", admin.getInfo());
console.log("Regular:", regular.getInfo());

// Composition over inheritance
console.log("=== COMPOSITION OVER INHERITANCE ===");

const speaker = {
    speak(text) {
        return text;
    }
};

const mover = {
    move(direction) {
        return `Moving ${direction}`;
    }
};

const robot = {
    name: "R2D2",
    ...speaker,
    ...mover
};

console.log("Robot speaks:", robot.speak("Beep boop"));
console.log("Robot moves:", robot.move("forward"));
```

### Prototype vs Class Comparison

```
┌─────────────────────────────────────────────────────────────┐
│                PROTOTYPE VS CLASS COMPARISON               │
├─────────────────────────────────────────────────────────────┤
│  Prototypes:                                               │
│  ├─ More flexible and dynamic                             │
│  ├─ Can modify at runtime                                 │
│  ├─ Memory efficient (shared methods)                     │
│  ├─ More complex syntax                                   │
│  └─ Harder to understand for beginners                    │
│                                                             │
│  Classes:                                                   │
│  ├─ Familiar syntax for OOP developers                    │
│  ├─ Built-in inheritance with extends                     │
│  ├─ Private fields and methods (ES2022+)                  │
│  ├─ Less flexible (can't modify at runtime)               │
│  └─ Still uses prototypes under the hood                  │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Prototypal Nature**: JavaScript uses prototypal inheritance, not classical
2. **Prototype Chain**: Objects inherit from their prototype, creating a chain
3. **Property Lookup**: JavaScript searches up the prototype chain for properties
4. **Classes are Sugar**: ES6 classes are syntactic sugar over prototypes
5. **Object.create()**: Modern way to create objects with specific prototypes
6. **Constructor Functions**: Functions used with `new` to create objects
7. **Prototype Pollution**: Be careful when modifying built-in prototypes

### Common Interview Questions

**Q: What is prototypal inheritance in JavaScript?**
A: Prototypal inheritance is JavaScript's mechanism where objects can inherit properties and methods from other objects through a prototype chain. Each object has a prototype object, and JavaScript follows this chain to find properties.

**Q: How do you create inheritance in JavaScript?**
A: You can create inheritance using constructor functions with prototypes, Object.create(), or ES6 classes with extends. All methods ultimately use the prototype chain under the hood.

**Q: What's the difference between `__proto__` and `prototype`?**
A: `prototype` is a property of constructor functions that becomes the prototype of instances. `__proto__` is a property of instances that points to their prototype (deprecated, use Object.getPrototypeOf()).

**Q: How do ES6 classes relate to prototypes?**
A: ES6 classes are syntactic sugar over prototypal inheritance. They provide a cleaner syntax but still use prototypes under the hood. The class keyword creates a constructor function with methods added to its prototype.

**Q: What is the prototype chain and how does it work?**
A: The prototype chain is a series of linked objects that JavaScript follows to find properties. When accessing a property, JavaScript first checks the object itself, then its prototype, then the prototype's prototype, continuing until it reaches Object.prototype or null.

---

## 🔹 12. Event Loop & Concurrency

### What is the Event Loop?
The Event Loop is JavaScript's mechanism for handling asynchronous operations. It's what allows JavaScript to be single-threaded while still handling non-blocking operations like I/O, timers, and network requests. Understanding the Event Loop is crucial for writing efficient, non-blocking code.

### Event Loop Architecture Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    EVENT LOOP ARCHITECTURE                  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐   │
│  │                CALL STACK                            │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ functionC() - Line 15                       │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ functionB() - Line 10                       │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ functionA() - Line 5                        │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                WEB APIs                             │   │
│  │  ├─ setTimeout/setInterval                          │   │
│  │  ├─ DOM events (click, load, etc.)                 │   │
│  │  ├─ fetch/XHR requests                             │   │
│  │  ├─ File API                                       │   │
│  │  └─ Other browser APIs                             │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              CALLBACK QUEUE                         │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ setTimeout callback                          │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ DOM event callback                          │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ XHR callback                               │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  ┌─────────────────────────────────────────────────────┐   │
│  │             MICROTASK QUEUE                         │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │ Promise .then() callback                     │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────┘   │   │
│  │  │ queueMicrotask() callback                   │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  EVENT LOOP:                                                │
│  1. Check if call stack is empty                          │
│  2. If empty, check microtask queue                       │
│  3. If microtask queue has items, execute all             │
│  4. Check callback queue                                  │
│  5. Move one callback to call stack                       │
│  6. Repeat                                                │
└─────────────────────────────────────────────────────────────┘
```

### Event Loop Execution Order

```
┌─────────────────────────────────────────────────────────────┐
│                EXECUTION ORDER PRIORITY                    │
├─────────────────────────────────────────────────────────────┤
│  1. SYNCHRONOUS CODE (Call Stack)                          │
│     ├─ Functions, loops, calculations                      │
│     └─ Blocks until complete                              │
│                                                             │
│  2. MICROTASKS (Microtask Queue)                          │
│     ├─ Promise .then() callbacks                           │
│     ├─ queueMicrotask() callbacks                          │
│     ├─ process.nextTick() (Node.js)                        │
│     └─ Execute ALL before next phase                       │
│                                                             │
│  3. MACROTASKS (Callback Queue)                            │
│     ├─ setTimeout/setInterval callbacks                    │
│     ├─ DOM event callbacks                                 │
│     ├─ fetch/XHR callbacks                                 │
│     └─ Execute ONE at a time                               │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Examples

#### Example 1: Basic Event Loop Demonstration
```javascript
console.log("=== BASIC EVENT LOOP DEMONSTRATION ===");

console.log("1. Start of script");

setTimeout(() => {
    console.log("2. setTimeout callback");
}, 0);

Promise.resolve().then(() => {
    console.log("3. Promise .then() callback");
});

console.log("4. End of script");

// Output order:
// 1. Start of script
// 4. End of script
// 3. Promise .then() callback
// 2. setTimeout callback

// Why this order?
// 1. Synchronous code executes first (1, 4)
// 2. Microtasks execute next (3)
// 3. Macrotasks execute last (2)
```

#### Example 2: Microtasks vs Macrotasks Priority
```javascript
console.log("=== MICROTASKS VS MACROTASKS PRIORITY ===");

console.log("Script start");

setTimeout(() => {
    console.log("setTimeout 1");
    
    Promise.resolve().then(() => {
        console.log("Promise inside setTimeout 1");
    });
}, 0);

setTimeout(() => {
    console.log("setTimeout 2");
    
    Promise.resolve().then(() => {
        console.log("Promise inside setTimeout 2");
    });
}, 0);

Promise.resolve().then(() => {
    console.log("Promise 1");
    
    setTimeout(() => {
        console.log("setTimeout inside Promise 1");
    }, 0);
});

Promise.resolve().then(() => {
    console.log("Promise 2");
    
    setTimeout(() => {
        console.log("setTimeout inside Promise 2");
    }, 0);
});

console.log("Script end");

// Output order:
// Script start
// Script end
// Promise 1
// Promise 2
// setTimeout 1
// Promise inside setTimeout 1
// setTimeout 2
// Promise inside setTimeout 2
// setTimeout inside Promise 1
// setTimeout inside Promise 2

// Explanation:
// 1. All synchronous code executes
// 2. All microtasks (Promises) execute
// 3. One macrotask (setTimeout) executes
// 4. Its microtasks execute
// 5. Next macrotask executes
// 6. Its microtasks execute
// 7. Remaining macrotasks execute
```

#### Example 3: setTimeout with 0 Delay
```javascript
console.log("=== SETTIMEOUT WITH 0 DELAY ===");

console.log("1. Start");

setTimeout(() => {
    console.log("2. setTimeout with 0 delay");
}, 0);

setTimeout(() => {
    console.log("3. setTimeout with 100ms delay");
}, 100);

setTimeout(() => {
    console.log("4. setTimeout with 0 delay (second)");
}, 0);

console.log("5. End");

// Output order:
// 1. Start
// 5. End
// 2. setTimeout with 0 delay
// 4. setTimeout with 0 delay (second)
// 3. setTimeout with 100ms delay

// Why setTimeout(0) doesn't execute immediately:
// 1. setTimeout(0) still goes to Web APIs
// 2. Even with 0 delay, it waits for current execution to complete
// 3. Then it goes to callback queue
// 4. Event loop processes it after microtasks
```

#### Example 4: Promise Chain and Microtasks
```javascript
console.log("=== PROMISE CHAIN AND MICROTASKS ===");

console.log("Script start");

Promise.resolve()
    .then(() => {
        console.log("Promise 1");
        return Promise.resolve("Nested Promise");
    })
    .then((value) => {
        console.log("Promise 2:", value);
        return "Final value";
    })
    .then((value) => {
        console.log("Promise 3:", value);
    });

setTimeout(() => {
    console.log("setTimeout callback");
}, 0);

console.log("Script end");

// Output order:
// Script start
// Script end
// Promise 1
// Promise 2: Nested Promise
// Promise 3: Final value
// setTimeout callback

// Why all promises execute before setTimeout:
// 1. Promises are microtasks
// 2. Microtasks execute completely before next macrotask
// 3. setTimeout is a macrotask
// 4. Event loop processes all microtasks first
```

#### Example 5: Complex Async Scenarios
```javascript
console.log("=== COMPLEX ASYNC SCENARIOS ===");

async function asyncFunction() {
    console.log("2. Async function start");
    
    await Promise.resolve();
    console.log("4. After await");
    
    return "Async result";
}

console.log("1. Script start");

setTimeout(() => {
    console.log("8. setTimeout callback");
}, 0);

Promise.resolve().then(() => {
    console.log("5. Promise .then() 1");
    
    Promise.resolve().then(() => {
        console.log("6. Nested Promise .then()");
    });
});

asyncFunction().then((result) => {
    console.log("7. Async function result:", result);
});

console.log("3. Script end");

// Output order:
// 1. Script start
// 2. Async function start
// 3. Script end
// 4. After await
// 5. Promise .then() 1
// 6. Nested Promise .then()
// 7. Async function result: Async result
// 8. setTimeout callback

// Explanation:
// 1. Synchronous code executes (1, 2, 3)
// 2. await creates a microtask (4)
// 3. Promise .then() executes (5)
// 4. Nested Promise executes (6)
// 5. Async function .then() executes (7)
// 6. setTimeout callback executes (8)
```

#### Example 6: Event Loop in Node.js vs Browser
```javascript
console.log("=== NODE.JS VS BROWSER EVENT LOOP ===");

// Node.js specific: process.nextTick
if (typeof process !== 'undefined') {
    console.log("Running in Node.js");
    
    console.log("1. Start");
    
    process.nextTick(() => {
        console.log("2. process.nextTick");
    });
    
    Promise.resolve().then(() => {
        console.log("3. Promise .then()");
    });
    
    setImmediate(() => {
        console.log("4. setImmediate");
    });
    
    setTimeout(() => {
        console.log("5. setTimeout");
    }, 0);
    
    console.log("6. End");
    
    // Node.js execution order:
    // 1. Start
    // 6. End
    // 2. process.nextTick (highest priority microtask)
    // 3. Promise .then() (regular microtask)
    // 4. setImmediate (check phase)
    // 5. setTimeout (timers phase)
} else {
    console.log("Running in browser");
    
    console.log("1. Start");
    
    Promise.resolve().then(() => {
        console.log("2. Promise .then()");
    });
    
    setTimeout(() => {
        console.log("3. setTimeout");
    }, 0);
    
    console.log("4. End");
    
    // Browser execution order:
    // 1. Start
    // 4. End
    // 2. Promise .then()
    // 3. setTimeout
}
```

#### Example 7: Blocking the Event Loop
```javascript
console.log("=== BLOCKING THE EVENT LOOP ===");

console.log("1. Start");

// This blocks the event loop
function blockingOperation() {
    console.log("2. Starting blocking operation");
    const start = Date.now();
    
    // Simulate heavy computation
    while (Date.now() - start < 1000) {
        // Block for 1 second
    }
    
    console.log("3. Blocking operation complete");
}

// This won't execute until blocking operation completes
setTimeout(() => {
    console.log("4. setTimeout callback");
}, 0);

Promise.resolve().then(() => {
    console.log("5. Promise .then()");
});

blockingOperation();

console.log("6. End");

// Output order:
// 1. Start
// 2. Starting blocking operation
// 3. Blocking operation complete
// 6. End
// 5. Promise .then()
// 4. setTimeout callback

// Why setTimeout doesn't execute during blocking:
// 1. Event loop is blocked during while loop
// 2. setTimeout callback waits in callback queue
// 3. Only after blocking operation completes does event loop continue
// 4. Microtasks execute first, then macrotasks

// Solution: Use Web Workers or break up heavy operations
console.log("=== NON-BLOCKING SOLUTION ===");

function nonBlockingOperation() {
    console.log("Starting non-blocking operation");
    
    return new Promise((resolve) => {
        setTimeout(() => {
            console.log("Non-blocking operation complete");
            resolve();
        }, 1000);
    });
}

async function runNonBlocking() {
    console.log("1. Start non-blocking");
    
    setTimeout(() => {
        console.log("2. setTimeout during operation");
    }, 500);
    
    await nonBlockingOperation();
    
    console.log("3. End non-blocking");
}

runNonBlocking();
```

### Event Loop Phases (Node.js)

```
┌─────────────────────────────────────────────────────────────┐
│                NODE.JS EVENT LOOP PHASES                   │
├─────────────────────────────────────────────────────────────┤
│  1. TIMERS PHASE                                           │
│     ├─ setTimeout, setInterval callbacks                   │
│     └─ Executes when timer threshold is reached            │
│                                                             │
│  2. PENDING CALLBACKS PHASE                                │
│     ├─ Deferred I/O callbacks                              │
│     └─ TCP errors, etc.                                    │
│                                                             │
│  3. IDLE, PREPARE PHASE                                    │
│     ├─ Internal use only                                   │
│     └─ Not used by developers                              │
│                                                             │
│  4. POLL PHASE                                             │
│     ├─ New I/O events                                      │
│     ├─ I/O callbacks                                       │
│     └─ Most time spent here                                │
│                                                             │
│  5. CHECK PHASE                                            │
│     ├─ setImmediate callbacks                              │
│     └─ Executes after poll phase                           │
│                                                             │
│  6. CLOSE CALLBACKS PHASE                                  │
│     ├─ close event callbacks                               │
│     └─ socket.on('close')                                  │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Single Threaded**: JavaScript has one main thread (call stack)
2. **Non-Blocking**: Uses event loop to handle async operations
3. **Microtask Priority**: Promises execute before setTimeout
4. **Event Loop Order**: Synchronous → Microtasks → Macrotasks
5. **Web APIs**: Handle async operations outside main thread
6. **Callback Queues**: Separate queues for microtasks and macrotasks
7. **Node.js vs Browser**: Different event loop implementations

### Common Interview Questions

**Q: What is the Event Loop in JavaScript?**
A: The Event Loop is JavaScript's mechanism for handling asynchronous operations. It continuously checks if the call stack is empty and then processes callbacks from the microtask and callback queues, allowing JavaScript to be single-threaded while handling non-blocking operations.

**Q: What's the difference between microtasks and macrotasks?**
A: Microtasks (Promises, queueMicrotask) execute immediately after the current execution context and before the next macrotask. Macrotasks (setTimeout, DOM events) execute one at a time after all microtasks are complete.

**Q: Why does setTimeout(0) not execute immediately?**
A: setTimeout(0) still goes through the Web APIs and callback queue. Even with 0 delay, it waits for the current execution context to complete and all microtasks to finish before executing.

**Q: How does the Event Loop handle blocking operations?**
A: Blocking operations prevent the Event Loop from processing other callbacks. The main thread is blocked until the operation completes, which is why heavy computations should be broken up or moved to Web Workers.

**Q: What's the execution order of async operations?**
A: The order is: 1) Synchronous code, 2) All microtasks (Promises), 3) One macrotask (setTimeout, etc.), 4) Any new microtasks from that macrotask, 5) Next macrotask, and so on.

---

## 🔹 13. Garbage Collection

### What is Garbage Collection?
Garbage Collection (GC) is JavaScript's automatic memory management system. It automatically frees up memory that is no longer being used by the program, preventing memory leaks and ensuring efficient memory usage. Understanding how garbage collection works is crucial for writing memory-efficient code.

### Memory Lifecycle Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    MEMORY LIFECYCLE                         │
├─────────────────────────────────────────────────────────────┤
│  1. ALLOCATION PHASE                                       │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ JavaScript engine allocates memory                  │   │
│  │ ├─ Variables, objects, functions                    │   │
│  │ ├─ Stack memory (primitives)                        │   │
│  │ └─ Heap memory (objects, arrays)                    │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  2. USAGE PHASE                                           │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Program uses allocated memory                        │   │
│  │ ├─ Read/write operations                            │   │
│  │ ├─ Function calls                                   │   │
│  │ └─ Object manipulation                              │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  3. RELEASE PHASE                                         │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Garbage collector frees unused memory               │   │
│  │ ├─ Automatic detection                              │   │
│  │ ├─ Memory reclamation                               │   │
│  │ └─ Heap compaction                                  │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### Garbage Collection Algorithms

#### 1. Reference Counting
#### 2. Mark and Sweep
#### 3. Generational Collection
#### 4. Incremental Marking

### Detailed Examples

#### Example 1: Basic Memory Allocation and Release
```javascript
console.log("=== BASIC MEMORY ALLOCATION AND RELEASE ===");

// Memory allocation
let user = {
    name: "John",
    email: "john@example.com",
    preferences: {
        theme: "dark",
        language: "en"
    }
};

console.log("User object created:", user);

// Creating references
let userRef = user;           // Reference to same object
let userCopy = { ...user };   // New object (different memory)

console.log("References created");
console.log("user === userRef:", user === userRef);           // true (same memory)
console.log("user === userCopy:", user === userCopy);         // false (different memory)

// Releasing references
user = null;                  // Remove one reference
console.log("user set to null");

userRef = null;               // Remove last reference
console.log("userRef set to null");

// At this point, the original user object is eligible for garbage collection
// because no references point to it

// userCopy still exists and won't be garbage collected
console.log("userCopy still exists:", userCopy);
```

#### Example 2: Reference Counting and Circular References
```javascript
console.log("=== REFERENCE COUNTING AND CIRCULAR REFERENCES ===");

// Circular reference example
let obj1 = { name: "Object 1" };
let obj2 = { name: "Object 2" };

// Create circular reference
obj1.ref = obj2;
obj2.ref = obj1;

console.log("Circular reference created:");
console.log("obj1.ref === obj2:", obj1.ref === obj2);         // true
console.log("obj2.ref === obj1:", obj2.ref === obj1);         // true

// Remove external references
let originalObj1 = obj1;
let originalObj2 = obj2;

obj1 = null;
obj2 = null;

console.log("External references removed");

// The objects still exist in memory due to circular reference
// Reference counting can't free them because each has a reference count > 0
console.log("obj1.ref still exists:", originalObj1.ref);
console.log("obj2.ref still exists:", originalObj2.ref);

// Modern garbage collectors (Mark and Sweep) can handle this
// by detecting unreachable objects from root references

// Break the circular reference to allow garbage collection
originalObj1.ref = null;
originalObj2.ref = null;

console.log("Circular reference broken");
```

#### Example 3: Mark and Sweep Algorithm
```javascript
console.log("=== MARK AND SWEEP ALGORITHM ===");

// Simulating the mark and sweep process
function createObjectGraph() {
    // Root objects (accessible from global scope)
    let root1 = { name: "Root 1", id: 1 };
    let root2 = { name: "Root 2", id: 2 };
    
    // Objects referenced by roots
    root1.child = { name: "Child 1", parent: root1 };
    root2.child = { name: "Child 2", parent: root2 };
    
    // Orphaned objects (not reachable from roots)
    let orphan1 = { name: "Orphan 1" };
    let orphan2 = { name: "Orphan 2" };
    
    // Create some references between orphaned objects
    orphan1.friend = orphan2;
    orphan2.friend = orphan1;
    
    console.log("Object graph created");
    console.log("Root objects:", root1, root2);
    console.log("Orphan objects:", orphan1, orphan2);
    
    return { root1, root2, orphan1, orphan2 };
}

let graph = createObjectGraph();

console.log("=== MARKING PHASE ===");
console.log("1. Start from root objects (root1, root2)");
console.log("2. Mark root1 as reachable");
console.log("3. Mark root1.child as reachable");
console.log("4. Mark root2 as reachable");
console.log("5. Mark root2.child as reachable");
console.log("6. Orphan1 and orphan2 remain unmarked");

console.log("=== SWEEPING PHASE ===");
console.log("1. Scan all objects in memory");
console.log("2. Free unmarked objects (orphan1, orphan2)");
console.log("3. Keep marked objects (root1, root2, their children)");

// Remove references to orphaned objects
graph.orphan1 = null;
graph.orphan2 = null;

console.log("Orphan references removed - objects eligible for GC");
```

#### Example 4: Memory Leaks and Prevention
```javascript
console.log("=== MEMORY LEAKS AND PREVENTION ===");

// Common memory leak: Forgotten timers
console.log("=== TIMER MEMORY LEAK ===");

let leakyTimer;
let leakyData = { message: "This data won't be garbage collected" };

function startLeakyTimer() {
    leakyTimer = setInterval(() => {
        console.log("Timer running with data:", leakyData.message);
    }, 1000);
}

function stopLeakyTimer() {
    if (leakyTimer) {
        clearInterval(leakyTimer);
        leakyTimer = null;
        console.log("Timer stopped and cleared");
    }
}

startLeakyTimer();

// Even if we remove the reference to leakyData
// leakyData = null;
// The timer still holds a reference to it through the closure

// Solution: Clear timer when done
setTimeout(() => {
    stopLeakyTimer();
    leakyData = null;  // Now safe to clear
    console.log("Data reference cleared");
}, 5000);

// Common memory leak: DOM event listeners
console.log("=== DOM EVENT LISTENER MEMORY LEAK ===");

// Simulating DOM element
let button = { id: "myButton" };
let eventHandler = function() {
    console.log("Button clicked");
};

// Add event listener
button.addEventListener = function(event, handler) {
    if (!this._listeners) this._listeners = {};
    if (!this._listeners[event]) this._listeners[event] = [];
    this._listeners[event].push(handler);
    console.log("Event listener added");
};

button.addEventListener("click", eventHandler);

// Problem: Even if we remove the button reference
// button = null;
// The event handler still exists and can't be garbage collected

// Solution: Remove event listener before clearing reference
button.removeEventListener = function(event, handler) {
    if (this._listeners && this._listeners[event]) {
        this._listeners[event] = this._listeners[event].filter(h => h !== handler);
        console.log("Event listener removed");
    }
};

button.removeEventListener("click", eventHandler);
button = null;  // Now safe to clear
```

#### Example 5: Closures and Memory Management
```javascript
console.log("=== CLOSURES AND MEMORY MANAGEMENT ===");

// Closure that captures large data
function createDataProcessor() {
    // Large data that gets captured in closure
    let largeData = new Array(1000000).fill("data");
    
    return {
        process: function() {
            // This closure captures largeData
            console.log("Processing data, length:", largeData.length);
            return largeData.slice(0, 10); // Return small subset
        },
        
        getDataSize: function() {
            return largeData.length;
        }
    };
}

let processor = createDataProcessor();
console.log("Data processor created, data size:", processor.getDataSize());

// The largeData array is kept in memory because it's captured by the closure
// Even though we only need a small subset

// Solution 1: Don't capture large data in closure
function createEfficientProcessor() {
    return {
        process: function(data) {
            // Pass data as parameter instead of capturing
            console.log("Processing data, length:", data.length);
            return data.slice(0, 10);
        }
    };
}

let efficientProcessor = createEfficientProcessor();
let data = new Array(1000000).fill("data");
let result = efficientProcessor.process(data);

// After processing, data can be garbage collected
data = null;

// Solution 2: Clear closure references when done
processor = null;  // Allow the closure and largeData to be garbage collected
```

#### Example 6: Weak References and WeakMap/WeakSet
```javascript
console.log("=== WEAK REFERENCES AND WEAKMAP/WEAKSET ===");

// Regular Map keeps strong references
console.log("=== REGULAR MAP (STRONG REFERENCES) ===");

let user = { name: "John", id: 1 };
let userMetadata = new Map();

userMetadata.set(user, { lastLogin: new Date(), preferences: {} });
console.log("User metadata stored in Map");

// Even if we remove the user reference
user = null;
console.log("User reference removed");

// The user object is still in memory because Map holds a strong reference
console.log("User object still exists:", userMetadata.keys().next().value);

// WeakMap uses weak references
console.log("=== WEAKMAP (WEAK REFERENCES) ===");

let user2 = { name: "Jane", id: 2 };
let userMetadataWeak = new WeakMap();

userMetadataWeak.set(user2, { lastLogin: new Date(), preferences: {} });
console.log("User metadata stored in WeakMap");

// Remove the user reference
user2 = null;
console.log("User2 reference removed");

// The user object can now be garbage collected
// WeakMap won't prevent garbage collection
console.log("WeakMap size (may be 0 after GC):", userMetadataWeak.size);

// WeakSet example
console.log("=== WEAKSET EXAMPLE ===");

let users = new WeakSet();
let user3 = { name: "Bob", id: 3 };
let user4 = { name: "Alice", id: 4 };

users.add(user3);
users.add(user4);
console.log("Users added to WeakSet");

// Check if users exist
console.log("User3 in set:", users.has(user3));  // true
console.log("User4 in set:", users.has(user4));  // true

// Remove references
user3 = null;
user4 = null;
console.log("User references removed");

// Users can now be garbage collected
// WeakSet won't prevent this
```

#### Example 7: Memory Monitoring and Best Practices
```javascript
console.log("=== MEMORY MONITORING AND BEST PRACTICES ===");

// Memory monitoring (if available)
if (performance.memory) {
    console.log("=== MEMORY USAGE ===");
    console.log("Used JS Heap Size:", performance.memory.usedJSHeapSize);
    console.log("Total JS Heap Size:", performance.memory.totalJSHeapSize);
    console.log("JS Heap Size Limit:", performance.memory.jsHeapSizeLimit);
}

// Best practices for memory management
console.log("=== MEMORY MANAGEMENT BEST PRACTICES ===");

// 1. Avoid global variables
// ❌ Bad: Global variable
window.globalData = new Array(1000000).fill("data");

// ✅ Good: Local variable or module scope
function processData() {
    let localData = new Array(1000000).fill("data");
    // Process data
    return localData.slice(0, 10);
}

// 2. Clear intervals and timeouts
let intervalId = setInterval(() => {
    console.log("Interval running");
}, 1000);

// Always clear when done
setTimeout(() => {
    clearInterval(intervalId);
    console.log("Interval cleared");
}, 5000);

// 3. Remove event listeners
let element = { id: "myElement" };
let handler = () => console.log("Event handled");

element.addEventListener = function(event, handler) {
    if (!this._listeners) this._listeners = {};
    if (!this._listeners[event]) this._listeners[event] = [];
    this._listeners[event].push(handler);
};

element.removeEventListener = function(event, handler) {
    if (this._listeners && this._listeners[event]) {
        this._listeners[event] = this._listeners[event].filter(h => h !== handler);
    }
};

element.addEventListener("click", handler);

// Remove when element is destroyed
element.removeEventListener("click", handler);

// 4. Use object pooling for frequently created/destroyed objects
class ObjectPool {
    constructor(createFn, resetFn) {
        this.pool = [];
        this.createFn = createFn;
        this.resetFn = resetFn;
    }
    
    get() {
        if (this.pool.length > 0) {
            const obj = this.pool.pop();
            this.resetFn(obj);
            return obj;
        }
        return this.createFn();
    }
    
    release(obj) {
        this.pool.push(obj);
    }
}

// Example usage
const vectorPool = new ObjectPool(
    () => ({ x: 0, y: 0 }),           // Create function
    (vector) => { vector.x = 0; vector.y = 0; }  // Reset function
);

let vector1 = vectorPool.get();
vector1.x = 10;
vector1.y = 20;

// Instead of creating new objects, reuse from pool
vectorPool.release(vector1);
```

### Garbage Collection Summary

```
┌─────────────────────────────────────────────────────────────┐
│                GARBAGE COLLECTION SUMMARY                   │
├─────────────────────────────────────────────────────────────┤
│  Algorithm          │ Pros                    │ Cons        │
├─────────────────────┼─────────────────────────┼─────────────┤
│  Reference Counting │ Simple, immediate       │ Circular refs│
│                     │                         │             │
│  Mark and Sweep     │ Handles circular refs   │ Stop-the-world│
│                     │ More efficient          │             │
│                     │                         │             │
│  Generational       │ Fast for young objects │ Complex     │
│                     │ Efficient for old      │             │
│                     │                         │             │
│  Incremental        │ Non-blocking           │ Overhead    │
│                     │ Better UX              │             │
└─────────────────────────────────────────────────────────────┘
```

### Key Points to Remember for Interviews

1. **Automatic Management**: JavaScript automatically manages memory through garbage collection
2. **Reference Counting**: Simple but can't handle circular references
3. **Mark and Sweep**: Modern algorithm that handles circular references
4. **Memory Leaks**: Common causes include forgotten timers, event listeners, and closures
5. **Weak References**: WeakMap/WeakSet allow objects to be garbage collected
6. **Best Practices**: Clear timers, remove event listeners, avoid global variables
7. **Monitoring**: Use performance.memory and browser dev tools to monitor memory usage

### Common Interview Questions

**Q: What is garbage collection in JavaScript?**
A: Garbage collection is JavaScript's automatic memory management system that frees up memory no longer being used by the program. It prevents memory leaks and ensures efficient memory usage without manual intervention.

**Q: How does the Mark and Sweep algorithm work?**
A: Mark and Sweep works in two phases: 1) Mark phase - traverses from root objects and marks all reachable objects, 2) Sweep phase - frees all unmarked objects. It can handle circular references that reference counting cannot.

**Q: What are common causes of memory leaks in JavaScript?**
A: Common causes include forgotten timers (setInterval/setTimeout), uncleared event listeners, closures that capture large objects, and circular references. These prevent objects from being garbage collected.

**Q: How do WeakMap and WeakSet help with memory management?**
A: WeakMap and WeakSet use weak references that don't prevent objects from being garbage collected. When the only references to an object are weak references, the object can be freed, making them useful for storing metadata without preventing cleanup.

**Q: What are best practices for preventing memory leaks?**
A: Best practices include clearing timers and intervals when done, removing event listeners, avoiding global variables, using local scope when possible, and being careful with closures that capture large objects.
