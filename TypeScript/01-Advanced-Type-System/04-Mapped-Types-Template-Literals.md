# 🗺️ **Mapped Types & Template Literals**

> **Complete guide to TypeScript mapped types, template literal types, and advanced type transformations**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction to Mapped Types](#introduction-to-mapped-types)
- [Basic Mapped Types](#basic-mapped-types)
- [Template Literal Types](#template-literal-types)
- [Advanced Mapped Patterns](#advanced-mapped-patterns)
- [Utility Types with Mapped Types](#utility-types-with-mapped-types)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Introduction to Mapped Types**

Mapped types allow you to create new types by transforming existing types, providing powerful type-level programming capabilities.

### **Basic Concept**

```typescript
// Basic mapped type syntax
type MappedType<T> = {
  [K in keyof T]: T[K];
};

// This is equivalent to the identity type
type Identity<T> = T;

// Usage
interface User {
  id: string;
  name: string;
  email: string;
}

type MappedUser = MappedType<User>; // { id: string; name: string; email: string }
```

### **Why Use Mapped Types?**

```typescript
// Without mapped types - manual type creation
interface PartialUser {
  id?: string;
  name?: string;
  email?: string;
}

// With mapped types - automatic type transformation
type Partial<T> = {
  [P in keyof T]?: T[P];
};

type PartialUser = Partial<User>; // All properties become optional
```

---

## 🔧 **Basic Mapped Types**

### **Property Modifiers**

```typescript
// Make all properties optional
type Partial<T> = {
  [P in keyof T]?: T[P];
};

// Make all properties required
type Required<T> = {
  [P in keyof T]-?: T[P];
};

// Make all properties readonly
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

// Remove readonly modifier
type Mutable<T> = {
  -readonly [P in keyof T]: T[P];
};

// Usage
interface User {
  id: string;
  name: string;
  email?: string;
}

type PartialUser = Partial<User>;     // All optional
type RequiredUser = Required<User>;   // All required
type ReadonlyUser = Readonly<User>;   // All readonly
type MutableUser = Mutable<ReadonlyUser>; // Remove readonly
```

### **Property Type Transformation**

```typescript
// Transform property types
type Stringify<T> = {
  [P in keyof T]: string;
};

type Numberify<T> = {
  [P in keyof T]: number;
};

// Usage
interface User {
  id: string;
  name: string;
  age: number;
}

type StringUser = Stringify<User>; // { id: string; name: string; age: string }
type NumberUser = Numberify<User>; // { id: number; name: number; age: number }
```

### **Conditional Property Transformation**

```typescript
// Transform properties based on condition
type StringPropertiesOnly<T> = {
  [P in keyof T]: T[P] extends string ? T[P] : never;
};

type NonStringProperties<T> = {
  [P in keyof T]: T[P] extends string ? never : T[P];
};

// Usage
interface Mixed {
  id: string;
  name: string;
  age: number;
  isActive: boolean;
}

type StringOnly = StringPropertiesOnly<Mixed>; // { id: string; name: string; age: never; isActive: never }
type NonString = NonStringProperties<Mixed>;   // { id: never; name: never; age: number; isActive: boolean }
```

---

## 📝 **Template Literal Types**

Template literal types allow you to create string literal types using template syntax.

### **Basic Template Literals**

```typescript
// Basic template literal types
type Greeting<T extends string> = `Hello, ${T}!`;

type Greeting1 = Greeting<"World">;  // "Hello, World!"
type Greeting2 = Greeting<"TypeScript">; // "Hello, TypeScript!"

// Multiple template variables
type Path<T extends string, U extends string> = `/api/${T}/${U}`;

type UserPath = Path<"users", "profile">; // "/api/users/profile"
type ProductPath = Path<"products", "details">; // "/api/products/details"
```

### **Template Literal with Union Types**

```typescript
// Template literals with union types
type HttpMethod = "GET" | "POST" | "PUT" | "DELETE";
type ApiEndpoint<T extends string> = `${HttpMethod} /api/${T}`;

type UserEndpoint = ApiEndpoint<"users">; // "GET /api/users" | "POST /api/users" | "PUT /api/users" | "DELETE /api/users"

// More complex example
type EventName<T extends string> = `on${Capitalize<T>}`;

type ClickEvent = EventName<"click">;   // "onClick"
type ChangeEvent = EventName<"change">; // "onChange"
type SubmitEvent = EventName<"submit">; // "onSubmit"
```

### **Template Literal Utility Types**

```typescript
// Built-in template literal utility types
type Uppercase<S extends string> = intrinsic;
type Lowercase<S extends string> = intrinsic;
type Capitalize<S extends string> = intrinsic;
type Uncapitalize<S extends string> = intrinsic;

// Usage
type Upper = Uppercase<"hello">;     // "HELLO"
type Lower = Lowercase<"WORLD">;     // "world"
type Cap = Capitalize<"hello">;      // "Hello"
type Uncap = Uncapitalize<"Hello">;  // "hello"

// Custom template literal utilities
type CamelCase<S extends string> = S extends `${infer P1}_${infer P2}`
  ? `${P1}${Capitalize<CamelCase<P2>>}`
  : S;

type Test1 = CamelCase<"hello_world">;      // "helloWorld"
type Test2 = CamelCase<"my_variable_name">; // "myVariableName"
```

---

## 🚀 **Advanced Mapped Patterns**

### **Key Remapping**

```typescript
// Remap keys using template literals
type AddPrefix<T, Prefix extends string> = {
  [K in keyof T as `${Prefix}${string & K}`]: T[K];
};

type AddSuffix<T, Suffix extends string> = {
  [K in keyof T as `${string & K}${Suffix}`]: T[K];
};

// Usage
interface User {
  id: string;
  name: string;
  email: string;
}

type PrefixedUser = AddPrefix<User, "user_">; // { user_id: string; user_name: string; user_email: string }
type SuffixedUser = AddSuffix<User, "_field">; // { id_field: string; name_field: string; email_field: string }
```

### **Conditional Key Mapping**

```typescript
// Map keys based on conditions
type FilterKeys<T, U> = {
  [K in keyof T as T[K] extends U ? K : never]: T[K];
};

type RenameKeys<T, M extends Record<keyof T, string>> = {
  [K in keyof T as M[K]]: T[K];
};

// Usage
interface User {
  id: string;
  name: string;
  age: number;
  email: string;
}

type StringKeys = FilterKeys<User, string>; // { id: string; name: string; email: string }
type NumberKeys = FilterKeys<User, number>; // { age: number }

type RenamedUser = RenameKeys<User, {
  id: "userId";
  name: "userName";
  age: "userAge";
  email: "userEmail";
}>; // { userId: string; userName: string; userAge: number; userEmail: string }
```

### **Complex Mapped Patterns**

```typescript
// Deep mapped type
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

// Conditional deep mapping
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

// Usage
interface NestedUser {
  id: string;
  profile: {
    name: string;
    settings: {
      theme: string;
      notifications: boolean;
    };
  };
}

type PartialNestedUser = DeepPartial<NestedUser>;
type ReadonlyNestedUser = DeepReadonly<NestedUser>;
```

---

## 🛠️ **Utility Types with Mapped Types**

### **Built-in Utility Types**

```typescript
// Pick utility type
type Pick<T, K extends keyof T> = {
  [P in K]: T[P];
};

// Omit utility type
type Omit<T, K extends keyof any> = Pick<T, Exclude<keyof T, K>>;

// Record utility type
type Record<K extends keyof any, T> = {
  [P in K]: T;
};

// Usage
interface User {
  id: string;
  name: string;
  email: string;
  age: number;
}

type UserBasic = Pick<User, "id" | "name">; // { id: string; name: string }
type UserWithoutId = Omit<User, "id">;      // { name: string; email: string; age: number }
type UserRecord = Record<"user1" | "user2", User>; // { user1: User; user2: User }
```

### **Custom Utility Types**

```typescript
// Optional by keys
type OptionalByKeys<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;

// Required by keys
type RequiredByKeys<T, K extends keyof T> = Omit<T, K> & Required<Pick<T, K>>;

// Partial by keys
type PartialByKeys<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;

// Readonly by keys
type ReadonlyByKeys<T, K extends keyof T> = Omit<T, K> & Readonly<Pick<T, K>>;

// Usage
interface User {
  id: string;
  name: string;
  email?: string;
  age?: number;
}

type OptionalEmail = OptionalByKeys<User, "email">; // { id: string; name: string; email?: string; age?: number }
type RequiredEmail = RequiredByKeys<User, "email">; // { id: string; name: string; email: string; age?: number }
```

---

## ✅ **Best Practices**

### **1. Use Mapped Types for Type Transformations**

```typescript
// ✅ Good: Use mapped types for consistent transformations
type Partial<T> = {
  [P in keyof T]?: T[P];
};

// ❌ Avoid: Manual type definitions
interface PartialUser {
  id?: string;
  name?: string;
  email?: string;
}
```

### **2. Leverage Template Literals for String Types**

```typescript
// ✅ Good: Use template literals for dynamic string types
type ApiEndpoint<T extends string> = `/api/${T}`;

// ❌ Avoid: Manual string literal unions
type ApiEndpoint = "/api/users" | "/api/products" | "/api/orders";
```

### **3. Combine Mapped Types with Conditional Types**

```typescript
// ✅ Good: Combine for powerful type transformations
type ConditionalMapped<T> = {
  [K in keyof T]: T[K] extends string ? T[K] : never;
};

// ❌ Avoid: Separate transformations
type StringOnly<T> = T extends string ? T : never;
```

### **4. Use Key Remapping for Advanced Transformations**

```typescript
// ✅ Good: Use key remapping for complex transformations
type AddPrefix<T, P extends string> = {
  [K in keyof T as `${P}${string & K}`]: T[K];
};

// ❌ Avoid: Manual key transformations
type PrefixedUser = {
  user_id: string;
  user_name: string;
  user_email: string;
};
```

---

## ❓ **Common Interview Questions**

### **1. What are mapped types in TypeScript?**

**Answer:**
Mapped types allow you to create new types by transforming existing types. They use the syntax `[K in keyof T]: T[K]` to iterate over properties and transform them.

### **2. How do you create a mapped type?**

**Answer:**
Use the mapped type syntax with property iteration:

```typescript
type Partial<T> = {
  [P in keyof T]?: T[P];
};
```

### **3. What are template literal types?**

**Answer:**
Template literal types allow you to create string literal types using template syntax with `${}` placeholders:

```typescript
type Greeting<T extends string> = `Hello, ${T}!`;
```

### **4. How do you use key remapping in mapped types?**

**Answer:**
Use the `as` clause to remap keys:

```typescript
type AddPrefix<T, P extends string> = {
  [K in keyof T as `${P}${string & K}`]: T[K];
};
```

### **5. What are the built-in template literal utility types?**

**Answer:**
TypeScript provides:
- `Uppercase<S>`: Convert to uppercase
- `Lowercase<S>`: Convert to lowercase
- `Capitalize<S>`: Capitalize first letter
- `Uncapitalize<S>`: Uncapitalize first letter

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-Conditional-Types.md" class="nav-button">← Previous: Conditional Types</a>
  <a href="../02-TypeScript-Modern-JavaScript/01-ES6-Features-TypeScript.md" class="nav-button">Next: ES6+ Features & TypeScript →</a>
</div>

*Last updated: December 2024*
