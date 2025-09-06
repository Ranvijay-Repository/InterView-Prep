# 📝 **Basic Types & Type Annotations**

> **Complete guide to TypeScript's basic types, type annotations, and type inference**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Basic Types](#basic-types)
- [Type Annotations](#type-annotations)
- [Type Inference](#type-inference)
- [Type Assertions](#type-assertions)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Basic Types**

TypeScript provides several basic types that correspond to JavaScript's primitive types and more.

### **Primitive Types**

```typescript
// String
let message: string = "Hello, TypeScript!";
let template: string = `Welcome ${message}`;

// Number
let count: number = 42;
let price: number = 99.99;
let hex: number = 0xf00d;
let binary: number = 0b1010;
let octal: number = 0o744;

// Boolean
let isActive: boolean = true;
let isComplete: boolean = false;

// Null and Undefined
let nullValue: null = null;
let undefinedValue: undefined = undefined;
```

### **Special Types**

```typescript
// Any - disables type checking
let anything: any = 42;
anything = "hello";
anything = true;

// Void - for functions that don't return a value
function logMessage(msg: string): void {
  console.log(msg);
}

// Never - for functions that never return
function throwError(message: string): never {
  throw new Error(message);
}

// Unknown - safer alternative to any
let userInput: unknown = getUserInput();
// userInput.toUpperCase(); // ❌ Error: Object is of type 'unknown'
```

---

## ✍️ **Type Annotations**

Type annotations explicitly specify the type of a variable, function parameter, or return value.

### **Variable Type Annotations**

```typescript
// Explicit type annotations
let userName: string = "John";
let userAge: number = 25;
let isLoggedIn: boolean = false;

// Array type annotations
let numbers: number[] = [1, 2, 3, 4, 5];
let names: string[] = ["Alice", "Bob", "Charlie"];

// Alternative array syntax
let scores: Array<number> = [85, 92, 78, 96];
let colors: Array<string> = ["red", "green", "blue"];
```

### **Function Type Annotations**

```typescript
// Function parameter and return type annotations
function add(a: number, b: number): number {
  return a + b;
}

// Arrow function with type annotations
const multiply = (x: number, y: number): number => {
  return x * y;
};

// Function with optional parameters
function greet(name: string, age?: number): string {
  if (age) {
    return `Hello ${name}, you are ${age} years old`;
  }
  return `Hello ${name}`;
}

// Function with default parameters
function createUser(name: string, role: string = "user"): object {
  return { name, role };
}
```

---

## 🔍 **Type Inference**

TypeScript can automatically infer types in many cases, reducing the need for explicit annotations.

### **Basic Type Inference**

```typescript
// TypeScript infers the type from the value
let message = "Hello"; // Type: string
let count = 42; // Type: number
let isActive = true; // Type: boolean

// Array type inference
let numbers = [1, 2, 3]; // Type: number[]
let mixed = [1, "hello", true]; // Type: (string | number | boolean)[]

// Object type inference
let person = {
  name: "John",
  age: 30,
  isActive: true
}; // Type: { name: string; age: number; isActive: boolean; }
```

### **Function Return Type Inference**

```typescript
// TypeScript infers return type
function getFullName(firstName: string, lastName: string) {
  return `${firstName} ${lastName}`; // Return type: string
}

// Explicit return type (when needed)
function calculateArea(width: number, height: number): number {
  return width * height;
}
```

---

## 🎭 **Type Assertions**

Type assertions tell TypeScript to treat a value as a specific type.

### **Angle Bracket Syntax**

```typescript
let someValue: unknown = "this is a string";
let strLength: number = (<string>someValue).length;
```

### **As Syntax (Preferred)**

```typescript
let someValue: unknown = "this is a string";
let strLength: number = (someValue as string).length;

// DOM element type assertion
let inputElement = document.getElementById("username") as HTMLInputElement;
inputElement.value = "new value";
```

### **Type Assertion Examples**

```typescript
// JSON parsing with type assertion
interface User {
  id: number;
  name: string;
  email: string;
}

let jsonString = '{"id": 1, "name": "John", "email": "john@example.com"}';
let user: User = JSON.parse(jsonString) as User;

// Array type assertion
let mixedArray = [1, "hello", true];
let stringArray = mixedArray as string[];
```

---

## ✅ **Best Practices**

### **1. Use Type Inference When Possible**

```typescript
// ✅ Good: Let TypeScript infer the type
let message = "Hello, TypeScript!";
let numbers = [1, 2, 3, 4, 5];

// ❌ Avoid: Unnecessary explicit annotations
let message: string = "Hello, TypeScript!";
let numbers: number[] = [1, 2, 3, 4, 5];
```

### **2. Be Explicit for Function Parameters and Return Types**

```typescript
// ✅ Good: Explicit parameter and return types
function calculateTotal(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// ❌ Avoid: Relying on inference for public APIs
function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0);
}
```

### **3. Use Unknown Instead of Any**

```typescript
// ✅ Good: Use unknown for truly unknown values
function processUserInput(input: unknown): string {
  if (typeof input === "string") {
    return input.toUpperCase();
  }
  return "Invalid input";
}

// ❌ Avoid: Using any
function processUserInput(input: any): string {
  return input.toUpperCase(); // No type safety
}
```

### **4. Prefer Type Assertions Over Type Casting**

```typescript
// ✅ Good: Type assertion with proper checks
function getElementById(id: string): HTMLElement | null {
  const element = document.getElementById(id);
  return element as HTMLElement | null;
}

// ❌ Avoid: Unsafe type casting
function getElementById(id: string): HTMLElement {
  return document.getElementById(id) as HTMLElement; // Could be null
}
```

---

## ❓ **Common Interview Questions**

### **1. What are the basic types in TypeScript?**

**Answer:**
TypeScript includes these basic types:
- **Primitive types**: `string`, `number`, `boolean`
- **Special types**: `null`, `undefined`, `void`, `never`, `any`, `unknown`
- **Object types**: `object`, arrays, functions, classes
- **Union types**: `string | number`
- **Literal types**: `"hello"`, `42`, `true`

### **2. What's the difference between `any` and `unknown`?**

**Answer:**
- **`any`**: Disables type checking completely, allows any operation
- **`unknown`**: Type-safe top type, requires type checking before use

```typescript
let anyValue: any = 42;
anyValue.toUpperCase(); // No error, but runtime error

let unknownValue: unknown = 42;
// unknownValue.toUpperCase(); // ❌ Error: Object is of type 'unknown'
if (typeof unknownValue === "string") {
  unknownValue.toUpperCase(); // ✅ Safe to use
}
```

### **3. When should you use type annotations vs type inference?**

**Answer:**
- **Use type annotations** for:
  - Function parameters and return types
  - Public API interfaces
  - Complex types that are hard to infer
- **Use type inference** for:
  - Simple variable declarations
  - Local variables
  - When the type is obvious from context

### **4. What are type assertions and when should you use them?**

**Answer:**
Type assertions tell TypeScript to treat a value as a specific type. Use them when:
- You know more about the type than TypeScript
- Working with DOM elements
- Parsing JSON data
- Working with third-party libraries

```typescript
// Example: DOM element
let input = document.getElementById("username") as HTMLInputElement;
input.value = "new value";
```

### **5. What's the difference between `void` and `never`?**

**Answer:**
- **`void`**: Used for functions that don't return a value
- **`never`**: Used for functions that never return (throw errors, infinite loops)

```typescript
function logMessage(msg: string): void {
  console.log(msg); // Returns undefined
}

function throwError(msg: string): never {
  throw new Error(msg); // Never returns
}
```

---

## 🧭 Navigation

<div class="navigation">
  <a href="00-TypeScript-Introduction-Setup.md" class="nav-button">← Previous: TypeScript Introduction</a>
  <a href="02-Functions-Parameters.md" class="nav-button">Next: Functions & Parameters →</a>
</div>

*Last updated: December 2024*
