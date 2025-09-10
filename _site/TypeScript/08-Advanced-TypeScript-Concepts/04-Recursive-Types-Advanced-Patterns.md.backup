# 🔄 **Recursive Types & Advanced Patterns**

> **Complete guide to TypeScript recursive types, advanced type patterns, and complex type system techniques**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Recursive Types Overview](#recursive-types-overview)
- [Basic Recursive Types](#basic-recursive-types)
- [Advanced Recursive Patterns](#advanced-recursive-patterns)
- [Complex Type Patterns](#complex-type-patterns)
- [Real-World Examples](#real-world-examples)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Recursive Types Overview**

Recursive types allow TypeScript to define types that reference themselves, enabling complex data structures and advanced type patterns.

### **What are Recursive Types?**


```typescript
// Recursive types reference themselves
const recursiveTypes = {
  purpose: "Define types that reference themselves",
  examples: "Trees, linked lists, nested structures",
  benefits: "Type safety for complex data structures",
  patterns: "Advanced type system patterns"
};

// Basic recursive type
interface TreeNode {
  value: number;
  left?: TreeNode;
  right?: TreeNode;
}

// Recursive type with generics
interface GenericTreeNode<T> {
  value: T;
  children: GenericTreeNode<T>[];
}

// Recursive type with constraints
interface ConstrainedTreeNode<T extends string | number> {
  value: T;
  left?: ConstrainedTreeNode<T>;
  right?: ConstrainedTreeNode<T>;
}
```


### **Benefits of Recursive Types**


```typescript
// Benefits of recursive types
const benefits = {
  typeSafety: "Type safety for complex data structures",
  intellisense: "Better IDE support for nested structures",
  validation: "Compile-time validation of structure",
  patterns: "Enable advanced type patterns",
  modeling: "Model complex domain concepts"
};

// Without recursive types
interface BadTreeNode {
  value: number;
  left?: any; // ❌ No type safety
  right?: any; // ❌ No type safety
}

// With recursive types
interface GoodTreeNode {
  value: number;
  left?: GoodTreeNode; // ✅ Type safe
  right?: GoodTreeNode; // ✅ Type safe
}
```


---

## 🔧 **Basic Recursive Types**

### **Tree Structures**


```typescript
// Tree structures with recursive types
interface BinaryTree<T> {
  value: T;
  left?: BinaryTree<T>;
  right?: BinaryTree<T>;
}

interface NaryTree<T> {
  value: T;
  children: NaryTree<T>[];
}

// Tree operations
function traverseTree<T>(tree: BinaryTree<T>, callback: (value: T) => void): void {
  callback(tree.value);
  if (tree.left) traverseTree(tree.left, callback);
  if (tree.right) traverseTree(tree.right, callback);
}

function findInTree<T>(tree: BinaryTree<T>, predicate: (value: T) => boolean): T | null {
  if (predicate(tree.value)) {
    return tree.value;
  }
  if (tree.left) {
    const leftResult = findInTree(tree.left, predicate);
    if (leftResult) return leftResult;
  }
  if (tree.right) {
    const rightResult = findInTree(tree.right, predicate);
    if (rightResult) return rightResult;
  }
  return null;
}

// Usage
const tree: BinaryTree<number> = {
  value: 5,
  left: {
    value: 3,
    left: { value: 1 },
    right: { value: 4 }
  },
  right: {
    value: 8,
    left: { value: 6 },
    right: { value: 9 }
  }
};

traverseTree(tree, value => console.log(value));
const found = findInTree(tree, value => value > 7);
```


### **Linked Lists**


```typescript
// Linked lists with recursive types
interface ListNode<T> {
  value: T;
  next?: ListNode<T>;
}

interface DoublyListNode<T> {
  value: T;
  next?: DoublyListNode<T>;
  prev?: DoublyListNode<T>;
}

// Linked list operations
function traverseList<T>(head: ListNode<T>, callback: (value: T) => void): void {
  let current = head;
  while (current) {
    callback(current.value);
    current = current.next!;
  }
}

function findInList<T>(head: ListNode<T>, predicate: (value: T) => boolean): T | null {
  let current = head;
  while (current) {
    if (predicate(current.value)) {
      return current.value;
    }
    current = current.next!;
  }
  return null;
}

function reverseList<T>(head: ListNode<T>): ListNode<T> {
  let prev: ListNode<T> | undefined;
  let current: ListNode<T> | undefined = head;
  
  while (current) {
    const next = current.next;
    current.next = prev;
    prev = current;
    current = next;
  }
  
  return prev!;
}

// Usage
const list: ListNode<number> = {
  value: 1,
  next: {
    value: 2,
    next: {
      value: 3,
      next: {
        value: 4
      }
    }
  }
};

traverseList(list, value => console.log(value));
const found = findInList(list, value => value > 2);
const reversed = reverseList(list);
```


### **Nested Objects**


```typescript
// Nested objects with recursive types
interface NestedObject {
  [key: string]: string | number | boolean | NestedObject;
}

interface TypedNestedObject<T> {
  [key: string]: T | TypedNestedObject<T>;
}

// Nested object operations
function getNestedValue(obj: NestedObject, path: string[]): any {
  let current = obj;
  for (const key of path) {
    if (current && typeof current === 'object' && key in current) {
      current = current[key] as NestedObject;
    } else {
      return undefined;
    }
  }
  return current;
}

function setNestedValue(obj: NestedObject, path: string[], value: any): void {
  let current = obj;
  for (let i = 0; i < path.length - 1; i++) {
    const key = path[i];
    if (!(key in current) || typeof current[key] !== 'object') {
      current[key] = {};
    }
    current = current[key] as NestedObject;
  }
  current[path[path.length - 1]] = value;
}

// Usage
const nested: NestedObject = {
  user: {
    profile: {
      name: 'John',
      age: 30
    },
    settings: {
      theme: 'dark'
    }
  }
};

const name = getNestedValue(nested, ['user', 'profile', 'name']);
setNestedValue(nested, ['user', 'profile', 'email'], 'john@example.com');
```


---

## 🚀 **Advanced Recursive Patterns**

### **Recursive Type Utilities**


```typescript
// Recursive type utilities
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

type DeepRequired<T> = {
  [P in keyof T]-?: T[P] extends object ? DeepRequired<T[P]> : T[P];
};

type DeepMutable<T> = {
  -readonly [P in keyof T]: T[P] extends object ? DeepMutable<T[P]> : T[P];
};

// Usage
interface User {
  id: number;
  profile: {
    name: string;
    email: string;
    settings: {
      theme: string;
      notifications: boolean;
    };
  };
}

type ReadonlyUser = DeepReadonly<User>;
type PartialUser = DeepPartial<User>;
type RequiredUser = DeepRequired<User>;
type MutableUser = DeepMutable<User>;
```


### **Recursive Conditional Types**


```typescript
// Recursive conditional types
type Flatten<T> = T extends (infer U)[] ? Flatten<U> : T;

type DeepFlatten<T> = T extends (infer U)[] ? DeepFlatten<U> : T;

type ExtractArrayTypes<T> = T extends (infer U)[] ? U : never;

type RecursiveExtract<T, U> = T extends U ? T : T extends object ? {
  [K in keyof T]: RecursiveExtract<T[K], U>;
}[keyof T] : never;

// Usage
type NestedArray = number[][][];
type Flattened = Flatten<NestedArray>; // number

type MixedArray = (string | number)[][];
type Extracted = ExtractArrayTypes<MixedArray>; // string | number
```


### **Recursive Mapped Types**


```typescript
// Recursive mapped types
type RecursiveRecord<K extends string, V> = {
  [P in K]: V | RecursiveRecord<K, V>;
};

type RecursiveArray<T> = T | RecursiveArray<T>[];

type RecursiveObject<T> = T | { [key: string]: RecursiveObject<T> };

// Usage
type NestedRecord = RecursiveRecord<'a' | 'b', string>;
type NestedArray = RecursiveArray<number>;
type NestedObject = RecursiveObject<string>;
```


---

## 🎭 **Complex Type Patterns**

### **Recursive Type Guards**


```typescript
// Recursive type guards
function isTreeNode(value: unknown): value is TreeNode {
  return (
    typeof value === 'object' &&
    value !== null &&
    'value' in value &&
    typeof (value as any).value === 'number' &&
    (!('left' in value) || isTreeNode((value as any).left)) &&
    (!('right' in value) || isTreeNode((value as any).right))
  );
}

function isListNode<T>(value: unknown, itemGuard: (item: unknown) => item is T): value is ListNode<T> {
  return (
    typeof value === 'object' &&
    value !== null &&
    'value' in value &&
    itemGuard((value as any).value) &&
    (!('next' in value) || isListNode((value as any).next, itemGuard))
  );
}

function isNestedObject(value: unknown): value is NestedObject {
  if (typeof value !== 'object' || value === null) {
    return false;
  }
  
  for (const [key, val] of Object.entries(value)) {
    if (typeof val !== 'string' && typeof val !== 'number' && typeof val !== 'boolean' && !isNestedObject(val)) {
      return false;
    }
  }
  
  return true;
}
```


### **Recursive Type Validation**


```typescript
// Recursive type validation
type ValidationResult<T> = {
  valid: boolean;
  errors: string[];
  data?: T;
};

function validateTreeNode(node: unknown): ValidationResult<TreeNode> {
  const errors: string[] = [];
  
  if (typeof node !== 'object' || node === null) {
    errors.push('Node must be an object');
    return { valid: false, errors };
  }
  
  const nodeObj = node as any;
  
  if (typeof nodeObj.value !== 'number') {
    errors.push('Node value must be a number');
  }
  
  if ('left' in nodeObj && nodeObj.left !== undefined) {
    const leftResult = validateTreeNode(nodeObj.left);
    if (!leftResult.valid) {
      errors.push(`Left child: ${leftResult.errors.join(', ')}`);
    }
  }
  
  if ('right' in nodeObj && nodeObj.right !== undefined) {
    const rightResult = validateTreeNode(nodeObj.right);
    if (!rightResult.valid) {
      errors.push(`Right child: ${rightResult.errors.join(', ')}`);
    }
  }
  
  return {
    valid: errors.length === 0,
    errors,
    data: errors.length === 0 ? node as TreeNode : undefined
  };
}
```


### **Recursive Type Transformations**


```typescript
// Recursive type transformations
type TransformTree<T, U> = {
  value: U;
  left?: TransformTree<T, U>;
  right?: TransformTree<T, U>;
};

function transformTree<T, U>(
  tree: BinaryTree<T>,
  transformer: (value: T) => U
): TransformTree<T, U> {
  return {
    value: transformer(tree.value),
    left: tree.left ? transformTree(tree.left, transformer) : undefined,
    right: tree.right ? transformTree(tree.right, transformer) : undefined
  };
}

type FilterTree<T> = {
  value: T;
  left?: FilterTree<T>;
  right?: FilterTree<T>;
};

function filterTree<T>(
  tree: BinaryTree<T>,
  predicate: (value: T) => boolean
): FilterTree<T> | null {
  if (!predicate(tree.value)) {
    return null;
  }
  
  return {
    value: tree.value,
    left: tree.left ? filterTree(tree.left, predicate) : undefined,
    right: tree.right ? filterTree(tree.right, predicate) : undefined
  };
}
```


---

## 🌍 **Real-World Examples**

### **File System Tree**


```typescript
// File system tree with recursive types
interface FileNode {
  name: string;
  type: 'file' | 'directory';
  size?: number;
  children?: FileNode[];
}

// File system operations
function findFile(root: FileNode, fileName: string): FileNode | null {
  if (root.name === fileName) {
    return root;
  }
  
  if (root.children) {
    for (const child of root.children) {
      const found = findFile(child, fileName);
      if (found) return found;
    }
  }
  
  return null;
}

function calculateTotalSize(root: FileNode): number {
  if (root.type === 'file') {
    return root.size || 0;
  }
  
  if (root.children) {
    return root.children.reduce((total, child) => total + calculateTotalSize(child), 0);
  }
  
  return 0;
}

function listAllFiles(root: FileNode): string[] {
  const files: string[] = [];
  
  if (root.type === 'file') {
    files.push(root.name);
  }
  
  if (root.children) {
    for (const child of root.children) {
      files.push(...listAllFiles(child));
    }
  }
  
  return files;
}

// Usage
const fileSystem: FileNode = {
  name: 'root',
  type: 'directory',
  children: [
    {
      name: 'documents',
      type: 'directory',
      children: [
        { name: 'readme.txt', type: 'file', size: 1024 },
        { name: 'notes.md', type: 'file', size: 2048 }
      ]
    },
    {
      name: 'images',
      type: 'directory',
      children: [
        { name: 'photo.jpg', type: 'file', size: 1024000 }
      ]
    }
  ]
};

const foundFile = findFile(fileSystem, 'readme.txt');
const totalSize = calculateTotalSize(fileSystem);
const allFiles = listAllFiles(fileSystem);
```


### **JSON Schema Validation**


```typescript
// JSON schema validation with recursive types
interface JsonSchema {
  type: 'string' | 'number' | 'boolean' | 'object' | 'array';
  properties?: Record<string, JsonSchema>;
  items?: JsonSchema;
  required?: string[];
  enum?: any[];
}

// Schema validation
function validateAgainstSchema(data: any, schema: JsonSchema): boolean {
  if (schema.type === 'string' && typeof data !== 'string') {
    return false;
  }
  
  if (schema.type === 'number' && typeof data !== 'number') {
    return false;
  }
  
  if (schema.type === 'boolean' && typeof data !== 'boolean') {
    return false;
  }
  
  if (schema.type === 'object' && typeof data !== 'object') {
    return false;
  }
  
  if (schema.type === 'array' && !Array.isArray(data)) {
    return false;
  }
  
  if (schema.enum && !schema.enum.includes(data)) {
    return false;
  }
  
  if (schema.type === 'object' && schema.properties) {
    for (const [key, propSchema] of Object.entries(schema.properties)) {
      if (schema.required?.includes(key) && !(key in data)) {
        return false;
      }
      if (key in data && !validateAgainstSchema(data[key], propSchema)) {
        return false;
      }
    }
  }
  
  if (schema.type === 'array' && schema.items) {
    for (const item of data) {
      if (!validateAgainstSchema(item, schema.items)) {
        return false;
      }
    }
  }
  
  return true;
}

// Usage
const userSchema: JsonSchema = {
  type: 'object',
  properties: {
    id: { type: 'number' },
    name: { type: 'string' },
    email: { type: 'string' },
    profile: {
      type: 'object',
      properties: {
        age: { type: 'number' },
        settings: {
          type: 'object',
          properties: {
            theme: { type: 'string', enum: ['light', 'dark'] }
          }
        }
      }
    }
  },
  required: ['id', 'name', 'email']
};

const userData = {
  id: 1,
  name: 'John',
  email: 'john@example.com',
  profile: {
    age: 30,
    settings: {
      theme: 'dark'
    }
  }
};

const isValid = validateAgainstSchema(userData, userSchema);
```


### **Component Tree**


```typescript
// Component tree with recursive types
interface ComponentNode {
  id: string;
  type: string;
  props: Record<string, any>;
  children?: ComponentNode[];
}

// Component operations
function findComponent(root: ComponentNode, componentId: string): ComponentNode | null {
  if (root.id === componentId) {
    return root;
  }
  
  if (root.children) {
    for (const child of root.children) {
      const found = findComponent(child, componentId);
      if (found) return found;
    }
  }
  
  return null;
}

function getComponentPath(root: ComponentNode, componentId: string): string[] {
  if (root.id === componentId) {
    return [root.id];
  }
  
  if (root.children) {
    for (const child of root.children) {
      const path = getComponentPath(child, componentId);
      if (path.length > 0) {
        return [root.id, ...path];
      }
    }
  }
  
  return [];
}

function renderComponent(node: ComponentNode): string {
  let result = `<${node.type} id="${node.id}">`;
  
  if (node.children) {
    for (const child of node.children) {
      result += renderComponent(child);
    }
  }
  
  result += `</${node.type}>`;
  return result;
}

// Usage
const componentTree: ComponentNode = {
  id: 'root',
  type: 'div',
  props: { className: 'app' },
  children: [
    {
      id: 'header',
      type: 'header',
      props: { className: 'header' },
      children: [
        { id: 'logo', type: 'img', props: { src: 'logo.png' } },
        { id: 'nav', type: 'nav', props: { className: 'navigation' } }
      ]
    },
    {
      id: 'main',
      type: 'main',
      props: { className: 'main-content' },
      children: [
        { id: 'sidebar', type: 'aside', props: { className: 'sidebar' } },
        { id: 'content', type: 'section', props: { className: 'content' } }
      ]
    }
  ]
};

const foundComponent = findComponent(componentTree, 'nav');
const componentPath = getComponentPath(componentTree, 'nav');
const renderedHTML = renderComponent(componentTree);
```


---

## ✅ **Best Practices**

### **1. Use Recursive Types for Tree-like Structures**


```typescript
// ✅ Good: Recursive types for trees
interface TreeNode<T> {
  value: T;
  children: TreeNode<T>[];
}

// ❌ Avoid: Non-recursive types for trees
interface BadTreeNode<T> {
  value: T;
  children: any[]; // ❌ No type safety
}
```


### **2. Provide Type Guards for Recursive Types**


```typescript
// ✅ Good: Type guards for recursive types
function isTreeNode(value: unknown): value is TreeNode {
  return (
    typeof value === 'object' &&
    value !== null &&
    'value' in value &&
    Array.isArray((value as any).children) &&
    (value as any).children.every(isTreeNode)
  );
}

// ❌ Avoid: No type guards
function processTreeNode(node: any) {
  // ❌ No type safety
}
```


### **3. Use Recursive Utilities for Deep Operations**


```typescript
// ✅ Good: Recursive utilities
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

// ❌ Avoid: Manual deep operations
function makeReadonly(obj: any): any {
  // ❌ Manual and error-prone
}
```


### **4. Handle Recursive Type Limits**


```typescript
// ✅ Good: Handle recursion limits
type SafeRecursive<T, Depth extends number = 5> = 
  Depth extends 0 ? T : {
    [P in keyof T]: T[P] extends object ? SafeRecursive<T[P], Prev<Depth>> : T[P];
  };

// ❌ Avoid: Unlimited recursion
type UnsafeRecursive<T> = {
  [P in keyof T]: T[P] extends object ? UnsafeRecursive<T[P]> : T[P];
};
```


---

## ❓ **Common Interview Questions**

### **1. What are recursive types in TypeScript?**

**Answer:**
Recursive types are types that reference themselves, allowing you to define complex data structures like trees, linked lists, and nested objects with full type safety.

### **2. How do you create recursive types?**

**Answer:**

```typescript
interface TreeNode {
  value: number;
  left?: TreeNode;
  right?: TreeNode;
}
```

The type references itself in the `left` and `right` properties.

### **3. What are the benefits of recursive types?**

**Answer:**
- **Type Safety**: Full type safety for complex data structures
- **IntelliSense**: Better IDE support for nested structures
- **Validation**: Compile-time validation of structure
- **Patterns**: Enable advanced type patterns
- **Modeling**: Model complex domain concepts

### **4. How do you handle recursion limits in TypeScript?**

**Answer:**
TypeScript has recursion limits to prevent infinite recursion. You can handle this by:
- Using conditional types with depth limits
- Breaking down complex recursive types
- Using iterative approaches where possible

### **5. What are some real-world use cases for recursive types?**

**Answer:**
- **File Systems**: Directory trees and file hierarchies
- **Component Trees**: UI component hierarchies
- **JSON Schemas**: Nested validation schemas
- **Data Structures**: Trees, linked lists, graphs
- **Configuration**: Nested configuration objects

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-Branded-Types-Opaque-Types.md" class="nav-button">← Previous: Branded Types & Opaque Types</a>
  <a href="../09-TypeScript-Performance-Optimization/01-Compilation-Performance.md" class="nav-button">Next: TypeScript Performance & Optimization →</a>
</div>

*Last updated: December 2025*
