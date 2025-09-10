# 🔍 **Type Guards & Narrowing**

> **Complete guide to TypeScript type guards, type narrowing, and advanced type safety techniques**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Type Guards Overview](#type-guards-overview)
- [Built-in Type Guards](#built-in-type-guards)
- [Custom Type Guards](#custom-type-guards)
- [Type Narrowing](#type-narrowing)
- [Advanced Patterns](#advanced-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Type Guards Overview**

Type guards are TypeScript's way of narrowing down types at runtime, providing type safety and better IntelliSense.

### **What are Type Guards?**


```typescript
// Type guards help TypeScript understand types at runtime
const typeGuards = {
  purpose: "Narrow down types at runtime",
  safety: "Provide type safety",
  intellisense: "Enable better IntelliSense",
  runtime: "Work at both compile-time and runtime"
};

// Basic type guard example
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function processValue(value: unknown) {
  if (isString(value)) {
    // TypeScript knows value is string here
    console.log(value.toUpperCase()); // ✅ No error
  } else {
    // TypeScript knows value is not string here
    console.log('Not a string');
  }
}
```


### **Type Guard Benefits**


```typescript
// Benefits of using type guards
const typeGuardBenefits = {
  typeSafety: "Compile-time type safety",
  runtimeSafety: "Runtime type checking",
  intellisense: "Better IDE support",
  refactoring: "Safer refactoring",
  debugging: "Easier debugging"
};

// Without type guard
function processWithoutGuard(value: unknown) {
  // TypeScript doesn't know the type
  console.log(value.length); // ❌ Error: Object is of type 'unknown'
}

// With type guard
function processWithGuard(value: unknown) {
  if (typeof value === 'string') {
    // TypeScript knows value is string
    console.log(value.length); // ✅ No error
  }
}
```


---

## 🛡️ **Built-in Type Guards**

### **typeof Type Guards**


```typescript
// typeof type guards
const typeofGuards = {
  string: "typeof value === 'string'",
  number: "typeof value === 'number'",
  boolean: "typeof value === 'boolean'",
  undefined: "typeof value === 'undefined'",
  object: "typeof value === 'object'",
  function: "typeof value === 'function'"
};

// typeof examples
function processByType(value: unknown) {
  if (typeof value === 'string') {
    // value is string
    return value.toUpperCase();
  } else if (typeof value === 'number') {
    // value is number
    return value * 2;
  } else if (typeof value === 'boolean') {
    // value is boolean
    return !value;
  } else if (typeof value === 'function') {
    // value is function
    return value();
  } else if (typeof value === 'object') {
    // value is object (including null)
    return value === null ? 'null' : 'object';
  } else {
    // value is undefined
    return 'undefined';
  }
}

// typeof with null check
function handleObject(value: unknown) {
  if (typeof value === 'object' && value !== null) {
    // value is object (not null)
    return Object.keys(value);
  }
  return [];
}
```


### **instanceof Type Guards**


```typescript
// instanceof type guards
const instanceofGuards = {
  arrays: "value instanceof Array",
  dates: "value instanceof Date",
  errors: "value instanceof Error",
  custom: "value instanceof CustomClass"
};

// instanceof examples
class CustomError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'CustomError';
  }
}

function handleError(error: unknown) {
  if (error instanceof Error) {
    // error is Error
    console.log(error.message);
    console.log(error.stack);
  } else if (error instanceof CustomError) {
    // error is CustomError
    console.log('Custom error:', error.message);
  } else {
    // error is not an Error
    console.log('Unknown error:', error);
  }
}

// instanceof with arrays
function processArray(value: unknown) {
  if (value instanceof Array) {
    // value is Array
    return value.map(item => item.toString());
  } else if (Array.isArray(value)) {
    // Alternative array check
    return value.length;
  }
  return 0;
}
```


### **in Operator Type Guards**


```typescript
// in operator type guards
const inOperatorGuards = {
  property: "Check if property exists in object",
  narrowing: "Narrow object types based on properties",
  discrimination: "Discriminate union types"
};

// in operator examples
interface Dog {
  breed: string;
  bark(): void;
}

interface Cat {
  breed: string;
  meow(): void;
}

function handlePet(pet: Dog | Cat) {
  if ('bark' in pet) {
    // pet is Dog
    pet.bark();
  } else if ('meow' in pet) {
    // pet is Cat
    pet.meow();
  }
}

// in operator with optional properties
interface User {
  id: number;
  name: string;
  email?: string;
}

function processUser(user: User) {
  if ('email' in user) {
    // email property exists
    console.log(user.email); // string | undefined
  } else {
    // email property doesn't exist
    console.log('No email provided');
  }
}
```


---

## 🔧 **Custom Type Guards**

### **Basic Custom Type Guards**


```typescript
// Custom type guard function
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function isNumber(value: unknown): value is number {
  return typeof value === 'number' && !isNaN(value);
}

function isBoolean(value: unknown): value is boolean {
  return typeof value === 'boolean';
}

// Using custom type guards
function processValue(value: unknown) {
  if (isString(value)) {
    // value is string
    return value.length;
  } else if (isNumber(value)) {
    // value is number
    return value * 2;
  } else if (isBoolean(value)) {
    // value is boolean
    return !value;
  }
  return null;
}
```


### **Complex Type Guards**


```typescript
// Complex type guards
interface ApiResponse {
  success: boolean;
  data?: any;
  error?: string;
}

function isApiResponse(value: unknown): value is ApiResponse {
  return (
    typeof value === 'object' &&
    value !== null &&
    'success' in value &&
    typeof (value as any).success === 'boolean'
  );
}

// Array type guards
function isStringArray(value: unknown): value is string[] {
  return Array.isArray(value) && value.every(item => typeof item === 'string');
}

function isNumberArray(value: unknown): value is number[] {
  return Array.isArray(value) && value.every(item => typeof item === 'number');
}

// Using complex type guards
function handleApiResponse(response: unknown) {
  if (isApiResponse(response)) {
    if (response.success) {
      console.log('Success:', response.data);
    } else {
      console.log('Error:', response.error);
    }
  } else {
    console.log('Invalid API response');
  }
}
```


### **Generic Type Guards**


```typescript
// Generic type guards
function isArrayOf<T>(value: unknown, guard: (item: unknown) => item is T): value is T[] {
  return Array.isArray(value) && value.every(guard);
}

function isObjectOf<T>(value: unknown, guard: (item: unknown) => item is T): value is Record<string, T> {
  return (
    typeof value === 'object' &&
    value !== null &&
    Object.values(value).every(guard)
  );
}

// Using generic type guards
function processStringArray(value: unknown) {
  if (isArrayOf(value, isString)) {
    // value is string[]
    return value.join(', ');
  }
  return '';
}

function processNumberObject(value: unknown) {
  if (isObjectOf(value, isNumber)) {
    // value is Record<string, number>
    return Object.values(value).reduce((sum, num) => sum + num, 0);
  }
  return 0;
}
```


---

## 🎯 **Type Narrowing**

### **Control Flow Analysis**


```typescript
// Control flow analysis
function analyzeValue(value: string | number | boolean) {
  // TypeScript analyzes the control flow
  if (typeof value === 'string') {
    // value is string
    return value.toUpperCase();
  } else if (typeof value === 'number') {
    // value is number
    return value * 2;
  } else {
    // value is boolean
    return !value;
  }
}

// Control flow with early returns
function processValue(value: unknown) {
  if (typeof value !== 'string') {
    return 'Not a string';
  }
  
  // TypeScript knows value is string here
  return value.toUpperCase();
}
```


### **Discriminated Unions**


```typescript
// Discriminated unions
interface LoadingState {
  status: 'loading';
}

interface SuccessState {
  status: 'success';
  data: any;
}

interface ErrorState {
  status: 'error';
  error: string;
}

type AppState = LoadingState | SuccessState | ErrorState;

function handleState(state: AppState) {
  switch (state.status) {
    case 'loading':
      // state is LoadingState
      return 'Loading...';
    case 'success':
      // state is SuccessState
      return `Data: ${state.data}`;
    case 'error':
      // state is ErrorState
      return `Error: ${state.error}`;
    default:
      // Exhaustive check
      const _exhaustive: never = state;
      return _exhaustive;
  }
}
```


### **Assertion Functions**


```typescript
// Assertion functions
function assertIsString(value: unknown): asserts value is string {
  if (typeof value !== 'string') {
    throw new Error('Expected string');
  }
}

function assertIsNumber(value: unknown): asserts value is number {
  if (typeof value !== 'number' || isNaN(value)) {
    throw new Error('Expected number');
  }
}

// Using assertion functions
function processValue(value: unknown) {
  assertIsString(value);
  // TypeScript knows value is string here
  return value.toUpperCase();
}

// Assertion function with custom error
function assertIsArray(value: unknown): asserts value is any[] {
  if (!Array.isArray(value)) {
    throw new Error('Expected array');
  }
}
```


---

## 🚀 **Advanced Patterns**

### **Branded Types**


```typescript
// Branded types
type Brand<T, B> = T & { __brand: B };
type UserId = Brand<number, 'UserId'>;
type ProductId = Brand<number, 'ProductId'>;

function createUserId(id: number): UserId {
  return id as UserId;
}

function createProductId(id: number): ProductId {
  return id as ProductId;
}

// Type guard for branded types
function isUserId(value: unknown): value is UserId {
  return typeof value === 'number' && value > 0;
}

function isProductId(value: unknown): value is ProductId {
  return typeof value === 'number' && value > 0;
}

// Using branded types
function processUser(userId: UserId) {
  // TypeScript ensures only UserId can be passed
  console.log('Processing user:', userId);
}

function processProduct(productId: ProductId) {
  // TypeScript ensures only ProductId can be passed
  console.log('Processing product:', productId);
}
```


### **Opaque Types**


```typescript
// Opaque types
declare const __opaque: unique symbol;
type Opaque<T, K> = T & { readonly [__opaque]: K };

type UserId = Opaque<number, 'UserId'>;
type ProductId = Opaque<number, 'ProductId'>;

// Factory functions for opaque types
function createUserId(id: number): UserId {
  return id as UserId;
}

function createProductId(id: number): ProductId {
  return id as ProductId;
}

// Type guards for opaque types
function isUserId(value: unknown): value is UserId {
  return typeof value === 'number' && value > 0;
}

function isProductId(value: unknown): value is ProductId {
  return typeof value === 'number' && value > 0;
}
```


### **Template Literal Types**


```typescript
// Template literal types
type EventName<T extends string> = `on${Capitalize<T>}`;
type ClickEvent = EventName<'click'>; // 'onClick'
type SubmitEvent = EventName<'submit'>; // 'onSubmit'

// Type guard for template literal types
function isEventName(value: string): value is EventName<string> {
  return value.startsWith('on') && value.length > 2;
}

// Using template literal types
function handleEvent(eventName: string) {
  if (isEventName(eventName)) {
    // eventName is EventName<string>
    console.log('Handling event:', eventName);
  }
}
```


---

## ✅ **Best Practices**

### **1. Use Built-in Type Guards When Possible**


```typescript
// ✅ Good: Use built-in type guards
function processValue(value: unknown) {
  if (typeof value === 'string') {
    return value.toUpperCase();
  }
  if (Array.isArray(value)) {
    return value.length;
  }
  if (value instanceof Date) {
    return value.toISOString();
  }
}

// ❌ Avoid: Unnecessary custom type guards
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function processValue(value: unknown) {
  if (isString(value)) {
    return value.toUpperCase();
  }
}
```


### **2. Make Type Guards Specific**


```typescript
// ✅ Good: Specific type guards
function isApiResponse(value: unknown): value is ApiResponse {
  return (
    typeof value === 'object' &&
    value !== null &&
    'success' in value &&
    typeof (value as any).success === 'boolean'
  );
}

// ❌ Avoid: Generic type guards
function isObject(value: unknown): value is object {
  return typeof value === 'object' && value !== null;
}
```


### **3. Use Discriminated Unions**


```typescript
// ✅ Good: Discriminated unions
interface LoadingState {
  status: 'loading';
}

interface SuccessState {
  status: 'success';
  data: any;
}

type AppState = LoadingState | SuccessState;

// ❌ Avoid: Union types without discrimination
type AppState = { status: string; data?: any };
```


### **4. Handle Exhaustive Checks**


```typescript
// ✅ Good: Exhaustive checks
function handleState(state: AppState) {
  switch (state.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return 'Success';
    default:
      const _exhaustive: never = state;
      return _exhaustive;
  }
}

// ❌ Avoid: Missing cases
function handleState(state: AppState) {
  switch (state.status) {
    case 'loading':
      return 'Loading...';
    // Missing 'success' case
  }
}
```


---

## ❓ **Common Interview Questions**

### **1. What are type guards in TypeScript?**

**Answer:**
Type guards are functions that help TypeScript narrow down types at runtime. They return a type predicate that tells TypeScript what type a value is, enabling type safety and better IntelliSense.

### **2. What's the difference between type guards and type assertions?**

**Answer:**
- **Type Guards**: Runtime checks that narrow types safely
- **Type Assertions**: Compile-time type casting without runtime checks
- Type guards are safer because they actually verify the type at runtime

### **3. How do you create a custom type guard?**

**Answer:**

```typescript
function isString(value: unknown): value is string {
  return typeof value === 'string';
}
```

The return type `value is string` is a type predicate that tells TypeScript the value is a string.

### **4. What are discriminated unions?**

**Answer:**
Discriminated unions are union types with a common property (discriminator) that helps TypeScript narrow down the exact type. They're useful for representing different states or variants.

### **5. How do you handle exhaustive checks in TypeScript?**

**Answer:**
Use the `never` type to ensure all cases are handled:

```typescript
function handleState(state: AppState) {
  switch (state.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return 'Success';
    default:
      const _exhaustive: never = state;
      return _exhaustive;
  }
}
```


---

## 🧭 Navigation

<div class="navigation">
  <a href="../07-TypeScript-Libraries-Ecosystem/04-TypeScript-Future-Roadmap.md" class="nav-button">← Previous: TypeScript Future Roadmap</a>
  <a href="02-Discriminated-Unions.md" class="nav-button">Next: Discriminated Unions →</a>
</div>

*Last updated: December 2025*
