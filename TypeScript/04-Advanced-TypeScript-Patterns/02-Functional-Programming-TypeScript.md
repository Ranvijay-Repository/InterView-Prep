# 🔄 **Functional Programming with TypeScript**

> **Complete guide to functional programming concepts in TypeScript including immutability, pure functions, and advanced functional patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Functional Programming Overview](#functional-programming-overview)
- [Pure Functions](#pure-functions)
- [Immutability](#immutability)
- [Higher-Order Functions](#higher-order-functions)
- [Function Composition](#function-composition)
- [Advanced Functional Patterns](#advanced-functional-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Functional Programming Overview**

Functional programming emphasizes immutability, pure functions, and function composition.

### **Core Principles**

```typescript
// Functional programming principles
const principles = {
  immutability: "Data cannot be changed after creation",
  pureFunctions: "Functions with no side effects",
  functionComposition: "Building complex functions from simple ones",
  higherOrderFunctions: "Functions that take or return other functions"
};

// TypeScript benefits for functional programming
const typescriptBenefits = {
  typeSafety: "Compile-time type checking for function signatures",
  generics: "Reusable functional abstractions",
  readonly: "Enforce immutability at type level",
  functionTypes: "First-class function types"
};
```

### **Functional vs Imperative**

```typescript
// Imperative approach
function processUsersImperative(users: User[]): string[] {
  const result: string[] = [];
  for (let i = 0; i < users.length; i++) {
    if (users[i].age > 18) {
      result.push(users[i].name.toUpperCase());
    }
  }
  return result;
}

// Functional approach
const processUsersFunctional = (users: User[]): string[] =>
  users
    .filter(user => user.age > 18)
    .map(user => user.name.toUpperCase());
```

---

## 🧹 **Pure Functions**

Pure functions are functions that always return the same output for the same input and have no side effects.

### **Pure Function Characteristics**

```typescript
// Pure function example
const add = (a: number, b: number): number => a + b;

// Pure function with objects
const createUser = (name: string, email: string): User => ({
  id: Date.now(),
  name,
  email,
  createdAt: new Date()
});

// Pure function with arrays
const addToArray = <T>(array: T[], item: T): T[] => [...array, item];

// Pure function with objects
const updateUser = (user: User, updates: Partial<User>): User => ({
  ...user,
  ...updates
});
```

### **Impure Functions (Avoid)**

```typescript
// ❌ Impure function - modifies external state
let counter = 0;
const incrementCounter = (): number => {
  counter++; // Side effect
  return counter;
};

// ❌ Impure function - uses external dependencies
const getCurrentTime = (): string => {
  return new Date().toISOString(); // Side effect - time changes
};

// ❌ Impure function - modifies input
const addToArrayImpure = <T>(array: T[], item: T): T[] => {
  array.push(item); // Mutates input
  return array;
};
```

### **Pure Function Benefits**

```typescript
// Pure functions are predictable
const multiply = (a: number, b: number): number => a * b;

// Always returns the same result for same inputs
console.log(multiply(2, 3)); // 6
console.log(multiply(2, 3)); // 6 (always the same)

// Easy to test
const testMultiply = () => {
  console.assert(multiply(2, 3) === 6, "Should return 6");
  console.assert(multiply(0, 5) === 0, "Should return 0");
  console.assert(multiply(-2, 3) === -6, "Should return -6");
};
```

---

## 🔒 **Immutability**

Immutability ensures data cannot be changed after creation, preventing bugs and making code more predictable.

### **Immutable Data Structures**

```typescript
// Immutable objects
const user: Readonly<User> = {
  id: 1,
  name: "John",
  email: "john@example.com"
};

// user.name = "Jane"; // ❌ Error: Cannot assign to 'name' because it is a read-only property

// Creating new objects instead of mutating
const updateUserName = (user: User, newName: string): User => ({
  ...user,
  name: newName
});

// Immutable arrays
const numbers: readonly number[] = [1, 2, 3, 4, 5];
// numbers.push(6); // ❌ Error: Property 'push' does not exist on type 'readonly number[]'

// Creating new arrays instead of mutating
const addToNumbers = (numbers: readonly number[], newNumber: number): number[] => [
  ...numbers,
  newNumber
];

const removeFromNumbers = (numbers: readonly number[], index: number): number[] =>
  numbers.filter((_, i) => i !== index);
```

### **Deep Immutability**

```typescript
// Deep immutable types
interface DeepReadonly<T> {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
}

interface User {
  id: number;
  name: string;
  profile: {
    age: number;
    settings: {
      theme: string;
      notifications: boolean;
    };
  };
}

const user: DeepReadonly<User> = {
  id: 1,
  name: "John",
  profile: {
    age: 30,
    settings: {
      theme: "dark",
      notifications: true
    }
  }
};

// user.profile.settings.theme = "light"; // ❌ Error: Cannot assign to 'theme' because it is a read-only property

// Creating deep copies
const updateUserTheme = (user: User, theme: string): User => ({
  ...user,
  profile: {
    ...user.profile,
    settings: {
      ...user.profile.settings,
      theme
    }
  }
});
```

### **Immutable Update Patterns**

```typescript
// Update nested objects
const updateNestedProperty = <T extends Record<string, any>>(
  obj: T,
  path: string[],
  value: any
): T => {
  if (path.length === 1) {
    return { ...obj, [path[0]]: value };
  }
  
  const [first, ...rest] = path;
  return {
    ...obj,
    [first]: updateNestedProperty(obj[first], rest, value)
  };
};

// Usage
const user = {
  id: 1,
  name: "John",
  profile: {
    age: 30,
    settings: {
      theme: "dark"
    }
  }
};

const updatedUser = updateNestedProperty(user, ["profile", "settings", "theme"], "light");
```

---

## 🔄 **Higher-Order Functions**

Higher-order functions are functions that take other functions as arguments or return functions.

### **Basic Higher-Order Functions**

```typescript
// Function that takes a function as argument
const withLogging = <T>(fn: (value: T) => T) => (value: T): T => {
  console.log(`Input: ${value}`);
  const result = fn(value);
  console.log(`Output: ${result}`);
  return result;
};

// Function that returns a function
const createMultiplier = (factor: number) => (value: number): number => value * factor;

// Usage
const double = createMultiplier(2);
const triple = createMultiplier(3);

console.log(double(5)); // 10
console.log(triple(5)); // 15

const loggedDouble = withLogging(double);
loggedDouble(5); // Logs input and output
```

### **Array Higher-Order Functions**

```typescript
// Custom map implementation
const map = <T, U>(array: T[], fn: (item: T, index: number) => U): U[] => {
  const result: U[] = [];
  for (let i = 0; i < array.length; i++) {
    result.push(fn(array[i], i));
  }
  return result;
};

// Custom filter implementation
const filter = <T>(array: T[], predicate: (item: T, index: number) => boolean): T[] => {
  const result: T[] = [];
  for (let i = 0; i < array.length; i++) {
    if (predicate(array[i], i)) {
      result.push(array[i]);
    }
  }
  return result;
};

// Custom reduce implementation
const reduce = <T, U>(
  array: T[],
  reducer: (accumulator: U, item: T, index: number) => U,
  initialValue: U
): U => {
  let accumulator = initialValue;
  for (let i = 0; i < array.length; i++) {
    accumulator = reducer(accumulator, array[i], i);
  }
  return accumulator;
};

// Usage
const numbers = [1, 2, 3, 4, 5];
const doubled = map(numbers, x => x * 2);
const evens = filter(numbers, x => x % 2 === 0);
const sum = reduce(numbers, (acc, x) => acc + x, 0);
```

### **Function Currying**

```typescript
// Curried function
const add = (a: number) => (b: number) => a + b;

// Usage
const add5 = add(5);
console.log(add5(3)); // 8

// Generic curry function
const curry = <T extends any[], R>(
  fn: (...args: T) => R
): ((...args: T) => R) | ((...args: T) => (...args: T) => R) => {
  return (...args: T) => {
    if (args.length >= fn.length) {
      return fn(...args);
    }
    return (...nextArgs: T) => curry(fn)(...args, ...nextArgs);
  };
};

// Usage
const multiply = (a: number, b: number, c: number) => a * b * c;
const curriedMultiply = curry(multiply);

console.log(curriedMultiply(2)(3)(4)); // 24
console.log(curriedMultiply(2, 3)(4)); // 24
console.log(curriedMultiply(2)(3, 4)); // 24
```

---

## 🎭 **Function Composition**

Function composition is the process of combining simple functions to create more complex ones.

### **Basic Function Composition**

```typescript
// Simple composition
const compose = <T>(f: (x: T) => T, g: (x: T) => T) => (x: T): T => f(g(x));

// Multiple function composition
const composeMany = <T>(...fns: Array<(x: T) => T>) => (x: T): T =>
  fns.reduceRight((acc, fn) => fn(acc), x);

// Usage
const add1 = (x: number) => x + 1;
const multiply2 = (x: number) => x * 2;
const square = (x: number) => x * x;

const composed = composeMany(square, multiply2, add1);
console.log(composed(3)); // ((3 + 1) * 2)² = 64
```

### **Advanced Function Composition**

```typescript
// Generic composition with different types
const compose = <A, B, C>(f: (b: B) => C, g: (a: A) => B) => (a: A): C => f(g(a));

// Pipe function (left to right composition)
const pipe = <T>(...fns: Array<(x: T) => T>) => (x: T): T =>
  fns.reduce((acc, fn) => fn(acc), x);

// Usage
const users = [
  { id: 1, name: "John", age: 30 },
  { id: 2, name: "Jane", age: 25 },
  { id: 3, name: "Bob", age: 35 }
];

const processUsers = pipe(
  (users: User[]) => users.filter(user => user.age > 25),
  (users: User[]) => users.map(user => user.name),
  (names: string[]) => names.join(", ")
);

console.log(processUsers(users)); // "John, Bob"
```

### **Monadic Composition**

```typescript
// Maybe monad for safe composition
type Maybe<T> = T | null | undefined;

const maybe = <T>(value: T): Maybe<T> => value;

const map = <T, U>(fn: (x: T) => U) => (maybe: Maybe<T>): Maybe<U> => {
  if (maybe === null || maybe === undefined) {
    return null;
  }
  return fn(maybe);
};

const flatMap = <T, U>(fn: (x: T) => Maybe<U>) => (maybe: Maybe<T>): Maybe<U> => {
  if (maybe === null || maybe === undefined) {
    return null;
  }
  return fn(maybe);
};

// Usage
const getUser = (id: number): Maybe<User> => {
  // Simulate API call
  return id > 0 ? { id, name: "John", email: "john@example.com" } : null;
};

const getEmail = (user: User): Maybe<string> => user.email;

const processUser = pipe(
  getUser,
  flatMap(getEmail),
  map(email => email.toUpperCase())
);

console.log(processUser(1)); // "JOHN@EXAMPLE.COM"
console.log(processUser(-1)); // null
```

---

## 🚀 **Advanced Functional Patterns**

### **Functor Pattern**

```typescript
// Functor interface
interface Functor<T> {
  map<U>(fn: (x: T) => U): Functor<U>;
}

// Array functor
class ArrayFunctor<T> implements Functor<T> {
  constructor(private value: T[]) {}

  map<U>(fn: (x: T) => U): ArrayFunctor<U> {
    return new ArrayFunctor(this.value.map(fn));
  }

  getValue(): T[] {
    return this.value;
  }
}

// Maybe functor
class MaybeFunctor<T> implements Functor<T> {
  constructor(private value: T | null) {}

  map<U>(fn: (x: T) => U): MaybeFunctor<U> {
    if (this.value === null) {
      return new MaybeFunctor<U>(null);
    }
    return new MaybeFunctor(fn(this.value));
  }

  getValue(): T | null {
    return this.value;
  }
}

// Usage
const numbers = new ArrayFunctor([1, 2, 3, 4, 5]);
const doubled = numbers.map(x => x * 2);
console.log(doubled.getValue()); // [2, 4, 6, 8, 10]

const maybeValue = new MaybeFunctor(5);
const result = maybeValue.map(x => x * 2);
console.log(result.getValue()); // 10
```

### **Applicative Functor**

```typescript
// Applicative functor interface
interface Applicative<T> extends Functor<T> {
  ap<U>(fn: Applicative<(x: T) => U>): Applicative<U>;
  of<U>(value: U): Applicative<U>;
}

// Maybe applicative
class MaybeApplicative<T> implements Applicative<T> {
  constructor(private value: T | null) {}

  map<U>(fn: (x: T) => U): MaybeApplicative<U> {
    if (this.value === null) {
      return new MaybeApplicative<U>(null);
    }
    return new MaybeApplicative(fn(this.value));
  }

  ap<U>(fn: MaybeApplicative<(x: T) => U>): MaybeApplicative<U> {
    if (this.value === null || fn.getValue() === null) {
      return new MaybeApplicative<U>(null);
    }
    return new MaybeApplicative(fn.getValue()(this.value));
  }

  of<U>(value: U): MaybeApplicative<U> {
    return new MaybeApplicative(value);
  }

  getValue(): T | null {
    return this.value;
  }
}

// Usage
const add = (a: number) => (b: number) => a + b;
const maybeAdd = new MaybeApplicative(add);
const maybe5 = new MaybeApplicative(5);
const maybe3 = new MaybeApplicative(3);

const result = maybe5.ap(maybe3.ap(maybeAdd));
console.log(result.getValue()); // 8
```

---

## ✅ **Best Practices**

### **1. Prefer Pure Functions**

```typescript
// ✅ Good: Pure function
const calculateTotal = (items: Item[]): number =>
  items.reduce((total, item) => total + item.price, 0);

// ❌ Avoid: Impure function
let total = 0;
const calculateTotalImpure = (items: Item[]): number => {
  total = 0; // Side effect
  items.forEach(item => {
    total += item.price; // Mutates external state
  });
  return total;
};
```

### **2. Use Immutable Data Structures**

```typescript
// ✅ Good: Immutable updates
const updateUser = (user: User, updates: Partial<User>): User => ({
  ...user,
  ...updates
});

// ❌ Avoid: Mutating data
const updateUserImpure = (user: User, updates: Partial<User>): User => {
  Object.assign(user, updates); // Mutates input
  return user;
};
```

### **3. Compose Functions Instead of Nesting**

```typescript
// ✅ Good: Function composition
const processData = pipe(
  filterValid,
  transformData,
  sortByDate,
  takeFirst(10)
);

// ❌ Avoid: Nested function calls
const processDataNested = (data: any[]) =>
  takeFirst(10, sortByDate(transformData(filterValid(data))));
```

### **4. Use Higher-Order Functions**

```typescript
// ✅ Good: Higher-order function
const withErrorHandling = <T>(fn: () => T) => (): T | null => {
  try {
    return fn();
  } catch (error) {
    console.error(error);
    return null;
  }
};

// ❌ Avoid: Repetitive error handling
const fetchUser = (): User | null => {
  try {
    return api.getUser();
  } catch (error) {
    console.error(error);
    return null;
  }
};

const fetchProduct = (): Product | null => {
  try {
    return api.getProduct();
  } catch (error) {
    console.error(error);
    return null;
  }
};
```

---

## ❓ **Common Interview Questions**

### **1. What is functional programming?**

**Answer:**
Functional programming is a programming paradigm that emphasizes:
- **Pure functions**: Functions with no side effects
- **Immutability**: Data cannot be changed after creation
- **Function composition**: Building complex functions from simple ones
- **Higher-order functions**: Functions that take or return other functions

### **2. What are the benefits of pure functions?**

**Answer:**
- **Predictability**: Same input always produces same output
- **Testability**: Easy to test without setup or teardown
- **Debugging**: Easier to debug since no side effects
- **Parallelization**: Can be safely executed in parallel

### **3. How do you implement immutability in TypeScript?**

**Answer:**
- Use `readonly` modifier for properties
- Use spread operator for creating new objects/arrays
- Use `Readonly<T>` utility type
- Create deep immutable types with `DeepReadonly<T>`

### **4. What is function composition?**

**Answer:**
Function composition is combining simple functions to create more complex ones:

```typescript
const compose = <T>(f: (x: T) => T, g: (x: T) => T) => (x: T): T => f(g(x));
```

### **5. What are higher-order functions?**

**Answer:**
Higher-order functions are functions that:
- Take other functions as arguments
- Return functions as results
- Examples: `map`, `filter`, `reduce`, `compose`

---

## 🧭 Navigation

<div class="navigation">
  <a href="01-Design-Patterns-TypeScript.md" class="nav-button">← Previous: Design Patterns in TypeScript</a>
  <a href="03-Error-Handling-Validation.md" class="nav-button">Next: Error Handling & Validation →</a>
</div>

*Last updated: December 2024*
