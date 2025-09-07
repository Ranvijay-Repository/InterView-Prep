# 🛡️ **Type Safety Best Practices**

> **Complete guide to TypeScript type safety, strict typing, and defensive programming techniques**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Type Safety Overview](#type-safety-overview)
- [Strict Type Configuration](#strict-type-configuration)
- [Type Guards and Validation](#type-guards-and-validation)
- [Defensive Programming](#defensive-programming)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Type Safety Overview**

Type safety is the cornerstone of TypeScript, providing compile-time error detection and runtime reliability.

### **Type Safety Benefits**

```typescript
// Type safety benefits
const typeSafetyBenefits = {
  compileTimeErrors: "Catch errors at compile time",
  intellisense: "Better IDE support and autocomplete",
  refactoring: "Safer refactoring with type checking",
  documentation: "Types serve as documentation",
  runtimeSafety: "Reduced runtime errors",
  maintainability: "Easier to maintain and debug"
};

// Type safety levels
const typeSafetyLevels = {
  strict: "Maximum type safety with strict mode",
  moderate: "Balanced type safety and flexibility",
  loose: "Minimal type checking for quick development",
  any: "No type safety (avoid when possible)"
};

// Type safety principles
const typeSafetyPrinciples = {
  explicitTypes: "Use explicit types instead of 'any'",
  strictNullChecks: "Enable strict null checks",
  noImplicitAny: "Prevent implicit 'any' types",
  strictFunctionTypes: "Enable strict function types",
  noImplicitReturns: "Require explicit returns"
};
```

### **Type Safety Challenges**

```typescript
// Type safety challenges
const typeSafetyChallenges = {
  learningCurve: "Learning TypeScript type system",
  complexity: "Managing complex type definitions",
  performance: "Type checking performance impact",
  migration: "Migrating from JavaScript",
  thirdParty: "Third-party library type definitions",
  dynamic: "Handling dynamic content"
};

// Common type safety issues
const commonIssues = {
  any: "Overuse of 'any' type",
  null: "Null and undefined handling",
  unions: "Complex union types",
  generics: "Generic type constraints",
  inference: "Type inference limitations",
  casting: "Unsafe type casting"
};
```

---

## ⚙️ **Strict Type Configuration**

### **Strict Mode Configuration**

```typescript
// Strict mode configuration
const strictModeConfig = {
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "noPropertyAccessFromIndexSignature": true,
    "exactOptionalPropertyTypes": true
  }
};

// Strict mode benefits
const strictModeBenefits = {
  noImplicitAny: "Prevents implicit 'any' types",
  strictNullChecks: "Prevents null/undefined errors",
  strictFunctionTypes: "Ensures function type safety",
  strictPropertyInitialization: "Ensures property initialization",
  noImplicitReturns: "Prevents missing return statements",
  noFallthroughCasesInSwitch: "Prevents switch fallthrough",
  noUncheckedIndexedAccess: "Prevents unsafe array access"
};

// Strict mode examples
function strictModeExamples() {
  // ✅ Good: Explicit types
  function add(a: number, b: number): number {
    return a + b;
  }
  
  // ❌ Avoid: Implicit any
  function addBad(a, b) {
    return a + b;
  }
  
  // ✅ Good: Null checks
  function processUser(user: User | null): string {
    if (user === null) {
      return 'No user';
    }
    return user.name;
  }
  
  // ❌ Avoid: No null checks
  function processUserBad(user: User | null): string {
    return user.name; // Error: Object is possibly 'null'
  }
}
```

### **TypeScript Configuration**

```typescript
// TypeScript configuration for type safety
const tsConfig = {
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "lib": ["ES2020", "DOM"],
    "allowJs": false,
    "checkJs": false,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "removeComments": true,
    "noEmitOnError": true,
    "preserveConstEnums": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "noPropertyAccessFromIndexSignature": true,
    "exactOptionalPropertyTypes": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
};
```

### **ESLint Configuration**

```typescript
// ESLint configuration for type safety
const eslintConfig = {
  "extends": [
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json",
    "tsconfigRootDir": "."
  },
  "plugins": ["@typescript-eslint"],
  "rules": {
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/no-unsafe-call": "error",
    "@typescript-eslint/no-unsafe-member-access": "error",
    "@typescript-eslint/no-unsafe-return": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "@typescript-eslint/no-unnecessary-type-assertion": "error",
    "@typescript-eslint/no-non-null-assertion": "error",
    "@typescript-eslint/strict-boolean-expressions": "error"
  }
};
```

---

## 🔍 **Type Guards and Validation**

### **Type Guard Functions**

```typescript
// Type guard functions
const typeGuardFunctions = {
  purpose: "Narrow types at runtime",
  safety: "Provide runtime type safety",
  intellisense: "Enable better IDE support",
  validation: "Validate data from external sources"
};

// Basic type guards
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function isNumber(value: unknown): value is number {
  return typeof value === 'number' && !isNaN(value);
}

function isBoolean(value: unknown): value is boolean {
  return typeof value === 'boolean';
}

function isArray(value: unknown): value is any[] {
  return Array.isArray(value);
}

function isObject(value: unknown): value is object {
  return typeof value === 'object' && value !== null;
}

// Complex type guards
interface User {
  id: number;
  name: string;
  email: string;
}

function isUser(value: unknown): value is User {
  return (
    typeof value === 'object' &&
    value !== null &&
    'id' in value &&
    'name' in value &&
    'email' in value &&
    typeof (value as any).id === 'number' &&
    typeof (value as any).name === 'string' &&
    typeof (value as any).email === 'string'
  );
}

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

// Usage examples
function processValue(value: unknown) {
  if (isString(value)) {
    // value is string
    console.log(value.toUpperCase());
  } else if (isNumber(value)) {
    // value is number
    console.log(value * 2);
  } else if (isUser(value)) {
    // value is User
    console.log(`User: ${value.name}`);
  }
}
```

### **Runtime Validation**

```typescript
// Runtime validation
const runtimeValidation = {
  purpose: "Validate data at runtime",
  safety: "Ensure data integrity",
  errorHandling: "Handle validation errors gracefully",
  types: "Convert validated data to proper types"
};

// Validation result type
type ValidationResult<T> = {
  success: true;
  data: T;
} | {
  success: false;
  error: string;
};

// Validation functions
function validateString(value: unknown): ValidationResult<string> {
  if (typeof value === 'string') {
    return { success: true, data: value };
  }
  return { success: false, error: 'Expected string' };
}

function validateNumber(value: unknown): ValidationResult<number> {
  if (typeof value === 'number' && !isNaN(value)) {
    return { success: true, data: value };
  }
  return { success: false, error: 'Expected number' };
}

function validateUser(value: unknown): ValidationResult<User> {
  if (isUser(value)) {
    return { success: true, data: value };
  }
  return { success: false, error: 'Invalid user object' };
}

// Validation utilities
function validateRequired<T>(value: T | null | undefined): ValidationResult<T> {
  if (value === null || value === undefined) {
    return { success: false, error: 'Required field is missing' };
  }
  return { success: true, data: value };
}

function validateMinLength(value: string, minLength: number): ValidationResult<string> {
  if (value.length < minLength) {
    return { success: false, error: `Minimum length is ${minLength}` };
  }
  return { success: true, data: value };
}

function validateEmail(value: string): ValidationResult<string> {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(value)) {
    return { success: false, error: 'Invalid email format' };
  }
  return { success: true, data: value };
}

// Usage
function processUserData(data: unknown) {
  const userResult = validateUser(data);
  if (!userResult.success) {
    throw new Error(userResult.error);
  }
  
  const user = userResult.data;
  console.log(`Processing user: ${user.name}`);
}
```

### **Schema Validation**

```typescript
// Schema validation
const schemaValidation = {
  purpose: "Validate complex data structures",
  libraries: "Use libraries like Zod, Joi, or Yup",
  types: "Generate types from schemas",
  runtime: "Runtime validation with compile-time types"
};

// Simple schema validation
interface Schema {
  validate(value: unknown): ValidationResult<any>;
}

class StringSchema implements Schema {
  constructor(private minLength?: number, private maxLength?: number) {}
  
  validate(value: unknown): ValidationResult<string> {
    if (typeof value !== 'string') {
      return { success: false, error: 'Expected string' };
    }
    
    if (this.minLength && value.length < this.minLength) {
      return { success: false, error: `Minimum length is ${this.minLength}` };
    }
    
    if (this.maxLength && value.length > this.maxLength) {
      return { success: false, error: `Maximum length is ${this.maxLength}` };
    }
    
    return { success: true, data: value };
  }
}

class NumberSchema implements Schema {
  constructor(private min?: number, private max?: number) {}
  
  validate(value: unknown): ValidationResult<number> {
    if (typeof value !== 'number' || isNaN(value)) {
      return { success: false, error: 'Expected number' };
    }
    
    if (this.min !== undefined && value < this.min) {
      return { success: false, error: `Minimum value is ${this.min}` };
    }
    
    if (this.max !== undefined && value > this.max) {
      return { success: false, error: `Maximum value is ${this.max}` };
    }
    
    return { success: true, data: value };
  }
}

class ObjectSchema implements Schema {
  constructor(private properties: Record<string, Schema>) {}
  
  validate(value: unknown): ValidationResult<Record<string, any>> {
    if (typeof value !== 'object' || value === null) {
      return { success: false, error: 'Expected object' };
    }
    
    const result: Record<string, any> = {};
    const errors: string[] = [];
    
    for (const [key, schema] of Object.entries(this.properties)) {
      const propertyValue = (value as any)[key];
      const validation = schema.validate(propertyValue);
      
      if (validation.success) {
        result[key] = validation.data;
      } else {
        errors.push(`${key}: ${validation.error}`);
      }
    }
    
    if (errors.length > 0) {
      return { success: false, error: errors.join(', ') };
    }
    
    return { success: true, data: result };
  }
}

// Usage
const userSchema = new ObjectSchema({
  id: new NumberSchema(1),
  name: new StringSchema(1, 100),
  email: new StringSchema(1, 255)
});

function validateUserData(data: unknown) {
  const result = userSchema.validate(data);
  if (!result.success) {
    throw new Error(result.error);
  }
  return result.data;
}
```

---

## 🛡️ **Defensive Programming**

### **Null and Undefined Handling**

```typescript
// Null and undefined handling
const nullUndefinedHandling = {
  purpose: "Handle null and undefined safely",
  techniques: "Use optional chaining, nullish coalescing, and type guards",
  patterns: "Defensive programming patterns",
  safety: "Prevent runtime errors"
};

// Optional chaining
function optionalChainingExamples() {
  interface User {
    profile?: {
      settings?: {
        theme?: string;
      };
    };
  }
  
  const user: User = { profile: { settings: { theme: 'dark' } } };
  
  // ✅ Good: Optional chaining
  const theme = user.profile?.settings?.theme ?? 'light';
  
  // ❌ Avoid: Unsafe property access
  const themeBad = user.profile.settings.theme; // Error: Object is possibly 'undefined'
  
  // ✅ Good: Nullish coalescing
  const userName = user.profile?.settings?.theme ?? 'default';
  
  // ❌ Avoid: Logical OR for falsy values
  const userNameBad = user.profile?.settings?.theme || 'default'; // 'default' for empty string
}

// Null checks
function nullCheckExamples() {
  function processUser(user: User | null): string {
    // ✅ Good: Explicit null check
    if (user === null) {
      return 'No user';
    }
    return user.name;
  }
  
  function processUserBad(user: User | null): string {
    // ❌ Avoid: No null check
    return user.name; // Error: Object is possibly 'null'
  }
  
  // ✅ Good: Type guard
  function isNotNull<T>(value: T | null): value is T {
    return value !== null;
  }
  
  function processUsers(users: (User | null)[]): string[] {
    return users
      .filter(isNotNull)
      .map(user => user.name);
  }
}
```

### **Input Validation**

```typescript
// Input validation
const inputValidation = {
  purpose: "Validate all inputs",
  techniques: "Type guards, schema validation, sanitization",
  security: "Prevent security vulnerabilities",
  reliability: "Ensure data integrity"
};

// Input validation functions
function validateInput(input: unknown): ValidationResult<any> {
  if (typeof input !== 'object' || input === null) {
    return { success: false, error: 'Expected object' };
  }
  
  const obj = input as Record<string, unknown>;
  const errors: string[] = [];
  
  // Validate required fields
  if (!('id' in obj) || typeof obj.id !== 'number') {
    errors.push('id is required and must be a number');
  }
  
  if (!('name' in obj) || typeof obj.name !== 'string') {
    errors.push('name is required and must be a string');
  }
  
  if (!('email' in obj) || typeof obj.email !== 'string') {
    errors.push('email is required and must be a string');
  }
  
  if (errors.length > 0) {
    return { success: false, error: errors.join(', ') };
  }
  
  return { success: true, data: obj };
}

// Sanitization
function sanitizeInput(input: string): string {
  return input
    .trim()
    .replace(/[<>]/g, '') // Remove potential HTML tags
    .replace(/['"]/g, '') // Remove quotes
    .substring(0, 1000); // Limit length
}

// Input validation with sanitization
function validateAndSanitizeInput(input: unknown): ValidationResult<User> {
  const validation = validateInput(input);
  if (!validation.success) {
    return validation;
  }
  
  const data = validation.data;
  const sanitizedUser: User = {
    id: data.id,
    name: sanitizeInput(data.name),
    email: sanitizeInput(data.email)
  };
  
  return { success: true, data: sanitizedUser };
}
```

### **Error Boundaries**

```typescript
// Error boundaries
const errorBoundaries = {
  purpose: "Catch and handle errors gracefully",
  techniques: "Try-catch blocks, error boundaries, fallbacks",
  logging: "Log errors for debugging",
  recovery: "Provide error recovery mechanisms"
};

// Error boundary class
class ErrorBoundary {
  private error: Error | null = null;
  private errorInfo: any = null;
  
  catchError(error: Error, errorInfo: any): void {
    this.error = error;
    this.errorInfo = errorInfo;
    
    // Log error
    console.error('Error caught by boundary:', error, errorInfo);
    
    // Report to error tracking service
    this.reportError(error, errorInfo);
  }
  
  private reportError(error: Error, errorInfo: any): void {
    // Send to error tracking service
    // e.g., Sentry, LogRocket, etc.
  }
  
  hasError(): boolean {
    return this.error !== null;
  }
  
  getError(): Error | null {
    return this.error;
  }
  
  clearError(): void {
    this.error = null;
    this.errorInfo = null;
  }
}

// Safe function execution
function safeExecute<T>(fn: () => T, fallback: T): T {
  try {
    return fn();
  } catch (error) {
    console.error('Error in safe execution:', error);
    return fallback;
  }
}

// Safe async function execution
async function safeExecuteAsync<T>(fn: () => Promise<T>, fallback: T): Promise<T> {
  try {
    return await fn();
  } catch (error) {
    console.error('Error in safe async execution:', error);
    return fallback;
  }
}

// Usage
const result = safeExecute(() => {
  // Potentially dangerous operation
  return JSON.parse(userInput);
}, {});

const asyncResult = await safeExecuteAsync(async () => {
  // Potentially dangerous async operation
  return await fetch('/api/data');
}, null);
```

---

## ⚠️ **Error Handling**

### **Error Types**

```typescript
// Error types
const errorTypes = {
  validation: "Validation errors",
  network: "Network errors",
  authentication: "Authentication errors",
  authorization: "Authorization errors",
  notFound: "Not found errors",
  server: "Server errors",
  client: "Client errors"
};

// Custom error classes
class ValidationError extends Error {
  constructor(message: string, public field?: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

class NetworkError extends Error {
  constructor(message: string, public statusCode?: number) {
    super(message);
    this.name = 'NetworkError';
  }
}

class AuthenticationError extends Error {
  constructor(message: string = 'Authentication failed') {
    super(message);
    this.name = 'AuthenticationError';
  }
}

class AuthorizationError extends Error {
  constructor(message: string = 'Access denied') {
    super(message);
    this.name = 'AuthorizationError';
  }
}

class NotFoundError extends Error {
  constructor(resource: string) {
    super(`${resource} not found`);
    this.name = 'NotFoundError';
  }
}

// Error handling utilities
function isValidationError(error: unknown): error is ValidationError {
  return error instanceof ValidationError;
}

function isNetworkError(error: unknown): error is NetworkError {
  return error instanceof NetworkError;
}

function isAuthenticationError(error: unknown): error is AuthenticationError {
  return error instanceof AuthenticationError;
}

function isAuthorizationError(error: unknown): error is AuthorizationError {
  return error instanceof AuthorizationError;
}

function isNotFoundError(error: unknown): error is NotFoundError {
  return error instanceof NotFoundError;
}
```

### **Error Handling Patterns**

```typescript
// Error handling patterns
const errorHandlingPatterns = {
  tryCatch: "Try-catch blocks for synchronous code",
  asyncAwait: "Async-await with try-catch for asynchronous code",
  promises: "Promise chains with catch for asynchronous code",
  errorBoundaries: "Error boundaries for React components",
  globalHandlers: "Global error handlers for unhandled errors"
};

// Try-catch pattern
function tryCatchPattern() {
  try {
    // Potentially dangerous operation
    const result = JSON.parse(userInput);
    return result;
  } catch (error) {
    if (error instanceof SyntaxError) {
      throw new ValidationError('Invalid JSON format');
    }
    throw error;
  }
}

// Async-await pattern
async function asyncAwaitPattern() {
  try {
    const response = await fetch('/api/data');
    if (!response.ok) {
      throw new NetworkError('Failed to fetch data', response.status);
    }
    return await response.json();
  } catch (error) {
    if (error instanceof NetworkError) {
      // Handle network error
      console.error('Network error:', error.message);
    }
    throw error;
  }
}

// Promise chain pattern
function promiseChainPattern() {
  return fetch('/api/data')
    .then(response => {
      if (!response.ok) {
        throw new NetworkError('Failed to fetch data', response.status);
      }
      return response.json();
    })
    .catch(error => {
      if (error instanceof NetworkError) {
        console.error('Network error:', error.message);
      }
      throw error;
    });
}

// Error handling middleware
function errorHandlingMiddleware(error: Error, req: Request, res: Response, next: NextFunction) {
  if (isValidationError(error)) {
    res.status(400).json({ error: error.message, field: error.field });
  } else if (isAuthenticationError(error)) {
    res.status(401).json({ error: error.message });
  } else if (isAuthorizationError(error)) {
    res.status(403).json({ error: error.message });
  } else if (isNotFoundError(error)) {
    res.status(404).json({ error: error.message });
  } else if (isNetworkError(error)) {
    res.status(error.statusCode || 500).json({ error: error.message });
  } else {
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

### **Error Recovery**

```typescript
// Error recovery
const errorRecovery = {
  purpose: "Recover from errors gracefully",
  techniques: "Retry mechanisms, fallbacks, circuit breakers",
  patterns: "Error recovery patterns",
  monitoring: "Monitor error rates and recovery success"
};

// Retry mechanism
async function retryOperation<T>(
  operation: () => Promise<T>,
  maxRetries: number = 3,
  delay: number = 1000
): Promise<T> {
  let lastError: Error;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error as Error;
      
      if (attempt === maxRetries) {
        throw lastError;
      }
      
      // Wait before retrying
      await new Promise(resolve => setTimeout(resolve, delay * attempt));
    }
  }
  
  throw lastError!;
}

// Circuit breaker pattern
class CircuitBreaker {
  private failureCount = 0;
  private lastFailureTime = 0;
  private state: 'CLOSED' | 'OPEN' | 'HALF_OPEN' = 'CLOSED';
  
  constructor(
    private failureThreshold: number = 5,
    private timeout: number = 60000
  ) {}
  
  async execute<T>(operation: () => Promise<T>): Promise<T> {
    if (this.state === 'OPEN') {
      if (Date.now() - this.lastFailureTime > this.timeout) {
        this.state = 'HALF_OPEN';
      } else {
        throw new Error('Circuit breaker is OPEN');
      }
    }
    
    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }
  
  private onSuccess(): void {
    this.failureCount = 0;
    this.state = 'CLOSED';
  }
  
  private onFailure(): void {
    this.failureCount++;
    this.lastFailureTime = Date.now();
    
    if (this.failureCount >= this.failureThreshold) {
      this.state = 'OPEN';
    }
  }
}

// Fallback mechanism
async function withFallback<T>(
  primaryOperation: () => Promise<T>,
  fallbackOperation: () => Promise<T>
): Promise<T> {
  try {
    return await primaryOperation();
  } catch (error) {
    console.warn('Primary operation failed, using fallback:', error);
    return await fallbackOperation();
  }
}

// Usage
const circuitBreaker = new CircuitBreaker();

const result = await circuitBreaker.execute(async () => {
  return await fetch('/api/data');
});

const resultWithFallback = await withFallback(
  async () => await fetch('/api/data'),
  async () => await fetch('/api/backup-data')
);
```

---

## ✅ **Best Practices**

### **1. Use Strict Type Configuration**

```typescript
// ✅ Good: Strict type configuration
const strictConfig = {
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true
  }
};

// ❌ Avoid: Loose type configuration
const looseConfig = {
  "compilerOptions": {
    "strict": false,
    "noImplicitAny": false,
    "strictNullChecks": false
  }
};
```

### **2. Use Type Guards**

```typescript
// ✅ Good: Type guards
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function processValue(value: unknown) {
  if (isString(value)) {
    // value is string
    console.log(value.toUpperCase());
  }
}

// ❌ Avoid: Type assertions
function processValueBad(value: unknown) {
  const str = value as string; // Unsafe
  console.log(str.toUpperCase());
}
```

### **3. Handle Null and Undefined**

```typescript
// ✅ Good: Null and undefined handling
function processUser(user: User | null): string {
  if (user === null) {
    return 'No user';
  }
  return user.name;
}

// ❌ Avoid: No null checks
function processUserBad(user: User | null): string {
  return user.name; // Error: Object is possibly 'null'
}
```

### **4. Use Defensive Programming**

```typescript
// ✅ Good: Defensive programming
function safeParseJSON(json: string): any {
  try {
    return JSON.parse(json);
  } catch (error) {
    console.error('Invalid JSON:', error);
    return null;
  }
}

// ❌ Avoid: No error handling
function unsafeParseJSON(json: string): any {
  return JSON.parse(json); // Can throw
}
```

---

## ❓ **Common Interview Questions**

### **1. How do you ensure type safety in TypeScript?**

**Answer:**
- **Strict Mode**: Enable strict mode in TypeScript configuration
- **Type Guards**: Use type guards for runtime type checking
- **Validation**: Validate inputs and external data
- **Error Handling**: Handle errors gracefully
- **Defensive Programming**: Use defensive programming techniques

### **2. What are the benefits of strict type checking?**

**Answer:**
- **Compile-time Errors**: Catch errors at compile time
- **Better IntelliSense**: Improved IDE support
- **Safer Refactoring**: Refactor with confidence
- **Documentation**: Types serve as documentation
- **Runtime Safety**: Reduced runtime errors

### **3. How do you handle null and undefined in TypeScript?**

**Answer:**
- **Strict Null Checks**: Enable strict null checks
- **Optional Chaining**: Use optional chaining operator
- **Nullish Coalescing**: Use nullish coalescing operator
- **Type Guards**: Use type guards to check for null/undefined
- **Defensive Programming**: Always check for null/undefined

### **4. What are type guards and how do you use them?**

**Answer:**
Type guards are functions that narrow types at runtime:
- **Purpose**: Provide runtime type safety
- **Syntax**: Return type predicate `value is Type`
- **Usage**: Check types before using them
- **Benefits**: Better IntelliSense and type safety

### **5. How do you handle errors in TypeScript?**

**Answer:**
- **Custom Error Classes**: Create specific error types
- **Try-Catch Blocks**: Use try-catch for error handling
- **Error Boundaries**: Implement error boundaries
- **Error Recovery**: Implement retry and fallback mechanisms
- **Logging**: Log errors for debugging

---

## 🧭 Navigation

<div class="navigation">
  <a href="01-Code-Organization-Architecture.md" class="nav-button">← Previous: Code Organization & Architecture</a>
  <a href="03-Error-Handling-Strategies.md" class="nav-button">Next: Error Handling Strategies →</a>
</div>

*Last updated: December 2025*
