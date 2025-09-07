# 🔒 **Compiler Options & Strict Mode**

> **Complete guide to TypeScript compiler options, strict mode settings, and type checking configuration**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Compiler Options Overview](#compiler-options-overview)
- [Strict Mode Options](#strict-mode-options)
- [Type Checking Options](#type-checking-options)
- [Module Resolution Options](#module-resolution-options)
- [Output Options](#output-options)
- [Advanced Options](#advanced-options)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Compiler Options Overview**

TypeScript compiler options control how the TypeScript compiler processes your code and generates JavaScript output.

### **Basic Compiler Options**

```json
{
  "compilerOptions": {
    // Target JavaScript version
    "target": "ES2020",
    
    // Module system
    "module": "commonjs",
    
    // Output directory
    "outDir": "./dist",
    
    // Root directory
    "rootDir": "./src",
    
    // Source maps
    "sourceMap": true,
    
    // Declaration files
    "declaration": true
  }
}
```

### **Compiler Option Categories**

```typescript
// Type checking options
"strict": true,
"noImplicitAny": true,
"strictNullChecks": true,

// Module resolution options
"moduleResolution": "node",
"baseUrl": "./src",
"paths": { "@/*": ["*"] },

// Output options
"outDir": "./dist",
"sourceMap": true,
"declaration": true,

// Advanced options
"experimentalDecorators": true,
"emitDecoratorMetadata": true
```

---

## 🔒 **Strict Mode Options**

Strict mode enables additional type checking options for better type safety.

### **Strict Mode Overview**

```json
{
  "compilerOptions": {
    // Enable all strict type checking options
    "strict": true,
    
    // Individual strict options (automatically enabled with strict: true)
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

### **noImplicitAny**

```typescript
// ❌ Error with noImplicitAny: true
function processData(data) { // Parameter 'data' implicitly has an 'any' type
  return data.toString();
}

// ✅ Good: Explicit type annotation
function processData(data: string | number): string {
  return data.toString();
}

// ✅ Good: Type inference
function processData(data: string) { // Type inferred as string
  return data.toUpperCase();
}
```

### **strictNullChecks**

```typescript
// ❌ Error with strictNullChecks: true
function getUser(id: number): User {
  const user = findUser(id); // findUser might return undefined
  return user; // Type 'User | undefined' is not assignable to type 'User'
}

// ✅ Good: Handle null/undefined
function getUser(id: number): User | undefined {
  const user = findUser(id);
  return user;
}

// ✅ Good: Use non-null assertion (when you're sure)
function getUser(id: number): User {
  const user = findUser(id);
  return user!; // Non-null assertion
}

// ✅ Good: Use type guard
function getUser(id: number): User {
  const user = findUser(id);
  if (!user) {
    throw new Error("User not found");
  }
  return user;
}
```

### **strictFunctionTypes**

```typescript
// ❌ Error with strictFunctionTypes: true
interface Animal {
  name: string;
}

interface Dog extends Animal {
  breed: string;
}

let animalHandler: (animal: Animal) => void;
let dogHandler: (dog: Dog) => void;

animalHandler = dogHandler; // Error: Type '(dog: Dog) => void' is not assignable to type '(animal: Animal) => void'

// ✅ Good: Use bivariant parameter types
let animalHandler: (animal: Animal) => void;
let dogHandler: (dog: Dog) => void;

// This is allowed because functions are contravariant in their parameter types
dogHandler = animalHandler; // OK
```

### **strictPropertyInitialization**

```typescript
// ❌ Error with strictPropertyInitialization: true
class User {
  name: string; // Property 'name' has no initializer and is not definitely assigned in the constructor
  age: number;  // Property 'age' has no initializer and is not definitely assigned in the constructor
}

// ✅ Good: Initialize in constructor
class User {
  name: string;
  age: number;
  
  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}

// ✅ Good: Use definite assignment assertion
class User {
  name!: string; // Definite assignment assertion
  age!: number;  // Definite assignment assertion
}

// ✅ Good: Use optional properties
class User {
  name?: string;
  age?: number;
}
```

---

## 🔍 **Type Checking Options**

### **Additional Type Checking Options**

```json
{
  "compilerOptions": {
    // Check for unreachable code
    "noUnreachableCode": true,
    
    // Check for unused locals
    "noUnusedLocals": true,
    
    // Check for unused parameters
    "noUnusedParameters": true,
    
    // Check for implicit returns
    "noImplicitReturns": true,
    
    // Check for fallthrough cases in switch
    "noFallthroughCasesInSwitch": true,
    
    // Check for unchecked indexed access
    "noUncheckedIndexedAccess": true
  }
}
```

### **noUnreachableCode**

```typescript
// ❌ Error with noUnreachableCode: true
function processData(data: string): string {
  if (data.length === 0) {
    return "empty";
    console.log("This will never execute"); // Unreachable code
  }
  return data;
}

// ✅ Good: Remove unreachable code
function processData(data: string): string {
  if (data.length === 0) {
    return "empty";
  }
  return data;
}
```

### **noUnusedLocals and noUnusedParameters**

```typescript
// ❌ Error with noUnusedLocals: true
function processData(data: string): string {
  const unusedVariable = "not used"; // Unused local variable
  return data;
}

// ❌ Error with noUnusedParameters: true
function processData(data: string, unusedParam: number): string {
  return data; // unusedParam is not used
}

// ✅ Good: Remove unused variables
function processData(data: string): string {
  return data;
}

// ✅ Good: Prefix unused parameters with underscore
function processData(data: string, _unusedParam: number): string {
  return data;
}
```

### **noUncheckedIndexedAccess**

```typescript
// ❌ Error with noUncheckedIndexedAccess: true
function getFirstElement<T>(array: T[]): T {
  return array[0]; // Type 'T | undefined' is not assignable to type 'T'
}

// ✅ Good: Handle undefined case
function getFirstElement<T>(array: T[]): T | undefined {
  return array[0];
}

// ✅ Good: Use type guard
function getFirstElement<T>(array: T[]): T {
  if (array.length === 0) {
    throw new Error("Array is empty");
  }
  return array[0];
}
```

---

## 📦 **Module Resolution Options**

### **Module Resolution Strategy**

```json
{
  "compilerOptions": {
    // Module resolution strategy
    "moduleResolution": "node",
    
    // Base URL for module resolution
    "baseUrl": "./src",
    
    // Path mapping
    "paths": {
      "@/*": ["*"],
      "@/components/*": ["components/*"],
      "@/utils/*": ["utils/*"]
    },
    
    // Module interop
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    
    // Force consistent casing
    "forceConsistentCasingInFileNames": true
  }
}
```

### **Module Resolution Examples**

```typescript
// With baseUrl: "./src" and paths: { "@/*": ["*"] }
import { User } from "@/types/user";           // Resolves to src/types/user
import { Button } from "@/components/Button";  // Resolves to src/components/Button
import { utils } from "@/utils/helpers";       // Resolves to src/utils/helpers

// Without path mapping
import { User } from "../../types/user";
import { Button } from "../components/Button";
import { utils } from "../utils/helpers";
```

---

## 📤 **Output Options**

### **Output Configuration**

```json
{
  "compilerOptions": {
    // Output directory
    "outDir": "./dist",
    
    // Root directory
    "rootDir": "./src",
    
    // Source maps
    "sourceMap": true,
    "inlineSourceMap": false,
    "sourceRoot": "./",
    
    // Declaration files
    "declaration": true,
    "declarationMap": true,
    "declarationDir": "./types",
    
    // Remove comments
    "removeComments": true,
    
    // Emit on error
    "noEmitOnError": true
  }
}
```

### **Source Map Options**

```json
{
  "compilerOptions": {
    // Generate source maps
    "sourceMap": true,
    
    // Inline source maps in generated files
    "inlineSourceMap": false,
    
    // Source root for source maps
    "sourceRoot": "./",
    
    // Generate declaration source maps
    "declarationMap": true
  }
}
```

---

## 🚀 **Advanced Options**

### **Experimental Features**

```json
{
  "compilerOptions": {
    // Enable decorators
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    
    // Enable import helpers
    "importHelpers": true,
    
    // Enable downlevel iteration
    "downlevelIteration": true
  }
}
```

### **Incremental Compilation**

```json
{
  "compilerOptions": {
    // Enable incremental compilation
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo",
    
    // Composite projects
    "composite": true,
    
    // Watch mode
    "watch": true,
    "preserveWatchOutput": true
  }
}
```

### **Advanced Type Checking**

```json
{
  "compilerOptions": {
    // Skip type checking of declaration files
    "skipLibCheck": true,
    
    // Allow JavaScript files
    "allowJs": true,
    "checkJs": true,
    
    // Resolve JSON modules
    "resolveJsonModule": true,
    
    // Allow unused labels
    "allowUnusedLabels": false,
    
    // Allow unreachable code
    "allowUnreachableCode": false
  }
}
```

---

## ✅ **Best Practices**

### **1. Enable Strict Mode**

```json
// ✅ Good: Enable strict mode
{
  "compilerOptions": {
    "strict": true
  }
}

// ❌ Avoid: Disabling strict mode
{
  "compilerOptions": {
    "strict": false
  }
}
```

### **2. Use Specific Strict Options**

```json
// ✅ Good: Enable specific strict options
{
  "compilerOptions": {
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noUncheckedIndexedAccess": true
  }
}

// ❌ Avoid: Only using basic strict mode
{
  "compilerOptions": {
    "strict": true
  }
}
```

### **3. Configure Module Resolution**

```json
// ✅ Good: Configure module resolution
{
  "compilerOptions": {
    "moduleResolution": "node",
    "baseUrl": "./src",
    "paths": {
      "@/*": ["*"]
    }
  }
}

// ❌ Avoid: Default module resolution
{
  "compilerOptions": {
    "moduleResolution": "classic"
  }
}
```

### **4. Use Incremental Compilation**

```json
// ✅ Good: Enable incremental compilation
{
  "compilerOptions": {
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo"
  }
}

// ❌ Avoid: Disabling incremental compilation
{
  "compilerOptions": {
    "incremental": false
  }
}
```

---

## ❓ **Common Interview Questions**

### **1. What is strict mode in TypeScript?**

**Answer:**
Strict mode enables additional type checking options for better type safety. It includes:
- `noImplicitAny`: Prevents implicit any types
- `strictNullChecks`: Prevents null/undefined errors
- `strictFunctionTypes`: Ensures function type safety
- `strictPropertyInitialization`: Ensures property initialization

### **2. What are the benefits of enabling strict mode?**

**Answer:**
- **Better type safety**: Catches more potential errors
- **Improved code quality**: Forces explicit type annotations
- **Better refactoring**: Safer code changes
- **Runtime safety**: Prevents common runtime errors

### **3. How do you handle strict null checks?**

**Answer:**
- Use union types: `string | null`
- Use optional properties: `name?: string`
- Use type guards: `if (value !== null)`
- Use non-null assertion: `value!`

### **4. What's the difference between moduleResolution "node" and "classic"?**

**Answer:**
- **"node"**: Uses Node.js module resolution algorithm
- **"classic"**: Uses TypeScript's legacy module resolution

### **5. How do you configure path mapping in TypeScript?**

**Answer:**
Use `baseUrl` and `paths` in `tsconfig.json`:

```json
{
  "compilerOptions": {
    "baseUrl": "./src",
    "paths": {
      "@/*": ["*"],
      "@/components/*": ["components/*"]
    }
  }
}
```

---

## 🧭 Navigation

<div class="navigation">
  <a href="01-tsconfig-json-Deep-Dive.md" class="nav-button">← Previous: tsconfig.json Deep Dive</a>
  <a href="03-TypeScript-Build-Tools.md" class="nav-button">Next: TypeScript with Build Tools →</a>
</div>

*Last updated: December 2024*
