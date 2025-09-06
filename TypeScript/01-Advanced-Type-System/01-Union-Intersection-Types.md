# 🔗 **Union & Intersection Types**

> **Complete guide to TypeScript union types, intersection types, and advanced type combinations**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Union Types](#union-types)
- [Intersection Types](#intersection-types)
- [Type Guards](#type-guards)
- [Discriminated Unions](#discriminated-unions)
- [Advanced Patterns](#advanced-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Union Types**

Union types allow a value to be one of several types, providing flexibility while maintaining type safety.

### **Basic Union Types**

```typescript
// Union of primitive types
let id: string | number;
id = "123"; // ✅ Valid
id = 456;   // ✅ Valid
// id = true; // ❌ Error: Type 'boolean' is not assignable to type 'string | number'

// Union of different types
let value: string | number | boolean;
value = "hello";
value = 42;
value = true;
```

### **Function Parameters with Union Types**

```typescript
// Function accepting multiple types
function formatValue(value: string | number): string {
  if (typeof value === "string") {
    return value.toUpperCase();
  }
  return value.toString();
}

// Usage
formatValue("hello"); // "HELLO"
formatValue(42);      // "42"
```

### **Array Union Types**

```typescript
// Array that can contain strings or numbers
let mixedArray: (string | number)[] = ["hello", 42, "world", 100];

// Union of array types
let stringOrNumberArray: string[] | number[];
stringOrNumberArray = ["a", "b", "c"]; // ✅ Valid
stringOrNumberArray = [1, 2, 3];       // ✅ Valid
// stringOrNumberArray = ["a", 1, "b"]; // ❌ Error: Mixed types not allowed
```

---

## 🔗 **Intersection Types**

Intersection types combine multiple types into one, requiring all properties from each type.

### **Basic Intersection Types**

```typescript
// Intersection of object types
interface Person {
  name: string;
  age: number;
}

interface Employee {
  employeeId: string;
  department: string;
}

// Intersection type
type EmployeePerson = Person & Employee;

// Usage
const employee: EmployeePerson = {
  name: "John Doe",
  age: 30,
  employeeId: "EMP001",
  department: "Engineering"
};
```

### **Function Intersection Types**

```typescript
// Intersection of function types
type LogFunction = (message: string) => void;
type TimestampFunction = () => string;

type LogWithTimestamp = LogFunction & TimestampFunction;

// Implementation
const logWithTimestamp: LogWithTimestamp = (message: string) => {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] ${message}`);
};

// Add timestamp method
(logWithTimestamp as any).timestamp = () => new Date().toISOString();
```

### **Complex Intersection Types**

```typescript
// Intersection with optional properties
interface BaseConfig {
  apiUrl: string;
  timeout: number;
}

interface AuthConfig {
  apiKey?: string;
  token?: string;
}

interface CacheConfig {
  cacheEnabled: boolean;
  cacheTimeout?: number;
}

// Intersection combining all configs
type AppConfig = BaseConfig & AuthConfig & CacheConfig;

// Usage
const config: AppConfig = {
  apiUrl: "https://api.example.com",
  timeout: 5000,
  cacheEnabled: true,
  apiKey: "secret-key"
};
```

---

## 🛡️ **Type Guards**

Type guards help narrow down union types to specific types at runtime.

### **Typeof Type Guards**

```typescript
function processValue(value: string | number | boolean): string {
  if (typeof value === "string") {
    // TypeScript knows value is string here
    return value.toUpperCase();
  } else if (typeof value === "number") {
    // TypeScript knows value is number here
    return value.toFixed(2);
  } else {
    // TypeScript knows value is boolean here
    return value ? "true" : "false";
  }
}
```

### **Instanceof Type Guards**

```typescript
class Dog {
  breed: string;
  constructor(breed: string) {
    this.breed = breed;
  }
}

class Cat {
  color: string;
  constructor(color: string) {
    this.color = color;
  }
}

function handlePet(pet: Dog | Cat): string {
  if (pet instanceof Dog) {
    // TypeScript knows pet is Dog here
    return `Dog breed: ${pet.breed}`;
  } else {
    // TypeScript knows pet is Cat here
    return `Cat color: ${pet.color}`;
  }
}
```

### **Custom Type Guards**

```typescript
// Custom type guard function
function isString(value: unknown): value is string {
  return typeof value === "string";
}

function isNumber(value: unknown): value is number {
  return typeof value === "number" && !isNaN(value);
}

// Usage
function processUnknownValue(value: unknown): string {
  if (isString(value)) {
    // TypeScript knows value is string
    return value.toUpperCase();
  } else if (isNumber(value)) {
    // TypeScript knows value is number
    return value.toString();
  }
  return "Unknown type";
}
```

---

## 🎭 **Discriminated Unions**

Discriminated unions use a common property to distinguish between different types in a union.

### **Basic Discriminated Union**

```typescript
// Discriminated union with 'type' property
type Shape = 
  | { type: "circle"; radius: number }
  | { type: "rectangle"; width: number; height: number }
  | { type: "triangle"; base: number; height: number };

function calculateArea(shape: Shape): number {
  switch (shape.type) {
    case "circle":
      // TypeScript knows shape has radius property
      return Math.PI * shape.radius * shape.radius;
    case "rectangle":
      // TypeScript knows shape has width and height properties
      return shape.width * shape.height;
    case "triangle":
      // TypeScript knows shape has base and height properties
      return (shape.base * shape.height) / 2;
    default:
      // Exhaustiveness check
      const _exhaustiveCheck: never = shape;
      return _exhaustiveCheck;
  }
}
```

### **Complex Discriminated Union**

```typescript
// API response discriminated union
type ApiResponse<T> = 
  | { status: "success"; data: T; timestamp: string }
  | { status: "error"; error: string; code: number }
  | { status: "loading" };

function handleApiResponse<T>(response: ApiResponse<T>): string {
  switch (response.status) {
    case "success":
      return `Success: ${JSON.stringify(response.data)}`;
    case "error":
      return `Error ${response.code}: ${response.error}`;
    case "loading":
      return "Loading...";
    default:
      const _exhaustiveCheck: never = response;
      return _exhaustiveCheck;
  }
}
```

---

## 🚀 **Advanced Patterns**

### **Union of Function Types**

```typescript
// Union of different function signatures
type EventHandler = 
  | ((event: MouseEvent) => void)
  | ((event: KeyboardEvent) => void)
  | ((event: TouchEvent) => void);

function addEventListener(handler: EventHandler): void {
  // Implementation
}

// Usage
addEventListener((event: MouseEvent) => {
  console.log("Mouse event:", event.clientX, event.clientY);
});
```

### **Conditional Union Types**

```typescript
// Union based on condition
type ApiEndpoint<T extends "GET" | "POST"> = 
  T extends "GET" 
    ? { method: "GET"; params: Record<string, string> }
    : { method: "POST"; body: Record<string, any> };

function makeRequest<T extends "GET" | "POST">(
  endpoint: ApiEndpoint<T>
): Promise<any> {
  if (endpoint.method === "GET") {
    // TypeScript knows endpoint has params
    return fetch(`/api?${new URLSearchParams(endpoint.params)}`);
  } else {
    // TypeScript knows endpoint has body
    return fetch("/api", {
      method: "POST",
      body: JSON.stringify(endpoint.body)
    });
  }
}
```

### **Intersection with Generics**

```typescript
// Intersection type with generics
interface Timestamped {
  createdAt: Date;
  updatedAt: Date;
}

interface Identifiable {
  id: string;
}

type TimestampedEntity<T> = T & Timestamped & Identifiable;

// Usage
interface User {
  name: string;
  email: string;
}

type TimestampedUser = TimestampedEntity<User>;

const user: TimestampedUser = {
  id: "1",
  name: "John Doe",
  email: "john@example.com",
  createdAt: new Date(),
  updatedAt: new Date()
};
```

---

## ✅ **Best Practices**

### **1. Use Discriminated Unions for State Management**

```typescript
// ✅ Good: Clear state representation
type LoadingState = 
  | { status: "idle" }
  | { status: "loading" }
  | { status: "success"; data: any }
  | { status: "error"; error: string };

// ❌ Avoid: Ambiguous state
type BadState = {
  isLoading?: boolean;
  data?: any;
  error?: string;
};
```

### **2. Prefer Union Types Over Any**

```typescript
// ✅ Good: Specific union type
function processInput(input: string | number | boolean): string {
  // Type-safe handling
}

// ❌ Avoid: Using any
function processInput(input: any): string {
  // No type safety
}
```

### **3. Use Type Guards for Runtime Safety**

```typescript
// ✅ Good: Type guard with runtime check
function isUser(obj: unknown): obj is User {
  return typeof obj === "object" && 
         obj !== null && 
         "id" in obj && 
         "name" in obj;
}

// Usage
if (isUser(data)) {
  // TypeScript knows data is User
  console.log(data.name);
}
```

### **4. Leverage Exhaustiveness Checking**

```typescript
// ✅ Good: Exhaustiveness check
function handleStatus(status: "pending" | "approved" | "rejected"): string {
  switch (status) {
    case "pending":
      return "Processing...";
    case "approved":
      return "Approved!";
    case "rejected":
      return "Rejected.";
    default:
      // This ensures all cases are handled
      const _exhaustiveCheck: never = status;
      return _exhaustiveCheck;
  }
}
```

---

## ❓ **Common Interview Questions**

### **1. What's the difference between union and intersection types?**

**Answer:**
- **Union types (`|`)**: A value can be one of several types
- **Intersection types (`&`)**: A value must satisfy all types simultaneously

```typescript
// Union: can be string OR number
let id: string | number;

// Intersection: must have both Person AND Employee properties
type EmployeePerson = Person & Employee;
```

### **2. How do type guards work in TypeScript?**

**Answer:**
Type guards narrow down union types to specific types:
- **`typeof`**: For primitive types
- **`instanceof`**: For class instances
- **Custom guards**: User-defined functions that return `value is Type`

### **3. What are discriminated unions and why are they useful?**

**Answer:**
Discriminated unions use a common property to distinguish between types:
- Provide type safety in switch statements
- Enable exhaustive checking
- Make code more maintainable and less error-prone

### **4. How do you handle exhaustiveness checking with union types?**

**Answer:**
Use the `never` type in the default case to ensure all union members are handled:

```typescript
function handleShape(shape: Circle | Rectangle): number {
  switch (shape.type) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "rectangle":
      return shape.width * shape.height;
    default:
      const _exhaustiveCheck: never = shape;
      return _exhaustiveCheck;
  }
}
```

### **5. When would you use intersection types over inheritance?**

**Answer:**
Use intersection types when:
- You need to combine multiple interfaces
- You want to avoid deep inheritance hierarchies
- You need to mix in functionality from multiple sources
- You're working with composition over inheritance

---

## 🧭 Navigation

<div class="navigation">
  <a href="../00-TypeScript-Fundamentals/03-Classes-Objects.md" class="nav-button">← Previous: Classes & Objects</a>
  <a href="02-Generics-Type-Parameters.md" class="nav-button">Next: Generics & Type Parameters →</a>
</div>

*Last updated: December 2024*
