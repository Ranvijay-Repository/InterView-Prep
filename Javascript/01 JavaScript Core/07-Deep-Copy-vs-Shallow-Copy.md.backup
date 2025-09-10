# 🔄 Deep Copy vs Shallow Copy

> **Understanding how to properly clone objects and arrays in JavaScript**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is Copying?](#what-is-copying)
- [Shallow Copy](#shallow-copy)
- [Deep Copy](#deep-copy)
- [Key Differences](#key-differences)
- [Copy Methods Comparison](#copy-methods-comparison)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What is Copying?

**Copying** in JavaScript means creating a new instance of an object or array that is independent of the original. The goal is to avoid unintended mutations of the original data.

### Why Copying Matters:
- **Data Integrity**: Prevent accidental changes to original data
- **Immutability**: Create new versions instead of modifying existing ones
- **State Management**: Essential for React, Redux, and modern JavaScript patterns
- **Bug Prevention**: Avoid shared reference issues

---

## 🔍 Shallow Copy

**Shallow Copy** creates a new object/array but only copies references to nested objects/arrays. The nested structures are still shared between the original and the copy.

### ASCII Diagram: Shallow Copy

{% raw %}
```
ORIGINAL OBJECT          SHALLOW COPY
┌─────────────────┐     ┌─────────────────┐
│ name: "John"    │     │ name: "John"    │
│ age: 30         │     │ age: 30         │
│ address: ───────┼─────┤ address: ───────┼─────┐
└─────────────────┘     └─────────────────┘     │
                        │                 │     │
                        └─────────────────┘     │
                                                ▼
                                        ┌─────────────┐
                                        │ city: "NY"  │
                                        │ zip: "10001"│
                                        └─────────────┘
                                        (SHARED REFERENCE)
```
{% endraw %}


### Shallow Copy Methods:
1. **Spread Operator** (`...`)
2. **Object.assign()**
3. **Array.slice()**
4. **Array.from()**

---

## 🗃️ Deep Copy

**Deep Copy** creates a completely independent copy of an object/array, including all nested structures. No references are shared between the original and the copy.

### ASCII Diagram: Deep Copy

{% raw %}
```
ORIGINAL OBJECT          DEEP COPY
┌─────────────────┐     ┌─────────────────┐
│ name: "John"    │     │ name: "John"    │
│ age: 30         │     │ age: 30         │
│ address: ───────┼─────┤ address: ───────┼─────┐
└─────────────────┘     └─────────────────┘     │
                        │                 │     │
                        └─────────────────┘     │
                                                ▼
                                        ┌─────────────┐
                                        │ city: "NY"  │
                                        │ zip: "10001"│
                                        └─────────────┘
                                        (INDEPENDENT COPY)
```
{% endraw %}


### Deep Copy Methods:
1. **JSON.parse(JSON.stringify())**
2. **structuredClone()** (Modern browsers)
3. **Lodash.cloneDeep()**
4. **Custom recursive function**

---

## ⚖️ Key Differences

| Aspect | Shallow Copy | Deep Copy |
|--------|--------------|-----------|
| **Nested Objects** | References shared | Completely independent |
| **Memory Usage** | Lower | Higher |
| **Performance** | Faster | Slower |
| **Use Case** | Simple objects | Complex nested structures |
| **Mutation Safety** | Partial | Complete |

---

## 🔧 Copy Methods Comparison

### Method 1: Spread Operator (Shallow)

{% raw %}
```javascript
const original = { a: 1, b: { c: 2 } };
const copy = { ...original };
```
{% endraw %}


### Method 2: Object.assign (Shallow)

{% raw %}
```javascript
const original = { a: 1, b: { c: 2 } };
const copy = Object.assign({}, original);
```
{% endraw %}


### Method 3: JSON Methods (Deep)

{% raw %}
```javascript
const original = { a: 1, b: { c: 2 } };
const copy = JSON.parse(JSON.stringify(original));
```
{% endraw %}


### Method 4: structuredClone (Deep)

{% raw %}
```javascript
const original = { a: 1, b: { c: 2 } };
const copy = structuredClone(original);
```
{% endraw %}


---

## 💻 Detailed Examples

### Example 1: Shallow Copy Limitations
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== SHALLOW COPY LIMITATIONS ===");

const originalPerson = {
    name: "John",
    age: 30,
    address: {
        city: "New York",
        zip: "10001"
    },
    hobbies: ["reading", "gaming"]
};

// Shallow copy using spread operator
const shallowCopy = { ...originalPerson };

console.log("=== Before Modification ===");
console.log("Original:", originalPerson.address.city);  // "New York"
console.log("Copy:", shallowCopy.address.city);         // "New York"

// Modify nested object in copy
shallowCopy.address.city = "Los Angeles";

console.log("=== After Modification ===");
console.log("Original:", originalPerson.address.city);  // "Los Angeles" 😱
console.log("Copy:", shallowCopy.address.city);         // "Los Angeles"

// Modify array in copy
shallowCopy.hobbies.push("swimming");

console.log("=== Array Modification ===");
console.log("Original hobbies:", originalPerson.hobbies); // ["reading", "gaming", "swimming"] 😱
console.log("Copy hobbies:", shallowCopy.hobbies);        // ["reading", "gaming", "swimming"]
```
{% endraw %}

</div>

### Example 2: Deep Copy with JSON Methods
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== DEEP COPY WITH JSON METHODS ===");

const originalData = {
    user: {
        name: "Alice",
        preferences: {
            theme: "dark",
            language: "en"
        }
    },
    settings: {
        notifications: true,
        autoSave: false
    },
    tags: ["javascript", "react", "node"]
};

// Deep copy using JSON methods
const deepCopy = JSON.parse(JSON.stringify(originalData));

console.log("=== Before Modification ===");
console.log("Original theme:", originalData.user.preferences.theme);  // "dark"
console.log("Copy theme:", deepCopy.user.preferences.theme);          // "dark"

// Modify nested object in copy
deepCopy.user.preferences.theme = "light";

console.log("=== After Modification ===");
console.log("Original theme:", originalData.user.preferences.theme);  // "dark" ✅
console.log("Copy theme:", deepCopy.user.preferences.theme);          // "light"

// Modify array in copy
deepCopy.tags.push("typescript");

console.log("=== Array Modification ===");
console.log("Original tags:", originalData.tags); // ["javascript", "react", "node"] ✅
console.log("Copy tags:", deepCopy.tags);         // ["javascript", "react", "node", "typescript"]
```
{% endraw %}

</div>

### Example 3: structuredClone (Modern Deep Copy)
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== STRUCTURED CLONE (MODERN) ===");

// Check if structuredClone is available
if (typeof structuredClone === 'function') {
    const complexObject = {
        date: new Date(),
        map: new Map([['key1', 'value1'], ['key2', 'value2']]),
        set: new Set([1, 2, 3, 4, 5]),
        regex: /hello/g,
        function: function() { return "Hello"; },
        undefined: undefined,
        null: null,
        boolean: true,
        number: 42,
        string: "Hello World"
    };

    try {
        const deepCopy = structuredClone(complexObject);
        
        console.log("=== Complex Object Deep Copy ===");
        console.log("Original date:", complexObject.date);
        console.log("Copy date:", deepCopy.date);
        console.log("Same date reference?", complexObject.date === deepCopy.date); // false ✅
        
        console.log("Original map size:", complexObject.map.size);
        console.log("Copy map size:", deepCopy.map.size);
        console.log("Same map reference?", complexObject.map === deepCopy.map); // false ✅
        
        // Modify copy
        deepCopy.map.set('key3', 'value3');
        console.log("Original map size after copy modification:", complexObject.map.size); // 2 ✅
        console.log("Copy map size after modification:", deepCopy.map.size); // 3
        
    } catch (error) {
        console.log("structuredClone error:", error.message);
    }
} else {
    console.log("structuredClone not available in this environment");
}
```
{% endraw %}

</div>

### Example 4: Custom Deep Copy Function
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== CUSTOM DEEP COPY FUNCTION ===");

function deepClone(obj, hash = new WeakMap()) {
    // Handle null, undefined, primitives
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
    
    // Handle circular references
    if (hash.has(obj)) {
        return hash.get(obj);
    }
    
    // Handle regular objects
    const clonedObj = {};
    hash.set(obj, clonedObj);
    
    for (let key in obj) {
        if (obj.hasOwnProperty(key)) {
            clonedObj[key] = deepClone(obj[key], hash);
        }
    }
    
    return clonedObj;
}

// Test the custom function
const testObject = {
    name: "Test",
    nested: {
        value: 42,
        array: [1, 2, 3]
    },
    circular: null
};

// Create circular reference
testObject.circular = testObject;

const customDeepCopy = deepClone(testObject);

console.log("=== Custom Deep Copy Test ===");
console.log("Original nested value:", testObject.nested.value);
console.log("Copy nested value:", customDeepCopy.nested.value);

// Modify copy
customDeepCopy.nested.value = 100;
customDeepCopy.nested.array.push(4);

console.log("=== After Modification ===");
console.log("Original nested value:", testObject.nested.value);        // 42 ✅
console.log("Copy nested value:", customDeepCopy.nested.value);       // 100
console.log("Original array:", testObject.nested.array);              // [1, 2, 3] ✅
console.log("Copy array:", customDeepCopy.nested.array);              // [1, 2, 3, 4]
```
{% endraw %}

</div>

### Example 5: Performance Comparison
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== PERFORMANCE COMPARISON ===");

// Create a large object for testing
function createLargeObject(depth, breadth) {
    if (depth === 0) return Math.random();
    
    const obj = {};
    for (let i = 0; i < breadth; i++) {
        obj[`key${i}`] = createLargeObject(depth - 1, breadth);
    }
    return obj;
}

const largeObject = createLargeObject(4, 5); // 4 levels deep, 5 properties per level

console.log("Large object created with", Object.keys(largeObject).length, "top-level properties");

// Performance test function
function measurePerformance(name, copyFunction) {
    const start = performance.now();
    const result = copyFunction(largeObject);
    const end = performance.now();
    
    console.log(`${name}: ${(end - start).toFixed(2)}ms`);
    return result;
}

console.log("=== Performance Results ===");

// Test different methods
const shallowCopy = measurePerformance("Shallow Copy (Spread)", () => ({ ...largeObject }));
const jsonCopy = measurePerformance("Deep Copy (JSON)", () => JSON.parse(JSON.stringify(largeObject)));

if (typeof structuredClone === 'function') {
    const structuredCopy = measurePerformance("Deep Copy (structuredClone)", () => structuredClone(largeObject));
}

console.log("=== Memory Usage Note ===");
console.log("Shallow copy: Lower memory, shared references");
console.log("Deep copy: Higher memory, independent copies");
```
{% endraw %}

</div>

---

## ⚠️ Common Pitfalls

### Pitfall 1: JSON Methods Limitations

{% raw %}
```javascript
// ❌ JSON methods can't handle:
const problematicObject = {
    function: function() { return "Hello"; },     // Functions are lost
    undefined: undefined,                         // Undefined becomes null
    date: new Date(),                            // Dates become strings
    regex: /hello/g,                            // Regex becomes empty object
    map: new Map([['key', 'value']]),           // Maps become empty objects
    set: new Set([1, 2, 3]),                    // Sets become empty objects
    circular: null                               // Circular references cause errors
};

// Create circular reference
problematicObject.circular = problematicObject;

try {
    const jsonCopy = JSON.parse(JSON.stringify(problematicObject));
    console.log("JSON copy successful");
} catch (error) {
    console.log("JSON copy failed:", error.message); // "Converting circular structure to JSON"
}
```
{% endraw %}


### Pitfall 2: Shallow Copy Misunderstanding

{% raw %}
```javascript
// ❌ Common mistake: thinking spread operator creates deep copy
const original = {
    user: { name: "John", age: 30 },
    settings: { theme: "dark" }
};

const copy = { ...original };

// This will affect the original!
copy.user.name = "Jane";
console.log(original.user.name); // "Jane" 😱
```
{% endraw %}


---

## 🎯 Best Practices

### ✅ When to Use Shallow Copy:
- Simple objects with primitive values only
- Performance-critical operations
- When you only need to copy top-level properties
- React state updates (when appropriate)

### ✅ When to Use Deep Copy:
- Complex nested objects
- When you need complete independence
- API responses that will be modified
- Configuration objects that need customization

### ✅ Recommended Approaches:
1. **Shallow Copy**: Use spread operator (`...`) for simple cases
2. **Deep Copy**: Use `structuredClone()` for modern browsers
3. **Fallback**: Use `JSON.parse(JSON.stringify())` for simple data
4. **Custom**: Implement custom function for special cases

---

## 🔑 Key Points

- **Shallow Copy**: Copies references, nested objects are shared
- **Deep Copy**: Creates completely independent copies
- **Spread Operator**: Fastest shallow copy method
- **JSON Methods**: Simple deep copy but with limitations
- **structuredClone**: Modern, robust deep copy method
- **Performance**: Shallow copy is always faster than deep copy
- **Memory**: Deep copy uses more memory but provides safety

---

## ❓ Common Interview Questions

### Q1: What's the difference between shallow and deep copy?
**A:** Shallow copy creates a new object but shares references to nested objects, while deep copy creates completely independent copies of all nested structures.

### Q2: How would you implement a deep copy function?
**A:** Use recursion to traverse the object, handle special cases like Date, Array, and circular references, and create new instances for each level.

### Q3: What are the limitations of JSON.parse(JSON.stringify())?
**A:** Can't handle functions, undefined, Date objects, RegExp, Map, Set, or circular references.

### Q4: When would you choose shallow copy over deep copy?
**A:** When you only need to copy top-level properties, for performance reasons, or when you intentionally want to share nested references.

### Q5: How does structuredClone differ from JSON methods?
**A:** structuredClone can handle more data types including Date, RegExp, Map, Set, and circular references, making it more robust.

---

## 🏋️ Practice Exercises

### Exercise 1: Implement Shallow Copy
Create a function that performs shallow copy without using spread operator or Object.assign.

### Exercise 2: Handle Circular References
Implement a deep copy function that can handle circular references without causing infinite loops.

### Exercise 3: Performance Optimization
Create a hybrid copy function that automatically chooses between shallow and deep copy based on object complexity.

---

## 📚 Additional Resources

- [MDN: structuredClone](https://developer.mozilla.org/en-US/docs/Web/API/structuredClone)
- [JavaScript.info: Object copying](https://javascript.info/object-copy)
- [Lodash: cloneDeep](https://lodash.com/docs/4.17.15#cloneDeep)
- [Performance comparison tools](https://jsperf.com/)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="06-Primitive-vs-Reference-Types.md" class="nav-link prev">← Previous: Primitive vs Reference Types</a>
    <a href="08-Pass-by-Value-vs-Pass-by-Reference.md" class="nav-link next">Next: Pass by Value vs Pass by Reference →</a>
</div>

*Last updated: December 2024*
