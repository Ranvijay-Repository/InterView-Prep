# 🎭 **Discriminated Unions**

> **Complete guide to TypeScript discriminated unions, pattern matching, and advanced union type techniques**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Discriminated Unions Overview](#discriminated-unions-overview)
- [Basic Discriminated Unions](#basic-discriminated-unions)
- [Advanced Patterns](#advanced-patterns)
- [Pattern Matching](#pattern-matching)
- [Real-World Examples](#real-world-examples)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Discriminated Unions Overview**

Discriminated unions are a powerful TypeScript feature that combines union types with a common discriminator property for type safety.

### **What are Discriminated Unions?**

```typescript
// Discriminated unions combine union types with a discriminator
const discriminatedUnions = {
  purpose: "Type-safe union types with discrimination",
  discriminator: "Common property that identifies the type",
  safety: "Compile-time type safety",
  exhaustiveness: "Exhaustive pattern matching"
};

// Basic discriminated union
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

// The 'status' property is the discriminator
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
  }
}
```

### **Benefits of Discriminated Unions**

```typescript
// Benefits of discriminated unions
const benefits = {
  typeSafety: "Compile-time type safety",
  exhaustiveness: "Exhaustive pattern matching",
  intellisense: "Better IDE support",
  refactoring: "Safer refactoring",
  debugging: "Easier debugging"
};

// Without discriminated unions
type BadState = { data?: any; error?: string; loading?: boolean };

function handleBadState(state: BadState) {
  if (state.loading) {
    return 'Loading...';
  } else if (state.data) {
    return `Data: ${state.data}`;
  } else if (state.error) {
    return `Error: ${state.error}`;
  }
  // What if multiple properties are true?
}

// With discriminated unions
type GoodState = LoadingState | SuccessState | ErrorState;

function handleGoodState(state: GoodState) {
  switch (state.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return `Data: ${state.data}`;
    case 'error':
      return `Error: ${state.error}`;
  }
}
```

---

## 🔧 **Basic Discriminated Unions**

### **Simple State Management**

```typescript
// Simple state management with discriminated unions
interface IdleState {
  state: 'idle';
}

interface LoadingState {
  state: 'loading';
  progress: number;
}

interface SuccessState {
  state: 'success';
  result: any;
}

interface ErrorState {
  state: 'error';
  message: string;
}

type AsyncState = IdleState | LoadingState | SuccessState | ErrorState;

function handleAsyncState(state: AsyncState) {
  switch (state.state) {
    case 'idle':
      return 'Ready to start';
    case 'loading':
      return `Loading... ${state.progress}%`;
    case 'success':
      return `Success: ${state.result}`;
    case 'error':
      return `Error: ${state.message}`;
  }
}
```

### **API Response Handling**

```typescript
// API response handling with discriminated unions
interface ApiLoadingResponse {
  status: 'loading';
}

interface ApiSuccessResponse<T> {
  status: 'success';
  data: T;
  timestamp: number;
}

interface ApiErrorResponse {
  status: 'error';
  error: string;
  code: number;
}

type ApiResponse<T> = ApiLoadingResponse | ApiSuccessResponse<T> | ApiErrorResponse;

function handleApiResponse<T>(response: ApiResponse<T>) {
  switch (response.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return `Data: ${response.data} (${response.timestamp})`;
    case 'error':
      return `Error ${response.code}: ${response.error}`;
  }
}

// Usage
const userResponse: ApiResponse<User> = {
  status: 'success',
  data: { id: 1, name: 'John' },
  timestamp: Date.now()
};
```

### **Form State Management**

```typescript
// Form state management with discriminated unions
interface FormIdleState {
  state: 'idle';
}

interface FormValidatingState {
  state: 'validating';
  field: string;
}

interface FormValidState {
  state: 'valid';
  data: FormData;
}

interface FormInvalidState {
  state: 'invalid';
  errors: Record<string, string>;
}

interface FormSubmittingState {
  state: 'submitting';
  data: FormData;
}

interface FormSubmittedState {
  state: 'submitted';
  result: any;
}

type FormState = 
  | FormIdleState 
  | FormValidatingState 
  | FormValidState 
  | FormInvalidState 
  | FormSubmittingState 
  | FormSubmittedState;

function handleFormState(state: FormState) {
  switch (state.state) {
    case 'idle':
      return 'Form is ready';
    case 'validating':
      return `Validating ${state.field}...`;
    case 'valid':
      return 'Form is valid';
    case 'invalid':
      return `Errors: ${Object.keys(state.errors).join(', ')}`;
    case 'submitting':
      return 'Submitting form...';
    case 'submitted':
      return 'Form submitted successfully';
  }
}
```

---

## 🚀 **Advanced Patterns**

### **Nested Discriminated Unions**

```typescript
// Nested discriminated unions
interface BaseEvent {
  type: string;
  timestamp: number;
}

interface UserEvent extends BaseEvent {
  type: 'user';
  userId: string;
  action: 'login' | 'logout' | 'update';
}

interface SystemEvent extends BaseEvent {
  type: 'system';
  level: 'info' | 'warning' | 'error';
  message: string;
}

interface NetworkEvent extends BaseEvent {
  type: 'network';
  method: 'GET' | 'POST' | 'PUT' | 'DELETE';
  url: string;
  status: number;
}

type Event = UserEvent | SystemEvent | NetworkEvent;

function handleEvent(event: Event) {
  switch (event.type) {
    case 'user':
      return `User ${event.userId} performed ${event.action}`;
    case 'system':
      return `System ${event.level}: ${event.message}`;
    case 'network':
      return `${event.method} ${event.url} - ${event.status}`;
  }
}
```

### **Generic Discriminated Unions**

```typescript
// Generic discriminated unions
interface LoadingResult<T> {
  status: 'loading';
  promise: Promise<T>;
}

interface SuccessResult<T> {
  status: 'success';
  data: T;
}

interface ErrorResult {
  status: 'error';
  error: Error;
}

type Result<T> = LoadingResult<T> | SuccessResult<T> | ErrorResult;

function handleResult<T>(result: Result<T>) {
  switch (result.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return `Success: ${result.data}`;
    case 'error':
      return `Error: ${result.error.message}`;
  }
}

// Usage with different types
const userResult: Result<User> = {
  status: 'success',
  data: { id: 1, name: 'John' }
};

const productResult: Result<Product[]> = {
  status: 'loading',
  promise: fetchProducts()
};
```

### **Conditional Discriminated Unions**

```typescript
// Conditional discriminated unions
interface BaseRequest {
  id: string;
  timestamp: number;
}

interface GetRequest extends BaseRequest {
  method: 'GET';
  url: string;
}

interface PostRequest extends BaseRequest {
  method: 'POST';
  url: string;
  body: any;
}

interface PutRequest extends BaseRequest {
  method: 'PUT';
  url: string;
  body: any;
}

interface DeleteRequest extends BaseRequest {
  method: 'DELETE';
  url: string;
}

type HttpRequest = GetRequest | PostRequest | PutRequest | DeleteRequest;

function handleRequest(request: HttpRequest) {
  switch (request.method) {
    case 'GET':
      return `GET ${request.url}`;
    case 'POST':
      return `POST ${request.url} with body: ${JSON.stringify(request.body)}`;
    case 'PUT':
      return `PUT ${request.url} with body: ${JSON.stringify(request.body)}`;
    case 'DELETE':
      return `DELETE ${request.url}`;
  }
}
```

---

## 🎭 **Pattern Matching**

### **Exhaustive Pattern Matching**

```typescript
// Exhaustive pattern matching
interface RedState {
  color: 'red';
  intensity: number;
}

interface GreenState {
  color: 'green';
  brightness: number;
}

interface BlueState {
  color: 'blue';
  saturation: number;
}

type ColorState = RedState | GreenState | BlueState;

function handleColorState(state: ColorState) {
  switch (state.color) {
    case 'red':
      return `Red with intensity ${state.intensity}`;
    case 'green':
      return `Green with brightness ${state.brightness}`;
    case 'blue':
      return `Blue with saturation ${state.saturation}`;
    default:
      // Exhaustive check
      const _exhaustive: never = state;
      return _exhaustive;
  }
}
```

### **Partial Pattern Matching**

```typescript
// Partial pattern matching
interface PartialState {
  type: 'partial';
  data: any;
  errors?: string[];
}

interface CompleteState {
  type: 'complete';
  data: any;
  timestamp: number;
}

type PartialOrComplete = PartialState | CompleteState;

function handlePartialOrComplete(state: PartialOrComplete) {
  switch (state.type) {
    case 'partial':
      if (state.errors) {
        return `Partial with errors: ${state.errors.join(', ')}`;
      }
      return 'Partial without errors';
    case 'complete':
      return `Complete at ${state.timestamp}`;
  }
}
```

### **Recursive Pattern Matching**

```typescript
// Recursive pattern matching
interface LeafNode {
  type: 'leaf';
  value: number;
}

interface BranchNode {
  type: 'branch';
  left: TreeNode;
  right: TreeNode;
}

type TreeNode = LeafNode | BranchNode;

function evaluateTree(node: TreeNode): number {
  switch (node.type) {
    case 'leaf':
      return node.value;
    case 'branch':
      return evaluateTree(node.left) + evaluateTree(node.right);
  }
}

// Usage
const tree: TreeNode = {
  type: 'branch',
  left: { type: 'leaf', value: 5 },
  right: {
    type: 'branch',
    left: { type: 'leaf', value: 3 },
    right: { type: 'leaf', value: 2 }
  }
};
```

---

## 🌍 **Real-World Examples**

### **Redux State Management**

```typescript
// Redux state management with discriminated unions
interface InitialState {
  status: 'initial';
}

interface LoadingState {
  status: 'loading';
  requestId: string;
}

interface SuccessState {
  status: 'success';
  data: any;
  timestamp: number;
}

interface ErrorState {
  status: 'error';
  error: string;
  retryCount: number;
}

type ReduxState = InitialState | LoadingState | SuccessState | ErrorState;

function handleReduxState(state: ReduxState) {
  switch (state.status) {
    case 'initial':
      return 'Initial state';
    case 'loading':
      return `Loading with request ID: ${state.requestId}`;
    case 'success':
      return `Success at ${state.timestamp}`;
    case 'error':
      return `Error (retry ${state.retryCount}): ${state.error}`;
  }
}
```

### **WebSocket Message Handling**

```typescript
// WebSocket message handling with discriminated unions
interface ConnectMessage {
  type: 'connect';
  userId: string;
}

interface DisconnectMessage {
  type: 'disconnect';
  reason: string;
}

interface DataMessage {
  type: 'data';
  payload: any;
}

interface ErrorMessage {
  type: 'error';
  code: number;
  message: string;
}

type WebSocketMessage = ConnectMessage | DisconnectMessage | DataMessage | ErrorMessage;

function handleWebSocketMessage(message: WebSocketMessage) {
  switch (message.type) {
    case 'connect':
      return `User ${message.userId} connected`;
    case 'disconnect':
      return `Disconnected: ${message.reason}`;
    case 'data':
      return `Data received: ${JSON.stringify(message.payload)}`;
    case 'error':
      return `Error ${message.code}: ${message.message}`;
  }
}
```

### **File System Operations**

```typescript
// File system operations with discriminated unions
interface FileReadOperation {
  operation: 'read';
  path: string;
  encoding: 'utf8' | 'binary';
}

interface FileWriteOperation {
  operation: 'write';
  path: string;
  content: string;
  encoding: 'utf8' | 'binary';
}

interface FileDeleteOperation {
  operation: 'delete';
  path: string;
}

interface FileListOperation {
  operation: 'list';
  directory: string;
  recursive: boolean;
}

type FileOperation = FileReadOperation | FileWriteOperation | FileDeleteOperation | FileListOperation;

function handleFileOperation(operation: FileOperation) {
  switch (operation.operation) {
    case 'read':
      return `Reading ${operation.path} with ${operation.encoding} encoding`;
    case 'write':
      return `Writing to ${operation.path} with ${operation.encoding} encoding`;
    case 'delete':
      return `Deleting ${operation.path}`;
    case 'list':
      return `Listing ${operation.directory}${operation.recursive ? ' recursively' : ''}`;
  }
}
```

---

## ✅ **Best Practices**

### **1. Use Descriptive Discriminators**

```typescript
// ✅ Good: Descriptive discriminators
interface LoadingState {
  status: 'loading';
}

interface SuccessState {
  status: 'success';
  data: any;
}

// ❌ Avoid: Unclear discriminators
interface LoadingState {
  state: 'loading';
}

interface SuccessState {
  state: 'success';
  data: any;
}
```

### **2. Keep Discriminators Simple**

```typescript
// ✅ Good: Simple string discriminators
interface LoadingState {
  status: 'loading';
}

interface SuccessState {
  status: 'success';
  data: any;
}

// ❌ Avoid: Complex discriminators
interface LoadingState {
  status: { type: 'loading'; id: string };
}

interface SuccessState {
  status: { type: 'success'; id: string };
  data: any;
}
```

### **3. Use Exhaustive Checks**

```typescript
// ✅ Good: Exhaustive checks
function handleState(state: AppState) {
  switch (state.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return 'Success';
    case 'error':
      return 'Error';
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
    case 'success':
      return 'Success';
    // Missing 'error' case
  }
}
```

### **4. Group Related States**

```typescript
// ✅ Good: Group related states
interface LoadingState {
  status: 'loading';
  progress: number;
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

// ❌ Avoid: Unrelated states
interface LoadingState {
  status: 'loading';
  progress: number;
}

interface UserState {
  user: User;
  isLoggedIn: boolean;
}

type AppState = LoadingState | UserState;
```

---

## ❓ **Common Interview Questions**

### **1. What are discriminated unions in TypeScript?**

**Answer:**
Discriminated unions are union types with a common discriminator property that helps TypeScript narrow down the exact type. They provide type safety and enable exhaustive pattern matching.

### **2. How do discriminated unions improve type safety?**

**Answer:**
- **Compile-time safety**: TypeScript can narrow types based on the discriminator
- **Exhaustive checking**: Ensures all cases are handled
- **Better IntelliSense**: IDE can provide accurate autocomplete
- **Safer refactoring**: Changes to union members are caught at compile time

### **3. What's the difference between union types and discriminated unions?**

**Answer:**
- **Union Types**: Simple combination of types without discrimination
- **Discriminated Unions**: Union types with a common discriminator property
- Discriminated unions provide better type narrowing and exhaustiveness checking

### **4. How do you handle exhaustive checks in discriminated unions?**

**Answer:**
Use the `never` type in the default case to ensure all cases are handled:
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

### **5. When should you use discriminated unions?**

**Answer:**
- **State management**: Representing different states of an application
- **API responses**: Handling different response types
- **Event handling**: Processing different types of events
- **Form validation**: Representing different validation states
- **Any scenario**: Where you need type-safe union types with discrimination

---

## 🧭 Navigation

<div class="navigation">
  <a href="01-Type-Guards-Narrowing.md" class="nav-button">← Previous: Type Guards & Narrowing</a>
  <a href="03-Branded-Types-Opaque-Types.md" class="nav-button">Next: Branded Types & Opaque Types →</a>
</div>

*Last updated: December 2024*
