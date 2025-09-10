# 🏷️ **Branded Types & Opaque Types**

> **Complete guide to TypeScript branded types, opaque types, and advanced type safety techniques**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Branded Types Overview](#branded-types-overview)
- [Basic Branded Types](#basic-branded-types)
- [Opaque Types](#opaque-types)
- [Advanced Patterns](#advanced-patterns)
- [Real-World Examples](#real-world-examples)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Branded Types Overview**

Branded types are a TypeScript technique for creating distinct types from primitive types, preventing accidental mixing of different kinds of values.

### **What are Branded Types?**


{% raw %}
```typescript
// Branded types create distinct types from primitives
const brandedTypes = {
  purpose: "Prevent accidental mixing of different value types",
  safety: "Compile-time type safety",
  clarity: "Make code more self-documenting",
  prevention: "Prevent bugs from type confusion"
};

// Basic branded type
type Brand<T, B> = T & { __brand: B };
type UserId = Brand<number, 'UserId'>;
type ProductId = Brand<number, 'ProductId'>;

// These are different types even though they're both numbers
function processUser(userId: UserId) {
  console.log('Processing user:', userId);
}

function processProduct(productId: ProductId) {
  console.log('Processing product:', productId);
}

// TypeScript prevents mixing them
const userId: UserId = 123 as UserId;
const productId: ProductId = 456 as ProductId;

// processUser(productId); // ❌ Error: Argument of type 'ProductId' is not assignable to parameter of type 'UserId'
```
{% endraw %}


### **Benefits of Branded Types**


{% raw %}
```typescript
// Benefits of branded types
const benefits = {
  typeSafety: "Prevent accidental type mixing",
  clarity: "Make code more self-documenting",
  refactoring: "Safer refactoring",
  debugging: "Easier debugging",
  maintenance: "Better code maintenance"
};

// Without branded types
function processUser(id: number) {
  console.log('Processing user:', id);
}

function processProduct(id: number) {
  console.log('Processing product:', id);
}

// Easy to mix up
const userId = 123;
const productId = 456;
processUser(productId); // ❌ Bug: Wrong ID type

// With branded types
type UserId = Brand<number, 'UserId'>;
type ProductId = Brand<number, 'ProductId'>;

function processUser(id: UserId) {
  console.log('Processing user:', id);
}

function processProduct(id: ProductId) {
  console.log('Processing product:', id);
}

// TypeScript prevents mixing
const userId: UserId = 123 as UserId;
const productId: ProductId = 456 as ProductId;
// processUser(productId); // ❌ Compile error: Type 'ProductId' is not assignable to parameter of type 'UserId'
```
{% endraw %}


---

## 🔧 **Basic Branded Types**

### **Simple Branded Types**


{% raw %}
```typescript
// Simple branded types
type Brand<T, B> = T & { __brand: B };

// Common branded types
type UserId = Brand<number, 'UserId'>;
type ProductId = Brand<number, 'ProductId'>;
type OrderId = Brand<number, 'OrderId'>;
type Email = Brand<string, 'Email'>;
type PhoneNumber = Brand<string, 'PhoneNumber'>;
type URL = Brand<string, 'URL'>;

// Factory functions
function createUserId(id: number): UserId {
  return id as UserId;
}

function createProductId(id: number): ProductId {
  return id as ProductId;
}

function createEmail(email: string): Email {
  return email as Email;
}

function createPhoneNumber(phone: string): PhoneNumber {
  return phone as PhoneNumber;
}

// Usage
const userId = createUserId(123);
const productId = createProductId(456);
const email = createEmail('user@example.com');
const phone = createPhoneNumber('+1234567890');
```
{% endraw %}


### **Branded Types with Validation**


{% raw %}
```typescript
// Branded types with validation
type ValidatedEmail = Brand<string, 'ValidatedEmail'>;
type ValidatedPhone = Brand<string, 'ValidatedPhone'>;

// Validation functions
function isValidEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function isValidPhone(phone: string): boolean {
  return /^\+?[\d\s-()]+$/.test(phone);
}

// Factory functions with validation
function createValidatedEmail(email: string): ValidatedEmail {
  if (!isValidEmail(email)) {
    throw new Error('Invalid email format');
  }
  return email as ValidatedEmail;
}

function createValidatedPhone(phone: string): ValidatedPhone {
  if (!isValidPhone(phone)) {
    throw new Error('Invalid phone format');
  }
  return phone as ValidatedPhone;
}

// Usage
try {
  const email = createValidatedEmail('user@example.com');
  const phone = createValidatedPhone('+1234567890');
  console.log('Valid email:', email);
  console.log('Valid phone:', phone);
} catch (error) {
  console.error('Validation error:', error.message);
}
```
{% endraw %}


### **Branded Types with Constraints**


{% raw %}
```typescript
// Branded types with constraints
type PositiveNumber = Brand<number, 'PositiveNumber'>;
type NonEmptyString = Brand<string, 'NonEmptyString'>;
type UppercaseString = Brand<string, 'UppercaseString'>;

// Constraint functions
function isPositive(value: number): boolean {
  return value > 0;
}

function isNonEmpty(value: string): boolean {
  return value.trim().length > 0;
}

function isUppercase(value: string): boolean {
  return value === value.toUpperCase();
}

// Factory functions with constraints
function createPositiveNumber(value: number): PositiveNumber {
  if (!isPositive(value)) {
    throw new Error('Number must be positive');
  }
  return value as PositiveNumber;
}

function createNonEmptyString(value: string): NonEmptyString {
  if (!isNonEmpty(value)) {
    throw new Error('String must not be empty');
  }
  return value as NonEmptyString;
}

function createUppercaseString(value: string): UppercaseString {
  if (!isUppercase(value)) {
    throw new Error('String must be uppercase');
  }
  return value as UppercaseString;
}
```
{% endraw %}


---

## 🔒 **Opaque Types**

### **Basic Opaque Types**


{% raw %}
```typescript
// Opaque types using unique symbol
declare const __opaque: unique symbol;
type Opaque<T, K> = T & { readonly [__opaque]: K };

// Opaque type definitions
type UserId = Opaque<number, 'UserId'>;
type ProductId = Opaque<number, 'ProductId'>;
type Email = Opaque<string, 'Email'>;
type PhoneNumber = Opaque<string, 'PhoneNumber'>;

// Factory functions
function createUserId(id: number): UserId {
  return id as UserId;
}

function createProductId(id: number): ProductId {
  return id as ProductId;
}

function createEmail(email: string): Email {
  return email as Email;
}

function createPhoneNumber(phone: string): PhoneNumber {
  return phone as PhoneNumber;
}

// Usage
const userId = createUserId(123);
const productId = createProductId(456);
const email = createEmail('user@example.com');
const phone = createPhoneNumber('+1234567890');
```
{% endraw %}


### **Opaque Types with Validation**


{% raw %}
```typescript
// Opaque types with validation
type ValidatedEmail = Opaque<string, 'ValidatedEmail'>;
type ValidatedPhone = Opaque<string, 'ValidatedPhone'>;
type ValidatedURL = Opaque<string, 'ValidatedURL'>;

// Validation functions
function isValidEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function isValidPhone(phone: string): boolean {
  return /^\+?[\d\s-()]+$/.test(phone);
}

function isValidURL(url: string): boolean {
  try {
    new URL(url);
    return true;
  } catch {
    return false;
  }
}

// Factory functions with validation
function createValidatedEmail(email: string): ValidatedEmail {
  if (!isValidEmail(email)) {
    throw new Error('Invalid email format');
  }
  return email as ValidatedEmail;
}

function createValidatedPhone(phone: string): ValidatedPhone {
  if (!isValidPhone(phone)) {
    throw new Error('Invalid phone format');
  }
  return phone as ValidatedPhone;
}

function createValidatedURL(url: string): ValidatedURL {
  if (!isValidURL(url)) {
    throw new Error('Invalid URL format');
  }
  return url as ValidatedURL;
}
```
{% endraw %}


### **Opaque Types with Constraints**


{% raw %}
```typescript
// Opaque types with constraints
type PositiveNumber = Opaque<number, 'PositiveNumber'>;
type NonEmptyString = Opaque<string, 'NonEmptyString'>;
type UppercaseString = Opaque<string, 'UppercaseString'>;
type LowercaseString = Opaque<string, 'LowercaseString'>;

// Constraint functions
function isPositive(value: number): boolean {
  return value > 0;
}

function isNonEmpty(value: string): boolean {
  return value.trim().length > 0;
}

function isUppercase(value: string): boolean {
  return value === value.toUpperCase();
}

function isLowercase(value: string): boolean {
  return value === value.toLowerCase();
}

// Factory functions with constraints
function createPositiveNumber(value: number): PositiveNumber {
  if (!isPositive(value)) {
    throw new Error('Number must be positive');
  }
  return value as PositiveNumber;
}

function createNonEmptyString(value: string): NonEmptyString {
  if (!isNonEmpty(value)) {
    throw new Error('String must not be empty');
  }
  return value as NonEmptyString;
}

function createUppercaseString(value: string): UppercaseString {
  if (!isUppercase(value)) {
    throw new Error('String must be uppercase');
  }
  return value as UppercaseString;
}

function createLowercaseString(value: string): LowercaseString {
  if (!isLowercase(value)) {
    throw new Error('String must be lowercase');
  }
  return value as LowercaseString;
}
```
{% endraw %}


---

## 🚀 **Advanced Patterns**

### **Branded Types with Methods**


{% raw %}
```typescript
// Branded types with methods
type BrandedNumber<T> = T & { __brand: T };

type UserId = BrandedNumber<number>;
type ProductId = BrandedNumber<number>;

// Factory functions
function createUserId(id: number): UserId {
  return id as UserId;
}

function createProductId(id: number): ProductId {
  return id as ProductId;
}

// Utility functions
function isUserId(value: unknown): value is UserId {
  return typeof value === 'number' && value > 0;
}

function isProductId(value: unknown): value is ProductId {
  return typeof value === 'number' && value > 0;
}

// Comparison functions
function compareUserIds(a: UserId, b: UserId): number {
  return a - b;
}

function compareProductIds(a: ProductId, b: ProductId): number {
  return a - b;
}

// Usage
const userId1 = createUserId(123);
const userId2 = createUserId(456);
const productId = createProductId(789);

console.log('User ID comparison:', compareUserIds(userId1, userId2));
// console.log('Mixed comparison:', compareUserIds(userId1, productId)); // ❌ Error
```
{% endraw %}


### **Branded Types with Generics**


{% raw %}
```typescript
// Branded types with generics
type Branded<T, B> = T & { __brand: B };

// Generic branded types
type ID<T> = Branded<number, T>;
type StringValue<T> = Branded<string, T>;

// Specific branded types
type UserId = ID<'UserId'>;
type ProductId = ID<'ProductId'>;
type Email = StringValue<'Email'>;
type PhoneNumber = StringValue<'PhoneNumber'>;

// Generic factory functions
function createID<T>(value: number): ID<T> {
  return value as ID<T>;
}

function createStringValue<T>(value: string): StringValue<T> {
  return value as StringValue<T>;
}

// Specific factory functions
function createUserId(id: number): UserId {
  return createID<'UserId'>(id);
}

function createProductId(id: number): ProductId {
  return createID<'ProductId'>(id);
}

function createEmail(email: string): Email {
  return createStringValue<'Email'>(email);
}

function createPhoneNumber(phone: string): PhoneNumber {
  return createStringValue<'PhoneNumber'>(phone);
}
```
{% endraw %}


### **Branded Types with Validation**


{% raw %}
```typescript
// Branded types with validation
type ValidatedBrand<T, B> = T & { __brand: B; __validated: true };

// Validated branded types
type ValidatedEmail = ValidatedBrand<string, 'Email'>;
type ValidatedPhone = ValidatedBrand<string, 'Phone'>;
type ValidatedURL = ValidatedBrand<string, 'URL'>;

// Validation functions
function isValidEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function isValidPhone(phone: string): boolean {
  return /^\+?[\d\s-()]+$/.test(phone);
}

function isValidURL(url: string): boolean {
  try {
    new URL(url);
    return true;
  } catch {
    return false;
  }
}

// Factory functions with validation
function createValidatedEmail(email: string): ValidatedEmail {
  if (!isValidEmail(email)) {
    throw new Error('Invalid email format');
  }
  return email as ValidatedEmail;
}

function createValidatedPhone(phone: string): ValidatedPhone {
  if (!isValidPhone(phone)) {
    throw new Error('Invalid phone format');
  }
  return phone as ValidatedPhone;
}

function createValidatedURL(url: string): ValidatedURL {
  if (!isValidURL(url)) {
    throw new Error('Invalid URL format');
  }
  return url as ValidatedURL;
}
```
{% endraw %}


---

## 🌍 **Real-World Examples**

### **Database IDs**


{% raw %}
```typescript
// Database IDs with branded types
type DatabaseId<T> = Brand<number, T>;

type UserId = DatabaseId<'User'>;
type ProductId = DatabaseId<'Product'>;
type OrderId = DatabaseId<'Order'>;
type CategoryId = DatabaseId<'Category'>;

// Factory functions
function createUserId(id: number): UserId {
  if (id <= 0) {
    throw new Error('User ID must be positive');
  }
  return id as UserId;
}

function createProductId(id: number): ProductId {
  if (id <= 0) {
    throw new Error('Product ID must be positive');
  }
  return id as ProductId;
}

// Database operations
interface User {
  id: UserId;
  name: string;
  email: string;
}

interface Product {
  id: ProductId;
  name: string;
  price: number;
}

// Type-safe database operations
function getUser(id: UserId): Promise<User> {
  return fetch(`/api/users/${id}`).then(res => res.json());
}

function getProduct(id: ProductId): Promise<Product> {
  return fetch(`/api/products/${id}`).then(res => res.json());
}

// Usage
const userId = createUserId(123);
const productId = createProductId(456);

getUser(userId); // ✅ Correct
getProduct(productId); // ✅ Correct
// getUser(productId); // ❌ Error: Type 'ProductId' is not assignable to parameter of type 'UserId'
```
{% endraw %}


### **API Endpoints**


{% raw %}
```typescript
// API endpoints with branded types
type APIEndpoint<T> = Brand<string, T>;

type UserEndpoint = APIEndpoint<'User'>;
type ProductEndpoint = APIEndpoint<'Product'>;
type OrderEndpoint = APIEndpoint<'Order'>;

// Factory functions
function createUserEndpoint(path: string): UserEndpoint {
  if (!path.startsWith('/users/')) {
    throw new Error('User endpoint must start with /users/');
  }
  return path as UserEndpoint;
}

function createProductEndpoint(path: string): ProductEndpoint {
  if (!path.startsWith('/products/')) {
    throw new Error('Product endpoint must start with /products/');
  }
  return path as ProductEndpoint;
}

// API operations
function callUserAPI(endpoint: UserEndpoint): Promise<any> {
  return fetch(endpoint).then(res => res.json());
}

function callProductAPI(endpoint: ProductEndpoint): Promise<any> {
  return fetch(endpoint).then(res => res.json());
}

// Usage
const userEndpoint = createUserEndpoint('/users/123');
const productEndpoint = createProductEndpoint('/products/456');

callUserAPI(userEndpoint); // ✅ Correct
callProductAPI(productEndpoint); // ✅ Correct
// callUserAPI(productEndpoint); // ❌ Error: Type 'ProductEndpoint' is not assignable to parameter of type 'UserEndpoint'
```
{% endraw %}


### **Configuration Values**


{% raw %}
```typescript
// Configuration values with branded types
type ConfigValue<T> = Brand<string, T>;

type DatabaseURL = ConfigValue<'DatabaseURL'>;
type APIKey = ConfigValue<'APIKey'>;
type SecretKey = ConfigValue<'SecretKey'>;

// Factory functions
function createDatabaseURL(url: string): DatabaseURL {
  if (!url.startsWith('postgres://') && !url.startsWith('mysql://')) {
    throw new Error('Invalid database URL format');
  }
  return url as DatabaseURL;
}

function createAPIKey(key: string): APIKey {
  if (key.length < 32) {
    throw new Error('API key must be at least 32 characters');
  }
  return key as APIKey;
}

function createSecretKey(key: string): SecretKey {
  if (key.length < 64) {
    throw new Error('Secret key must be at least 64 characters');
  }
  return key as SecretKey;
}

// Configuration usage
interface AppConfig {
  databaseURL: DatabaseURL;
  apiKey: APIKey;
  secretKey: SecretKey;
}

function createAppConfig(config: {
  databaseURL: string;
  apiKey: string;
  secretKey: string;
}): AppConfig {
  return {
    databaseURL: createDatabaseURL(config.databaseURL),
    apiKey: createAPIKey(config.apiKey),
    secretKey: createSecretKey(config.secretKey)
  };
}
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Use Descriptive Brand Names**


{% raw %}
```typescript
// ✅ Good: Descriptive brand names
type UserId = Brand<number, 'UserId'>;
type ProductId = Brand<number, 'ProductId'>;
type Email = Brand<string, 'Email'>;

// ❌ Avoid: Unclear brand names
type ID1 = Brand<number, 'ID1'>;
type ID2 = Brand<number, 'ID2'>;
type Str = Brand<string, 'Str'>;
```
{% endraw %}


### **2. Provide Factory Functions**


{% raw %}
```typescript
// ✅ Good: Factory functions
function createUserId(id: number): UserId {
  if (id <= 0) {
    throw new Error('User ID must be positive');
  }
  return id as UserId;
}

// ❌ Avoid: Direct casting
const userId = 123 as UserId;
```
{% endraw %}


### **3. Add Validation**


{% raw %}
```typescript
// ✅ Good: Validation in factory functions
function createEmail(email: string): Email {
  if (!isValidEmail(email)) {
    throw new Error('Invalid email format');
  }
  return email as Email;
}

// ❌ Avoid: No validation
function createEmail(email: string): Email {
  return email as Email;
}
```
{% endraw %}


### **4. Use Opaque Types for Better Encapsulation**


{% raw %}
```typescript
// ✅ Good: Opaque types
declare const __opaque: unique symbol;
type Opaque<T, K> = T & { readonly [__opaque]: K };

type UserId = Opaque<number, 'UserId'>;

// ❌ Avoid: Branded types when you need better encapsulation
type UserId = Brand<number, 'UserId'>;
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. What are branded types in TypeScript?**

**Answer:**
Branded types are a TypeScript technique for creating distinct types from primitive types by adding a brand property. They prevent accidental mixing of different kinds of values and provide compile-time type safety.

### **2. What's the difference between branded types and opaque types?**

**Answer:**
- **Branded Types**: Use a `__brand` property that can be accessed
- **Opaque Types**: Use a unique symbol that cannot be accessed, providing better encapsulation
- Opaque types are generally preferred for better type safety

### **3. When should you use branded types?**

**Answer:**
- **Prevent type confusion**: When you have multiple types that use the same primitive
- **API safety**: When you want to prevent mixing different ID types
- **Configuration**: When you want to ensure correct configuration values
- **Domain modeling**: When you want to model domain concepts more precisely

### **4. How do you create branded types?**

**Answer:**

{% raw %}
```typescript
type Brand<T, B> = T & { __brand: B };
type UserId = Brand<number, 'UserId'>;

function createUserId(id: number): UserId {
  return id as UserId;
}
```
{% endraw %}


### **5. What are the benefits of branded types?**

**Answer:**
- **Type Safety**: Prevent accidental type mixing
- **Clarity**: Make code more self-documenting
- **Refactoring**: Safer refactoring with compile-time checks
- **Debugging**: Easier debugging with distinct types
- **Maintenance**: Better code maintenance and understanding

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Discriminated-Unions.md" class="nav-button">← Previous: Discriminated Unions</a>
  <a href="04-Recursive-Types-Advanced-Patterns.md" class="nav-button">Next: Recursive Types & Advanced Patterns →</a>
</div>

*Last updated: December 2025*
