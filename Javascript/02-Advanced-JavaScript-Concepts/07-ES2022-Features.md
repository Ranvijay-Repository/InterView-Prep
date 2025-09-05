# 🔹 ES2022+ Features

> **Comprehensive coverage of ES2022+ JavaScript features: Class fields & private methods, Top-level await in modules, and Error.cause**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [ES2022 Overview](#es2022-overview)
- [Class Fields & Private Methods](#class-fields--private-methods)
- [Top-level await in Modules](#top-level-await-in-modules)
- [Error.cause](#errorcause)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 ES2022 Overview

**ES2022** (ECMAScript 2022) introduced several powerful features that enhance JavaScript's class system, module handling, and error management capabilities.

### Why ES2022+ Features Matter:
- **Better Encapsulation**: True private fields and methods with # syntax
- **Cleaner Class Syntax**: Public and private instance fields
- **Module Initialization**: Top-level await for better module setup
- **Error Handling**: Error.cause for better error chaining and debugging
- **Developer Experience**: More intuitive and maintainable code

---

## 🔒 Class Fields & Private Methods

**Class Fields** and **Private Methods** provide a cleaner way to declare instance properties and methods, with true privacy using the `#` prefix.

### Why Class Fields & Private Methods Matter:
- **True Privacy**: Real encapsulation, not just naming conventions
- **Cleaner Syntax**: Declare fields directly in class body
- **Better Performance**: Optimized by JavaScript engines
- **Modern Standards**: Follow current JavaScript best practices

### ASCII Diagram: Class Fields Structure
```
CLASS FIELDS STRUCTURE
┌─────────────────────────────────┐
│        CLASS DEFINITION         │
│  ┌─────────────────────────────┐ │
│  │ class MyClass {             │ │
│  │   #privateField = "secret"; │ │
│  │   publicField = "public";   │ │
│  │   static #privateStatic;    │ │
│  │   static publicStatic;      │ │
│  │                             │ │
│  │   #privateMethod() { ... }  │ │
│  │   publicMethod() { ... }    │ │
│  │ }                           │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  INSTANCE     │
        │  Fields       │
        │  Private      │
        │  Public       │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  STATIC       │
        │  Fields       │
        │  Private      │
        │  Public       │
        └───────────────┘
```

### Field Types:
1. **Public Instance Fields**: Accessible from anywhere
2. **Private Instance Fields (#)**: Only accessible within the class
3. **Public Static Fields**: Shared across all instances
4. **Private Static Fields (#)**: Private to the class itself

---

## ⚡ Top-level await in Modules

**Top-level await** in modules allows you to use the `await` keyword at the module level, making it easier to initialize applications and handle async setup.

### Why Top-level await in Modules Matters:
- **Module Initialization**: Async setup when modules load
- **Configuration Loading**: Load config files asynchronously
- **Service Setup**: Initialize services before module export
- **Cleaner Code**: Eliminate wrapper functions for async initialization
- **Better Error Handling**: Handle async errors at module level

### ASCII Diagram: Top-level await Module Flow
```
TOP-LEVEL AWAIT MODULE FLOW
┌─────────────────────────────────┐
│        MODULE LOADING           │
│  ┌─────────────────────────────┐ │
│  │ import './config.js'        │ │
│  │                             │ │
│  │ const config = await        │ │
│  │   loadConfiguration();      │ │
│  │                             │ │
│  │ export { config };          │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  AWAIT        │
        │  Execution    │
        │  Pauses       │
        │  Module       │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  RESOLUTION   │
        │  Module       │
        │  Continues    │
        │  Loading      │
        └───────────────┘
```

### Use Cases:
- **Environment Configuration**: Load environment-specific settings
- **Database Connections**: Establish connections during startup
- **API Client Setup**: Initialize API clients with configuration
- **Feature Flags**: Load feature configuration asynchronously
- **Service Initialization**: Initialize services before module export

---

## 🚨 Error.cause

**Error.cause** allows you to chain errors together, providing better context and debugging information when errors occur.

### Why Error.cause Matters:
- **Error Chaining**: Link related errors together
- **Better Debugging**: Understand error context and chain
- **Root Cause Analysis**: Trace errors back to their source
- **Improved Logging**: Better error reporting and monitoring
- **Error Recovery**: Handle errors more intelligently

### ASCII Diagram: Error.cause Chain
```
ERROR.CAUSE CHAIN
┌─────────────────────────────────┐
│        ERROR CHAINING           │
│  ┌─────────────────────────────┐ │
│  │ DatabaseError               │ │
│  │ ├── cause: NetworkError     │ │
│  │     ├── cause: TimeoutError │ │
│  │         ├── cause: DNSError │ │
│  │             └── Root Cause  │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  ERROR        │
        │  Traversal    │
        │  Follow       │
        │  Cause Chain  │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  ROOT CAUSE   │
        │  Identified   │
        │  Better       │
        │  Debugging    │
        └───────────────┘
```

### Error Chaining Benefits:
- **Context Preservation**: Maintain error context through the chain
- **Debugging**: Easier to trace error origins
- **Logging**: Better error reporting for monitoring
- **Recovery**: Implement intelligent error handling strategies

---

## 💻 Detailed Examples

### Example 1: Advanced Class Fields with Private Methods
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced class with private fields and methods
class BankAccount {
    // Private instance fields
    #accountNumber;
    #balance = 0;
    #transactions = [];
    #isLocked = false;
    
    // Public instance fields
    accountType = 'checking';
    owner = '';
    
    // Private static fields
    static #totalAccounts = 0;
    static #bankCode = 'JSBANK';
    
    // Public static fields
    static maxBalance = 1000000;
    static supportedCurrencies = ['USD', 'EUR', 'GBP'];
    
    constructor(accountNumber, owner, initialBalance = 0) {
        this.#accountNumber = accountNumber;
        this.owner = owner;
        this.#balance = initialBalance;
        
        // Increment total accounts
        BankAccount.#totalAccounts++;
        
        // Log account creation
        this.#logTransaction('Account created', initialBalance);
    }
    
    // Private methods
    #logTransaction(description, amount) {
        const transaction = {
            id: this.#transactions.length + 1,
            description,
            amount,
            balance: this.#balance,
            timestamp: new Date(),
            type: amount >= 0 ? 'credit' : 'debit'
        };
        
        this.#transactions.push(transaction);
        this.#validateTransaction(transaction);
    }
    
    #validateTransaction(transaction) {
        if (transaction.amount < 0 && Math.abs(transaction.amount) > this.#balance) {
            throw new Error('Insufficient funds');
        }
        
        if (this.#isLocked) {
            throw new Error('Account is locked');
        }
    }
    
    #updateBalance(amount) {
        this.#balance += amount;
        
        // Check for suspicious activity
        if (Math.abs(amount) > 10000) {
            this.#flagForReview(amount);
        }
    }
    
    #flagForReview(amount) {
        console.warn(`Large transaction flagged: $${amount} on account ${this.#accountNumber}`);
        // In real implementation: notify compliance team
    }
    
    // Public methods
    deposit(amount) {
        if (amount <= 0) {
            throw new Error('Deposit amount must be positive');
        }
        
        this.#updateBalance(amount);
        this.#logTransaction('Deposit', amount);
        return this.#balance;
    }
    
    withdraw(amount) {
        if (amount <= 0) {
            throw new Error('Withdrawal amount must be positive');
        }
        
        if (amount > this.#balance) {
            throw new Error('Insufficient funds');
        }
        
        this.#updateBalance(-amount);
        this.#logTransaction('Withdrawal', -amount);
        return this.#balance;
    }
    
    transfer(amount, targetAccount) {
        if (!(targetAccount instanceof BankAccount)) {
            throw new Error('Invalid target account');
        }
        
        this.withdraw(amount);
        targetAccount.deposit(amount);
        
        this.#logTransaction(`Transfer to ${targetAccount.#accountNumber}`, -amount);
        targetAccount.#logTransaction(`Transfer from ${this.#accountNumber}`, amount);
        
        return true;
    }
    
    // Getters
    get balance() {
        return this.#balance;
    }
    
    get accountNumber() {
        return this.#accountNumber;
    }
    
    get transactionHistory() {
        return [...this.#transactions]; // Return copy, not reference
    }
    
    get isLocked() {
        return this.#isLocked;
    }
    
    // Static methods
    static getTotalAccounts() {
        return BankAccount.#totalAccounts;
    }
    
    static getBankCode() {
        return BankAccount.#bankCode;
    }
    
    // Account management
    lock() {
        this.#isLocked = true;
        console.log(`Account ${this.#accountNumber} locked`);
    }
    
    unlock() {
        this.#isLocked = false;
        console.log(`Account ${this.#accountNumber} unlocked`);
    }
    
    // Cleanup method
    close() {
        if (this.#balance > 0) {
            throw new Error('Cannot close account with positive balance');
        }
        
        BankAccount.#totalAccounts--;
        this.#isLocked = true;
        console.log(`Account ${this.#accountNumber} closed`);
    }
}

// Usage
const account1 = new BankAccount('12345', 'John Doe', 1000);
const account2 = new BankAccount('67890', 'Jane Smith', 500);

console.log('Total accounts:', BankAccount.getTotalAccounts());
console.log('Bank code:', BankAccount.getBankCode());

// Perform transactions
account1.deposit(500);
account1.transfer(200, account2);

console.log('Account 1 balance:', account1.balance);
console.log('Account 2 balance:', account2.balance);
console.log('Account 1 transactions:', account1.transactionHistory);

// Try to access private fields (will throw error)
// console.log(account1.#balance); // SyntaxError: Private field
// console.log(account1.#accountNumber); // SyntaxError: Private field
</code></pre>
</div>

### Example 2: Top-level await in Module System
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// config.js - Module with top-level await
const config = await loadConfiguration();

async function loadConfiguration() {
    try {
        // Simulate async config loading
        const env = process.env.NODE_ENV || 'development';
        
        // Simulate API call for config
        await new Promise(resolve => setTimeout(resolve, 100));
        
        const configs = {
            development: {
                port: 3000,
                database: 'localhost',
                debug: true,
                logLevel: 'debug',
                features: ['dev-tools', 'hot-reload', 'debug-panel']
            },
            production: {
                port: 80,
                database: 'production-db',
                debug: false,
                logLevel: 'error',
                features: ['monitoring', 'analytics', 'caching']
            },
            test: {
                port: 3001,
                database: 'test-db',
                debug: true,
                logLevel: 'warn',
                features: ['test-runner', 'coverage', 'mocking']
            }
        };
        
        return configs[env] || configs.development;
    } catch (error) {
        console.warn('Using fallback config:', error.message);
        return {
            port: 3000,
            database: 'localhost',
            debug: true,
            logLevel: 'info',
            features: ['basic']
        };
    }
}

export { config };

// database.js - Database connection with top-level await
const connection = await establishConnection();

async function establishConnection() {
    try {
        // Simulate database connection
        await new Promise(resolve => setTimeout(resolve, 200));
        
        return {
            host: 'localhost',
            port: 5432,
            database: 'myapp',
            status: 'connected',
            poolSize: 10,
            connectionTimeout: 5000
        };
    } catch (error) {
        throw new Error(`Database connection failed: ${error.message}`);
    }
}

export { connection };

// services.js - Service initialization with top-level await
const services = await initializeServices();

async function initializeServices() {
    try {
        // Simulate service initialization
        await new Promise(resolve => setTimeout(resolve, 150));
        
        return {
            auth: { status: 'ready', provider: 'jwt' },
            cache: { status: 'ready', type: 'redis' },
            queue: { status: 'ready', type: 'bull' },
            storage: { status: 'ready', type: 's3' }
        };
    } catch (error) {
        throw new Error(`Service initialization failed: ${error.message}`);
    }
}

export { services };

// app.js - Main application using top-level await modules
import { config } from './config.js';
import { connection } from './database.js';
import { services } from './services.js';

console.log('App starting with configuration:', config);
console.log('Database connection:', connection);
console.log('Services status:', services);

// The app won't start until all top-level awaits resolve
const app = {
    port: config.port,
    database: connection,
    services: services,
    
    start() {
        console.log(`Server starting on port ${this.port}`);
        console.log(`Database: ${this.database.status}`);
        console.log(`Services: ${Object.keys(this.services).join(', ')}`);
        
        // Initialize app with loaded configuration
        this.initializeFeatures();
    },
    
    initializeFeatures() {
        config.features.forEach(feature => {
            console.log(`Initializing feature: ${feature}`);
            // Feature-specific initialization logic
        });
    }
};

export default app;
</code></pre>
</div>

### Example 3: Error.cause for Comprehensive Error Handling
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Custom error classes with Error.cause
class NetworkError extends Error {
    constructor(message, cause) {
        super(message);
        this.name = 'NetworkError';
        this.cause = cause;
    }
}

class DatabaseError extends Error {
    constructor(message, cause) {
        super(message);
        this.name = 'DatabaseError';
        this.cause = cause;
    }
}

class ValidationError extends Error {
    constructor(message, cause) {
        super(message);
        this.name = 'ValidationError';
        this.cause = cause;
    }
}

class BusinessLogicError extends Error {
    constructor(message, cause) {
        super(message);
        this.name = 'BusinessLogicError';
        this.cause = cause;
    }
}

// Error handling utility
class ErrorHandler {
    static logError(error, context = '') {
        console.error(`[${context}] Error:`, error.message);
        
        let currentError = error;
        let level = 0;
        
        while (currentError.cause) {
            level++;
            const indent = '  '.repeat(level);
            console.error(`${indent}Caused by:`, currentError.cause.message);
            currentError = currentError.cause;
        }
        
        // Log stack trace
        if (error.stack) {
            console.error('Stack trace:', error.stack);
        }
    }
    
    static getRootCause(error) {
        let currentError = error;
        while (currentError.cause) {
            currentError = currentError.cause;
        }
        return currentError;
    }
    
    static getErrorChain(error) {
        const chain = [];
        let currentError = error;
        
        while (currentError) {
            chain.push({
                name: currentError.name,
                message: currentError.message,
                stack: currentError.stack
            });
            currentError = currentError.cause;
        }
        
        return chain;
    }
}

// Database service with error chaining
class DatabaseService {
    constructor() {
        this.connection = null;
    }
    
    async connect() {
        try {
            // Simulate connection attempt
            await new Promise((resolve, reject) => {
                setTimeout(() => {
                    if (Math.random() > 0.8) {
                        reject(new Error('Connection timeout'));
                    } else {
                        resolve();
                    }
                }, 1000);
            });
            
            this.connection = { status: 'connected' };
        } catch (error) {
            throw new NetworkError('Failed to connect to database', error);
        }
    }
    
    async query(sql, params) {
        if (!this.connection) {
            throw new DatabaseError('Database not connected', 
                new Error('Connection not established'));
        }
        
        try {
            // Simulate query execution
            await new Promise((resolve, reject) => {
                setTimeout(() => {
                    if (Math.random() > 0.9) {
                        reject(new Error('Query execution failed'));
                    } else {
                        resolve();
                    }
                }, 500);
            });
            
            return { rows: [], count: 0 };
        } catch (error) {
            throw new DatabaseError(`Query failed: ${sql}`, error);
        }
    }
}

// User service with error chaining
class UserService {
    constructor(databaseService) {
        this.db = databaseService;
    }
    
    async createUser(userData) {
        try {
            // Validate user data
            if (!userData.email || !userData.name) {
                throw new ValidationError('Invalid user data', 
                    new Error('Email and name are required'));
            }
            
            // Check if user already exists
            const existingUser = await this.db.query(
                'SELECT * FROM users WHERE email = ?', 
                [userData.email]
            );
            
            if (existingUser.rows.length > 0) {
                throw new BusinessLogicError('User already exists', 
                    new Error(`User with email ${userData.email} already exists`));
            }
            
            // Create user
            const result = await this.db.query(
                'INSERT INTO users (email, name) VALUES (?, ?)',
                [userData.email, userData.name]
            );
            
            return { id: result.insertId, ...userData };
        } catch (error) {
            // Chain the error with context
            if (error instanceof ValidationError || 
                error instanceof BusinessLogicError) {
                throw error; // Re-throw business logic errors
            }
            
            throw new BusinessLogicError('Failed to create user', error);
        }
    }
}

// Usage example
async function main() {
    try {
        const dbService = new DatabaseService();
        await dbService.connect();
        
        const userService = new UserService(dbService);
        
        // Try to create a user
        const user = await userService.createUser({
            email: 'john@example.com',
            name: 'John Doe'
        });
        
        console.log('User created:', user);
    } catch (error) {
        // Handle error with full context
        ErrorHandler.logError(error, 'User Creation');
        
        // Get root cause
        const rootCause = ErrorHandler.getRootCause(error);
        console.log('Root cause:', rootCause.message);
        
        // Get full error chain
        const errorChain = ErrorHandler.getErrorChain(error);
        console.log('Error chain length:', errorChain.length);
        
        // Handle specific error types
        if (error instanceof ValidationError) {
            console.log('Validation error occurred');
        } else if (error instanceof DatabaseError) {
            console.log('Database error occurred');
        } else if (error instanceof NetworkError) {
            console.log('Network error occurred');
        }
    }
}

// Run the example
main().catch(console.error);
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What's the difference between private fields (#) and traditional closure-based privacy?
**A:** Private fields (#) provide true encapsulation at the class level and are scoped to the class instance, while closures create privacy at the function level. Private fields are more performant, easier to debug, and follow modern JavaScript standards. They're truly inaccessible from outside the class, unlike closures which can be accessed if you have a reference to the function.

### Q2: How do class fields improve performance compared to constructor-based properties?
**A:** Class fields are optimized by JavaScript engines and can be more efficient than setting properties in the constructor. They're initialized once when the class is defined, and the engine can make better optimizations. They also provide cleaner syntax and better readability.

### Q3: What are the limitations of top-level await in modules?
**A:** Top-level await is only available in ES modules, can delay module loading since the module isn't considered "ready" until all awaits resolve, and can impact application startup time. It's great for configuration loading and initialization but should be used judiciously.

### Q4: How does Error.cause improve error handling compared to traditional error wrapping?
**A:** Error.cause provides a standardized way to chain errors, making it easier to trace error origins and understand the full context. It's more performant than custom error wrapping solutions and provides better debugging information. The cause chain can be traversed programmatically for better error analysis.

### Q5: When would you use private static fields vs private instance fields?
**A:** Use private static fields (#staticField) for data that should be shared across all instances of a class but remain private to the class itself (like counters, caches, or configuration). Use private instance fields (#instanceField) for data that should be unique to each instance and private to that instance.

---

## 🏋️ Practice Exercises

### Exercise 1: Build a Secure Configuration Manager
Create a configuration manager class using private fields and methods that loads configuration from multiple sources with top-level await and provides secure access to sensitive settings.

### Exercise 2: Implement a Robust Error Handling System
Build an error handling system using Error.cause that can chain different types of errors, provide meaningful error messages, and implement automatic error recovery strategies.

### Exercise 3: Create a Service Registry with Top-level Await
Implement a service registry that uses top-level await to initialize services in the correct order, with proper error handling and dependency management.

---

## 📚 Additional Resources

- **ES2022 Specification**: [ECMAScript 2022](https://tc39.es/ecma262/2022/)
- **Class Fields**: [MDN Class Fields](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/Public_class_fields)
- **Private Class Fields**: [MDN Private Class Fields](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/Private_class_fields)
- **Top-level await**: [V8 Blog - Top-level await](https://v8.dev/features/top-level-await)
- **Error.cause**: [MDN Error.cause](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error/cause)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="06-ES2021-Features.md" class="nav-link prev">← Previous: ES2021+ Features</a>
    <a href="08-ES2023-Features.md" class="nav-link next">Next: ES2023+ Features →</a>
</div>

*Last updated: December 2024*
