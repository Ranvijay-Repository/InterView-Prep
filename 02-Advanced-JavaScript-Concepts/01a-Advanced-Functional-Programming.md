# 🔹 Advanced Functional Programming

> **Senior-level functional programming concepts: Monads, Functors, Applicatives, and advanced patterns**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [What are Functors?](#what-are-functors)
- [Understanding Monads](#understanding-monads)
- [Applicative Functors](#applicative-functors)
- [Advanced Composition Patterns](#advanced-composition-patterns)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What are Functors?

**Functors** are containers that can be mapped over. They provide a way to apply functions to values inside containers without changing the container structure.

### Why Functors Matter for Senior Roles:
- **Functional Architecture**: Build robust, composable systems
- **Error Handling**: Create safe, predictable data flows
- **Data Transformation**: Handle complex data pipelines elegantly
- **Interview Preparation**: Demonstrate deep functional programming knowledge

---

## 🔗 Understanding Monads

**Monads** are a way to chain operations on values that might not exist or might fail. They provide a clean way to handle side effects and asynchronous operations.

### Monad Laws:
1. **Left Identity**: `unit(x).flatMap(f) === f(x)`
2. **Right Identity**: `m.flatMap(unit) === m`
3. **Associativity**: `m.flatMap(f).flatMap(g) === m.flatMap(x => f(x).flatMap(g))`

### ASCII Diagram: Monad Structure
```
MONAD STRUCTURE
┌─────────────────────────────────┐
│           MONAD                 │
│  ┌─────────────────────────────┐ │
│  │ value: T                    │ │
│  │ flatMap: (T → Monad<U>)     │ │
│  │           → Monad<U>        │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  Operations   │
        │  Chainable    │
        │  Composable   │
        └───────────────┘
```

### Why Monads Matter:
- **Error Handling**: Safe chaining of operations that might fail
- **Null Safety**: Handle undefined/null values gracefully
- **Async Operations**: Chain asynchronous operations cleanly
- **Functional Composition**: Build complex operations from simple ones

## 🎯 Applicative Functors

**Applicative Functors** allow you to apply functions that are inside a context to values that are also inside a context, without unwrapping them.

### Applicative Laws:
1. **Identity**: `pure(id) <*> v === v`
2. **Homomorphism**: `pure(f) <*> pure(x) === pure(f(x))`
3. **Interchange**: `u <*> pure(y) === pure(f => f(y)) <*> u`
4. **Composition**: `u <*> (v <*> w) === pure(compose) <*> u <*> v <*> w`

### ASCII Diagram: Applicative Pattern
```
APPLICATIVE PATTERN
┌─────────────────────────────────┐
│      APPLICATIVE FUNCTOR       │
│  ┌─────────────────────────────┐ │
│  │ pure: T → Applicative<T>   │ │
│  │ <*>: Applicative<T→U>      │ │
│  │      → Applicative<T>      │ │
│  │      → Applicative<U>      │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │ Function in   │
        │ Context       │
        │ Applied to    │
        │ Value in      │
        │ Context       │
        └───────────────┘
```

### Use Cases:
- **Validation**: Apply validation functions to data
- **Configuration**: Apply config functions to settings
- **Error Handling**: Apply functions to error contexts
- **Async Operations**: Apply functions to Promise results

---

## 🔄 Advanced Composition Patterns

### Function Composition with Monads
```javascript
// Monadic composition example
const composeM = (f, g) => x => 
    x.flatMap(g).flatMap(f);

// Usage with Maybe monad
const safeDivide = (a, b) => 
    b === 0 ? Maybe.nothing() : Maybe.just(a / b);

const safeSqrt = x => 
    x < 0 ? Maybe.nothing() : Maybe.just(Math.sqrt(x));

const composed = composeM(safeSqrt, safeDivide);
```

### Applicative Composition
```javascript
// Applicative composition
const liftA2 = (f, a, b) => 
    a.map(f).ap(b);

const liftA3 = (f, a, b, c) => 
    a.map(f).ap(b).ap(c);

// Example: Adding three numbers safely
const add3 = (a, b, c) => a + b + c;
const safeAdd3 = liftA3(add3, Maybe.just(1), Maybe.just(2), Maybe.just(3));
```

---

## 💻 Detailed Examples

### Example 1: Maybe Monad Implementation
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>class Maybe {
    constructor(value) {
        this.value = value;
    }
    
    static just(value) {
        return new Maybe(value);
    }
    
    static nothing() {
        return new Maybe(null);
    }
    
    map(f) {
        return this.isNothing() ? Maybe.nothing() : Maybe.just(f(this.value));
    }
    
    flatMap(f) {
        return this.isNothing() ? Maybe.nothing() : f(this.value);
    }
    
    isNothing() {
        return this.value === null || this.value === undefined;
    }
    
    getOrElse(defaultValue) {
        return this.isNothing() ? defaultValue : this.value;
    }
}

// Usage examples
const safeDivide = (a, b) => 
    b === 0 ? Maybe.nothing() : Maybe.just(a / b);

const result = Maybe.just(10)
    .flatMap(x => safeDivide(x, 2))
    .map(x => x * 3)
    .getOrElse(0);

console.log(result); // 15
</code></pre>
</div>

### Example 2: Either Monad for Error Handling
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>class Either {
    constructor(left, right) {
        this.left = left;
        this.right = right;
    }
    
    static left(error) {
        return new Either(error, null);
    }
    
    static right(value) {
        return new Either(null, value);
    }
    
    map(f) {
        return this.isLeft() ? this : Either.right(f(this.right));
    }
    
    flatMap(f) {
        return this.isLeft() ? this : f(this.right);
    }
    
    isLeft() {
        return this.left !== null;
    }
    
    isRight() {
        return this.right !== null;
    }
    
    fold(leftFn, rightFn) {
        return this.isLeft() ? leftFn(this.left) : rightFn(this.right);
    }
}

// Usage example
const fetchUser = (id) => {
    if (id < 0) {
        return Either.left("Invalid user ID");
    }
    return Either.right({ id, name: "John Doe" });
};

const result = fetchUser(5)
    .map(user => ({ ...user, greeting: `Hello ${user.name}!` }))
    .fold(
        error => console.error("Error:", error),
        user => console.log("Success:", user)
    );
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What is a Monad and why is it useful?
**A:** A Monad is a design pattern that provides a way to chain operations on values that might not exist or might fail. It's useful for error handling, null safety, and composing operations that have side effects. Monads follow three laws: left identity, right identity, and associativity.

### Q2: What's the difference between Functors and Monads?
**A:** Functors can map over values inside containers using `map()`, while Monads can chain operations using `flatMap()` (also called `bind` or `>>=`). Monads are more powerful because they can handle nested contexts and side effects, while Functors only transform values within a single context.

### Q3: How would you implement the Maybe monad?
**A:** The Maybe monad represents optional values and has two states: `Just(value)` for existing values and `Nothing` for missing values. It implements `map()` for safe transformations and `flatMap()` for chaining operations that might fail. The key is that operations on `Nothing` always return `Nothing`.

### Q4: What are Applicative Functors and when would you use them?
**A:** Applicative Functors allow you to apply functions that are inside a context to values that are also inside a context. They're useful when you need to combine multiple contextual values or apply multiple functions to the same data. They're more powerful than Functors but less powerful than Monads.

### Q5: How do Monads help with error handling?
**A:** Monads like Either or Maybe provide a clean way to handle errors without throwing exceptions. They allow you to chain operations and handle errors at any point in the chain. The error state propagates through the chain, and you can handle it at the end using methods like `fold()` or `getOrElse()`.

---

## 🏋️ Practice Exercises

### Exercise 1: Implement the List Monad
Create a List monad that can handle operations on arrays of values. Implement `map()`, `flatMap()`, and demonstrate how it can be used for list comprehensions.

### Exercise 2: Build a Validation Monad
Implement a Validation monad that can collect multiple validation errors and return them all at once, rather than failing on the first error.

### Exercise 3: Create a State Monad
Implement a State monad that can carry state through a computation chain, allowing you to build stateful computations in a functional way.

---

## 📚 Additional Resources

- **Functional Programming in JavaScript**: [Mostly Adequate Guide](https://github.com/MostlyAdequate/mostly-adequate-guide)
- **Category Theory**: [Bartosz Milewski's Programming Cafe](https://bartoszmilewski.com/)
- **Monads in JavaScript**: [JavaScript Allongé](https://leanpub.com/javascriptallongesix)
- **Functional Programming Libraries**: [Ramda](https://ramdajs.com/), [Folktale](https://folktale.origamitower.com/)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="01-Functional-Programming.md" class="nav-link prev">← Previous: Functional Programming Basics</a>
    <a href="02-Object-Oriented-JavaScript.md" class="nav-link next">Next: Object-Oriented JavaScript →</a>
</div>

*Last updated: December 2024*
