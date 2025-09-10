# 🔄 Pass by Value vs Pass by Reference

> **Understanding how JavaScript passes data to functions and what gets modified**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is Parameter Passing?](#what-is-parameter-passing)
- [Pass by Value](#pass-by-value)
- [Pass by Reference](#pass-by-reference)
- [JavaScript's Approach](#javascripts-approach)
- [Memory Visualization](#memory-visualization)
- [Detailed Examples](#detailed-examples)
- [Common Misconceptions](#common-misconceptions)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What is Parameter Passing?

**Parameter Passing** is the mechanism by which data is transferred from the calling function to the called function. It determines how arguments are handled and whether the original data can be modified.

### Why Understanding This Matters:
- **Function Behavior**: Predict what happens to your data
- **Bug Prevention**: Avoid unintended side effects
- **Performance**: Understand memory implications
- **Debugging**: Know why variables change unexpectedly

---

## 🔢 Pass by Value

**Pass by Value** means a copy of the actual value is passed to the function. The function works with a local copy, and changes don't affect the original variable.

### Characteristics:
- ✅ **Safe**: Original data cannot be modified
- ✅ **Predictable**: Function behavior is isolated
- ✅ **Memory**: Creates a copy (may use more memory)
- ❌ **Performance**: Copying large objects can be slow

---

## 🔗 Pass by Reference

**Pass by Reference** means the memory address (reference) of the data is passed to the function. The function works with the original data, and changes directly affect it.

### Characteristics:
- ✅ **Efficient**: No copying of large data
- ✅ **Direct**: Function can modify original data
- ❌ **Risky**: Original data can be accidentally changed
- ❌ **Unpredictable**: Side effects can occur

---

## 🚀 JavaScript's Approach

JavaScript uses **"Pass by Value"** for all data types, but with a crucial distinction:

- **Primitives**: Passed by value (actual value copied)
- **Objects/Arrays**: Passed by value of reference (reference copied, but both point to same data)

### ASCII Diagram: JavaScript Parameter Passing

{% raw %}
```
PRIMITIVES (Pass by Value)           OBJECTS (Pass by Value of Reference)
┌─────────────────┐                  ┌─────────────────┐
│ Original: 42    │                  │ Original: {x: 1}│
│ Copy: 42        │                  │ Copy: {x: 1}    │
│ (Independent)   │                  │ (Same Reference)│
└─────────────────┘                  └─────────────────┘

Function receives: 42                 Function receives: [ref to {x: 1}]
(completely new copy)                 (copy of reference, same data)
```
{% endraw %}


---

## 🧠 Memory Visualization

### Primitive Values in Memory:

{% raw %}
```
STACK MEMORY
┌─────────────┐
│ a = 42      │ ← Original variable
└─────────────┘
┌─────────────┐
│ param = 42  │ ← Function parameter (copy)
└─────────────┘
```
{% endraw %}


### Object References in Memory:

{% raw %}
```
STACK MEMORY          HEAP MEMORY
┌─────────────┐       ┌─────────────┐
│ obj = [ref] │──────→│ {x: 1, y: 2}│
└─────────────┘       └─────────────┘
┌─────────────┐       │             │
│ param = [ref]│──────┘             │
└─────────────┘       (Same object)
```
{% endraw %}


---

## 💻 Detailed Examples

### Example 1: Primitive Values (True Pass by Value)
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== PRIMITIVE VALUES (PASS BY VALUE) ===");

function modifyPrimitive(value) {
    console.log("Inside function - before modification:", value);
    value = value * 2;  // Modify the local copy
    console.log("Inside function - after modification:", value);
}

let number = 42;
let string = "Hello";
let boolean = true;

console.log("=== Before function calls ===");
console.log("Original number:", number);      // 42
console.log("Original string:", string);      // "Hello"
console.log("Original boolean:", boolean);    // true

console.log("\n=== Calling modifyPrimitive with number ===");
modifyPrimitive(number);
console.log("After function call - number:", number);  // Still 42 ✅

console.log("\n=== Calling modifyPrimitive with string ===");
modifyPrimitive(string);
console.log("After function call - string:", string);  // Still "Hello" ✅

console.log("\n=== Calling modifyPrimitive with boolean ===");
modifyPrimitive(boolean);
console.log("After function call - boolean:", boolean);  // Still true ✅

console.log("\n=== KEY INSIGHT ===");
console.log("Primitive values are truly passed by value!");
console.log("Function modifications don't affect the original variables.");
```
{% endraw %}

</div>

### Example 2: Objects (Pass by Value of Reference)
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== OBJECTS (PASS BY VALUE OF REFERENCE) ===");

function modifyObject(obj) {
    console.log("Inside function - before modification:");
    console.log("obj:", obj);
    
    // Modify the object's properties (affects original!)
    obj.name = "Modified Name";
    obj.age = 999;
    obj.hobbies.push("programming");
    
    console.log("Inside function - after modification:");
    console.log("obj:", obj);
    
    // Try to reassign the parameter (doesn't affect original reference)
    obj = { completely: "new object" };
    console.log("Inside function - after reassignment:");
    console.log("obj:", obj);
}

const person = {
    name: "John",
    age: 30,
    hobbies: ["reading", "gaming"]
};

console.log("=== Before function call ===");
console.log("Original person:", person);

console.log("\n=== Calling modifyObject ===");
modifyObject(person);

console.log("\n=== After function call ===");
console.log("Original person:", person);  // Properties modified! 😱

console.log("\n=== KEY INSIGHT ===");
console.log("Object properties can be modified inside functions");
console.log("But reassigning the parameter doesn't change the original reference");
```
{% endraw %}

</div>

### Example 3: Arrays (Same Behavior as Objects)
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== ARRAYS (PASS BY VALUE OF REFERENCE) ===");

function modifyArray(arr) {
    console.log("Inside function - received array:", arr);
    
    // Modify array elements (affects original!)
    arr[0] = "MODIFIED";
    arr.push("NEW_ITEM");
    
    console.log("Inside function - after modification:", arr);
    
    // Try to reassign (doesn't affect original reference)
    arr = ["completely", "new", "array"];
    console.log("Inside function - after reassignment:", arr);
}

const numbers = [1, 2, 3, 4, 5];
const strings = ["apple", "banana", "cherry"];

console.log("=== Before function calls ===");
console.log("Original numbers:", numbers);
console.log("Original strings:", strings);

console.log("\n=== Calling modifyArray with numbers ===");
modifyArray(numbers);
console.log("After function call - numbers:", numbers);  // Modified! 😱

console.log("\n=== Calling modifyArray with strings ===");
modifyArray(strings);
console.log("After function call - strings:", strings);  // Modified! 😱

console.log("\n=== KEY INSIGHT ===");
console.log("Array elements can be modified inside functions");
console.log("But reassigning the parameter doesn't change the original reference");
```
{% endraw %}

</div>

### Example 4: Function Parameters and Return Values
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== FUNCTION PARAMETERS AND RETURN VALUES ===");

function processData(primitive, object, array) {
    console.log("=== Inside processData ===");
    console.log("Received primitive:", primitive);
    console.log("Received object:", object);
    console.log("Received array:", array);
    
    // Modify primitive (local copy only)
    primitive = primitive * 10;
    
    // Modify object properties (affects original)
    object.value = "CHANGED";
    
    // Modify array elements (affects original)
    array[0] = "FIRST_CHANGED";
    
    console.log("After modifications:");
    console.log("Local primitive:", primitive);
    console.log("Modified object:", object);
    console.log("Modified array:", array);
    
    // Return modified values
    return {
        primitiveResult: primitive,
        objectResult: object,
        arrayResult: array
    };
}

// Test data
let number = 5;
const obj = { value: "original", id: 1 };
const arr = ["first", "second", "third"];

console.log("=== Before function call ===");
console.log("number:", number);
console.log("obj:", obj);
console.log("arr:", arr);

console.log("\n=== Calling processData ===");
const result = processData(number, obj, arr);

console.log("\n=== After function call ===");
console.log("number:", number);        // Still 5 ✅ (primitive)
console.log("obj:", obj);              // Modified! 😱 (object)
console.log("arr:", arr);              // Modified! 😱 (array)

console.log("\n=== Function return value ===");
console.log("result:", result);

console.log("\n=== KEY INSIGHT ===");
console.log("Primitives: Safe, won't be modified");
console.log("Objects/Arrays: Properties/elements can be modified");
console.log("Return values provide a way to get modified primitives back");
```
{% endraw %}

</div>

### Example 5: Preventing Unintended Modifications
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


{% raw %}
```javascript
console.log("=== PREVENTING UNINTENDED MODIFICATIONS ===");

// ❌ BAD: Function that modifies input
function badFunction(obj) {
    obj.name = "BADLY_MODIFIED";
    obj.timestamp = Date.now();
    return "Operation completed";
}

// ✅ GOOD: Function that doesn't modify input
function goodFunction(obj) {
    // Create a copy to work with
    const workingCopy = { ...obj };
    
    // Modify the copy, not the original
    workingCopy.name = "SAFELY_MODIFIED";
    workingCopy.timestamp = Date.now();
    
    return workingCopy;
}

// ✅ BETTER: Function that's completely pure
function betterFunction(obj) {
    // Return new object without modifying input
    return {
        ...obj,
        name: "PURELY_MODIFIED",
        timestamp: Date.now(),
        processed: true
    };
}

// Test data
const originalUser = {
    name: "John",
    email: "john@example.com",
    preferences: { theme: "dark" }
};

console.log("=== Original data ===");
console.log("originalUser:", originalUser);

console.log("\n=== Testing badFunction ===");
const badResult = badFunction(originalUser);
console.log("Function result:", badResult);
console.log("Original modified:", originalUser);  // 😱 Modified!

console.log("\n=== Testing goodFunction ===");
const goodResult = goodFunction(originalUser);
console.log("Function result:", goodResult);
console.log("Original preserved:", originalUser);  // ✅ Preserved!

console.log("\n=== Testing betterFunction ===");
const betterResult = betterFunction(originalUser);
console.log("Function result:", betterResult);
console.log("Original preserved:", originalUser);  // ✅ Preserved!

console.log("\n=== KEY INSIGHT ===");
console.log("Always consider whether your function should modify input");
console.log("Use defensive copying to prevent unintended side effects");
console.log("Pure functions are easier to test and reason about");
```
{% endraw %}

</div>

---

## ⚠️ Common Misconceptions

### Misconception 1: "JavaScript is Pass by Reference"

{% raw %}
```javascript
// ❌ WRONG: Thinking JavaScript passes objects by reference
function wrongUnderstanding(obj) {
    obj = { new: "object" };  // This doesn't affect the original!
}

const original = { value: "original" };
wrongUnderstanding(original);
console.log(original); // Still { value: "original" } ✅
```
{% endraw %}


### Misconception 2: "Primitives are Passed by Reference"

{% raw %}
```javascript
// ❌ WRONG: Thinking primitives are passed by reference
function modifyString(str) {
    str = str.toUpperCase();  // This doesn't affect the original!
}

let message = "hello";
modifyString(message);
console.log(message); // Still "hello" ✅
```
{% endraw %}


---

## 🎯 Best Practices

### ✅ Do's:
- **Understand the difference** between primitive and object parameter passing
- **Use defensive copying** when you don't want to modify input
- **Return new objects** instead of modifying existing ones
- **Document side effects** clearly in function documentation
- **Test with both primitives and objects** to ensure expected behavior

### ❌ Don'ts:
- **Don't assume** objects are passed by reference
- **Don't modify** input parameters unless explicitly intended
- **Don't forget** that array methods modify the original array
- **Don't ignore** the performance implications of copying large objects

---

## 🔑 Key Points

- **JavaScript uses Pass by Value** for all data types
- **Primitives**: True pass by value (copies are independent)
- **Objects/Arrays**: Pass by value of reference (reference copied, data shared)
- **Function parameters** are local variables within the function scope
- **Modifying object properties** affects the original object
- **Reassigning parameters** doesn't affect the original reference
- **Defensive copying** prevents unintended side effects

---

## ❓ Common Interview Questions

### Q1: How does JavaScript pass parameters to functions?
**A:** JavaScript uses pass by value for all data types. For primitives, the actual value is copied. For objects and arrays, a copy of the reference is passed, but both the original and the copy point to the same data in memory.

### Q2: What's the difference between pass by value and pass by reference?
**A:** Pass by value means a copy of the data is passed, and modifications don't affect the original. Pass by reference means the memory address is passed, and modifications directly affect the original data.

### Q3: Can you modify an object passed to a function?
**A:** Yes, you can modify the properties of an object passed to a function, and these changes will affect the original object. However, you cannot change which object the original variable references.

### Q4: How would you prevent a function from modifying its input parameters?
**A:** Use defensive copying techniques like spread operator (`{...obj}`), `Object.assign({}, obj)`, or `JSON.parse(JSON.stringify(obj))` for deep copying.

### Q5: What happens when you reassign a parameter inside a function?
**A:** Reassigning a parameter only changes the local variable within the function. It doesn't affect the original variable that was passed in, regardless of whether it's a primitive or object.

---

## 🏋️ Practice Exercises

### Exercise 1: Parameter Behavior Analysis
Create functions that demonstrate different parameter passing behaviors and test them with various data types.

### Exercise 2: Defensive Programming
Implement functions that safely work with input parameters without modifying them, using appropriate copying strategies.

### Exercise 3: Side Effect Detection
Write a tool that can analyze functions and identify potential side effects based on parameter usage.

---

## 📚 Additional Resources

- [MDN: Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions)
- [JavaScript.info: Function parameters](https://javascript.info/function-basics)
- [Eloquent JavaScript: Functions](https://eloquentjavascript.net/03_functions.html)
- [You Don't Know JS: Scope & Closures](https://github.com/getify/You-Dont-Know-JS)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="07-Deep-Copy-vs-Shallow-Copy.md" class="nav-link prev">← Previous: Deep Copy vs Shallow Copy</a>
    <a href="09-Type-Coercion.md" class="nav-link next">Next: Type Coercion →</a>
</div>

*Last updated: December 2024*
