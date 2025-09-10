# 🧪 **Unit Testing with TypeScript**

> **Complete guide to unit testing TypeScript applications with Jest, testing patterns, and best practices**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Testing Setup](#testing-setup)
- [Jest Configuration](#jest-configuration)
- [Basic Testing Patterns](#basic-testing-patterns)
- [Mocking and Stubbing](#mocking-and-stubbing)
- [Async Testing](#async-testing)
- [Advanced Testing Patterns](#advanced-testing-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Testing Setup**

Setting up unit testing for TypeScript applications requires proper configuration and understanding of testing frameworks.

### **Basic Setup**


```bash
# Install testing dependencies
npm install --save-dev jest @types/jest ts-jest
npm install --save-dev @testing-library/jest-dom
npm install --save-dev @testing-library/react @testing-library/user-event

# For Node.js testing
npm install --save-dev supertest @types/supertest

# For React testing
npm install --save-dev @testing-library/react @testing-library/user-event
```


### **Package.json Scripts**


```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:ci": "jest --ci --coverage --watchAll=false"
  }
}
```


### **Basic Jest Configuration**


```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  transform: {
    '^.+\\.ts$': 'ts-jest',
  },
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
    '!src/**/index.ts',
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts'],
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
};
```


---

## ⚙️ **Jest Configuration**

### **Advanced Jest Configuration**


```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  transform: {
    '^.+\\.ts$': 'ts-jest',
  },
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
    '!src/**/index.ts',
    '!src/**/__tests__/**',
    '!src/**/__mocks__/**',
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html', 'json'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts'],
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
  testTimeout: 10000,
  clearMocks: true,
  restoreMocks: true,
  resetMocks: true,
};
```


### **TypeScript Configuration for Testing**


```json
// tsconfig.test.json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "types": ["jest", "node"],
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true
  },
  "include": [
    "src/**/*",
    "src/**/__tests__/**/*",
    "src/**/*.test.ts",
    "src/**/*.spec.ts"
  ]
}
```


### **Setup Files**


```typescript
// src/setupTests.ts
import '@testing-library/jest-dom';

// Global test setup
beforeEach(() => {
  // Reset mocks before each test
  jest.clearAllMocks();
});

// Global test teardown
afterEach(() => {
  // Cleanup after each test
});

// Global test timeout
jest.setTimeout(10000);
```


---

## 🧪 **Basic Testing Patterns**

### **Function Testing**


```typescript
// src/utils/math.ts
export const add = (a: number, b: number): number => a + b;

export const divide = (a: number, b: number): number => {
  if (b === 0) {
    throw new Error('Division by zero');
  }
  return a / b;
};

export const isEven = (n: number): boolean => n % 2 === 0;

// src/utils/__tests__/math.test.ts
import { add, divide, isEven } from '../math';

describe('Math Utils', () => {
  describe('add', () => {
    it('should add two positive numbers', () => {
      expect(add(2, 3)).toBe(5);
    });

    it('should add negative numbers', () => {
      expect(add(-2, -3)).toBe(-5);
    });

    it('should add positive and negative numbers', () => {
      expect(add(5, -3)).toBe(2);
    });

    it('should handle zero', () => {
      expect(add(0, 5)).toBe(5);
      expect(add(5, 0)).toBe(5);
    });
  });

  describe('divide', () => {
    it('should divide two positive numbers', () => {
      expect(divide(10, 2)).toBe(5);
    });

    it('should divide negative numbers', () => {
      expect(divide(-10, -2)).toBe(5);
    });

    it('should throw error when dividing by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division by zero');
    });

    it('should handle decimal results', () => {
      expect(divide(7, 3)).toBeCloseTo(2.33, 2);
    });
  });

  describe('isEven', () => {
    it('should return true for even numbers', () => {
      expect(isEven(2)).toBe(true);
      expect(isEven(4)).toBe(true);
      expect(isEven(100)).toBe(true);
    });

    it('should return false for odd numbers', () => {
      expect(isEven(1)).toBe(false);
      expect(isEven(3)).toBe(false);
      expect(isEven(99)).toBe(false);
    });

    it('should handle zero', () => {
      expect(isEven(0)).toBe(true);
    });
  });
});
```


### **Class Testing**


```typescript
// src/models/User.ts
export class User {
  constructor(
    public id: number,
    public name: string,
    public email: string,
    public age: number
  ) {}

  get isAdult(): boolean {
    return this.age >= 18;
  }

  get displayName(): string {
    return `${this.name} (${this.email})`;
  }

  updateProfile(updates: Partial<Pick<User, 'name' | 'email' | 'age'>>): void {
    if (updates.name) this.name = updates.name;
    if (updates.email) this.email = updates.email;
    if (updates.age) this.age = updates.age;
  }

  validate(): string[] {
    const errors: string[] = [];
    
    if (!this.name || this.name.trim().length === 0) {
      errors.push('Name is required');
    }
    
    if (!this.email || !this.email.includes('@')) {
      errors.push('Valid email is required');
    }
    
    if (this.age < 0 || this.age > 150) {
      errors.push('Age must be between 0 and 150');
    }
    
    return errors;
  }
}

// src/models/__tests__/User.test.ts
import { User } from '../User';

describe('User', () => {
  let user: User;

  beforeEach(() => {
    user = new User(1, 'John Doe', 'john@example.com', 30);
  });

  describe('constructor', () => {
    it('should create a user with provided values', () => {
      expect(user.id).toBe(1);
      expect(user.name).toBe('John Doe');
      expect(user.email).toBe('john@example.com');
      expect(user.age).toBe(30);
    });
  });

  describe('isAdult', () => {
    it('should return true for users 18 and older', () => {
      user.age = 18;
      expect(user.isAdult).toBe(true);
      
      user.age = 25;
      expect(user.isAdult).toBe(true);
    });

    it('should return false for users under 18', () => {
      user.age = 17;
      expect(user.isAdult).toBe(false);
      
      user.age = 10;
      expect(user.isAdult).toBe(false);
    });
  });

  describe('displayName', () => {
    it('should return formatted display name', () => {
      expect(user.displayName).toBe('John Doe (john@example.com)');
    });
  });

  describe('updateProfile', () => {
    it('should update name', () => {
      user.updateProfile({ name: 'Jane Doe' });
      expect(user.name).toBe('Jane Doe');
    });

    it('should update email', () => {
      user.updateProfile({ email: 'jane@example.com' });
      expect(user.email).toBe('jane@example.com');
    });

    it('should update age', () => {
      user.updateProfile({ age: 25 });
      expect(user.age).toBe(25);
    });

    it('should update multiple fields', () => {
      user.updateProfile({ 
        name: 'Jane Doe', 
        email: 'jane@example.com',
        age: 25 
      });
      expect(user.name).toBe('Jane Doe');
      expect(user.email).toBe('jane@example.com');
      expect(user.age).toBe(25);
    });
  });

  describe('validate', () => {
    it('should return no errors for valid user', () => {
      const errors = user.validate();
      expect(errors).toHaveLength(0);
    });

    it('should return error for empty name', () => {
      user.name = '';
      const errors = user.validate();
      expect(errors).toContain('Name is required');
    });

    it('should return error for invalid email', () => {
      user.email = 'invalid-email';
      const errors = user.validate();
      expect(errors).toContain('Valid email is required');
    });

    it('should return error for invalid age', () => {
      user.age = -1;
      const errors = user.validate();
      expect(errors).toContain('Age must be between 0 and 150');
      
      user.age = 151;
      const errors2 = user.validate();
      expect(errors2).toContain('Age must be between 0 and 150');
    });

    it('should return multiple errors', () => {
      user.name = '';
      user.email = 'invalid';
      user.age = -1;
      
      const errors = user.validate();
      expect(errors).toHaveLength(3);
    });
  });
});
```


---

## 🎭 **Mocking and Stubbing**

### **Basic Mocking**


```typescript
// src/services/UserService.ts
export class UserService {
  constructor(private apiClient: ApiClient) {}

  async getUser(id: number): Promise<User> {
    const response = await this.apiClient.get(`/users/${id}`);
    return response.data;
  }

  async createUser(userData: CreateUserRequest): Promise<User> {
    const response = await this.apiClient.post('/users', userData);
    return response.data;
  }

  async updateUser(id: number, userData: UpdateUserRequest): Promise<User> {
    const response = await this.apiClient.put(`/users/${id}`, userData);
    return response.data;
  }

  async deleteUser(id: number): Promise<void> {
    await this.apiClient.delete(`/users/${id}`);
  }
}

// src/services/__tests__/UserService.test.ts
import { UserService } from '../UserService';
import { ApiClient } from '../ApiClient';

// Mock the ApiClient
jest.mock('../ApiClient');

describe('UserService', () => {
  let userService: UserService;
  let mockApiClient: jest.Mocked<ApiClient>;

  beforeEach(() => {
    mockApiClient = new ApiClient() as jest.Mocked<ApiClient>;
    userService = new UserService(mockApiClient);
  });

  describe('getUser', () => {
    it('should return user data', async () => {
      const mockUser = { id: 1, name: 'John Doe', email: 'john@example.com' };
      mockApiClient.get.mockResolvedValue({ data: mockUser });

      const result = await userService.getUser(1);

      expect(mockApiClient.get).toHaveBeenCalledWith('/users/1');
      expect(result).toEqual(mockUser);
    });

    it('should throw error when API call fails', async () => {
      const error = new Error('API Error');
      mockApiClient.get.mockRejectedValue(error);

      await expect(userService.getUser(1)).rejects.toThrow('API Error');
    });
  });

  describe('createUser', () => {
    it('should create user and return user data', async () => {
      const userData = { name: 'John Doe', email: 'john@example.com' };
      const mockUser = { id: 1, ...userData };
      mockApiClient.post.mockResolvedValue({ data: mockUser });

      const result = await userService.createUser(userData);

      expect(mockApiClient.post).toHaveBeenCalledWith('/users', userData);
      expect(result).toEqual(mockUser);
    });
  });
});
```


### **Advanced Mocking**


```typescript
// src/utils/__tests__/dateUtils.test.ts
import { formatDate, parseDate, isWeekend } from '../dateUtils';

// Mock Date.now()
const mockDate = new Date('2023-01-15T10:30:00Z');
jest.spyOn(global, 'Date').mockImplementation(() => mockDate);

describe('Date Utils', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  afterAll(() => {
    jest.restoreAllMocks();
  });

  describe('formatDate', () => {
    it('should format date correctly', () => {
      const date = new Date('2023-01-15T10:30:00Z');
      const formatted = formatDate(date, 'YYYY-MM-DD');
      expect(formatted).toBe('2023-01-15');
    });
  });

  describe('isWeekend', () => {
    it('should return true for Saturday', () => {
      const saturday = new Date('2023-01-14'); // Saturday
      expect(isWeekend(saturday)).toBe(true);
    });

    it('should return true for Sunday', () => {
      const sunday = new Date('2023-01-15'); // Sunday
      expect(isWeekend(sunday)).toBe(true);
    });

    it('should return false for weekday', () => {
      const monday = new Date('2023-01-16'); // Monday
      expect(isWeekend(monday)).toBe(false);
    });
  });
});
```


### **Module Mocking**


```typescript
// src/services/__tests__/EmailService.test.ts
import { EmailService } from '../EmailService';

// Mock the email module
jest.mock('nodemailer', () => ({
  createTransport: jest.fn(() => ({
    sendMail: jest.fn(),
  })),
}));

describe('EmailService', () => {
  let emailService: EmailService;

  beforeEach(() => {
    emailService = new EmailService();
  });

  it('should send email successfully', async () => {
    const mockSendMail = jest.fn().mockResolvedValue({ messageId: '123' });
    const nodemailer = require('nodemailer');
    nodemailer.createTransport().sendMail = mockSendMail;

    const result = await emailService.sendEmail({
      to: 'test@example.com',
      subject: 'Test',
      body: 'Test message'
    });

    expect(mockSendMail).toHaveBeenCalledWith({
      to: 'test@example.com',
      subject: 'Test',
      body: 'Test message'
    });
    expect(result.success).toBe(true);
  });
});
```


---

## ⚡ **Async Testing**

### **Promise Testing**


```typescript
// src/services/__tests__/ApiService.test.ts
import { ApiService } from '../ApiService';

describe('ApiService', () => {
  let apiService: ApiService;

  beforeEach(() => {
    apiService = new ApiService();
  });

  describe('fetchData', () => {
    it('should resolve with data when API call succeeds', async () => {
      const mockData = { id: 1, name: 'Test' };
      jest.spyOn(global, 'fetch').mockResolvedValue({
        ok: true,
        json: () => Promise.resolve(mockData),
      } as Response);

      const result = await apiService.fetchData('/api/test');

      expect(result).toEqual(mockData);
    });

    it('should reject with error when API call fails', async () => {
      jest.spyOn(global, 'fetch').mockRejectedValue(new Error('Network error'));

      await expect(apiService.fetchData('/api/test')).rejects.toThrow('Network error');
    });

    it('should handle timeout', async () => {
      jest.spyOn(global, 'fetch').mockImplementation(() => 
        new Promise((_, reject) => 
          setTimeout(() => reject(new Error('Timeout')), 100)
        )
      );

      await expect(apiService.fetchData('/api/test')).rejects.toThrow('Timeout');
    });
  });
});
```


### **Callback Testing**


```typescript
// src/utils/__tests__/asyncUtils.test.ts
import { retry, delay, timeout } from '../asyncUtils';

describe('Async Utils', () => {
  describe('retry', () => {
    it('should retry failed operations', async () => {
      let attempts = 0;
      const mockFunction = jest.fn().mockImplementation(() => {
        attempts++;
        if (attempts < 3) {
          throw new Error('Temporary failure');
        }
        return 'success';
      });

      const result = await retry(mockFunction, 3, 100);

      expect(result).toBe('success');
      expect(mockFunction).toHaveBeenCalledTimes(3);
    });

    it('should fail after max retries', async () => {
      const mockFunction = jest.fn().mockRejectedValue(new Error('Persistent failure'));

      await expect(retry(mockFunction, 3, 100)).rejects.toThrow('Persistent failure');
      expect(mockFunction).toHaveBeenCalledTimes(3);
    });
  });

  describe('timeout', () => {
    it('should resolve before timeout', async () => {
      const promise = Promise.resolve('success');
      const result = await timeout(promise, 1000);
      expect(result).toBe('success');
    });

    it('should reject after timeout', async () => {
      const promise = new Promise(resolve => setTimeout(resolve, 2000));
      await expect(timeout(promise, 1000)).rejects.toThrow('Timeout');
    });
  });
});
```


---

## 🚀 **Advanced Testing Patterns**

### **Test Doubles and Spies**


```typescript
// src/services/__tests__/OrderService.test.ts
import { OrderService } from '../OrderService';
import { PaymentService } from '../PaymentService';
import { InventoryService } from '../InventoryService';
import { NotificationService } from '../NotificationService';

describe('OrderService', () => {
  let orderService: OrderService;
  let mockPaymentService: jest.Mocked<PaymentService>;
  let mockInventoryService: jest.Mocked<InventoryService>;
  let mockNotificationService: jest.Mocked<NotificationService>;

  beforeEach(() => {
    mockPaymentService = {
      processPayment: jest.fn(),
      refundPayment: jest.fn(),
    } as jest.Mocked<PaymentService>;

    mockInventoryService = {
      checkStock: jest.fn(),
      reserveItems: jest.fn(),
      releaseItems: jest.fn(),
    } as jest.Mocked<InventoryService>;

    mockNotificationService = {
      sendOrderConfirmation: jest.fn(),
      sendOrderUpdate: jest.fn(),
    } as jest.Mocked<NotificationService>;

    orderService = new OrderService(
      mockPaymentService,
      mockInventoryService,
      mockNotificationService
    );
  });

  describe('processOrder', () => {
    it('should process order successfully', async () => {
      const order = {
        id: 1,
        items: [{ id: 1, quantity: 2 }],
        total: 100,
        customerId: 1,
      };

      mockInventoryService.checkStock.mockResolvedValue(true);
      mockInventoryService.reserveItems.mockResolvedValue(undefined);
      mockPaymentService.processPayment.mockResolvedValue({ success: true, transactionId: '123' });
      mockNotificationService.sendOrderConfirmation.mockResolvedValue(undefined);

      const result = await orderService.processOrder(order);

      expect(mockInventoryService.checkStock).toHaveBeenCalledWith(order.items);
      expect(mockInventoryService.reserveItems).toHaveBeenCalledWith(order.items);
      expect(mockPaymentService.processPayment).toHaveBeenCalledWith(order.total, order.customerId);
      expect(mockNotificationService.sendOrderConfirmation).toHaveBeenCalledWith(order);
      expect(result.success).toBe(true);
    });

    it('should handle insufficient stock', async () => {
      const order = {
        id: 1,
        items: [{ id: 1, quantity: 2 }],
        total: 100,
        customerId: 1,
      };

      mockInventoryService.checkStock.mockResolvedValue(false);

      const result = await orderService.processOrder(order);

      expect(result.success).toBe(false);
      expect(result.error).toBe('Insufficient stock');
      expect(mockPaymentService.processPayment).not.toHaveBeenCalled();
    });

    it('should handle payment failure', async () => {
      const order = {
        id: 1,
        items: [{ id: 1, quantity: 2 }],
        total: 100,
        customerId: 1,
      };

      mockInventoryService.checkStock.mockResolvedValue(true);
      mockInventoryService.reserveItems.mockResolvedValue(undefined);
      mockPaymentService.processPayment.mockResolvedValue({ success: false, error: 'Payment failed' });
      mockInventoryService.releaseItems.mockResolvedValue(undefined);

      const result = await orderService.processOrder(order);

      expect(result.success).toBe(false);
      expect(result.error).toBe('Payment failed');
      expect(mockInventoryService.releaseItems).toHaveBeenCalledWith(order.items);
    });
  });
});
```


### **Integration Testing**


```typescript
// src/__tests__/integration/userIntegration.test.ts
import request from 'supertest';
import { app } from '../../app';
import { connectDB, disconnectDB } from '../../config/database';

describe('User Integration Tests', () => {
  beforeAll(async () => {
    await connectDB();
  });

  afterAll(async () => {
    await disconnectDB();
  });

  describe('POST /users', () => {
    it('should create a new user', async () => {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        age: 30,
      };

      const response = await request(app)
        .post('/users')
        .send(userData)
        .expect(201);

      expect(response.body).toMatchObject({
        id: expect.any(Number),
        name: userData.name,
        email: userData.email,
        age: userData.age,
      });
    });

    it('should return validation error for invalid data', async () => {
      const invalidData = {
        name: '',
        email: 'invalid-email',
        age: -1,
      };

      const response = await request(app)
        .post('/users')
        .send(invalidData)
        .expect(400);

      expect(response.body.errors).toContain('Name is required');
      expect(response.body.errors).toContain('Valid email is required');
      expect(response.body.errors).toContain('Age must be positive');
    });
  });

  describe('GET /users/:id', () => {
    it('should return user by id', async () => {
      const userData = {
        name: 'Jane Doe',
        email: 'jane@example.com',
        age: 25,
      };

      const createResponse = await request(app)
        .post('/users')
        .send(userData);

      const userId = createResponse.body.id;

      const response = await request(app)
        .get(`/users/${userId}`)
        .expect(200);

      expect(response.body).toMatchObject(userData);
    });

    it('should return 404 for non-existent user', async () => {
      await request(app)
        .get('/users/99999')
        .expect(404);
    });
  });
});
```


---

## ✅ **Best Practices**

### **1. Use Descriptive Test Names**


```typescript
// ✅ Good: Descriptive test names
describe('UserService', () => {
  describe('getUser', () => {
    it('should return user data when user exists', () => {
      // Test implementation
    });

    it('should throw error when user does not exist', () => {
      // Test implementation
    });

    it('should handle network errors gracefully', () => {
      // Test implementation
    });
  });
});

// ❌ Avoid: Vague test names
describe('UserService', () => {
  describe('getUser', () => {
    it('should work', () => {
      // Test implementation
    });

    it('should handle error', () => {
      // Test implementation
    });
  });
});
```


### **2. Use Arrange-Act-Assert Pattern**


```typescript
// ✅ Good: AAA pattern
it('should calculate total price correctly', () => {
  // Arrange
  const items = [
    { price: 10, quantity: 2 },
    { price: 5, quantity: 3 },
  ];
  const expectedTotal = 35;

  // Act
  const actualTotal = calculateTotal(items);

  // Assert
  expect(actualTotal).toBe(expectedTotal);
});

// ❌ Avoid: Mixed concerns
it('should calculate total price correctly', () => {
  const items = [{ price: 10, quantity: 2 }, { price: 5, quantity: 3 }];
  expect(calculateTotal(items)).toBe(35);
});
```


### **3. Use Proper Mocking**


```typescript
// ✅ Good: Proper mocking
describe('UserService', () => {
  let userService: UserService;
  let mockApiClient: jest.Mocked<ApiClient>;

  beforeEach(() => {
    mockApiClient = new ApiClient() as jest.Mocked<ApiClient>;
    userService = new UserService(mockApiClient);
  });

  it('should fetch user data', async () => {
    const mockUser = { id: 1, name: 'John' };
    mockApiClient.get.mockResolvedValue({ data: mockUser });

    const result = await userService.getUser(1);

    expect(mockApiClient.get).toHaveBeenCalledWith('/users/1');
    expect(result).toEqual(mockUser);
  });
});

// ❌ Avoid: No mocking
describe('UserService', () => {
  it('should fetch user data', async () => {
    const userService = new UserService(new ApiClient());
    const result = await userService.getUser(1);
    // This will make actual API calls
  });
});
```


### **4. Test Edge Cases**


```typescript
// ✅ Good: Test edge cases
describe('divide', () => {
  it('should divide positive numbers', () => {
    expect(divide(10, 2)).toBe(5);
  });

  it('should divide negative numbers', () => {
    expect(divide(-10, -2)).toBe(5);
  });

  it('should throw error when dividing by zero', () => {
    expect(() => divide(10, 0)).toThrow('Division by zero');
  });

  it('should handle decimal results', () => {
    expect(divide(7, 3)).toBeCloseTo(2.33, 2);
  });
});

// ❌ Avoid: Only testing happy path
describe('divide', () => {
  it('should divide numbers', () => {
    expect(divide(10, 2)).toBe(5);
  });
});
```


---

## ❓ **Common Interview Questions**

### **1. How do you set up testing for TypeScript projects?**

**Answer:**
1. Install Jest and TypeScript testing dependencies
2. Configure Jest with ts-jest preset
3. Set up test scripts in package.json
4. Create test files with .test.ts or .spec.ts extension

### **2. What are the benefits of unit testing?**

**Answer:**
- **Early bug detection**: Catch errors during development
- **Documentation**: Tests serve as living documentation
- **Refactoring safety**: Ensure changes don't break existing functionality
- **Code quality**: Encourage better code design

### **3. How do you mock dependencies in Jest?**

**Answer:**

```typescript
// Mock entire module
jest.mock('./module');

// Mock specific methods
jest.spyOn(object, 'method').mockImplementation(() => {});

// Mock with return values
jest.fn().mockReturnValue('value');
jest.fn().mockResolvedValue('async value');
```


### **4. How do you test async code?**

**Answer:**

```typescript
// Test promises
it('should resolve promise', async () => {
  const result = await asyncFunction();
  expect(result).toBe('expected');
});

// Test rejected promises
it('should reject promise', async () => {
  await expect(asyncFunction()).rejects.toThrow('Error');
});
```


### **5. What's the difference between unit and integration tests?**

**Answer:**
- **Unit tests**: Test individual functions/components in isolation
- **Integration tests**: Test how multiple components work together
- **Unit tests**: Fast, isolated, mock dependencies
- **Integration tests**: Slower, test real interactions, use real dependencies

---

## 🧭 Navigation

<div class="navigation">
  <a href="../05-TypeScript-Different-Environments/04-TypeScript-Angular.md" class="nav-button">← Previous: TypeScript with Angular</a>
  <a href="02-Type-Testing-Validation.md" class="nav-button">Next: Type Testing & Validation →</a>
</div>

*Last updated: December 2025*
