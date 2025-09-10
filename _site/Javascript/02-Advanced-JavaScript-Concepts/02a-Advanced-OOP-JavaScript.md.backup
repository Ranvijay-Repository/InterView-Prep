# 🔹 Advanced Object-Oriented JavaScript

> **Senior-level OOP concepts: Private fields, static blocks, decorators, metadata, and Proxy & Reflect API**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [Private Fields & Methods](#private-fields--methods)
- [Static Blocks](#static-blocks)
- [Decorators & Metadata](#decorators--metadata)
- [Proxy & Reflect API](#proxy--reflect-api)
- [Advanced Design Patterns](#advanced-design-patterns)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🔒 Private Fields & Methods

**Private fields** (introduced in ES2022) provide true encapsulation by making class members inaccessible from outside the class.

### Why Private Fields Matter:
- **True Encapsulation**: Real privacy, not just naming conventions
- **Better Security**: Prevent external modification of internal state
- **Cleaner APIs**: Expose only what's necessary
- **Modern JavaScript**: Use the latest language features

---

## 🧱 Static Blocks

**Static blocks** allow you to perform complex initialization logic for static members when a class is defined.

### Use Cases:
- **Complex Initialization**: Multi-step setup for static properties
- **Async Setup**: Initialize static members that require async operations
- **Conditional Logic**: Set up static members based on environment
- **Cross-Reference Setup**: Initialize static members that reference each other

### ASCII Diagram: Static Block Execution

{% raw %}
```
STATIC BLOCK EXECUTION
┌─────────────────────────────────┐
│        CLASS DEFINITION         │
│  ┌─────────────────────────────┐ │
│  │ class MyClass {             │ │
│  │   static {                  │ │
│  │     // Static block         │ │
│  │     // Executes once        │ │
│  │     // When class loads     │ │
│  │   }                         │ │
│  │ }                           │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  Class Loads  │
        │  Static Block │
        │  Executes     │
        │  Once         │
        └───────────────┘
```
{% endraw %}


---

## 🎭 Decorators & Metadata

**Decorators** are functions that can be used to modify classes, methods, properties, or parameters at design time.

### Why Decorators Matter:
- **Aspect-Oriented Programming**: Add cross-cutting concerns cleanly
- **Validation**: Automatically validate method parameters
- **Logging**: Add logging without cluttering business logic
- **Caching**: Implement caching strategies declaratively
- **Dependency Injection**: Configure dependencies automatically

### ASCII Diagram: Decorator Pattern

{% raw %}
```
DECORATOR PATTERN
┌─────────────────────────────────┐
│        ORIGINAL CLASS           │
│  ┌─────────────────────────────┐ │
│  │ class User {                │ │
│  │   @validate                 │
│  │   @log                      │
│  │   save() { ... }            │
│  │ }                           │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  DECORATORS   │
        │  @validate    │
        │  @log         │
        │  @cache       │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │ ENHANCED CLASS│
        │ With additional│
        │ functionality │
        └───────────────┘
```
{% endraw %}


---

## 🔍 Proxy & Reflect API

**Proxy** objects enable you to intercept and customize operations performed on objects (like property lookup, assignment, enumeration, function invocation, etc.).

### Why Proxy & Reflect Matter:
- **Virtualization**: Create virtual objects that don't exist
- **Validation**: Intercept property assignments for validation
- **Logging**: Track all property access and modifications
- **Default Values**: Provide default values for missing properties
- **Security**: Control access to sensitive properties

### ASCII Diagram: Proxy Interception

{% raw %}
```
PROXY INTERCEPTION
┌─────────────────────────────────┐
│        PROXY OBJECT             │
│  ┌─────────────────────────────┐ │
│  │ const proxy = new Proxy(    │ │
│  │   target,                   │ │
│  │   handler                    │ │
│  │ );                          │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  OPERATIONS   │
        │  get          │
        │  set          │
        │  delete       │
        │  apply        │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │   HANDLER     │
        │  Intercepts   │
        │  Operations   │
        │  Customizes   │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │   TARGET      │
        │  Original     │
        │  Object       │
        └───────────────┘
```
{% endraw %}


---

## 🏗️ Advanced Design Patterns

### 1. **Factory Pattern with Private Fields**

{% raw %}
```javascript
class UserFactory {
    static #userCount = 0;
    
    static createUser(name, email) {
        this.#userCount++;
        return new User(name, email, this.#userCount);
    }
    
    static getUserCount() {
        return this.#userCount;
    }
}
```
{% endraw %}


### 2. **Singleton with Private Constructor**

{% raw %}
```javascript
class DatabaseConnection {
    static #instance = null;
    #connectionString;
    
    constructor(connectionString) {
        if (DatabaseConnection.#instance) {
            throw new Error("Use getInstance() method");
        }
        this.#connectionString = connectionString;
    }
    
    static getInstance(connectionString) {
        if (!DatabaseConnection.#instance) {
            DatabaseConnection.#instance = new DatabaseConnection(connectionString);
        }
        return DatabaseConnection.#instance;
    }
}
```
{% endraw %}


---

## 💻 Detailed Examples

### Example 1: Private Fields Implementation
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>class BankAccount {
    #balance = 0;
    #accountNumber;
    #transactions = [];
    
    constructor(accountNumber, initialBalance = 0) {
        this.#accountNumber = accountNumber;
        this.#balance = initialBalance;
    }
    
    deposit(amount) {
        if (amount > 0) {
            this.#balance += amount;
            this.#transactions.push({
                type: 'deposit',
                amount,
                timestamp: new Date()
            });
            return true;
        }
        return false;
    }
    
    withdraw(amount) {
        if (amount > 0 && amount <= this.#balance) {
            this.#balance -= amount;
            this.#transactions.push({
                type: 'withdraw',
                amount,
                timestamp: new Date()
            });
            return true;
        }
        return false;
    }
    
    getBalance() {
        return this.#balance;
    }
    
    getAccountNumber() {
        return this.#accountNumber;
    }
    
    getTransactionHistory() {
        return [...this.#transactions]; // Return copy, not reference
    }
}

// Usage
const account = new BankAccount("12345", 1000);
account.deposit(500);
console.log(account.getBalance()); // 1500

// Private fields are truly private
// console.log(account.#balance); // SyntaxError: Private field
</code></pre>
</div>

### Example 2: Static Blocks for Complex Initialization
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>class Configuration {
    static #config;
    static #isInitialized = false;
    
    static {
        // Static block for complex initialization
        try {
            // Load environment-specific config
            const env = process.env.NODE_ENV || 'development';
            const configPath = `./config.${env}.json`;
            
            // Simulate async config loading
            this.#config = this.#loadConfig(configPath);
            this.#isInitialized = true;
            
            console.log(`Configuration loaded for ${env} environment`);
        } catch (error) {
            console.error('Failed to load configuration:', error);
            // Fallback to default config
            this.#config = this.#getDefaultConfig();
            this.#isInitialized = true;
        }
    }
    
    static #loadConfig(path) {
        // Simulate config loading
        const configs = {
            'development': { port: 3000, debug: true },
            'production': { port: 80, debug: false },
            'test': { port: 3001, debug: true }
        };
        
        const env = path.match(/config\.(\w+)\.json/)[1];
        return configs[env] || configs.development;
    }
    
    static #getDefaultConfig() {
        return { port: 3000, debug: true };
    }
    
    static get(key) {
        if (!this.#isInitialized) {
            throw new Error('Configuration not initialized');
        }
        return this.#config[key];
    }
    
    static getAll() {
        if (!this.#isInitialized) {
            throw new Error('Configuration not initialized');
        }
        return { ...this.#config };
    }
}

// Usage
console.log(Configuration.get('port')); // 3000 (or env-specific)
console.log(Configuration.getAll()); // Full config object
</code></pre>
</div>

### Example 3: Decorators Implementation
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Simple decorator factory
function log(target, propertyKey, descriptor) {
    const originalMethod = descriptor.value;
    
    descriptor.value = function(...args) {
        console.log(`Calling ${propertyKey} with:`, args);
        const result = originalMethod.apply(this, args);
        console.log(`${propertyKey} returned:`, result);
        return result;
    };
    
    return descriptor;
}

function validate(target, propertyKey, descriptor) {
    const originalMethod = descriptor.value;
    
    descriptor.value = function(...args) {
        // Simple validation - check if first argument is positive
        if (args[0] <= 0) {
            throw new Error(`${propertyKey}: First argument must be positive`);
        }
        return originalMethod.apply(this, args);
    };
    
    return descriptor;
}

class Calculator {
    @log
    @validate
    multiply(a, b) {
        return a * b;
    }
    
    @log
    divide(a, b) {
        if (b === 0) {
            throw new Error('Division by zero');
        }
        return a / b;
    }
}

// Usage
const calc = new Calculator();
try {
    console.log(calc.multiply(5, 3)); // Logs the call and result
    console.log(calc.multiply(-1, 3)); // Throws validation error
} catch (error) {
    console.error('Error:', error.message);
}
</code></pre>
</div>

### Example 4: Proxy & Reflect API
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Validation Proxy
function createValidatedObject(target, validators) {
    return new Proxy(target, {
        set(target, property, value, receiver) {
            // Check if validator exists for this property
            if (validators[property]) {
                const isValid = validators[property](value);
                if (!isValid) {
                    throw new Error(`Invalid value for ${property}: ${value}`);
                }
            }
            
            // Use Reflect to set the property
            return Reflect.set(target, property, value, receiver);
        },
        
        get(target, property, receiver) {
            // Log property access
            console.log(`Accessing property: ${property}`);
            
            // Use Reflect to get the property
            return Reflect.get(target, property, receiver);
        },
        
        deleteProperty(target, property) {
            // Prevent deletion of certain properties
            if (property === 'id') {
                throw new Error('Cannot delete id property');
            }
            
            // Use Reflect to delete the property
            return Reflect.deleteProperty(target, property);
        }
    });
}

// Validators
const validators = {
    age: (value) => typeof value === 'number' && value >= 0 && value <= 150,
    email: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
    name: (value) => typeof value === 'string' && value.length > 0
};

// Create validated user object
const user = createValidatedObject({}, validators);

// Usage
try {
    user.name = "John Doe";     // Valid
    user.age = 30;              // Valid
    user.email = "john@example.com"; // Valid
    
    console.log(user.name);     // Logs access, returns "John Doe"
    
    user.age = -5;              // Throws validation error
} catch (error) {
    console.error('Validation error:', error.message);
}

// Try to delete protected property
try {
    delete user.id;              // Throws error
} catch (error) {
    console.error('Deletion error:', error.message);
}
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What are private fields in JavaScript and how do they differ from closures?
**A:** Private fields (introduced in ES2022) use the `#` prefix and provide true encapsulation at the class level. They're different from closures because they're scoped to the class instance, not to the function that creates them. Private fields are truly inaccessible from outside the class, while closures can be accessed if you have a reference to the function.

### Q2: How do static blocks work and when would you use them?
**A:** Static blocks execute once when the class is defined, allowing you to perform complex initialization logic for static members. They're useful for async setup, conditional logic, cross-referencing static properties, or any initialization that requires multiple steps or error handling.

### Q3: What are decorators and how do they work?
**A:** Decorators are functions that can modify classes, methods, properties, or parameters at design time. They use the `@` syntax and are executed when the class is defined. Decorators are useful for adding cross-cutting concerns like validation, logging, caching, or dependency injection without cluttering the business logic.

### Q4: How does the Proxy API work and what are its use cases?
**A:** Proxy objects intercept operations performed on objects (like property access, assignment, deletion) and allow you to customize these operations. Use cases include validation, logging, default values, security (controlling access), virtualization (creating objects that don't exist), and implementing reactive patterns.

### Q5: What's the difference between Proxy and Reflect?
**A:** Proxy is used to intercept and customize operations on objects, while Reflect provides methods to perform these operations programmatically. Reflect methods mirror the operations that Proxy can intercept. They're often used together - Proxy for interception, Reflect for performing the actual operation.

---

## 🏋️ Practice Exercises

### Exercise 1: Implement a Caching Decorator
Create a decorator that caches method results based on input parameters. The decorator should handle different parameter types and provide cache invalidation options.

### Exercise 2: Build a Validation Proxy
Implement a Proxy that validates object properties based on schema definitions. Support different validation rules for different property types.

### Exercise 3: Create a Singleton with Private Fields
Implement a Singleton pattern using private fields and static blocks. Ensure thread safety and provide a way to reset the instance if needed.

---

## 📚 Additional Resources

- **Private Fields**: [MDN Private Class Fields](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/Private_class_fields)
- **Decorators**: [TC39 Decorators Proposal](https://github.com/tc39/proposal-decorators)
- **Proxy & Reflect**: [MDN Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
- **Advanced OOP Patterns**: [JavaScript Design Patterns](https://addyosmani.com/resources/essentialjsdesignpatterns/book/)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="02-Object-Oriented-JavaScript.md" class="nav-link prev">← Previous: Object-Oriented JavaScript Basics</a>
    <a href="03-Asynchronous-JavaScript.md" class="nav-link next">Next: Asynchronous JavaScript →</a>
</div>

*Last updated: December 2024*
