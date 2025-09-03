# 🔹 Primitive vs Reference Types

*Understanding JavaScript's Data Type Categories*

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents
- [What are Data Types?](#what-are-data-types)
- [Primitive Types](#primitive-types)
- [Reference Types](#reference-types)
- [Memory Storage](#memory-storage)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points for Interviews](#key-points-for-interviews)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 What are Data Types?

Data types in JavaScript define the kind of data that can be stored and manipulated. JavaScript has two main categories of data types: **Primitive Types** and **Reference Types**. Understanding the difference between these is crucial for writing efficient and bug-free code.

### 🔍 Simple Analogy
Think of data types like different types of storage:
- **Primitive Types** = Simple boxes (each holds one value directly)
- **Reference Types** = Complex warehouses (hold addresses to where data is stored)

---

## 🏗️ Primitive Types

### 1. **String**
- Text data enclosed in quotes
- Immutable (cannot be changed once created)
- Examples: `"Hello"`, `'World'`, `` `Template` ``

### 2. **Number**
- Numeric values (integers and decimals)
- Includes special values: `Infinity`, `-Infinity`, `NaN`
- Examples: `42`, `3.14`, `-17`

### 3. **Boolean**
- Logical values: `true` or `false`
- Used in conditional statements and comparisons

### 4. **null**
- Represents intentional absence of any object value
- Type is `object` (this is a known JavaScript bug)

### 5. **undefined**
- Variable declared but not assigned a value
- Function returns undefined by default

### 6. **Symbol** (ES6+)
- Unique and immutable primitive value
- Used as object property keys

### 7. **BigInt** (ES2020+)
- Arbitrary precision integers
- Suffixed with `n`: `123n`

---

## 🏢 Reference Types

### 1. **Object**
- Collection of key-value pairs
- Mutable (can be modified after creation)
- Examples: `{}`, `{ name: "John", age: 30 }`

### 2. **Array**
- Ordered collection of values
- Indexed starting from 0
- Examples: `[]`, `[1, 2, 3]`, `["a", "b", "c"]`

### 3. **Function**
- Callable objects
- Can be assigned to variables, passed as arguments
- Examples: `function() {}`, `() => {}`, `function test() {}`

### 4. **Date**
- Represents date and time
- Built-in methods for date manipulation

### 5. **RegExp**
- Regular expression objects
- Used for pattern matching in strings

### 6. **Error**
- Built-in error objects
- Examples: `Error`, `TypeError`, `ReferenceError`

### 7. **Custom Classes**
- User-defined object types
- Created with `class` keyword

---

## 💾 Memory Storage

### 🔍 Memory Storage Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                    MEMORY STORAGE                           │
├─────────────────────────────────────────────────────────────┤
│  🧠 STACK MEMORY (Primitive Types)                         │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Variable: name                                       │   │
│  │ Value: "John"                                        │   │
│  │ Memory: Direct value storage                         │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  🧠 HEAP MEMORY (Reference Types)                         │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Variable: user                                       │   │
│  │ Value: 0x1234 (memory address)                       │   │
│  │ Memory: Pointer to heap location                     │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                │
│                           ▼                                │
│  🏢 HEAP LOCATION 0x1234                                  │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ { name: "John", age: 30 }                           │   │
│  │ Actual object data stored here                      │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 🔄 Storage Comparison

| Aspect | Primitive Types | Reference Types |
|--------|----------------|-----------------|
| **Storage** | Stack memory | Heap memory |
| **Access** | Direct value | Memory address (pointer) |
| **Size** | Fixed size | Variable size |
| **Copying** | Value copied | Reference copied |
| **Comparison** | Value comparison | Reference comparison |
| **Mutability** | Immutable | Mutable |

---

## 💻 Detailed Examples

### Example 1: Basic Type Demonstration
```javascript
console.log("=== BASIC TYPE DEMONSTRATION ===");

// Primitive Types
console.log("=== PRIMITIVE TYPES ===");

let stringVar = "Hello World";
let numberVar = 42;
let booleanVar = true;
let nullVar = null;
let undefinedVar = undefined;
let symbolVar = Symbol("unique");
let bigIntVar = 123456789012345678901234567890n;

console.log("String:", stringVar, typeof stringVar);
console.log("Number:", numberVar, typeof numberVar);
console.log("Boolean:", booleanVar, typeof booleanVar);
console.log("Null:", nullVar, typeof nullVar);
console.log("Undefined:", undefinedVar, typeof undefinedVar);
console.log("Symbol:", symbolVar, typeof symbolVar);
console.log("BigInt:", bigIntVar, typeof bigIntVar);

// Reference Types
console.log("=== REFERENCE TYPES ===");

let objectVar = { name: "John", age: 30 };
let arrayVar = [1, 2, 3, 4, 5];
let functionVar = function() { return "I'm a function"; };
let dateVar = new Date();
let regexVar = /pattern/;
let errorVar = new Error("Test error");

console.log("Object:", objectVar, typeof objectVar);
console.log("Array:", arrayVar, typeof arrayVar);
console.log("Function:", functionVar, typeof functionVar);
console.log("Date:", dateVar, typeof dateVar);
console.log("RegExp:", regexVar, typeof regexVar);
console.log("Error:", errorVar, typeof errorVar);
```

### Example 2: Memory Storage and Assignment
```javascript
console.log("=== MEMORY STORAGE AND ASSIGNMENT ===");

// Primitive Types - Direct Value Storage
console.log("=== PRIMITIVE TYPES - DIRECT STORAGE ===");

let originalNumber = 42;
let copiedNumber = originalNumber; // Value is copied

console.log("Original number:", originalNumber);
console.log("Copied number:", copiedNumber);

// Modify the copy
copiedNumber = 100;
console.log("After modification:");
console.log("Original number:", originalNumber); // Still 42
console.log("Copied number:", copiedNumber);    // Now 100

console.log("Primitive types are copied by value - each has its own memory location");

// Reference Types - Memory Address Storage
console.log("=== REFERENCE TYPES - ADDRESS STORAGE ===");

let originalObject = { name: "John", age: 30 };
let copiedObject = originalObject; // Memory address is copied

console.log("Original object:", originalObject);
console.log("Copied object:", copiedObject);

// Modify the copy
copiedObject.age = 31;
console.log("After modification:");
console.log("Original object:", originalObject); // Age changed to 31
console.log("Copied object:", copiedObject);    // Age is 31

console.log("Reference types share the same memory location - both point to same data");
```

### Example 3: Comparison Behavior
```javascript
console.log("=== COMPARISON BEHAVIOR ===");

// Primitive Type Comparison
console.log("=== PRIMITIVE TYPE COMPARISON ===");

let string1 = "Hello";
let string2 = "Hello";
let string3 = new String("Hello"); // String object (reference type)

console.log("String comparison:");
console.log("string1 === string2:", string1 === string2);           // true (value comparison)
console.log("string1 === string3:", string1 === string3);           // false (type comparison)
console.log("string1 == string3:", string1 == string3);             // true (loose equality)

let number1 = 42;
let number2 = 42;
let number3 = Number(42);

console.log("Number comparison:");
console.log("number1 === number2:", number1 === number2);           // true (value comparison)
console.log("number1 === number3:", number1 === number3);           // true (value comparison)

// Reference Type Comparison
console.log("=== REFERENCE TYPE COMPARISON ===");

let obj1 = { name: "John", age: 30 };
let obj2 = { name: "John", age: 30 };
let obj3 = obj1; // Same reference

console.log("Object comparison:");
console.log("obj1 === obj2:", obj1 === obj2);                       // false (different references)
console.log("obj1 === obj3:", obj1 === obj3);                       // true (same reference)

let arr1 = [1, 2, 3];
let arr2 = [1, 2, 3];
let arr3 = arr1; // Same reference

console.log("Array comparison:");
console.log("arr1 === arr2:", arr1 === arr2);                       // false (different references)
console.log("arr1 === arr3:", arr1 === arr3);                       // true (same reference)

// Deep comparison for objects
console.log("=== DEEP COMPARISON ===");

function deepEqual(obj1, obj2) {
    if (obj1 === obj2) return true;
    if (typeof obj1 !== 'object' || typeof obj2 !== 'object') return false;
    if (obj1 === null || obj2 === null) return false;
    
    const keys1 = Object.keys(obj1);
    const keys2 = Object.keys(obj2);
    
    if (keys1.length !== keys2.length) return false;
    
    for (let key of keys1) {
        if (!keys2.includes(key)) return false;
        if (!deepEqual(obj1[key], obj2[key])) return false;
    }
    
    return true;
}

console.log("Deep comparison obj1 vs obj2:", deepEqual(obj1, obj2)); // true
console.log("Deep comparison arr1 vs arr2:", deepEqual(arr1, arr2)); // true
```

### Example 4: Function Parameters and Return Values
```javascript
console.log("=== FUNCTION PARAMETERS AND RETURN VALUES ===");

// Primitive Types in Functions
console.log("=== PRIMITIVE TYPES IN FUNCTIONS ===");

function modifyPrimitive(value) {
    console.log("Inside function - received value:", value);
    value = value * 2; // Modify the parameter
    console.log("Inside function - modified value:", value);
    return value;
}

let originalPrimitive = 10;
console.log("Before function call:", originalPrimitive);

let result = modifyPrimitive(originalPrimitive);
console.log("After function call:", originalPrimitive); // Still 10
console.log("Function result:", result);                 // 20

console.log("Primitive types are passed by value - original is unchanged");

// Reference Types in Functions
console.log("=== REFERENCE TYPES IN FUNCTIONS ===");

function modifyReference(obj) {
    console.log("Inside function - received object:", obj);
    obj.age = obj.age + 1; // Modify the object
    console.log("Inside function - modified object:", obj);
    return obj;
}

let originalObject = { name: "John", age: 30 };
console.log("Before function call:", originalObject);

let modifiedObject = modifyReference(originalObject);
console.log("After function call:", originalObject);     // Age changed to 31
console.log("Modified object:", modifiedObject);         // Same object

console.log("Reference types are passed by reference - original is modified");

// Important: JavaScript is always pass by value
console.log("=== JAVASCRIPT IS ALWAYS PASS BY VALUE ===");

function reassignReference(obj) {
    console.log("Inside function - received object:", obj);
    obj = { name: "Jane", age: 25 }; // Reassign parameter
    console.log("Inside function - reassigned object:", obj);
    return obj;
}

let testObject = { name: "John", age: 30 };
console.log("Before function call:", testObject);

let newObject = reassignReference(testObject);
console.log("After function call:", testObject);         // Still original object
console.log("New object:", newObject);                   // New object

console.log("Even with reference types, reassignment doesn't affect original");
```

### Example 5: Common Pitfalls and Solutions
```javascript
console.log("=== COMMON PITFALLS AND SOLUTIONS ===");

// Pitfall 1: Mutable Reference Types
console.log("=== PITFALL 1: MUTABLE REFERENCE TYPES ===");

let user = { name: "John", age: 30 };
let userCopy = user; // Same reference

userCopy.age = 31;
console.log("Original user:", user);     // Age changed to 31
console.log("User copy:", userCopy);     // Age is 31

// Solution: Create a copy
let userDeepCopy = JSON.parse(JSON.stringify(user));
userDeepCopy.age = 32;
console.log("After deep copy modification:");
console.log("Original user:", user);         // Age still 31
console.log("Deep copy:", userDeepCopy);     // Age is 32

// Pitfall 2: Array Methods that Modify Original
console.log("=== PITFALL 2: ARRAY METHODS ===");

let originalArray = [1, 2, 3, 4, 5];
let arrayCopy = originalArray; // Same reference

// Mutating methods
arrayCopy.push(6);             // Modifies original
arrayCopy.splice(0, 1);        // Modifies original
arrayCopy.sort((a, b) => b - a); // Modifies original

console.log("Original array:", originalArray); // Modified
console.log("Array copy:", arrayCopy);         // Same as original

// Solution: Use non-mutating methods
let originalArray2 = [1, 2, 3, 4, 5];
let safeCopy = [...originalArray2]; // Spread operator creates copy

safeCopy.push(6);
console.log("After safe modification:");
console.log("Original array:", originalArray2); // Unchanged
console.log("Safe copy:", safeCopy);            // Modified

// Pitfall 3: Object Property Assignment
console.log("=== PITFALL 3: OBJECT PROPERTY ASSIGNMENT ===");

let config = { theme: "dark", language: "en" };
let configCopy = config; // Same reference

configCopy.theme = "light";
console.log("Original config:", config);     // Theme changed
console.log("Config copy:", configCopy);     // Theme changed

// Solution: Object spread or Object.assign
let safeConfig = { ...config }; // Spread operator
safeConfig.language = "es";
console.log("After safe modification:");
console.log("Original config:", config);     // Language unchanged
console.log("Safe config:", safeConfig);     // Language changed
```

### Example 6: Type Checking and Conversion
```javascript
console.log("=== TYPE CHECKING AND CONVERSION ===");

// Type Checking Methods
console.log("=== TYPE CHECKING METHODS ===");

let testString = "Hello";
let testNumber = 42;
let testBoolean = true;
let testObject = { name: "John" };
let testArray = [1, 2, 3];
let testFunction = function() {};
let testNull = null;
let testUndefined = undefined;

console.log("Type checking results:");
console.log("typeof testString:", typeof testString);
console.log("typeof testNumber:", typeof testNumber);
console.log("typeof testBoolean:", typeof testBoolean);
console.log("typeof testObject:", typeof testObject);
console.log("typeof testArray:", typeof testArray);
console.log("typeof testFunction:", typeof testFunction);
console.log("typeof testNull:", typeof testNull);
console.log("typeof testUndefined:", typeof testUndefined);

// Better type checking
console.log("=== BETTER TYPE CHECKING ===");

console.log("Array check:");
console.log("Array.isArray(testArray):", Array.isArray(testArray));
console.log("Array.isArray(testObject):", Array.isArray(testObject));

console.log("Null check:");
console.log("testNull === null:", testNull === null);
console.log("testUndefined === undefined:", testUndefined === undefined);

console.log("Object check:");
console.log("Object.prototype.toString.call(testObject):", Object.prototype.toString.call(testObject));
console.log("Object.prototype.toString.call(testArray):", Object.prototype.toString.call(testArray));

// Type Conversion
console.log("=== TYPE CONVERSION ===");

let stringNumber = "42";
let actualNumber = Number(stringNumber);
let booleanString = "true";
let actualBoolean = Boolean(booleanString);

console.log("String to Number:", stringNumber, "→", actualNumber, typeof actualNumber);
console.log("String to Boolean:", booleanString, "→", actualBoolean, typeof actualBoolean);

// Falsy values
console.log("=== FALSY VALUES ===");
console.log("Boolean(''):", Boolean(""));
console.log("Boolean(0):", Boolean(0));
console.log("Boolean(null):", Boolean(null));
console.log("Boolean(undefined):", Boolean(undefined));
console.log("Boolean(NaN):", Boolean(NaN));

// Truthy values
console.log("=== TRUTHY VALUES ===");
console.log("Boolean('hello'):", Boolean("hello"));
console.log("Boolean(42):", Boolean(42));
console.log("Boolean({}):", Boolean({}));
console.log("Boolean([]):", Boolean([]));
console.log("Boolean(function(){}):", Boolean(function(){}));
```

---

## ⚠️ Common Pitfalls

### Pitfall 1: Mutable Reference Types
```javascript
console.log("=== PITFALL 1: MUTABLE REFERENCE TYPES ===");

// ❌ Problem: Modifying shared reference
let originalUser = { name: "John", age: 30 };
let userCopy = originalUser;

userCopy.age = 31;
console.log("Original user age:", originalUser.age); // 31 (unexpected!)

// ✅ Solution: Create proper copies
let safeUserCopy = { ...originalUser }; // Spread operator
safeUserCopy.age = 32;
console.log("Original user age:", originalUser.age); // 31 (unchanged)
console.log("Safe copy age:", safeUserCopy.age);     // 32
```

### Pitfall 2: Array Methods that Modify Original
```javascript
console.log("=== PITFALL 2: ARRAY METHODS ===");

// ❌ Problem: Mutating methods affect original
let originalArray = [1, 2, 3];
let arrayCopy = originalArray;

arrayCopy.push(4);
console.log("Original array:", originalArray); // [1, 2, 3, 4] (unexpected!)

// ✅ Solution: Use non-mutating methods
let safeArrayCopy = [...originalArray]; // Spread operator
safeArrayCopy.push(5);
console.log("Original array:", originalArray); // [1, 2, 3, 4] (unchanged)
console.log("Safe copy:", safeArrayCopy);      // [1, 2, 3, 4, 5]
```

### Pitfall 3: Object Property Assignment
```javascript
console.log("=== PITFALL 3: OBJECT PROPERTY ASSIGNMENT ===");

// ❌ Problem: Nested objects share references
let originalConfig = { theme: { color: "dark" } };
let configCopy = { ...originalConfig };

configCopy.theme.color = "light";
console.log("Original theme color:", originalConfig.theme.color); // "light" (unexpected!)

// ✅ Solution: Deep copy for nested objects
let deepConfigCopy = JSON.parse(JSON.stringify(originalConfig));
deepConfigCopy.theme.color = "blue";
console.log("Original theme color:", originalConfig.theme.color); // "light" (unchanged)
console.log("Deep copy theme color:", deepConfigCopy.theme.color); // "blue"
```

---

## ✅ Best Practices

### 1. Use const for Reference Types When Possible
```javascript
console.log("=== BEST PRACTICE 1: USE CONST FOR REFERENCE TYPES ===");

// ✅ Good: const for objects that won't be reassigned
const user = { name: "John", age: 30 };
user.age = 31; // ✅ Can modify properties
// user = {}; // ❌ Cannot reassign

// ✅ Good: const for arrays that won't be reassigned
const numbers = [1, 2, 3];
numbers.push(4); // ✅ Can modify array
// numbers = []; // ❌ Cannot reassign

// ✅ Use let when you need to reassign
let currentUser = user;
currentUser = { name: "Jane", age: 25 }; // ✅ Can reassign
```

### 2. Create Copies Instead of Sharing References
```javascript
console.log("=== BEST PRACTICE 2: CREATE COPIES ===");

// ✅ Good: Spread operator for shallow copies
const original = { name: "John", age: 30 };
const copy = { ...original };

// ✅ Good: Array spread for arrays
const originalArray = [1, 2, 3];
const arrayCopy = [...originalArray];

// ✅ Good: Object.assign for copies
const copy2 = Object.assign({}, original);

// ✅ Good: Deep copy for nested objects
const deepCopy = JSON.parse(JSON.stringify(original));
```

### 3. Use Type-Safe Comparisons
```javascript
console.log("=== BEST PRACTICE 3: TYPE-SAFE COMPARISONS ===");

// ✅ Good: Strict equality for primitives
const string1 = "Hello";
const string2 = "Hello";
console.log(string1 === string2); // true

// ✅ Good: Reference equality for objects
const obj1 = { name: "John" };
const obj2 = { name: "John" };
console.log(obj1 === obj2); // false (different references)

// ✅ Good: Deep comparison when needed
function deepEqual(a, b) {
    return JSON.stringify(a) === JSON.stringify(b);
}
console.log(deepEqual(obj1, obj2)); // true
```

---

## 🎯 Key Points for Interviews

### 🔑 Core Concepts
1. **Primitive Types**: Stored directly in memory, immutable
2. **Reference Types**: Stored as memory addresses, mutable
3. **Memory Storage**: Stack vs Heap memory
4. **Copying Behavior**: Value vs Reference copying
5. **Comparison**: Value vs Reference comparison

### 🚨 Common Mistakes
1. **Modifying shared references**
2. **Using mutating array methods**
3. **Not understanding pass by value**
4. **Confusing type checking methods**

### 💡 Advanced Concepts
1. **Shallow vs Deep Copying**
2. **Object Immutability Patterns**
3. **Memory Management**
4. **Type Coercion Rules**

---

## ❓ Common Interview Questions

### Q: What's the difference between primitive and reference types in JavaScript?
**A:** 

**Primitive Types:**
- Stored directly in stack memory
- Include: String, Number, Boolean, null, undefined, Symbol, BigInt
- Immutable (cannot be changed once created)
- Copied by value when assigned
- Compared by value

**Reference Types:**
- Stored in heap memory with stack holding memory address
- Include: Object, Array, Function, Date, RegExp, Error, Custom Classes
- Mutable (can be modified after creation)
- Copied by reference when assigned
- Compared by reference

### Q: How does memory storage work for different types?
**A:** 

**Primitive Types:**
- Stored directly in stack memory
- Fixed size allocation
- Fast access
- Automatic cleanup when variable goes out of scope

**Reference Types:**
- Actual data stored in heap memory
- Stack holds memory address (pointer)
- Variable size allocation
- Slower access (indirect)
- Garbage collection manages cleanup

### Q: What happens when you assign a reference type to another variable?
**A:** When you assign a reference type to another variable:

**What Happens:**
- Memory address is copied, not the actual data
- Both variables point to the same memory location
- Modifying one affects the other
- Original data is shared, not duplicated

**Example:**
```javascript
let obj1 = { name: "John" };
let obj2 = obj1; // obj2 gets memory address of obj1

obj2.name = "Jane";
console.log(obj1.name); // "Jane" (original is modified)
console.log(obj2.name); // "Jane"
```

**Why This Happens:**
- JavaScript copies the reference (memory address)
- Both variables point to same object in heap
- Modifications affect the shared object

### Q: How do you create a true copy of an object or array?
**A:** To create a true copy:

**Shallow Copy (for simple objects):**
```javascript
// Spread operator
const copy1 = { ...originalObject };

// Object.assign
const copy2 = Object.assign({}, originalObject);

// Array spread
const arrayCopy = [...originalArray];
```

**Deep Copy (for nested objects):**
```javascript
// JSON method (simple but has limitations)
const deepCopy1 = JSON.parse(JSON.stringify(originalObject));

// Recursive function (more robust)
function deepClone(obj) {
    if (obj === null || typeof obj !== 'object') return obj;
    if (obj instanceof Date) return new Date(obj);
    if (obj instanceof Array) return obj.map(item => deepClone(item));
    
    const cloned = {};
    for (let key in obj) {
        if (obj.hasOwnProperty(key)) {
            cloned[key] = deepClone(obj[key]);
        }
    }
    return cloned;
}

const deepCopy2 = deepClone(originalObject);
```

### Q: Why does JavaScript have both primitive and reference types?
**A:** JavaScript has both types for several reasons:

**Primitive Types:**
- **Efficiency**: Fast access and operations
- **Simplicity**: Simple, predictable behavior
- **Memory**: Fixed size, easy to manage
- **Performance**: Direct value operations

**Reference Types:**
- **Complexity**: Handle complex data structures
- **Flexibility**: Mutable, can be modified
- **Memory Management**: Variable size, efficient for large data
- **Object-Oriented**: Support for OOP patterns

**Design Benefits:**
- **Performance**: Fast operations on simple data
- **Flexibility**: Complex data structures when needed
- **Memory Efficiency**: Appropriate storage for different data types
- **Developer Experience**: Intuitive behavior for different use cases

---

## 🧪 Practice Exercises

### Exercise 1: Type Identification
```javascript
console.log("Exercise 1: Identify the data types");

const values = [
    "Hello",
    42,
    true,
    null,
    undefined,
    Symbol("test"),
    123n,
    {},
    [],
    function() {},
    new Date(),
    /regex/,
    new Error("test")
];

// Your task: Identify the type of each value
// Use typeof, Array.isArray, and other methods
```

### Exercise 2: Copying Objects
```javascript
console.log("Exercise 2: Create copies of objects");

const original = {
    name: "John",
    age: 30,
    hobbies: ["reading", "gaming"],
    address: {
        city: "New York",
        country: "USA"
    }
};

// Your task: Create shallow and deep copies
// Test that modifications don't affect the original
```

### Exercise 3: Memory Management
```javascript
console.log("Exercise 3: Understand memory behavior");

// Your task: Create examples that demonstrate
// 1. Primitive type copying
// 2. Reference type sharing
// 3. How to avoid unintended modifications
```

---

## 📚 Additional Resources

- **MDN Web Docs**: [Data Types](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures)
- **JavaScript.info**: [Primitive vs Reference Types](https://javascript.info/types)
- **ECMAScript Specification**: [Data Types](https://tc39.es/ecma262/#sec-ecmascript-data-types-and-values)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./05-Temporal-Dead-Zone.md" class="nav-link prev">⬅️ Previous: Temporal Dead Zone (TDZ)</a>
    <a href="./07-Deep-Copy-vs-Shallow-Copy.md" class="nav-link next">Next: Deep Copy vs Shallow Copy ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

*Last updated: December 2024*
