# 🚀 **ES6+ Features & TypeScript**

> **Complete guide to using ES6+ features with TypeScript, including arrow functions, destructuring, classes, and modern syntax**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Arrow Functions](#arrow-functions)
- [Destructuring Assignment](#destructuring-assignment)
- [Template Literals](#template-literals)
- [Classes and Inheritance](#classes-and-inheritance)
- [Modules and Imports](#modules-and-imports)
- [Promises and Async/Await](#promises-and-asyncawait)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🏹 **Arrow Functions**

Arrow functions provide a concise syntax for writing functions and have different `this` binding behavior.

### **Basic Arrow Function Syntax**


{% raw %}
```typescript
// Traditional function
function add(a: number, b: number): number {
  return a + b;
}

// Arrow function equivalent
const add = (a: number, b: number): number => {
  return a + b;
};

// Arrow function with implicit return
const add = (a: number, b: number): number => a + b;

// Single parameter arrow function
const square = (x: number): number => x * x;

// No parameters arrow function
const getCurrentTime = (): Date => new Date();
```
{% endraw %}


### **Arrow Functions with TypeScript**


{% raw %}
```typescript
// Arrow function with explicit return type
const processUser = (user: User): string => {
  return `Processing user: ${user.name}`;
};

// Arrow function with generic types
const identity = <T>(value: T): T => value;

// Arrow function with rest parameters
const sum = (...numbers: number[]): number => {
  return numbers.reduce((total, num) => total + num, 0);
};

// Arrow function with default parameters
const greet = (name: string, greeting: string = "Hello"): string => {
  return `${greeting}, ${name}!`;
};
```
{% endraw %}


### **Arrow Functions in Array Methods**


{% raw %}
```typescript
interface User {
  id: number;
  name: string;
  age: number;
  isActive: boolean;
}

const users: User[] = [
  { id: 1, name: "John", age: 30, isActive: true },
  { id: 2, name: "Jane", age: 25, isActive: false },
  { id: 3, name: "Bob", age: 35, isActive: true }
];

// Map with arrow functions
const userNames = users.map((user: User): string => user.name);

// Filter with arrow functions
const activeUsers = users.filter((user: User): boolean => user.isActive);

// Reduce with arrow functions
const totalAge = users.reduce((sum: number, user: User): number => sum + user.age, 0);

// Find with arrow functions
const user = users.find((user: User): boolean => user.id === 2);
```
{% endraw %}


---

## 🎯 **Destructuring Assignment**

Destructuring allows you to extract values from arrays and objects into distinct variables.

### **Array Destructuring**


{% raw %}
```typescript
// Basic array destructuring
const numbers: number[] = [1, 2, 3, 4, 5];
const [first, second, third] = numbers;

// Array destructuring with rest operator
const [head, ...tail] = numbers;

// Array destructuring with default values
const [a = 0, b = 0, c = 0] = [1, 2];

// Array destructuring with type annotations
const [x: number, y: number, z: number] = [1, 2, 3];

// Function parameter destructuring
const processCoordinates = ([x, y]: [number, number]): string => {
  return `Coordinates: (${x}, ${y})`;
};
```
{% endraw %}


### **Object Destructuring**


{% raw %}
```typescript
interface User {
  id: number;
  name: string;
  email: string;
  age: number;
  address?: {
    street: string;
    city: string;
    country: string;
  };
}

const user: User = {
  id: 1,
  name: "John Doe",
  email: "john@example.com",
  age: 30,
  address: {
    street: "123 Main St",
    city: "New York",
    country: "USA"
  }
};

// Basic object destructuring
const { name, email, age } = user;

// Object destructuring with renaming
const { name: userName, email: userEmail } = user;

// Object destructuring with default values
const { name, email, age = 0 } = user;

// Nested object destructuring
const { address: { street, city } } = user;

// Function parameter destructuring
const createUser = ({ name, email, age }: { name: string; email: string; age: number }): User => {
  return { id: Date.now(), name, email, age };
};
```
{% endraw %}


### **Destructuring with TypeScript**


{% raw %}
```typescript
// Destructuring with explicit types
const processUser = ({ name, age }: { name: string; age: number }): string => {
  return `${name} is ${age} years old`;
};

// Destructuring with interface
interface UserInput {
  name: string;
  email: string;
  age: number;
}

const validateUser = ({ name, email, age }: UserInput): boolean => {
  return name.length > 0 && email.includes("@") && age > 0;
};

// Destructuring with optional properties
const processOptionalUser = ({ name, age = 0 }: { name: string; age?: number }): string => {
  return `${name} is ${age} years old`;
};
```
{% endraw %}


---

## 📝 **Template Literals**

Template literals provide an easy way to create strings with embedded expressions.

### **Basic Template Literals**


{% raw %}
```typescript
// Basic template literal
const name: string = "John";
const age: number = 30;
const message: string = `Hello, my name is ${name} and I am ${age} years old.`;

// Template literal with expressions
const calculateTotal = (price: number, tax: number): string => {
  const total = price + (price * tax);
  return `Total: $${total.toFixed(2)}`;
};

// Template literal with multiline strings
const htmlTemplate = `
  <div class="user-card">
    <h2>${name}</h2>
    <p>Age: ${age}</p>
    <p>Email: ${email}</p>
  </div>
`;
```
{% endraw %}


### **Template Literals with TypeScript**


{% raw %}
```typescript
// Template literal with type safety
const createApiUrl = (endpoint: string, id: number): string => {
  return `https://api.example.com/${endpoint}/${id}`;
};

// Template literal with function calls
const formatUserInfo = (user: User): string => {
  return `
    User Information:
    - ID: ${user.id}
    - Name: ${user.name}
    - Email: ${user.email}
    - Age: ${user.age}
    - Status: ${user.isActive ? "Active" : "Inactive"}
  `;
};

// Template literal with conditional expressions
const getStatusMessage = (isOnline: boolean, lastSeen: Date): string => {
  return `User is ${isOnline ? "online" : `last seen ${lastSeen.toLocaleDateString()}`}`;
};
```
{% endraw %}


---

## 🏗️ **Classes and Inheritance**

TypeScript enhances ES6 classes with type annotations and access modifiers.

### **Basic Class Syntax**


{% raw %}
```typescript
// Basic class with TypeScript
class Person {
  private name: string;
  protected age: number;
  public email: string;

  constructor(name: string, age: number, email: string) {
    this.name = name;
    this.age = age;
    this.email = email;
  }

  public getName(): string {
    return this.name;
  }

  protected getAge(): number {
    return this.age;
  }

  private validateEmail(email: string): boolean {
    return email.includes("@");
  }
}
```
{% endraw %}


### **Class Inheritance**


{% raw %}
```typescript
// Base class
class Animal {
  protected name: string;
  protected age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }

  public makeSound(): string {
    return "Some generic animal sound";
  }

  public getInfo(): string {
    return `${this.name} is ${this.age} years old`;
  }
}

// Derived class
class Dog extends Animal {
  private breed: string;

  constructor(name: string, age: number, breed: string) {
    super(name, age); // Call parent constructor
    this.breed = breed;
  }

  public makeSound(): string {
    return "Woof!";
  }

  public getBreed(): string {
    return this.breed;
  }

  public getFullInfo(): string {
    return `${this.getInfo()} and is a ${this.breed}`;
  }
}
```
{% endraw %}


### **Static Methods and Properties**


{% raw %}
```typescript
class MathUtils {
  public static readonly PI: number = 3.14159;

  public static add(a: number, b: number): number {
    return a + b;
  }

  public static multiply(a: number, b: number): number {
    return a * b;
  }

  public static circleArea(radius: number): number {
    return this.PI * radius * radius;
  }
}

// Usage
const sum = MathUtils.add(5, 3);
const area = MathUtils.circleArea(5);
```
{% endraw %}


---

## 📦 **Modules and Imports**

TypeScript supports ES6 module syntax with type safety.

### **Export and Import Syntax**


{% raw %}
```typescript
// user.ts - Exporting
export interface User {
  id: number;
  name: string;
  email: string;
}

export class UserService {
  private users: User[] = [];

  public addUser(user: User): void {
    this.users.push(user);
  }

  public getUser(id: number): User | undefined {
    return this.users.find(user => user.id === id);
  }
}

// Default export
export default class UserRepository {
  // Implementation
}

// Named exports
export const API_URL = "https://api.example.com";
export const MAX_USERS = 100;
```
{% endraw %}


### **Import Syntax**


{% raw %}
```typescript
// Importing named exports
import { User, UserService } from "./user";

// Importing default export
import UserRepository from "./user";

// Importing with renaming
import { User as UserType, UserService as Service } from "./user";

// Importing everything
import * as UserModule from "./user";

// Importing with type-only imports
import type { User } from "./user";

// Usage
const user: User = { id: 1, name: "John", email: "john@example.com" };
const userService = new UserService();
```
{% endraw %}


### **Re-exporting**


{% raw %}
```typescript
// index.ts - Re-exporting
export { User, UserService } from "./user";
export { Product, ProductService } from "./product";
export { Order, OrderService } from "./order";

// Re-exporting with renaming
export { User as UserType } from "./user";
export { Product as ProductType } from "./product";
```
{% endraw %}


---

## ⚡ **Promises and Async/Await**

TypeScript provides excellent support for asynchronous programming with Promises and async/await.

### **Basic Promise Usage**


{% raw %}
```typescript
// Promise with TypeScript
const fetchUser = (id: number): Promise<User> => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (id > 0) {
        resolve({ id, name: "John Doe", email: "john@example.com" });
      } else {
        reject(new Error("Invalid user ID"));
      }
    }, 1000);
  });
};

// Promise with error handling
const processUser = (id: number): Promise<string> => {
  return fetchUser(id)
    .then((user: User) => {
      return `User: ${user.name}`;
    })
    .catch((error: Error) => {
      return `Error: ${error.message}`;
    });
};
```
{% endraw %}


### **Async/Await with TypeScript**


{% raw %}
```typescript
// Async function with TypeScript
const getUserInfo = async (id: number): Promise<string> => {
  try {
    const user: User = await fetchUser(id);
    return `User: ${user.name}, Email: ${user.email}`;
  } catch (error) {
    return `Error: ${(error as Error).message}`;
  }
};

// Async function with multiple awaits
const processMultipleUsers = async (ids: number[]): Promise<string[]> => {
  const results: string[] = [];
  
  for (const id of ids) {
    try {
      const user: User = await fetchUser(id);
      results.push(`User ${id}: ${user.name}`);
    } catch (error) {
      results.push(`Error for user ${id}: ${(error as Error).message}`);
    }
  }
  
  return results;
};

// Async function with Promise.all
const fetchAllUsers = async (ids: number[]): Promise<User[]> => {
  const promises: Promise<User>[] = ids.map(id => fetchUser(id));
  return Promise.all(promises);
};
```
{% endraw %}


### **Advanced Async Patterns**


{% raw %}
```typescript
// Async function with timeout
const fetchUserWithTimeout = async (id: number, timeout: number = 5000): Promise<User> => {
  const timeoutPromise = new Promise<never>((_, reject) => {
    setTimeout(() => reject(new Error("Request timeout")), timeout);
  });

  const userPromise = fetchUser(id);

  return Promise.race([userPromise, timeoutPromise]);
};

// Async function with retry logic
const fetchUserWithRetry = async (id: number, maxRetries: number = 3): Promise<User> => {
  let lastError: Error;

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fetchUser(id);
    } catch (error) {
      lastError = error as Error;
      if (attempt === maxRetries) {
        throw lastError;
      }
      // Wait before retry
      await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
    }
  }

  throw lastError!;
};
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Use Arrow Functions for Short Functions**


{% raw %}
```typescript
// ✅ Good: Arrow function for short operations
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(n => n * 2);

// ❌ Avoid: Arrow function for complex logic
const complexLogic = (data: any[]) => {
  // 50+ lines of complex logic
  // Better to use regular function
};
```
{% endraw %}


### **2. Use Destructuring for Clean Code**


{% raw %}
```typescript
// ✅ Good: Destructuring for clean parameter handling
const createUser = ({ name, email, age }: UserInput): User => {
  return { id: Date.now(), name, email, age };
};

// ❌ Avoid: Manual property access
const createUser = (userInput: UserInput): User => {
  return { 
    id: Date.now(), 
    name: userInput.name, 
    email: userInput.email, 
    age: userInput.age 
  };
};
```
{% endraw %}


### **3. Use Template Literals for String Building**


{% raw %}
```typescript
// ✅ Good: Template literals
const message = `Hello ${name}, you have ${count} messages`;

// ❌ Avoid: String concatenation
const message = "Hello " + name + ", you have " + count + " messages";
```
{% endraw %}


### **4. Use Async/Await for Better Readability**


{% raw %}
```typescript
// ✅ Good: Async/await
const processData = async (): Promise<void> => {
  try {
    const user = await fetchUser(1);
    const profile = await fetchProfile(user.id);
    console.log(profile);
  } catch (error) {
    console.error(error);
  }
};

// ❌ Avoid: Promise chains for complex logic
const processData = (): Promise<void> => {
  return fetchUser(1)
    .then(user => fetchProfile(user.id))
    .then(profile => console.log(profile))
    .catch(error => console.error(error));
};
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. What are the differences between arrow functions and regular functions?**

**Answer:**
- **`this` binding**: Arrow functions don't have their own `this`, they inherit from the enclosing scope
- **`arguments` object**: Arrow functions don't have their own `arguments` object
- **Constructor**: Arrow functions cannot be used as constructors
- **Hoisting**: Arrow functions are not hoisted

### **2. How do you use destructuring in TypeScript?**

**Answer:**
Destructuring works the same as JavaScript but with type safety:


{% raw %}
```typescript
const { name, age }: { name: string; age: number } = user;
const [first, second]: [number, number] = [1, 2];
```
{% endraw %}


### **3. What are the benefits of using async/await over Promises?**

**Answer:**
- **Readability**: Code looks more synchronous and easier to read
- **Error handling**: Try/catch blocks instead of .catch()
- **Debugging**: Better stack traces and debugging experience
- **Sequential execution**: Easier to write sequential async operations

### **4. How do you handle errors in async/await?**

**Answer:**
Use try/catch blocks:


{% raw %}
```typescript
const fetchData = async (): Promise<void> => {
  try {
    const data = await apiCall();
    console.log(data);
  } catch (error) {
    console.error("Error:", error);
  }
};
```
{% endraw %}


### **5. What's the difference between import and import type?**

**Answer:**
- **`import`**: Imports both runtime and type information
- **`import type`**: Imports only type information, removed at compile time


{% raw %}
```typescript
import { User } from "./user";        // Runtime import
import type { User } from "./user";   // Type-only import
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
  <a href="../01-Advanced-Type-System/04-Mapped-Types-Template-Literals.md" class="nav-button">← Previous: Mapped Types & Template Literals</a>
  <a href="02-Modules-Imports.md" class="nav-button">Next: Modules & Imports →</a>
</div>

*Last updated: December 2025*
