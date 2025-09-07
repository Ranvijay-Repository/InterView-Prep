# 🎭 **Decorators & Metadata**

> **Complete guide to TypeScript decorators, metadata reflection, and advanced decorator patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction to Decorators](#introduction-to-decorators)
- [Class Decorators](#class-decorators)
- [Method Decorators](#method-decorators)
- [Property Decorators](#property-decorators)
- [Parameter Decorators](#parameter-decorators)
- [Metadata Reflection](#metadata-reflection)
- [Advanced Decorator Patterns](#advanced-decorator-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Introduction to Decorators**

Decorators are a special kind of declaration that can be attached to classes, methods, properties, or parameters to modify their behavior.

### **Enabling Decorators**

```json
// tsconfig.json
{
  "compilerOptions": {
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "target": "ES5"
  }
}
```

### **Basic Decorator Syntax**

```typescript
// Simple decorator function
function simpleDecorator(target: any) {
  console.log("Decorator applied to:", target);
}

// Class decorator
@simpleDecorator
class MyClass {
  // Class implementation
}

// Method decorator
function methodDecorator(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  console.log("Method decorator applied to:", propertyKey);
}

class MyClass {
  @methodDecorator
  myMethod() {
    console.log("Hello from myMethod");
  }
}
```

---

## 🏗️ **Class Decorators**

Class decorators are applied to class constructors and can modify or replace the class definition.

### **Basic Class Decorator**

```typescript
// Class decorator that adds a property
function addTimestamp(target: any) {
  return class extends target {
    createdAt = new Date();
  };
}

@addTimestamp
class User {
  name: string;
  
  constructor(name: string) {
    this.name = name;
  }
}

// Usage
const user = new User("John");
console.log(user.createdAt); // Current timestamp
```

### **Class Decorator with Parameters**

```typescript
// Class decorator factory
function addProperty(propertyName: string, defaultValue: any) {
  return function(target: any) {
    return class extends target {
      [propertyName] = defaultValue;
    };
  };
}

@addProperty("version", "1.0.0")
@addProperty("author", "John Doe")
class MyClass {
  name: string;
  
  constructor(name: string) {
    this.name = name;
  }
}

// Usage
const instance = new MyClass("Test");
console.log(instance.version); // "1.0.0"
console.log(instance.author);  // "John Doe"
```

### **Class Decorator for Validation**

```typescript
// Validation decorator
function validateClass(target: any) {
  const originalConstructor = target;
  
  function newConstructor(...args: any[]) {
    const instance = new originalConstructor(...args);
    
    // Validate required properties
    const requiredProps = Reflect.getMetadata("required", target) || [];
    for (const prop of requiredProps) {
      if (instance[prop] === undefined || instance[prop] === null) {
        throw new Error(`Property ${prop} is required`);
      }
    }
    
    return instance;
  }
  
  newConstructor.prototype = originalConstructor.prototype;
  return newConstructor;
}

@validateClass
class User {
  @required
  name: string;
  
  @required
  email: string;
  
  age?: number;
  
  constructor(name: string, email: string, age?: number) {
    this.name = name;
    this.email = email;
    this.age = age;
  }
}
```

---

## 🔧 **Method Decorators**

Method decorators are applied to method definitions and can modify method behavior.

### **Basic Method Decorator**

```typescript
// Method decorator that logs method calls
function logMethod(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  
  descriptor.value = function(...args: any[]) {
    console.log(`Calling method ${propertyKey} with arguments:`, args);
    const result = originalMethod.apply(this, args);
    console.log(`Method ${propertyKey} returned:`, result);
    return result;
  };
  
  return descriptor;
}

class Calculator {
  @logMethod
  add(a: number, b: number): number {
    return a + b;
  }
  
  @logMethod
  multiply(a: number, b: number): number {
    return a * b;
  }
}

// Usage
const calc = new Calculator();
calc.add(2, 3); // Logs method call and result
```

### **Method Decorator with Parameters**

```typescript
// Method decorator factory
function retry(maxAttempts: number) {
  return function(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    
    descriptor.value = async function(...args: any[]) {
      let lastError: Error;
      
      for (let attempt = 1; attempt <= maxAttempts; attempt++) {
        try {
          return await originalMethod.apply(this, args);
        } catch (error) {
          lastError = error as Error;
          if (attempt === maxAttempts) {
            throw lastError;
          }
          console.log(`Attempt ${attempt} failed, retrying...`);
        }
      }
    };
    
    return descriptor;
  };
}

class ApiService {
  @retry(3)
  async fetchData(url: string): Promise<any> {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.json();
  }
}
```

### **Method Decorator for Caching**

```typescript
// Caching decorator
function cache(ttl: number = 60000) {
  return function(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    const cache = new Map<string, { value: any; expiry: number }>();
    
    descriptor.value = function(...args: any[]) {
      const key = JSON.stringify(args);
      const cached = cache.get(key);
      
      if (cached && Date.now() < cached.expiry) {
        console.log(`Cache hit for ${propertyKey}`);
        return cached.value;
      }
      
      const result = originalMethod.apply(this, args);
      cache.set(key, {
        value: result,
        expiry: Date.now() + ttl
      });
      
      return result;
    };
    
    return descriptor;
  };
}

class DataService {
  @cache(30000) // Cache for 30 seconds
  async fetchUser(id: number): Promise<User> {
    console.log(`Fetching user ${id} from API`);
    // Simulate API call
    return new Promise(resolve => {
      setTimeout(() => {
        resolve({ id, name: `User ${id}`, email: `user${id}@example.com` });
      }, 1000);
    });
  }
}
```

---

## 📊 **Property Decorators**

Property decorators are applied to property declarations and can modify property behavior.

### **Basic Property Decorator**

```typescript
// Property decorator that adds validation
function required(target: any, propertyKey: string) {
  const requiredProperties = Reflect.getMetadata("required", target.constructor) || [];
  requiredProperties.push(propertyKey);
  Reflect.defineMetadata("required", requiredProperties, target.constructor);
}

// Property decorator that adds default value
function defaultValue(value: any) {
  return function(target: any, propertyKey: string) {
    if (!target[propertyKey]) {
      target[propertyKey] = value;
    }
  };
}

class User {
  @required
  name: string;
  
  @required
  email: string;
  
  @defaultValue(0)
  age: number;
  
  @defaultValue("active")
  status: string;
}
```

### **Property Decorator with Getter/Setter**

```typescript
// Property decorator that adds getter/setter
function property(target: any, propertyKey: string) {
  let value: any;
  
  const getter = function() {
    console.log(`Getting ${propertyKey}: ${value}`);
    return value;
  };
  
  const setter = function(newValue: any) {
    console.log(`Setting ${propertyKey}: ${newValue}`);
    value = newValue;
  };
  
  Object.defineProperty(target, propertyKey, {
    get: getter,
    set: setter,
    enumerable: true,
    configurable: true
  });
}

class Person {
  @property
  name: string;
  
  @property
  age: number;
}

// Usage
const person = new Person();
person.name = "John"; // Logs: Setting name: John
console.log(person.name); // Logs: Getting name: John
```

---

## 📝 **Parameter Decorators**

Parameter decorators are applied to parameter declarations and can modify parameter behavior.

### **Basic Parameter Decorator**

```typescript
// Parameter decorator that logs parameter values
function logParameter(target: any, propertyKey: string, parameterIndex: number) {
  const existingParameters = Reflect.getMetadata("logParameters", target, propertyKey) || [];
  existingParameters.push(parameterIndex);
  Reflect.defineMetadata("logParameters", existingParameters, target, propertyKey);
}

// Parameter decorator that validates parameter types
function validateType(type: any) {
  return function(target: any, propertyKey: string, parameterIndex: number) {
    const existingTypes = Reflect.getMetadata("parameterTypes", target, propertyKey) || [];
    existingTypes[parameterIndex] = type;
    Reflect.defineMetadata("parameterTypes", existingTypes, target, propertyKey);
  };
}

class Service {
  processData(
    @logParameter
    @validateType(String)
    name: string,
    
    @logParameter
    @validateType(Number)
    age: number
  ): string {
    return `Processing ${name}, age ${age}`;
  }
}
```

---

## 🔍 **Metadata Reflection**

TypeScript's metadata reflection API allows you to access and modify metadata at runtime.

### **Basic Metadata Operations**

```typescript
import "reflect-metadata";

// Define metadata
Reflect.defineMetadata("key", "value", target);
Reflect.defineMetadata("key", "value", target, propertyKey);

// Get metadata
const value = Reflect.getMetadata("key", target);
const value = Reflect.getMetadata("key", target, propertyKey);

// Check if metadata exists
const exists = Reflect.hasMetadata("key", target);
const exists = Reflect.hasMetadata("key", target, propertyKey);

// Get all metadata keys
const keys = Reflect.getMetadataKeys(target);
const keys = Reflect.getMetadataKeys(target, propertyKey);
```

### **Metadata with Decorators**

```typescript
// Custom metadata decorator
function metadata(key: string, value: any) {
  return function(target: any, propertyKey?: string) {
    if (propertyKey) {
      Reflect.defineMetadata(key, value, target, propertyKey);
    } else {
      Reflect.defineMetadata(key, value, target);
    }
  };
}

// Usage
@metadata("version", "1.0.0")
@metadata("author", "John Doe")
class MyClass {
  @metadata("required", true)
  name: string;
  
  @metadata("default", "unknown")
  status: string;
}

// Access metadata
const version = Reflect.getMetadata("version", MyClass);
const author = Reflect.getMetadata("author", MyClass);
const nameRequired = Reflect.getMetadata("required", MyClass.prototype, "name");
const statusDefault = Reflect.getMetadata("default", MyClass.prototype, "status");
```

### **Metadata for Dependency Injection**

```typescript
// Injectable decorator
function injectable(target: any) {
  Reflect.defineMetadata("injectable", true, target);
}

// Inject decorator
function inject(token: string) {
  return function(target: any, propertyKey: string, parameterIndex: number) {
    const existingTokens = Reflect.getMetadata("injectTokens", target, propertyKey) || [];
    existingTokens[parameterIndex] = token;
    Reflect.defineMetadata("injectTokens", existingTokens, target, propertyKey);
  };
}

// Usage
@injectable
class UserService {
  constructor(
    @inject("DatabaseService") private db: DatabaseService,
    @inject("LoggerService") private logger: LoggerService
  ) {}
}

// Dependency injection container
class Container {
  private services = new Map<string, any>();
  
  register<T>(token: string, service: T): void {
    this.services.set(token, service);
  }
  
  resolve<T>(target: any): T {
    const tokens = Reflect.getMetadata("injectTokens", target) || [];
    const dependencies = tokens.map((token: string) => this.services.get(token));
    return new target(...dependencies);
  }
}
```

---

## 🚀 **Advanced Decorator Patterns**

### **Decorator Composition**

```typescript
// Compose multiple decorators
function compose(...decorators: any[]) {
  return function(target: any, propertyKey?: string, descriptor?: PropertyDescriptor) {
    return decorators.reduce((result, decorator) => {
      if (propertyKey && descriptor) {
        return decorator(result, propertyKey, descriptor);
      } else if (propertyKey) {
        return decorator(result, propertyKey);
      } else {
        return decorator(result);
      }
    }, target);
  };
}

// Usage
class MyClass {
  @compose(
    logMethod,
    cache(30000),
    retry(3)
  )
  async fetchData(url: string): Promise<any> {
    // Method implementation
  }
}
```

### **Conditional Decorators**

```typescript
// Conditional decorator
function conditional(condition: boolean, decorator: any) {
  return function(target: any, propertyKey?: string, descriptor?: PropertyDescriptor) {
    if (condition) {
      if (propertyKey && descriptor) {
        return decorator(target, propertyKey, descriptor);
      } else if (propertyKey) {
        return decorator(target, propertyKey);
      } else {
        return decorator(target);
      }
    }
    return target;
  };
}

// Usage
const isDevelopment = process.env.NODE_ENV === "development";

class MyClass {
  @conditional(isDevelopment, logMethod)
  processData(data: any): any {
    // Method implementation
  }
}
```

---

## ✅ **Best Practices**

### **1. Use Decorators for Cross-Cutting Concerns**

```typescript
// ✅ Good: Use decorators for logging, caching, validation
@logMethod
@cache(30000)
@validate
async fetchUser(id: number): Promise<User> {
  // Implementation
}

// ❌ Avoid: Using decorators for business logic
@businessLogic // Don't do this
async processOrder(order: Order): Promise<void> {
  // Implementation
}
```

### **2. Keep Decorators Simple and Focused**

```typescript
// ✅ Good: Simple, focused decorator
function logMethod(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  descriptor.value = function(...args: any[]) {
    console.log(`Calling ${propertyKey}`);
    return originalMethod.apply(this, args);
  };
}

// ❌ Avoid: Complex decorator with multiple responsibilities
function complexDecorator(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  // 100+ lines of complex logic
}
```

### **3. Use Metadata for Configuration**

```typescript
// ✅ Good: Use metadata for configuration
@metadata("version", "1.0.0")
@metadata("author", "John Doe")
class MyClass {
  @metadata("required", true)
  name: string;
}

// ❌ Avoid: Hardcoding configuration in decorators
@version("1.0.0")
@author("John Doe")
class MyClass {
  @required(true)
  name: string;
}
```

---

## ❓ **Common Interview Questions**

### **1. What are decorators in TypeScript?**

**Answer:**
Decorators are special declarations that can be attached to classes, methods, properties, or parameters to modify their behavior. They use the `@` syntax and are experimental in TypeScript.

### **2. How do you enable decorators in TypeScript?**

**Answer:**
Enable in `tsconfig.json`:

```json
{
  "compilerOptions": {
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true
  }
}
```

### **3. What are the different types of decorators?**

**Answer:**
- **Class decorators**: Applied to class constructors
- **Method decorators**: Applied to method definitions
- **Property decorators**: Applied to property declarations
- **Parameter decorators**: Applied to parameter declarations

### **4. How do you use metadata with decorators?**

**Answer:**
Use the `reflect-metadata` library and `Reflect.defineMetadata()` and `Reflect.getMetadata()`:

```typescript
import "reflect-metadata";

function metadata(key: string, value: any) {
  return function(target: any, propertyKey?: string) {
    Reflect.defineMetadata(key, value, target, propertyKey);
  };
}
```

### **5. What are some common use cases for decorators?**

**Answer:**
- **Logging**: Log method calls and parameters
- **Caching**: Cache method results
- **Validation**: Validate method parameters
- **Dependency injection**: Inject dependencies
- **Authorization**: Check user permissions

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-Async-Await-Promises.md" class="nav-button">← Previous: Async/Await & Promises</a>
  <a href="../03-TypeScript-Configuration-Tooling/01-tsconfig-json-Deep-Dive.md" class="nav-button">Next: tsconfig.json Deep Dive →</a>
</div>

*Last updated: December 2024*
