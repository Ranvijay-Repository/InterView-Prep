# 🔀 **Conditional Types**

> **Complete guide to TypeScript conditional types, type inference, and advanced conditional patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction to Conditional Types](#introduction-to-conditional-types)
- [Basic Conditional Types](#basic-conditional-types)
- [Conditional Type Inference](#conditional-type-inference)
- [Distributive Conditional Types](#distributive-conditional-types)
- [Advanced Conditional Patterns](#advanced-conditional-patterns)
- [Utility Types with Conditionals](#utility-types-with-conditionals)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Introduction to Conditional Types**

Conditional types allow you to create types that depend on other types, enabling powerful type-level programming.

### **Basic Syntax**

{% raw %}
{% raw %}
```typescript
// Basic conditional type syntax
type IsString<T> = T extends string ? true : false;

// Usage
type Test1 = IsString<string>;  // true
type Test2 = IsString<number>;  // false
type Test3 = IsString<"hello">; // true (string literal extends string)
```
{% endraw %}

### **Why Use Conditional Types?**

{% raw %}
{% raw %}
```typescript
// Without conditional types - limited flexibility
type ApiResponse = {
  data: any;
  error: string | null;
};

// With conditional types - type-safe and flexible
type ApiResponse<T> = T extends string 
  ? { message: T; error: null }
  : { data: T; error: string | null };

// Usage
type StringResponse = ApiResponse<string>; // { message: string; error: null }
type DataResponse = ApiResponse<User[]>;   // { data: User[]; error: string | null }
```
{% endraw %}

---

## 🔧 **Basic Conditional Types**

### **Simple Conditional Types**

{% raw %}
{% raw %}
```typescript
// Check if type is an array
type IsArray<T> = T extends any[] ? true : false;

type Test1 = IsArray<string[]>;  // true
type Test2 = IsArray<number>;    // false
type Test3 = IsArray<never[]>;   // true

// Check if type is a function
type IsFunction<T> = T extends (...args: any[]) => any ? true : false;

type Test4 = IsFunction<() => void>;     // true
type Test5 = IsFunction<string>;         // false
type Test6 = IsFunction<(x: number) => string>; // true
```
{% endraw %}

### **Conditional Types with Multiple Conditions**

{% raw %}
{% raw %}
```typescript
// Multiple condition checks
type TypeName<T> = 
  T extends string ? "string" :
  T extends number ? "number" :
  T extends boolean ? "boolean" :
  T extends undefined ? "undefined" :
  T extends null ? "null" :
  T extends Function ? "function" :
  "object";

type Test1 = TypeName<string>;    // "string"
type Test2 = TypeName<number>;    // "number"
type Test3 = TypeName<boolean>;   // "boolean"
type Test4 = TypeName<() => void>; // "function"
type Test5 = TypeName<{}>;        // "object"
```
{% endraw %}

### **Conditional Types with Generics**

{% raw %}
{% raw %}
```typescript
// Generic conditional type
type NonNullable<T> = T extends null | undefined ? never : T;

type Test1 = NonNullable<string | null>;      // string
type Test2 = NonNullable<number | undefined>; // number
type Test3 = NonNullable<null>;               // never
type Test4 = NonNullable<undefined>;          // never

// Conditional type with generic constraints
type ExtractArrayType<T> = T extends (infer U)[] ? U : never;

type Test5 = ExtractArrayType<string[]>;  // string
type Test6 = ExtractArrayType<number[]>;  // number
type Test7 = ExtractArrayType<string>;    // never
```
{% endraw %}

---

## 🔍 **Conditional Type Inference**

The `infer` keyword allows you to extract types from other types within conditional types.

### **Basic Type Inference**

{% raw %}
{% raw %}
```typescript
// Extract return type from function
type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never;

type Test1 = ReturnType<() => string>;           // string
type Test2 = ReturnType<(x: number) => boolean>; // boolean
type Test3 = ReturnType<string>;                 // never

// Extract parameter types from function
type Parameters<T> = T extends (...args: infer P) => any ? P : never;

type Test4 = Parameters<(x: string, y: number) => void>; // [string, number]
type Test5 = Parameters<() => void>;                     // []
type Test6 = Parameters<string>;                         // never
```
{% endraw %}

### **Advanced Type Inference**

{% raw %}
{% raw %}
```typescript
// Extract first parameter type
type FirstParameter<T> = T extends (first: infer F, ...args: any[]) => any ? F : never;

type Test1 = FirstParameter<(x: string, y: number) => void>; // string
type Test2 = FirstParameter<() => void>;                     // never

// Extract array element type
type ArrayElement<T> = T extends (infer U)[] ? U : never;

type Test3 = ArrayElement<string[]>;  // string
type Test4 = ArrayElement<number[]>;  // number
type Test5 = ArrayElement<string>;    // never

// Extract promise type
type Awaited<T> = T extends Promise<infer U> ? U : T;

type Test6 = Awaited<Promise<string>>; // string
type Test7 = Awaited<string>;          // string
```
{% endraw %}

---

## 🔄 **Distributive Conditional Types**

Conditional types distribute over union types, applying the condition to each member.

### **Understanding Distribution**

{% raw %}
{% raw %}
```typescript
// Distributive conditional type
type ToArray<T> = T extends any ? T[] : never;

type Test1 = ToArray<string | number>; // string[] | number[]
// This is equivalent to:
// (string extends any ? string[] : never) | (number extends any ? number[] : never)
// = string[] | number[]

// Non-distributive version
type ToArrayNonDist<T> = [T] extends [any] ? T[] : never;

type Test2 = ToArrayNonDist<string | number>; // (string | number)[]
```
{% endraw %}

### **Controlling Distribution**

{% raw %}
{% raw %}
```typescript
// Prevent distribution by wrapping in tuple
type NonDistributive<T> = [T] extends [any] ? T : never;

type Test1 = NonDistributive<string | number>; // string | number

// Force distribution
type Distributive<T> = T extends any ? T : never;

type Test2 = Distributive<string | number>; // string | number (same result)

// More complex example
type ExtractString<T> = T extends string ? T : never;

type Test3 = ExtractString<string | number | boolean>; // string
type Test4 = ExtractString<number | boolean>;          // never
```
{% endraw %}

---

## 🚀 **Advanced Conditional Patterns**

### **Recursive Conditional Types**

{% raw %}
{% raw %}
```typescript
// Deep readonly type
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

interface User {
  id: string;
  profile: {
    name: string;
    settings: {
      theme: string;
    };
  };
}

type ReadonlyUser = DeepReadonly<User>;
// All properties become readonly, including nested objects

// Flatten array type
type Flatten<T> = T extends (infer U)[] 
  ? U extends any[] 
    ? Flatten<U> 
    : U 
  : T;

type Test1 = Flatten<string[][]>;     // string
type Test2 = Flatten<number[][][]>;   // number
type Test3 = Flatten<string>;         // string
```
{% endraw %}

### **Conditional Types with Mapped Types**

{% raw %}
{% raw %}
```typescript
// Conditional mapped type
type ConditionalKeys<T, U> = {
  [K in keyof T]: T[K] extends U ? K : never;
}[keyof T];

type Test1 = ConditionalKeys<{ a: string; b: number; c: boolean }, string>; // "a"
type Test2 = ConditionalKeys<{ a: string; b: number; c: string }, string>;  // "a" | "c"

// Pick conditional properties
type PickByType<T, U> = Pick<T, ConditionalKeys<T, U>>;

interface Example {
  name: string;
  age: number;
  email: string;
  isActive: boolean;
}

type StringProps = PickByType<Example, string>; // { name: string; email: string }
type NumberProps = PickByType<Example, number>; // { age: number }
```
{% endraw %}

### **Complex Conditional Logic**

{% raw %}
{% raw %}
```typescript
// API response type based on method
type ApiResponse<T, Method extends "GET" | "POST" | "PUT" | "DELETE"> = 
  Method extends "GET" 
    ? { data: T; error: null }
    : Method extends "POST"
    ? { data: T; error: null; created: true }
    : Method extends "PUT"
    ? { data: T; error: null; updated: true }
    : Method extends "DELETE"
    ? { success: true; error: null }
    : never;

type GetResponse = ApiResponse<User[], "GET">;     // { data: User[]; error: null }
type PostResponse = ApiResponse<User, "POST">;     // { data: User; error: null; created: true }
type DeleteResponse = ApiResponse<never, "DELETE">; // { success: true; error: null }
```
{% endraw %}

---

## 🛠️ **Utility Types with Conditionals**

### **Built-in Utility Types Using Conditionals**

{% raw %}
{% raw %}
```typescript
// Extract utility type
type Extract<T, U> = T extends U ? T : never;

type Test1 = Extract<string | number | boolean, string | number>; // string | number

// Exclude utility type
type Exclude<T, U> = T extends U ? never : T;

type Test2 = Exclude<string | number | boolean, string>; // number | boolean

// NonNullable utility type
type NonNullable<T> = T extends null | undefined ? never : T;

type Test3 = NonNullable<string | null | undefined>; // string

// ReturnType utility type
type ReturnType<T extends (...args: any) => any> = T extends (...args: any) => infer R ? R : any;

type Test4 = ReturnType<() => string>; // string
```
{% endraw %}

### **Custom Utility Types**

{% raw %}
{% raw %}
```typescript
// Deep partial type
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

// Deep required type
type DeepRequired<T> = {
  [P in keyof T]-?: T[P] extends object ? DeepRequired<T[P]> : T[P];
};

// Optional by keys
type OptionalByKeys<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;

// Required by keys
type RequiredByKeys<T, K extends keyof T> = Omit<T, K> & Required<Pick<T, K>>;

// Usage examples
interface User {
  id: string;
  name: string;
  email?: string;
  profile?: {
    age?: number;
    bio?: string;
  };
}

type PartialUser = DeepPartial<User>;
type RequiredUser = DeepRequired<User>;
type OptionalEmail = OptionalByKeys<User, "email">;
type RequiredEmail = RequiredByKeys<User, "email">;
```
{% endraw %}

---

## ✅ **Best Practices**

### **1. Use Conditional Types for Type-Level Logic**

{% raw %}
{% raw %}
```typescript
// ✅ Good: Type-level conditional logic
type ApiResponse<T> = T extends string 
  ? { message: T }
  : { data: T };

// ❌ Avoid: Runtime conditional logic in types
type BadApiResponse<T> = {
  message?: T;
  data?: T;
};
```
{% endraw %}

### **2. Leverage Type Inference with `infer`**

{% raw %}
{% raw %}
```typescript
// ✅ Good: Extract types using infer
type ExtractReturnType<T> = T extends (...args: any[]) => infer R ? R : never;

// ❌ Avoid: Manual type extraction
type ManualReturnType<T> = T extends () => string ? string : never;
```
{% endraw %}

### **3. Use Distribution Carefully**

{% raw %}
{% raw %}
```typescript
// ✅ Good: Understand when distribution happens
type ToArray<T> = T extends any ? T[] : never;
type StringOrNumberArray = ToArray<string | number>; // string[] | number[]

// ✅ Good: Prevent distribution when needed
type ToArrayNonDist<T> = [T] extends [any] ? T[] : never;
type UnionArray = ToArrayNonDist<string | number>; // (string | number)[]
```
{% endraw %}

### **4. Create Reusable Conditional Types**

{% raw %}
{% raw %}
```typescript
// ✅ Good: Reusable conditional utility
type IsAssignable<T, U> = T extends U ? true : false;
type IsString<T> = IsAssignable<T, string>;
type IsNumber<T> = IsAssignable<T, number>;
```
{% endraw %}

---

## ❓ **Common Interview Questions**

### **1. What are conditional types in TypeScript?**

**Answer:**
Conditional types allow you to create types that depend on other types using the syntax `T extends U ? X : Y`. They enable type-level programming and dynamic type selection based on conditions.

### **2. How does the `infer` keyword work?**

**Answer:**
The `infer` keyword allows you to extract types from other types within conditional types:

{% raw %}
{% raw %}
```typescript
type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never;
```
{% endraw %}

### **3. What is distributive conditional types?**

**Answer:**
Conditional types distribute over union types, applying the condition to each member:

{% raw %}
{% raw %}
```typescript
type ToArray<T> = T extends any ? T[] : never;
type Test = ToArray<string | number>; // string[] | number[]
```
{% endraw %}

### **4. How do you prevent distribution in conditional types?**

**Answer:**
Wrap the type in a tuple to prevent distribution:

{% raw %}
{% raw %}
```typescript
type NonDistributive<T> = [T] extends [any] ? T[] : never;
type Test = NonDistributive<string | number>; // (string | number)[]
```
{% endraw %}

### **5. Can you create recursive conditional types?**

**Answer:**
Yes, conditional types can be recursive:

{% raw %}
{% raw %}
```typescript
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};
```
{% endraw %}

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Generics-Type-Parameters.md" class="nav-button">← Previous: Generics & Type Parameters</a>
  <a href="04-Mapped-Types-Template-Literals.md" class="nav-button">Next: Mapped Types & Template Literals →</a>
</div>

*Last updated: December 2025*
