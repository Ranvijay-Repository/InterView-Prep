# 🔧 **Functions & Parameters**

> **Complete guide to TypeScript functions, parameter types, return types, and advanced function features**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Function Declarations](#function-declarations)
- [Function Expressions](#function-expressions)
- [Arrow Functions](#arrow-functions)
- [Parameter Types](#parameter-types)
- [Return Types](#return-types)
- [Function Overloads](#function-overloads)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Function Declarations**

TypeScript enhances JavaScript functions with type annotations for parameters and return values.

### **Basic Function Declaration**

```typescript
// Function with typed parameters and return type
function add(a: number, b: number): number {
  return a + b;
}

// Function with string parameters
function greet(name: string): string {
  return `Hello, ${name}!`;
}

// Function with no return value (void)
function logMessage(message: string): void {
  console.log(message);
}
```

### **Function with Optional Parameters**

```typescript
// Optional parameter with ?
function createUser(name: string, age?: number): object {
  if (age) {
    return { name, age };
  }
  return { name };
}

// Usage
createUser("John"); // { name: "John" }
createUser("Alice", 25); // { name: "Alice", age: 25 }
```

### **Function with Default Parameters**

```typescript
// Default parameter values
function greetUser(name: string, greeting: string = "Hello"): string {
  return `${greeting}, ${name}!`;
}

// Usage
greetUser("John"); // "Hello, John!"
greetUser("Alice", "Hi"); // "Hi, Alice!"
```

---

## 📝 **Function Expressions**

Function expressions in TypeScript can be typed using the function type syntax.

### **Basic Function Expression**

```typescript
// Function expression with type annotation
const multiply = function(x: number, y: number): number {
  return x * y;
};

// Function expression assigned to typed variable
const divide: (a: number, b: number) => number = function(x, y) {
  return x / y;
};
```

### **Function Type Aliases**

```typescript
// Define function type
type MathOperation = (a: number, b: number) => number;

// Use the type
const add: MathOperation = (x, y) => x + y;
const subtract: MathOperation = (x, y) => x - y;

// Function that takes a function as parameter
function calculate(a: number, b: number, operation: MathOperation): number {
  return operation(a, b);
}
```

---

## 🏹 **Arrow Functions**

Arrow functions in TypeScript provide concise syntax with full type support.

### **Basic Arrow Functions**

```typescript
// Simple arrow function
const square = (x: number): number => x * x;

// Arrow function with block body
const formatName = (firstName: string, lastName: string): string => {
  return `${firstName} ${lastName}`;
};

// Arrow function with no parameters
const getCurrentTime = (): Date => new Date();
```

### **Arrow Functions with Complex Types**

```typescript
// Arrow function returning an object
const createPerson = (name: string, age: number): { name: string; age: number } => ({
  name,
  age
});

// Arrow function with array return type
const getEvenNumbers = (numbers: number[]): number[] => {
  return numbers.filter(n => n % 2 === 0);
};
```

---

## 📋 **Parameter Types**

TypeScript provides several ways to handle different parameter scenarios.

### **Required Parameters**

```typescript
// All parameters are required
function buildUrl(protocol: string, domain: string, path: string): string {
  return `${protocol}://${domain}/${path}`;
}

// Usage
buildUrl("https", "example.com", "api/users");
```

### **Optional Parameters**

```typescript
// Optional parameters with ?
function searchUsers(query: string, limit?: number, offset?: number): User[] {
  // Implementation
  return [];
}

// Usage
searchUsers("john"); // limit and offset are undefined
searchUsers("john", 10); // limit = 10, offset is undefined
searchUsers("john", 10, 20); // limit = 10, offset = 20
```

### **Rest Parameters**

```typescript
// Rest parameters (spread operator)
function sum(...numbers: number[]): number {
  return numbers.reduce((total, num) => total + num, 0);
}

// Usage
sum(1, 2, 3, 4, 5); // 15
sum(10, 20); // 30
```

### **Destructured Parameters**

```typescript
// Object destructuring in parameters
function createUser({ name, age, email }: { name: string; age: number; email: string }): User {
  return { name, age, email };
}

// Array destructuring in parameters
function getFirstAndLast([first, ...rest]: string[]): { first: string; last: string } {
  return { first, last: rest[rest.length - 1] };
}
```

---

## 🔄 **Return Types**

TypeScript allows you to specify what a function returns.

### **Explicit Return Types**

```typescript
// Function with explicit return type
function getFullName(firstName: string, lastName: string): string {
  return `${firstName} ${lastName}`;
}

// Function returning an object
function createConfig(): { apiUrl: string; timeout: number } {
  return {
    apiUrl: "https://api.example.com",
    timeout: 5000
  };
}

// Function returning a union type
function parseId(id: string | number): number {
  if (typeof id === "string") {
    return parseInt(id, 10);
  }
  return id;
}
```

### **Void and Never Return Types**

```typescript
// Void - function doesn't return a value
function logError(error: string): void {
  console.error(error);
}

// Never - function never returns (throws error or infinite loop)
function throwError(message: string): never {
  throw new Error(message);
}

// Never - infinite loop
function infiniteLoop(): never {
  while (true) {
    // This function never returns
  }
}
```

---

## 🔀 **Function Overloads**

Function overloads allow you to define multiple function signatures for the same function.

### **Basic Function Overloads**

```typescript
// Function overloads
function format(value: string): string;
function format(value: number): string;
function format(value: boolean): string;
function format(value: string | number | boolean): string {
  return String(value);
}

// Usage
format("hello"); // string
format(42); // string
format(true); // string
```

### **Complex Function Overloads**

```typescript
// Overloads for different parameter combinations
function createElement(tag: string): HTMLElement;
function createElement(tag: string, attributes: Record<string, string>): HTMLElement;
function createElement(tag: string, attributes: Record<string, string>, children: string[]): HTMLElement;
function createElement(
  tag: string,
  attributes?: Record<string, string>,
  children?: string[]
): HTMLElement {
  const element = document.createElement(tag);
  
  if (attributes) {
    Object.entries(attributes).forEach(([key, value]) => {
      element.setAttribute(key, value);
    });
  }
  
  if (children) {
    children.forEach(child => {
      element.appendChild(document.createTextNode(child));
    });
  }
  
  return element;
}
```

---

## ✅ **Best Practices**

### **1. Use Explicit Return Types for Public APIs**

```typescript
// ✅ Good: Explicit return type for public function
export function calculateTotal(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// ❌ Avoid: Relying on inference for public APIs
export function calculateTotal(items: Item[]) {
  return items.reduce((sum, item) => sum + item.price, 0);
}
```

### **2. Use Function Overloads for Complex APIs**

```typescript
// ✅ Good: Clear overloads for different use cases
function fetchData(url: string): Promise<Response>;
function fetchData(url: string, options: RequestInit): Promise<Response>;
function fetchData(url: string, options?: RequestInit): Promise<Response> {
  return fetch(url, options);
}
```

### **3. Prefer Arrow Functions for Simple Operations**

```typescript
// ✅ Good: Arrow function for simple operations
const double = (x: number): number => x * 2;

// ❌ Avoid: Function declaration for simple operations
function double(x: number): number {
  return x * 2;
}
```

### **4. Use Rest Parameters for Variable Arguments**

```typescript
// ✅ Good: Rest parameters for variable arguments
function logMessages(...messages: string[]): void {
  messages.forEach(msg => console.log(msg));
}

// ❌ Avoid: Array parameter when rest is more appropriate
function logMessages(messages: string[]): void {
  messages.forEach(msg => console.log(msg));
}
```

---

## ❓ **Common Interview Questions**

### **1. How do you define function types in TypeScript?**

**Answer:**
Function types can be defined using:
- **Function type syntax**: `(param: type) => returnType`
- **Function interface**: `interface MyFunction { (param: type): returnType; }`
- **Type alias**: `type MyFunction = (param: type) => returnType;`

```typescript
// Function type syntax
const add: (a: number, b: number) => number = (x, y) => x + y;

// Interface
interface MathOperation {
  (a: number, b: number): number;
}

// Type alias
type MathOp = (a: number, b: number) => number;
```

### **2. What's the difference between optional and default parameters?**

**Answer:**
- **Optional parameters**: Can be omitted, will be `undefined` if not provided
- **Default parameters**: Have a default value if not provided

```typescript
// Optional parameter
function greet(name: string, age?: number): string {
  return age ? `${name} is ${age}` : `Hello ${name}`;
}

// Default parameter
function greet(name: string, greeting: string = "Hello"): string {
  return `${greeting}, ${name}!`;
}
```

### **3. How do function overloads work in TypeScript?**

**Answer:**
Function overloads allow multiple function signatures for the same function. TypeScript uses the first matching signature:

```typescript
function process(value: string): string;
function process(value: number): number;
function process(value: string | number): string | number {
  return value;
}
```

### **4. When should you use `void` vs `never` return types?**

**Answer:**
- **`void`**: Function completes but doesn't return a value
- **`never`**: Function never completes (throws error, infinite loop)

```typescript
function logMessage(msg: string): void {
  console.log(msg); // Completes, returns undefined
}

function throwError(msg: string): never {
  throw new Error(msg); // Never completes
}
```

### **5. How do you handle rest parameters in TypeScript?**

**Answer:**
Rest parameters collect remaining arguments into an array:

```typescript
function sum(...numbers: number[]): number {
  return numbers.reduce((total, num) => total + num, 0);
}

sum(1, 2, 3, 4, 5); // numbers = [1, 2, 3, 4, 5]
```

---

## 🧭 Navigation

<div class="navigation">
  <a href="01-Basic-Types-Type-Annotations.md" class="nav-button">← Previous: Basic Types & Type Annotations</a>
  <a href="03-Classes-Objects.md" class="nav-button">Next: Classes & Objects →</a>
</div>

*Last updated: December 2024*
