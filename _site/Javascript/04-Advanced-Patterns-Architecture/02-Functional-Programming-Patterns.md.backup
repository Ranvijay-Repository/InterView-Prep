# 🔹 Functional Programming Patterns

> **Comprehensive coverage of advanced functional programming patterns: Railway Oriented Programming, Either/Maybe monads, and Lens pattern**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [Functional Programming Patterns Overview](#functional-programming-patterns-overview)
- [Railway Oriented Programming](#railway-oriented-programming)
- [Either/Maybe Monads](#eithermaybe-monads)
- [Lens Pattern](#lens-pattern)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 Functional Programming Patterns Overview

**Functional Programming Patterns** provide elegant solutions for handling complex data transformations, error handling, and immutable data manipulation in a functional style.

### Why Functional Programming Patterns Matter:
- **Error Handling**: Graceful failure handling without exceptions
- **Data Transformation**: Clean, composable data pipelines
- **Immutability**: Safe data manipulation without side effects
- **Composability**: Build complex operations from simple functions
- **Testing**: Easier to test pure functions

---

## 🚂 Railway Oriented Programming

**Railway Oriented Programming** is a functional approach to error handling that treats success and failure as parallel "railways" that can be composed together.

### Why Railway Oriented Programming Matters:
- **Error Handling**: Explicit error paths without exceptions
- **Composability**: Chain operations with automatic error propagation
- **Readability**: Clear success and failure paths
- **Debugging**: Easy to trace error flow
- **Type Safety**: Compile-time error handling guarantees

### ASCII Diagram: Railway Oriented Programming Flow

```
RAILWAY ORIENTED PROGRAMMING
┌─────────────────────────────────┐
│        INPUT                    │
│  ┌─────────────────────────────┐ │
│  │ Data/Request                │ │
│  │                             │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  VALIDATION   │
        │               │
        │  Success →    │
        │  Failure →    │
        └───────────────┘
                │
                ▼
    ┌─────────────────────┐
    │  SUCCESS RAILWAY    │  │  FAILURE RAILWAY
    │                     │  │
    │  Process Data       │  │  Error Handling
    │  Transform          │  │  Logging
    │  Business Logic     │  │  User Feedback
    │                     │  │  Fallback
    └─────────────────────┘  │
                │            │
                ▼            ▼
        ┌───────────────┐  ┌───────────────┐
        │  SUCCESS      │  │  FAILURE      │
        │  OUTPUT       │  │  OUTPUT       │
        │               │  │               │
        │  Result       │  │  Error        │
        │  Data         │  │  Message      │
        └───────────────┘  └───────────────┘
```


### Use Cases:
- **API Validation**: Input validation and error handling
- **Data Processing**: Pipeline operations with error handling
- **Form Validation**: User input validation
- **Business Logic**: Complex operations with multiple failure points
- **Configuration**: Settings validation and processing

---

## 🎭 Either/Maybe Monads

**Either/Maybe Monads** are functional data types that represent computations that can either succeed or fail, providing a clean way to handle errors and optional values.

### Why Either/Maybe Monads Matter:
- **Error Handling**: Explicit error representation
- **Null Safety**: Eliminate null/undefined issues
- **Composability**: Chain operations safely
- **Type Safety**: Compile-time error handling
- **Functional Style**: Pure error handling without exceptions

### ASCII Diagram: Either/Maybe Monad Structure

```
EITHER/MAYBE MONAD STRUCTURE
┌─────────────────────────────────┐
│        EITHER MONAD             │
│  ┌─────────────────────────────┐ │
│  │ Left(Error)                 │ │
│  │ Right(Success)              │ │
│  │                             │ │
│  │ map() → Transform success   │ │
│  │ flatMap() → Chain operations│ │
│  │ fold() → Handle both cases  │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  MAYBE MONAD  │
        │               │
        │  Just(Value)  │
        │  Nothing      │
        │               │
        │  map() → Transform │
        │  flatMap() → Chain │
        │  getOrElse() → Default │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  OPERATIONS   │
        │               │
        │  Validation   │
        │  Transformation│
        │  Error Handling│
        │  Fallbacks    │
        └───────────────┘
```


### Monad Operations:
- **map()**: Transform success values
- **flatMap()**: Chain operations
- **fold()**: Handle both success and failure
- **getOrElse()**: Provide default values
- **orElse()**: Alternative error handling

---

## 🔍 Lens Pattern

**Lens Pattern** provides a way to access and modify deeply nested data structures immutably, making data manipulation safe and composable.

### Why Lens Pattern Matters:
- **Immutability**: Safe data updates without mutation
- **Deep Access**: Navigate complex nested structures
- **Composability**: Combine multiple lenses
- **Type Safety**: Compile-time property access validation
- **Performance**: Efficient immutable updates

### ASCII Diagram: Lens Pattern Structure

```
LENS PATTERN STRUCTURE
┌─────────────────────────────────┐
│        DATA STRUCTURE           │
│  ┌─────────────────────────────┐ │
│  │ user: {                     │ │
│  │   profile: {                │ │
│  │     name: "John",           │ │
│  │     address: {              │ │
│  │       city: "NYC"           │ │
│  │     }                       │ │
│  │   }                         │ │
│  │ }                           │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  LENS         │
        │               │
        │  get() → Read │
        │  set() → Write│
        │  over() → Transform │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  COMPOSED     │
        │  LENSES       │
        │               │
        │  userLens     │
        │  .profileLens │
        │  .addressLens │
        │  .cityLens    │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  OPERATIONS   │
        │               │
        │  Read city    │
        │  Update city  │
        │  Transform    │
        └───────────────┘
```


### Lens Operations:
- **get()**: Read values from nested structures
- **set()**: Set values immutably
- **over()**: Transform values with functions
- **compose()**: Combine multiple lenses
- **view()**: Read-only access

---

## 💻 Detailed Examples

### Example 1: Railway Oriented Programming Implementation
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Railway Oriented Programming with comprehensive error handling
class Result {
    constructor(isSuccess, value, error) {
        this.isSuccess = isSuccess;
        this.value = value;
        this.error = error;
    }
    
    static success(value) {
        return new Result(true, value, null);
    }
    
    static failure(error) {
        return new Result(false, null, error);
    }
    
    // Railway functions
    map(fn) {
        return this.isSuccess 
            ? Result.success(fn(this.value))
            : Result.failure(this.error);
    }
    
    flatMap(fn) {
        return this.isSuccess 
            ? fn(this.value)
            : Result.failure(this.error);
    }
    
    fold(onSuccess, onFailure) {
        return this.isSuccess 
            ? onSuccess(this.value)
            : onFailure(this.error);
    }
    
    // Utility methods
    getOrElse(defaultValue) {
        return this.isSuccess ? this.value : defaultValue;
    }
    
    orElse(fn) {
        return this.isSuccess ? this : fn(this.error);
    }
    
    // Error handling
    tap(fn) {
        if (this.isSuccess) {
            fn(this.value);
        }
        return this;
    }
    
    tapError(fn) {
        if (!this.isSuccess) {
            fn(this.error);
        }
        return this;
    }
}

// Railway functions for composition
const railway = {
    // Success railway
    success: (value) => Result.success(value),
    
    // Failure railway
    failure: (error) => Result.failure(error),
    
    // Try-catch wrapper
    try: (fn) => {
        try {
            return Result.success(fn());
        } catch (error) {
            return Result.failure(error);
        }
    },
    
    // Async try-catch wrapper
    tryAsync: async (fn) => {
        try {
            const result = await fn();
            return Result.success(result);
        } catch (error) {
            return Result.failure(error);
        }
    },
    
    // Validation railway
    validate: (predicate, error) => (value) => 
        predicate(value) ? Result.success(value) : Result.failure(error),
    
    // Pipeline composition
    pipe: (...functions) => (initialValue) => 
        functions.reduce((result, fn) => 
            result.flatMap(fn), Result.success(initialValue)),
    
    // Parallel execution
    all: async (results) => {
        try {
            const values = await Promise.all(
                results.map(r => r.isSuccess ? r.value : Promise.reject(r.error))
            );
            return Result.success(values);
        } catch (error) {
            return Result.failure(error);
        }
    }
};

// Validation functions
const validators = {
    required: (fieldName) => railway.validate(
        value => value != null && value !== '',
        `${fieldName} is required`
    ),
    
    email: railway.validate(
        email => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email),
        'Invalid email format'
    ),
    
    minLength: (min) => (fieldName) => railway.validate(
        value => String(value).length >= min,
        `${fieldName} must be at least ${min} characters`
    ),
    
    maxLength: (max) => (fieldName) => railway.validate(
        value => String(value).length <= max,
        `${fieldName} must be no more than ${max} characters`
    ),
    
    range: (min, max) => (fieldName) => railway.validate(
        value => Number(value) >= min && Number(value) <= max,
        `${fieldName} must be between ${min} and ${max}`
    ),
    
    pattern: (regex, message) => railway.validate(
        value => regex.test(String(value)),
        message
    )
};

// Business logic functions
const businessLogic = {
    // User registration pipeline
    registerUser: railway.pipe(
        // Validate input
        (data) => railway.pipe(
            validators.required('username')(data.username),
            validators.required('email')(data.email),
            validators.required('password')(data.password),
            validators.email(data.email),
            validators.minLength(8)('password')(data.password),
            validators.pattern(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/, 'Password must contain lowercase, uppercase, and number')(data.password)
        ).map(() => data),
        
        // Check if user exists
        async (data) => {
            const exists = await checkUserExists(data.email);
            return exists 
                ? Result.failure('User already exists')
                : Result.success(data);
        },
        
        // Hash password
        async (data) => {
            const hashedPassword = await hashPassword(data.password);
            return Result.success({ ...data, password: hashedPassword });
        },
        
        // Save user
        async (data) => {
            const user = await saveUser(data);
            return Result.success(user);
        },
        
        // Send welcome email
        async (user) => {
            await sendWelcomeEmail(user.email);
            return Result.success(user);
        }
    ),
    
    // Order processing pipeline
    processOrder: railway.pipe(
        // Validate order
        (order) => railway.pipe(
            validators.required('items')(order.items),
            validators.required('customerId')(order.customerId),
            validators.range(0.01, 10000)('total')(order.total)
        ).map(() => order),
        
        // Check inventory
        async (order) => {
            const inventoryCheck = await checkInventory(order.items);
            return inventoryCheck.success 
                ? Result.success(order)
                : Result.failure(`Insufficient inventory: ${inventoryCheck.missingItems.join(', ')}`);
        },
        
        // Process payment
        async (order) => {
            const payment = await processPayment(order.total, order.paymentMethod);
            return payment.success 
                ? Result.success({ ...order, paymentId: payment.paymentId })
                : Result.failure(`Payment failed: ${payment.error}`);
        },
        
        // Create order
        async (order) => {
            const createdOrder = await createOrder(order);
            return Result.success(createdOrder);
        },
        
        // Update inventory
        async (order) => {
            await updateInventory(order.items);
            return Result.success(order);
        },
        
        // Send confirmation
        async (order) => {
            await sendOrderConfirmation(order.customerId, order.id);
            return Result.success(order);
        }
    )
};

// Mock functions for demonstration
async function checkUserExists(email) {
    // Simulate API call
    return email === 'existing@example.com';
}

async function hashPassword(password) {
    // Simulate password hashing
    return `hashed_${password}`;
}

async function saveUser(userData) {
    // Simulate saving user
    return { id: Date.now(), ...userData };
}

async function sendWelcomeEmail(email) {
    // Simulate sending email
    console.log(`Welcome email sent to ${email}`);
}

async function checkInventory(items) {
    // Simulate inventory check
    const missingItems = items.filter(item => item.id === 'out-of-stock');
    return {
        success: missingItems.length === 0,
        missingItems
    };
}

async function processPayment(amount, method) {
    // Simulate payment processing
    if (method === 'invalid') {
        return { success: false, error: 'Invalid payment method' };
    }
    return { success: true, paymentId: `pay_${Date.now()}` };
}

async function createOrder(orderData) {
    // Simulate order creation
    return { id: `order_${Date.now()}`, ...orderData };
}

async function updateInventory(items) {
    // Simulate inventory update
    console.log('Inventory updated for items:', items);
}

async function sendOrderConfirmation(customerId, orderId) {
    // Simulate sending confirmation
    console.log(`Order confirmation sent to customer ${customerId} for order ${orderId}`);
}

// Usage examples
const userRegistration = async () => {
    const userData = {
        username: 'john_doe',
        email: 'john@example.com',
        password: 'SecurePass123'
    };
    
    const result = await businessLogic.registerUser(userData);
    
    return result.fold(
        (user) => ({ success: true, user }),
        (error) => ({ success: false, error })
    );
};

const orderProcessing = async () => {
    const order = {
        items: [{ id: 'item1', quantity: 2 }],
        customerId: 'cust123',
        total: 99.99,
        paymentMethod: 'credit_card'
    };
    
    const result = await businessLogic.processOrder(order);
    
    return result.fold(
        (processedOrder) => ({ success: true, order: processedOrder }),
        (error) => ({ success: false, error })
    );
};

// Test the pipelines
console.log('=== User Registration ===');
userRegistration().then(console.log);

console.log('\n=== Order Processing ===');
orderProcessing().then(console.log);
</code></pre>
</div>

### Example 2: Either/Maybe Monads with Advanced Operations
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced Either and Maybe monads with comprehensive operations
class Either {
    constructor(left, right, isLeft) {
        this.left = left;
        this.right = right;
        this.isLeft = isLeft;
    }
    
    static Left(value) {
        return new Either(value, null, true);
    }
    
    static Right(value) {
        return new Either(null, value, false);
    }
    
    // Functor operations
    map(fn) {
        return this.isLeft 
            ? Either.Left(this.left)
            : Either.Right(fn(this.right));
    }
    
    // Monad operations
    flatMap(fn) {
        return this.isLeft 
            ? Either.Left(this.left)
            : fn(this.right);
    }
    
    // Applicative operations
    ap(other) {
        return this.isLeft 
            ? Either.Left(this.left)
            : other.isLeft 
                ? Either.Left(other.left)
                : Either.Right(this.right(other.right));
    }
    
    // Utility methods
    fold(onLeft, onRight) {
        return this.isLeft ? onLeft(this.left) : onRight(this.right);
    }
    
    getOrElse(defaultValue) {
        return this.isLeft ? defaultValue : this.right;
    }
    
    orElse(fn) {
        return this.isLeft ? fn(this.left) : this;
    }
    
    // Error handling
    tap(fn) {
        if (!this.isLeft) {
            fn(this.right);
        }
        return this;
    }
    
    tapError(fn) {
        if (this.isLeft) {
            fn(this.left);
        }
        return this;
    }
    
    // Conversion
    toMaybe() {
        return this.isLeft ? Maybe.Nothing() : Maybe.Just(this.right);
    }
    
    // Pattern matching
    match(patterns) {
        return this.fold(
            patterns.Left || (() => {}),
            patterns.Right || (() => {})
        );
    }
}

class Maybe {
    constructor(value, isJust) {
        this.value = value;
        this.isJust = isJust;
    }
    
    static Just(value) {
        return new Maybe(value, true);
    }
    
    static Nothing() {
        return new Maybe(null, false);
    }
    
    // Functor operations
    map(fn) {
        return this.isJust 
            ? Maybe.Just(fn(this.value))
            : Maybe.Nothing();
    }
    
    // Monad operations
    flatMap(fn) {
        return this.isJust 
            ? fn(this.value)
            : Maybe.Nothing();
    }
    
    // Applicative operations
    ap(other) {
        return this.isJust && other.isJust
            ? Maybe.Just(this.value(other.value))
            : Maybe.Nothing();
    }
    
    // Utility methods
    getOrElse(defaultValue) {
        return this.isJust ? this.value : defaultValue;
    }
    
    orElse(fn) {
        return this.isJust ? this : fn();
    }
    
    // Safe operations
    filter(predicate) {
        return this.isJust && predicate(this.value)
            ? this
            : Maybe.Nothing();
    }
    
    // Conversion
    toEither(error) {
        return this.isJust 
            ? Either.Right(this.value)
            : Either.Left(error);
    }
    
    // Pattern matching
    match(patterns) {
        return this.isJust
            ? (patterns.Just || (() => {}))(this.value)
            : (patterns.Nothing || (() => {}))();
    }
}

// Utility functions for working with monads
const monadUtils = {
    // Sequence operations
    sequence: (monads) => {
        if (monads.length === 0) {
            return Maybe.Just([]);
        }
        
        return monads.reduce((acc, monad) => 
            acc.flatMap(values => 
                monad.map(value => [...values, value])
            ), Maybe.Just([])
        );
    },
    
    // Traverse operations
    traverse: (fn, monads) => {
        return monadUtils.sequence(monads.map(fn));
    },
    
    // Lift operations
    lift2: (fn) => (ma, mb) => 
        ma.flatMap(a => mb.map(b => fn(a, b))),
    
    lift3: (fn) => (ma, mb, mc) => 
        ma.flatMap(a => 
            mb.flatMap(b => 
                mc.map(c => fn(a, b, c))
            )
        ),
    
    // Safe operations
    safe: (fn) => (...args) => {
        try {
            return Either.Right(fn(...args));
        } catch (error) {
            return Either.Left(error);
        }
    },
    
    safeAsync: (fn) => async (...args) => {
        try {
            const result = await fn(...args);
            return Either.Right(result);
        } catch (error) {
            return Either.Left(error);
        }
    }
};

// Example: User service with monads
class UserService {
    constructor() {
        this.users = new Map();
        this.nextId = 1;
    }
    
    // Create user with validation
    createUser(userData) {
        return Either.Right(userData)
            .flatMap(this.validateUser)
            .flatMap(this.generateId)
            .flatMap(this.saveUser)
            .map(user => ({ ...user, createdAt: new Date() }));
    }
    
    // Validate user data
    validateUser(userData) {
        const validations = [
            this.validateRequired('name', userData.name),
            this.validateRequired('email', userData.email),
            this.validateEmail(userData.email),
            this.validateAge(userData.age)
        ];
        
        // Combine all validations
        const results = validations.map(v => v.toEither());
        const combined = monadUtils.sequence(results);
        
        return combined.map(() => userData);
    }
    
    validateRequired(fieldName, value) {
        return value != null && value !== ''
            ? Maybe.Just(value)
            : Maybe.Nothing();
    }
    
    validateEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
            ? Maybe.Just(email)
            : Maybe.Nothing();
    }
    
    validateAge(age) {
        if (age == null) return Maybe.Just(age); // Optional field
        return age >= 0 && age <= 150
            ? Maybe.Just(age)
            : Maybe.Nothing();
    }
    
    generateId(userData) {
        return Either.Right({ ...userData, id: this.nextId++ });
    }
    
    saveUser(userData) {
        this.users.set(userData.id, userData);
        return Either.Right(userData);
    }
    
    // Get user with error handling
    getUser(id) {
        const user = this.users.get(id);
        return user 
            ? Either.Right(user)
            : Either.Left(`User with id ${id} not found`);
    }
    
    // Update user safely
    updateUser(id, updates) {
        return this.getUser(id)
            .flatMap(user => {
                const updatedUser = { ...user, ...updates };
                return this.validateUser(updatedUser)
                    .flatMap(() => {
                        this.users.set(id, updatedUser);
                        return Either.Right(updatedUser);
                    });
            });
    }
    
    // Delete user
    deleteUser(id) {
        return this.getUser(id)
            .flatMap(user => {
                this.users.delete(id);
                return Either.Right(user);
            });
    }
    
    // Search users with monadic operations
    searchUsers(criteria) {
        const users = Array.from(this.users.values());
        
        return Either.Right(users)
            .map(users => users.filter(user => {
                if (criteria.name && !user.name.includes(criteria.name)) return false;
                if (criteria.email && !user.email.includes(criteria.email)) return false;
                if (criteria.minAge && user.age < criteria.minAge) return false;
                if (criteria.maxAge && user.age > criteria.maxAge) return false;
                return true;
            }))
            .map(users => users.sort((a, b) => a.name.localeCompare(b.name)));
    }
}

// Example: Order processing with monads
class OrderService {
    constructor() {
        this.orders = new Map();
        this.nextOrderId = 1;
    }
    
    // Process order with comprehensive validation
    processOrder(orderData) {
        return Either.Right(orderData)
            .flatMap(this.validateOrder)
            .flatMap(this.checkInventory)
            .flatMap(this.processPayment)
            .flatMap(this.createOrder)
            .flatMap(this.updateInventory)
            .flatMap(this.sendConfirmation);
    }
    
    validateOrder(orderData) {
        const validations = [
            this.validateItems(orderData.items),
            this.validateCustomer(orderData.customerId),
            this.validateAmount(orderData.amount)
        ];
        
        return monadUtils.sequence(validations.map(v => v.toEither()))
            .map(() => orderData);
    }
    
    validateItems(items) {
        return items && items.length > 0
            ? Maybe.Just(items)
            : Maybe.Nothing();
    }
    
    validateCustomer(customerId) {
        return customerId && customerId.length > 0
            ? Maybe.Just(customerId)
            : Maybe.Nothing();
    }
    
    validateAmount(amount) {
        return amount > 0 && amount <= 10000
            ? Maybe.Just(amount)
            : Maybe.Nothing();
    }
    
    checkInventory(orderData) {
        // Simulate inventory check
        const available = orderData.items.every(item => item.id !== 'out-of-stock');
        return available
            ? Either.Right(orderData)
            : Either.Left('Some items are out of stock');
    }
    
    processPayment(orderData) {
        // Simulate payment processing
        if (orderData.paymentMethod === 'invalid') {
            return Either.Left('Invalid payment method');
        }
        
        return Either.Right({
            ...orderData,
            paymentId: `pay_${Date.now()}`,
            status: 'paid'
        });
    }
    
    createOrder(orderData) {
        const order = {
            id: this.nextOrderId++,
            ...orderData,
            createdAt: new Date()
        };
        
        this.orders.set(order.id, order);
        return Either.Right(order);
    }
    
    updateInventory(orderData) {
        // Simulate inventory update
        console.log('Inventory updated for order:', orderData.id);
        return Either.Right(orderData);
    }
    
    sendConfirmation(orderData) {
        // Simulate sending confirmation
        console.log(`Confirmation sent for order ${orderData.id}`);
        return Either.Right(orderData);
    }
}

// Usage examples
const userService = new UserService();
const orderService = new OrderService();

// Create user with monadic operations
const createUserResult = userService.createUser({
    name: 'John Doe',
    email: 'john@example.com',
    age: 30
});

createUserResult.fold(
    error => console.error('User creation failed:', error),
    user => console.log('User created:', user)
);

// Process order with monadic operations
const orderResult = orderService.processOrder({
    items: [{ id: 'item1', quantity: 2 }],
    customerId: 'cust123',
    amount: 99.99,
    paymentMethod: 'credit_card'
});

orderResult.fold(
    error => console.error('Order processing failed:', error),
    order => console.log('Order processed:', order)
);

// Search users with monadic operations
const searchResult = userService.searchUsers({
    name: 'John',
    minAge: 25
});

searchResult.fold(
    error => console.error('Search failed:', error),
    users => console.log('Search results:', users)
);
</code></pre>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="01-Design-Patterns-Advanced.md" class="nav-link prev">← Previous: Advanced Design Patterns</a>
    <a href="03-Architecture-Patterns.md" class="nav-link next">Next: Architecture Patterns →</a>
</div>

*Last updated: December 2024*
