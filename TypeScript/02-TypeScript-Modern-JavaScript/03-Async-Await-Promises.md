# ⚡ **Async/Await & Promises**

> **Complete guide to asynchronous programming in TypeScript with Promises, async/await, error handling, and advanced patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Promise Fundamentals](#promise-fundamentals)
- [Async/Await Syntax](#asyncawait-syntax)
- [Error Handling](#error-handling)
- [Promise Combinators](#promise-combinators)
- [Advanced Async Patterns](#advanced-async-patterns)
- [TypeScript Specific Features](#typescript-specific-features)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Promise Fundamentals**

Promises provide a way to handle asynchronous operations with better error handling and composition.

### **Basic Promise Syntax**

```typescript
// Creating a Promise
const fetchUser = (id: number): Promise<User> => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (id > 0) {
        resolve({ id, name: "John Doe", email: "john@example.com" });
      } else {
        reject(new Error("Invalid user ID"));
      }
    }, 1000);
  });
};

// Promise with explicit types
const processData = (data: string): Promise<ProcessedData> => {
  return new Promise<ProcessedData>((resolve, reject) => {
    try {
      const processed = JSON.parse(data);
      resolve(processed);
    } catch (error) {
      reject(error);
    }
  });
};
```

### **Promise States and Methods**

```typescript
// Promise states: pending, fulfilled, rejected
const promise = fetchUser(1);

// Promise methods
promise
  .then((user: User) => {
    console.log("User:", user);
    return user.name;
  })
  .then((name: string) => {
    console.log("Name:", name);
  })
  .catch((error: Error) => {
    console.error("Error:", error.message);
  })
  .finally(() => {
    console.log("Promise completed");
  });
```

### **Promise with TypeScript Generics**

```typescript
// Generic Promise type
const createPromise = <T>(value: T, delay: number = 1000): Promise<T> => {
  return new Promise<T>((resolve) => {
    setTimeout(() => resolve(value), delay);
  });
};

// Usage
const stringPromise = createPromise<string>("Hello", 500);
const numberPromise = createPromise<number>(42, 1000);
const userPromise = createPromise<User>({ id: 1, name: "John", email: "john@example.com" });
```

---

## 🔄 **Async/Await Syntax**

Async/await provides a more readable way to work with Promises.

### **Basic Async/Await**

```typescript
// Async function
const getUserInfo = async (id: number): Promise<string> => {
  try {
    const user: User = await fetchUser(id);
    return `User: ${user.name}, Email: ${user.email}`;
  } catch (error) {
    return `Error: ${(error as Error).message}`;
  }
};

// Async function with multiple awaits
const processUserData = async (id: number): Promise<ProcessedUser> => {
  const user: User = await fetchUser(id);
  const profile: UserProfile = await fetchUserProfile(user.id);
  const settings: UserSettings = await fetchUserSettings(user.id);
  
  return {
    ...user,
    profile,
    settings
  };
};
```

### **Async Function Types**

```typescript
// Async function type
type AsyncFunction<T, R> = (param: T) => Promise<R>;

// Async function with generic return type
const fetchData = async <T>(url: string): Promise<T> => {
  const response = await fetch(url);
  return response.json();
};

// Usage
const userData = await fetchData<User>("/api/users/1");
const productData = await fetchData<Product[]>("/api/products");
```

### **Async Arrow Functions**

```typescript
// Async arrow function
const processData = async (data: string): Promise<ProcessedData> => {
  const parsed = JSON.parse(data);
  const validated = await validateData(parsed);
  return transformData(validated);
};

// Async arrow function with implicit return
const getCurrentTime = async (): Promise<string> => 
  new Date().toISOString();

// Async arrow function in array methods
const processUsers = async (userIds: number[]): Promise<User[]> => {
  const users = await Promise.all(
    userIds.map(async (id: number) => await fetchUser(id))
  );
  return users;
};
```

---

## 🛡️ **Error Handling**

Proper error handling is crucial for robust asynchronous code.

### **Try/Catch with Async/Await**

```typescript
// Basic error handling
const safeFetchUser = async (id: number): Promise<User | null> => {
  try {
    const user: User = await fetchUser(id);
    return user;
  } catch (error) {
    console.error("Failed to fetch user:", error);
    return null;
  }
};

// Error handling with custom error types
class UserNotFoundError extends Error {
  constructor(userId: number) {
    super(`User with ID ${userId} not found`);
    this.name = "UserNotFoundError";
  }
}

const fetchUserWithCustomError = async (id: number): Promise<User> => {
  try {
    const user: User = await fetchUser(id);
    if (!user) {
      throw new UserNotFoundError(id);
    }
    return user;
  } catch (error) {
    if (error instanceof UserNotFoundError) {
      throw error;
    }
    throw new Error(`Unexpected error: ${(error as Error).message}`);
  }
};
```

### **Promise Error Handling**

```typescript
// Promise with error handling
const fetchUserWithPromise = (id: number): Promise<User> => {
  return fetchUser(id)
    .then((user: User) => {
      if (!user) {
        throw new UserNotFoundError(id);
      }
      return user;
    })
    .catch((error: Error) => {
      if (error instanceof UserNotFoundError) {
        throw error;
      }
      throw new Error(`Unexpected error: ${error.message}`);
    });
};

// Promise with multiple error handlers
const complexAsyncOperation = (): Promise<string> => {
  return fetchUser(1)
    .then((user: User) => fetchUserProfile(user.id))
    .then((profile: UserProfile) => processProfile(profile))
    .catch((error: Error) => {
      console.error("Error in complex operation:", error);
      throw error;
    });
};
```

---

## 🔗 **Promise Combinators**

Promise combinators allow you to work with multiple Promises efficiently.

### **Promise.all**

```typescript
// Promise.all - wait for all promises to resolve
const fetchAllUsers = async (ids: number[]): Promise<User[]> => {
  const promises: Promise<User>[] = ids.map(id => fetchUser(id));
  return Promise.all(promises);
};

// Promise.all with error handling
const fetchAllUsersSafely = async (ids: number[]): Promise<(User | Error)[]> => {
  const promises: Promise<User>[] = ids.map(id => 
    fetchUser(id).catch(error => error)
  );
  return Promise.all(promises);
};

// Usage
const users = await fetchAllUsers([1, 2, 3, 4, 5]);
const safeUsers = await fetchAllUsersSafely([1, 2, 3, 4, 5]);
```

### **Promise.allSettled**

```typescript
// Promise.allSettled - wait for all promises to settle
const fetchUsersWithStatus = async (ids: number[]): Promise<PromiseSettledResult<User>[]> => {
  const promises: Promise<User>[] = ids.map(id => fetchUser(id));
  return Promise.allSettled(promises);
};

// Usage
const results = await fetchUsersWithStatus([1, 2, 3, 4, 5]);
results.forEach((result, index) => {
  if (result.status === "fulfilled") {
    console.log(`User ${index + 1}:`, result.value);
  } else {
    console.error(`User ${index + 1} failed:`, result.reason);
  }
});
```

### **Promise.race**

```typescript
// Promise.race - first promise to settle wins
const fetchUserWithTimeout = async (id: number, timeout: number = 5000): Promise<User> => {
  const timeoutPromise = new Promise<never>((_, reject) => {
    setTimeout(() => reject(new Error("Request timeout")), timeout);
  });

  const userPromise = fetchUser(id);

  return Promise.race([userPromise, timeoutPromise]);
};

// Usage
try {
  const user = await fetchUserWithTimeout(1, 3000);
  console.log("User:", user);
} catch (error) {
  console.error("Error:", error);
}
```

### **Promise.any**

```typescript
// Promise.any - first promise to fulfill wins
const fetchUserFromMultipleSources = async (id: number): Promise<User> => {
  const sources = [
    fetchUserFromAPI(id),
    fetchUserFromCache(id),
    fetchUserFromDatabase(id)
  ];

  return Promise.any(sources);
};

// Usage
try {
  const user = await fetchUserFromMultipleSources(1);
  console.log("User found:", user);
} catch (error) {
  console.error("All sources failed:", error);
}
```

---

## 🚀 **Advanced Async Patterns**

### **Retry Logic**

```typescript
// Retry with exponential backoff
const fetchUserWithRetry = async (
  id: number, 
  maxRetries: number = 3,
  baseDelay: number = 1000
): Promise<User> => {
  let lastError: Error;

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fetchUser(id);
    } catch (error) {
      lastError = error as Error;
      
      if (attempt === maxRetries) {
        throw lastError;
      }

      // Exponential backoff
      const delay = baseDelay * Math.pow(2, attempt - 1);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }

  throw lastError!;
};
```

### **Circuit Breaker Pattern**

```typescript
// Circuit breaker implementation
class CircuitBreaker {
  private failureCount = 0;
  private lastFailureTime = 0;
  private state: "CLOSED" | "OPEN" | "HALF_OPEN" = "CLOSED";

  constructor(
    private threshold: number = 5,
    private timeout: number = 60000
  ) {}

  async execute<T>(operation: () => Promise<T>): Promise<T> {
    if (this.state === "OPEN") {
      if (Date.now() - this.lastFailureTime > this.timeout) {
        this.state = "HALF_OPEN";
      } else {
        throw new Error("Circuit breaker is OPEN");
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
    this.state = "CLOSED";
  }

  private onFailure(): void {
    this.failureCount++;
    this.lastFailureTime = Date.now();
    
    if (this.failureCount >= this.threshold) {
      this.state = "OPEN";
    }
  }
}

// Usage
const circuitBreaker = new CircuitBreaker();
const user = await circuitBreaker.execute(() => fetchUser(1));
```

### **Async Queue**

```typescript
// Async queue implementation
class AsyncQueue<T> {
  private queue: T[] = [];
  private processing = false;

  async enqueue(item: T): Promise<void> {
    this.queue.push(item);
    if (!this.processing) {
      await this.process();
    }
  }

  private async process(): Promise<void> {
    this.processing = true;
    
    while (this.queue.length > 0) {
      const item = this.queue.shift()!;
      try {
        await this.processItem(item);
      } catch (error) {
        console.error("Error processing item:", error);
      }
    }
    
    this.processing = false;
  }

  private async processItem(item: T): Promise<void> {
    // Process the item
    console.log("Processing:", item);
  }
}
```

---

## 🎭 **TypeScript Specific Features**

### **Async Function Return Types**

```typescript
// Explicit return types for async functions
const fetchUserData = async (id: number): Promise<User> => {
  const user = await fetchUser(id);
  return user;
};

// Async function returning void
const logUser = async (id: number): Promise<void> => {
  const user = await fetchUser(id);
  console.log(user);
};

// Async function with union return type
const fetchUserOrNull = async (id: number): Promise<User | null> => {
  try {
    return await fetchUser(id);
  } catch {
    return null;
  }
};
```

### **Generic Async Functions**

```typescript
// Generic async function
const fetchData = async <T>(url: string): Promise<T> => {
  const response = await fetch(url);
  return response.json();
};

// Generic async function with constraints
const fetchEntity = async <T extends { id: number }>(
  id: number,
  endpoint: string
): Promise<T> => {
  const response = await fetch(`${endpoint}/${id}`);
  return response.json();
};

// Usage
const user = await fetchEntity<User>("/api/users");
const product = await fetchEntity<Product>("/api/products");
```

### **Async Iterators**

```typescript
// Async iterator for processing data in chunks
async function* processUsersInBatches(userIds: number[]): AsyncGenerator<User, void, unknown> {
  const batchSize = 10;
  
  for (let i = 0; i < userIds.length; i += batchSize) {
    const batch = userIds.slice(i, i + batchSize);
    const users = await Promise.all(batch.map(id => fetchUser(id)));
    
    for (const user of users) {
      yield user;
    }
  }
}

// Usage
for await (const user of processUsersInBatches([1, 2, 3, 4, 5])) {
  console.log("Processing user:", user);
}
```

---

## ✅ **Best Practices**

### **1. Use Async/Await for Better Readability**

```typescript
// ✅ Good: Async/await
const processUser = async (id: number): Promise<void> => {
  try {
    const user = await fetchUser(id);
    const profile = await fetchUserProfile(user.id);
    console.log(profile);
  } catch (error) {
    console.error(error);
  }
};

// ❌ Avoid: Promise chains for complex logic
const processUser = (id: number): Promise<void> => {
  return fetchUser(id)
    .then(user => fetchUserProfile(user.id))
    .then(profile => console.log(profile))
    .catch(error => console.error(error));
};
```

### **2. Handle Errors Appropriately**

```typescript
// ✅ Good: Specific error handling
const fetchUserSafely = async (id: number): Promise<User | null> => {
  try {
    return await fetchUser(id);
  } catch (error) {
    if (error instanceof UserNotFoundError) {
      return null;
    }
    throw error;
  }
};

// ❌ Avoid: Generic error handling
const fetchUserSafely = async (id: number): Promise<User | null> => {
  try {
    return await fetchUser(id);
  } catch {
    return null; // Loses error information
  }
};
```

### **3. Use Promise Combinators for Multiple Operations**

```typescript
// ✅ Good: Promise.all for parallel operations
const fetchUserData = async (id: number): Promise<UserData> => {
  const [user, profile, settings] = await Promise.all([
    fetchUser(id),
    fetchUserProfile(id),
    fetchUserSettings(id)
  ]);
  
  return { user, profile, settings };
};

// ❌ Avoid: Sequential awaits for independent operations
const fetchUserData = async (id: number): Promise<UserData> => {
  const user = await fetchUser(id);
  const profile = await fetchUserProfile(id);
  const settings = await fetchUserSettings(id);
  
  return { user, profile, settings };
};
```

---

## ❓ **Common Interview Questions**

### **1. What's the difference between Promises and async/await?**

**Answer:**
- **Promises**: Use `.then()` and `.catch()` methods, can be chained
- **Async/await**: Syntactic sugar over Promises, more readable, uses try/catch

```typescript
// Promise
fetchUser(1).then(user => console.log(user)).catch(error => console.error(error));

// Async/await
try {
  const user = await fetchUser(1);
  console.log(user);
} catch (error) {
  console.error(error);
}
```

### **2. How do you handle errors in async/await?**

**Answer:**
Use try/catch blocks:

```typescript
const fetchUser = async (id: number): Promise<User> => {
  try {
    const user = await apiCall(id);
    return user;
  } catch (error) {
    console.error("Error fetching user:", error);
    throw error;
  }
};
```

### **3. What are Promise combinators and when do you use them?**

**Answer:**
- **Promise.all**: Wait for all promises to resolve
- **Promise.allSettled**: Wait for all promises to settle
- **Promise.race**: First promise to settle wins
- **Promise.any**: First promise to fulfill wins

### **4. How do you implement retry logic with async/await?**

**Answer:**
Use a loop with exponential backoff:

```typescript
const fetchWithRetry = async (url: string, maxRetries: number = 3): Promise<Response> => {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fetch(url);
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      await new Promise(resolve => setTimeout(resolve, 1000 * Math.pow(2, i)));
    }
  }
};
```

### **5. What's the difference between Promise.all and Promise.allSettled?**

**Answer:**
- **Promise.all**: Fails fast if any promise rejects
- **Promise.allSettled**: Waits for all promises to settle, returns results for both fulfilled and rejected promises

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Modules-Imports.md" class="nav-button">← Previous: Modules & Imports</a>
  <a href="04-Decorators-Metadata.md" class="nav-button">Next: Decorators & Metadata →</a>
</div>

*Last updated: December 2024*
