# 🔄 Type Coercion

> **Understanding how JavaScript automatically converts types and how to control it**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is Type Coercion?](#what-is-type-coercion)
- [Types of Type Coercion](#types-of-type-coercion)
- [Implicit vs Explicit Coercion](#implicit-vs-explicit-coercion)
- [Coercion Rules](#coercion-rules)
- [Common Coercion Scenarios](#common-coercion-scenarios)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercions)
- [Additional Resources](#additional-resources)

---

## 🎯 What is Type Coercion?

**Type Coercion** is JavaScript's automatic conversion of one data type to another when performing operations. It happens when the expected type doesn't match the actual type.

### Why Understanding This Matters:
- **Predictable Code**: Know what your operations will produce
- **Bug Prevention**: Avoid unexpected type conversions
- **Performance**: Understand conversion overhead
- **Debugging**: Identify why operations behave unexpectedly

---

## 🔄 Types of Type Coercion

### 1. **Implicit Coercion** (Automatic)
JavaScript automatically converts types during operations:
```javascript
"5" + 3        // "53" (string concatenation)
"5" - 3        // 2 (number subtraction)
"5" * "3"      // 15 (number multiplication)
```

### 2. **Explicit Coercion** (Manual)
Developer intentionally converts types:
```javascript
String(42)     // "42"
Number("42")   // 42
Boolean(0)     // false
```

---

## ⚖️ Implicit vs Explicit Coercion

| Aspect | Implicit Coercion | Explicit Coercion |
|--------|-------------------|-------------------|
| **Control** | Automatic | Manual |
| **Readability** | Can be unclear | Clear intent |
| **Predictability** | Sometimes surprising | Always predictable |
| **Best Practice** | Avoid when possible | Use when needed |

---

## 📋 Coercion Rules

### ASCII Diagram: Coercion Priority
```
COERCION PRIORITY CHART
┌─────────────────────────────────────┐
│ 1. STRING + ANYTHING = STRING      │
│    "5" + 3 → "53"                 │
│    "5" + true → "5true"           │
│    "5" + null → "5null"           │
├─────────────────────────────────────┤
│ 2. ARITHMETIC OPERATIONS           │
│    Convert to NUMBER when possible │
│    "5" - 3 → 2                    │
│    "5" * "3" → 15                 │
│    "5" / "2" → 2.5                │
├─────────────────────────────────────┤
│ 3. COMPARISON OPERATORS            │
│    == (loose equality)             │
│    != (loose inequality)           │
│    >, <, >=, <=                   │
├─────────────────────────────────────┤
│ 4. LOGICAL OPERATORS               │
│    &&, ||, ! (convert to boolean) │
└─────────────────────────────────────┘
```

### String Coercion Rules:
- **String + Anything** = String concatenation
- **Template literals** convert everything to string
- **String()** constructor converts explicitly

### Number Coercion Rules:
- **Arithmetic operators** (except + with string) convert to number
- **Number()** constructor converts explicitly
- **parseInt()** and **parseFloat()** for specific parsing

### Boolean Coercion Rules:
- **Falsy values**: `false`, `0`, `""`, `null`, `undefined`, `NaN`
- **Truthy values**: Everything else
- **Logical operators** convert to boolean

---

## 🎭 Common Coercion Scenarios

### 1. **String Concatenation**
```javascript
"Hello" + " " + "World"     // "Hello World"
"5" + 3                     // "53"
"Price: " + 99.99           // "Price: 99.99"
```

### 2. **Arithmetic Operations**
```javascript
"5" - 3                     // 2
"5" * "3"                   // 15
"10" / "2"                  // 5
"5" % "2"                   // 1
```

### 3. **Comparison Operations**
```javascript
"5" == 5                    // true (loose equality)
"5" === 5                   // false (strict equality)
"10" > 5                    // true
"abc" < "def"               // true (lexicographic)
```

---

## 💻 Detailed Examples

### Example 1: String Coercion
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== STRING COERCION EXAMPLES ===");

// String concatenation with different types
console.log("=== String + Primitive Types ===");
console.log("String + Number:", "Hello" + 42);           // "Hello42"
console.log("String + Boolean:", "Value: " + true);      // "Value: true"
console.log("String + Null:", "Null: " + null);          // "Null: null"
console.log("String + Undefined:", "Undef: " + undefined); // "Undef: undefined"

// String concatenation with objects
console.log("\n=== String + Objects ===");
const obj = { name: "John", age: 30 };
const arr = [1, 2, 3];
const func = function() { return "function"; };

console.log("String + Object:", "Object: " + obj);       // "Object: [object Object]"
console.log("String + Array:", "Array: " + arr);         // "Array: 1,2,3"
console.log("String + Function:", "Func: " + func);      // "Func: function() { return 'function'; }"

// Template literals (automatic string conversion)
console.log("\n=== Template Literals ===");
const number = 42;
const boolean = true;
const nullValue = null;

console.log(`Number: ${number}`);                         // "Number: 42"
console.log(`Boolean: ${boolean}`);                       // "Boolean: true"
console.log(`Null: ${nullValue}`);                        // "Null: null"
console.log(`Expression: ${2 + 3}`);                      // "Expression: 5"

// Explicit string conversion
console.log("\n=== Explicit String Conversion ===");
console.log("String(42):", String(42));                  // "42"
console.log("String(true):", String(true));               // "true"
console.log("String(null):", String(null));               // "null"
console.log("String(undefined):", String(undefined));     // "undefined"
console.log("String({}):", String({}));                   // "[object Object]"
```
</div>

### Example 2: Number Coercion
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== NUMBER COERCION EXAMPLES ===");

// Arithmetic operations (automatic number conversion)
console.log("=== Arithmetic Operations ===");
console.log("'5' - 3:", "5" - 3);                        // 2
console.log("'5' * '3':", "5" * "3");                    // 15
console.log("'10' / '2':", "10" / "2");                  // 5
console.log("'7' % '3':", "7" % "3");                    // 1
console.log("'5' ** '2':", "5" ** "2");                  // 25

// Unary operators
console.log("\n=== Unary Operators ===");
console.log("+'42':", +"42");                             // 42
console.log("-'42':", -"42");                             // -42
console.log("+'abc':", +"abc");                           // NaN
console.log("+'':", +"");                                 // 0
console.log("+true:", +true);                             // 1
console.log("+false:", +false);                           // 0
console.log("+null:", +null);                             // 0
console.log("+undefined:", +undefined);                   // NaN

// Explicit number conversion
console.log("\n=== Explicit Number Conversion ===");
console.log("Number('42'):", Number("42"));               // 42
console.log("Number('42.5'):", Number("42.5"));           // 42.5
console.log("Number('abc'):", Number("abc"));             // NaN
console.log("Number(''):", Number(""));                   // 0
console.log("Number(true):", Number(true));                // 1
console.log("Number(false):", Number(false));              // 0
console.log("Number(null):", Number(null));                // 0
console.log("Number(undefined):", Number(undefined));      // NaN

// parseInt and parseFloat
console.log("\n=== parseInt and parseFloat ===");
console.log("parseInt('42.9'):", parseInt("42.9"));      // 42
console.log("parseFloat('42.9'):", parseFloat("42.9"));  // 42.9
console.log("parseInt('42px'):", parseInt("42px"));      // 42
console.log("parseInt('px42'):", parseInt("px42"));      // NaN
```
</div>

### Example 3: Boolean Coercion
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== BOOLEAN COERCION EXAMPLES ===");

// Falsy values (convert to false)
console.log("=== Falsy Values ===");
console.log("Boolean(false):", Boolean(false));           // false
console.log("Boolean(0):", Boolean(0));                   // false
console.log("Boolean(-0):", Boolean(-0));                 // false
console.log("Boolean(''):", Boolean(""));                 // false
console.log("Boolean(null):", Boolean(null));              // false
console.log("Boolean(undefined):", Boolean(undefined));   // false
console.log("Boolean(NaN):", Boolean(NaN));               // false

// Truthy values (convert to true)
console.log("\n=== Truthy Values ===");
console.log("Boolean(true):", Boolean(true));             // true
console.log("Boolean(42):", Boolean(42));                 // true
console.log("Boolean(-42):", Boolean(-42));               // true
console.log("Boolean('hello'):", Boolean("hello"));       // true
console.log("Boolean('0'):", Boolean("0"));               // true (string!)
console.log("Boolean('false'):", Boolean("false"));       // true (string!)
console.log("Boolean([]):", Boolean([]));                 // true
console.log("Boolean({}):", Boolean({}));                 // true
console.log("Boolean(function(){}):", Boolean(function(){})); // true

// Logical operators (implicit boolean conversion)
console.log("\n=== Logical Operators ===");
console.log("!false:", !false);                           // true
console.log("!'hello':", !"hello");                       // false
console.log("!0:", !0);                                   // true
console.log("!!'hello':", !!"hello");                     // true (double negation)
console.log("!!0:", !!0);                                 // false

// Short-circuit evaluation
console.log("\n=== Short-Circuit Evaluation ===");
const result1 = "hello" && "world";                       // "world" (truthy)
const result2 = "" && "world";                            // "" (falsy)
const result3 = "hello" || "world";                       // "hello" (truthy)
const result4 = "" || "world";                            // "world" (falsy)

console.log("'hello' && 'world':", result1);
console.log("'' && 'world':", result2);
console.log("'hello' || 'world':", result3);
console.log("'' || 'world':", result4);
```
</div>

### Example 4: Comparison Coercion
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== COMPARISON COERCION EXAMPLES ===");

// Loose equality (==) - allows type coercion
console.log("=== Loose Equality (==) ===");
console.log("'5' == 5:", "5" == 5);                       // true
console.log("5 == '5':", 5 == "5");                       // true
console.log("true == 1:", true == 1);                     // true
console.log("false == 0:", false == 0);                   // true
console.log("null == undefined:", null == undefined);      // true
console.log("null == 0:", null == 0);                     // false
console.log("undefined == 0:", undefined == 0);            // false
console.log("NaN == NaN:", NaN == NaN);                    // false (NaN is never equal to anything!)

// Strict equality (===) - no type coercion
console.log("\n=== Strict Equality (===) ===");
console.log("'5' === 5:", "5" === 5);                     // false
console.log("5 === 5:", 5 === 5);                         // true
console.log("true === 1:", true === 1);                   // false
console.log("false === 0:", false === 0);                 // false
console.log("null === undefined:", null === undefined);    // false

// Comparison operators (>, <, >=, <=)
console.log("\n=== Comparison Operators ===");
console.log("'5' > 3:", "5" > 3);                         // true
console.log("'10' < 5:", "10" < 5);                       // false (lexicographic comparison!)
console.log("'abc' < 'def':", "abc" < "def");             // true
console.log("'2' >= 2:", "2" >= 2);                       // true
console.log("'1' <= 10:", "1" <= 10);                     // true

// Tricky comparisons
console.log("\n=== Tricky Comparisons ===");
console.log("[] == false:", [] == false);                 // true (empty array converts to 0)
console.log("[] == 0:", [] == 0);                         // true
console.log("[] == '':", [] == "");                       // true
console.log("{} == false:", {} == false);                 // false
console.log("{} == 0:", {} == 0);                         // false
console.log("{} == '':", {} == "");                       // false

// Array comparisons
console.log("\n=== Array Comparisons ===");
console.log("[] == []:", [] == []);                       // false (different references)
console.log("[] == ![]:", [] == ![]);                     // true (![] converts to false, [] converts to 0)
console.log("[1,2] == '1,2':", [1,2] == "1,2");         // true (array converts to string)
```
</div>

### Example 5: Real-World Coercion Scenarios
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>

```javascript
console.log("=== REAL-WORLD COERCION SCENARIOS ===");

// Form input handling
console.log("=== Form Input Handling ===");
const formInputs = {
    username: "john_doe",
    age: "25",
    isActive: "true",
    score: "95.5"
};

// Common mistake: not converting types
console.log("=== Common Mistakes ===");
console.log("Age + 1:", formInputs.age + 1);              // "251" (string concatenation!)
console.log("Score * 2:", formInputs.score * 2);          // 191 (correct - number operation)
console.log("Is active:", formInputs.isActive);            // "true" (string, not boolean)

// Proper type handling
console.log("\n=== Proper Type Handling ===");
const processedInputs = {
    username: String(formInputs.username),                 // Already string
    age: Number(formInputs.age),                           // Convert to number
    isActive: Boolean(formInputs.isActive === "true"),     // Convert to boolean
    score: parseFloat(formInputs.score)                    // Convert to number
};

console.log("Processed inputs:", processedInputs);
console.log("Age + 1:", processedInputs.age + 1);         // 26 ✅
console.log("Score * 2:", processedInputs.score * 2);     // 191 ✅
console.log("Is active:", processedInputs.isActive);       // true ✅

// API response handling
console.log("\n=== API Response Handling ===");
const apiResponse = {
    id: "123",
    name: "Product A",
    price: "29.99",
    inStock: "1",
    tags: "electronics, gadgets"
};

// Convert API response to proper types
const product = {
    id: Number(apiResponse.id),
    name: String(apiResponse.name),
    price: parseFloat(apiResponse.price),
    inStock: Boolean(Number(apiResponse.inStock)),
    tags: apiResponse.tags.split(", ")
};

console.log("Original API response:", apiResponse);
console.log("Processed product:", product);
console.log("Price with tax:", product.price * 1.1);      // 32.989 ✅
console.log("Is in stock:", product.inStock);              // true ✅
console.log("Number of tags:", product.tags.length);       // 2 ✅
```
</div>

---

## ⚠️ Common Pitfalls

### Pitfall 1: String Concatenation vs Addition
```javascript
// ❌ WRONG: Unexpected string concatenation
const price = "10";
const quantity = 5;
const total = price + quantity;  // "105" instead of 15

// ✅ CORRECT: Explicit conversion
const total = Number(price) + quantity;  // 15
```

### Pitfall 2: Loose Equality Confusion
```javascript
// ❌ WRONG: Loose equality can be confusing
console.log([] == false);    // true
console.log({} == false);    // false
console.log(null == 0);      // false
console.log(null == undefined); // true

// ✅ CORRECT: Use strict equality
console.log([] === false);   // false
console.log({} === false);   // false
console.log(null === 0);     // false
console.log(null === undefined); // false
```

### Pitfall 3: Boolean Conversion Surprises
```javascript
// ❌ WRONG: Surprising boolean conversions
console.log(Boolean("0"));      // true (string "0" is truthy!)
console.log(Boolean("false"));  // true (string "false" is truthy!)
console.log(Boolean([]));       // true (empty array is truthy!)

// ✅ CORRECT: Be explicit about what you want
console.log("0" === "0");      // true
console.log("false" === "false"); // true
console.log([] === []);        // false (different references)
```

---

## 🎯 Best Practices

### ✅ Do's:
- **Use strict equality** (`===`, `!==`) instead of loose equality (`==`, `!=`)
- **Be explicit** about type conversions when needed
- **Understand** the coercion rules for your operations
- **Test** edge cases with different data types
- **Document** expected input types in your functions

### ❌ Don'ts:
- **Don't rely** on implicit coercion for critical operations
- **Don't assume** types without checking
- **Don't use** loose equality unless you specifically need coercion
- **Don't ignore** the performance implications of repeated conversions

---

## 🔑 Key Points

- **Type Coercion** is JavaScript's automatic type conversion
- **Implicit coercion** happens automatically during operations
- **Explicit coercion** gives you control over type conversion
- **String concatenation** (`+`) converts everything to string
- **Arithmetic operations** convert to number when possible
- **Logical operators** convert to boolean
- **Strict equality** (`===`) prevents unexpected coercion
- **Always be explicit** about types when it matters

---

## ❓ Common Interview Questions

### Q1: What is type coercion in JavaScript?
**A:** Type coercion is JavaScript's automatic conversion of one data type to another when performing operations. It happens when the expected type doesn't match the actual type, such as adding a string and a number.

### Q2: What's the difference between == and ===?
**A:** `==` (loose equality) allows type coercion and compares values after conversion, while `===` (strict equality) requires both value and type to be the same without any conversion.

### Q3: What are falsy values in JavaScript?
**A:** Falsy values are: `false`, `0`, `-0`, `0n`, `""`, `null`, `undefined`, and `NaN`. Everything else is considered truthy.

### Q4: How does string concatenation work with different types?
**A:** The `+` operator with a string converts everything to a string. For example, `"5" + 3` becomes `"53"`, and `"Hello" + true` becomes `"Hellotrue"`.

### Q5: What's the best way to avoid type coercion issues?
**A:** Use strict equality (`===`, `!==`), be explicit about type conversions when needed, and understand the coercion rules for your operations. Always test with different data types to ensure expected behavior.

---

## 🏋️ Practice Exercises

### Exercise 1: Type Conversion Function
Create a function that safely converts any value to a specific type (string, number, or boolean) with proper error handling.

### Exercise 2: Coercion Predictor
Write a function that predicts the result of type coercion between two values and explains the conversion process.

### Exercise 3: Safe Comparison Utility
Implement utility functions for safe comparisons that handle edge cases and provide clear feedback about what's being compared.

---

## 📚 Additional Resources

- [MDN: Type coercion](https://developer.mozilla.org/en-US/docs/Glossary/Type_coercion)
- [JavaScript.info: Type conversions](https://javascript.info/type-conversions)
- [You Don't Know JS: Types & Grammar](https://github.com/getify/You-Dont-Know-JS)
- [ECMAScript specification](https://tc39.es/ecma262/)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="08-Pass-by-Value-vs-Pass-by-Reference.md" class="nav-link prev">← Previous: Pass by Value vs Pass by Reference</a>
    <a href="10-The-this-Keyword.md" class="nav-link next">Next: The `this` Keyword →</a>
</div>

*Last updated: December 2024*
