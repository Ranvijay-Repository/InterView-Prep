# 🟢 **TypeScript with Node.js**

> **Complete guide to using TypeScript with Node.js, including setup, configuration, and best practices for server-side development**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Node.js TypeScript Setup](#nodejs-typescript-setup)
- [Project Configuration](#project-configuration)
- [Node.js Specific Types](#nodejs-specific-types)
- [Express.js Integration](#expressjs-integration)
- [Database Integration](#database-integration)
- [Testing with TypeScript](#testing-with-typescript)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Node.js TypeScript Setup**

Setting up TypeScript for Node.js development requires proper configuration and tooling.

### **Basic Setup**


```bash
# Initialize Node.js project
npm init -y

# Install TypeScript and Node.js types
npm install --save-dev typescript @types/node
npm install --save-dev ts-node nodemon

# Install additional development dependencies
npm install --save-dev @types/express @types/cors @types/helmet
```


### **Package.json Scripts**


```json
{
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "dev": "nodemon --exec ts-node src/index.ts",
    "watch": "tsc --watch",
    "clean": "rm -rf dist"
  }
}
```


### **Basic TypeScript Configuration**


```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "sourceMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```


---

## ⚙️ **Project Configuration**

### **Advanced TypeScript Configuration**


```json
// tsconfig.json - Production configuration
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "sourceMap": true,
    "removeComments": true,
    "noEmitOnError": true,
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
```


### **Development Configuration**


```json
// tsconfig.dev.json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "sourceMap": true,
    "declaration": false,
    "removeComments": false
  },
  "include": ["src/**/*", "tests/**/*"]
}
```


### **Nodemon Configuration**


```json
// nodemon.json
{
  "watch": ["src"],
  "ext": "ts,json",
  "ignore": ["src/**/*.test.ts"],
  "exec": "ts-node src/index.ts"
}
```


---

## 🔧 **Node.js Specific Types**

### **Built-in Node.js Types**


```typescript
// Node.js built-in modules
import * as fs from 'fs';
import * as path from 'path';
import * as http from 'http';
import * as url from 'url';
import { EventEmitter } from 'events';

// File system operations
const readFile = async (filePath: string): Promise<string> => {
  try {
    const data = await fs.promises.readFile(filePath, 'utf8');
    return data;
  } catch (error) {
    throw new Error(`Failed to read file: ${error}`);
  }
};

// Path operations
const getFilePath = (filename: string): string => {
  return path.join(__dirname, '..', 'data', filename);
};

// HTTP server
const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ message: 'Hello World' }));
});

server.listen(3000, () => {
  console.log('Server running on port 3000');
});
```


### **Custom Node.js Types**


```typescript
// Custom types for Node.js applications
interface ServerConfig {
  port: number;
  host: string;
  environment: 'development' | 'production' | 'test';
  database: {
    host: string;
    port: number;
    name: string;
  };
}

interface RequestContext {
  requestId: string;
  userId?: string;
  timestamp: Date;
}

// Environment variables
interface ProcessEnv {
  NODE_ENV: 'development' | 'production' | 'test';
  PORT: string;
  DATABASE_URL: string;
  JWT_SECRET: string;
}

declare global {
  namespace NodeJS {
    interface ProcessEnv extends ProcessEnv {}
  }
}
```


### **Event Emitter Types**


```typescript
// Custom event emitter with typed events
interface AppEvents {
  userCreated: (user: User) => void;
  userDeleted: (userId: string) => void;
  error: (error: Error) => void;
}

class AppEventEmitter extends EventEmitter {
  emit<K extends keyof AppEvents>(event: K, ...args: Parameters<AppEvents[K]>): boolean {
    return super.emit(event, ...args);
  }

  on<K extends keyof AppEvents>(event: K, listener: AppEvents[K]): this {
    return super.on(event, listener);
  }

  off<K extends keyof AppEvents>(event: K, listener: AppEvents[K]): this {
    return super.off(event, listener);
  }
}

// Usage
const appEvents = new AppEventEmitter();

appEvents.on('userCreated', (user) => {
  console.log(`User created: ${user.name}`);
});

appEvents.emit('userCreated', { id: 1, name: 'John', email: 'john@example.com' });
```


---

## 🚀 **Express.js Integration**

### **Basic Express Setup**


```typescript
// src/app.ts
import express, { Application, Request, Response, NextFunction } from 'express';
import cors from 'cors';
import helmet from 'helmet';

const app: Application = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', (req: Request, res: Response) => {
  res.json({ message: 'Hello World' });
});

// Error handling middleware
app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

export default app;
```


### **Typed Express Routes**


```typescript
// src/routes/users.ts
import { Router, Request, Response } from 'express';
import { UserService } from '../services/UserService';

const router = Router();
const userService = new UserService();

// GET /users
router.get('/', async (req: Request, res: Response) => {
  try {
    const users = await userService.getAllUsers();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch users' });
  }
});

// GET /users/:id
router.get('/:id', async (req: Request<{ id: string }>, res: Response) => {
  try {
    const user = await userService.getUserById(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch user' });
  }
});

// POST /users
router.post('/', async (req: Request<{}, User, CreateUserRequest>, res: Response) => {
  try {
    const user = await userService.createUser(req.body);
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: 'Failed to create user' });
  }
});

export default router;
```


### **Custom Request Types**


```typescript
// src/types/express.d.ts
import { User } from './User';

declare global {
  namespace Express {
    interface Request {
      user?: User;
      requestId: string;
    }
  }
}

// src/middleware/auth.ts
import { Request, Response, NextFunction } from 'express';
import { UserService } from '../services/UserService';

export const authenticate = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const user = await UserService.verifyToken(token);
    req.user = user;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
};
```


---

## 🗄️ **Database Integration**

### **MongoDB with Mongoose**


```typescript
// src/models/User.ts
import mongoose, { Document, Schema } from 'mongoose';

export interface IUser extends Document {
  name: string;
  email: string;
  age: number;
  createdAt: Date;
  updatedAt: Date;
}

const UserSchema = new Schema<IUser>({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  age: { type: Number, required: true }
}, {
  timestamps: true
});

export const User = mongoose.model<IUser>('User', UserSchema);
```


### **PostgreSQL with TypeORM**


```typescript
// src/entities/User.ts
import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ unique: true })
  email: string;

  @Column()
  age: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
```


### **Database Service Layer**


```typescript
// src/services/UserService.ts
import { User } from '../models/User';
import { CreateUserRequest, UpdateUserRequest } from '../types/User';

export class UserService {
  async getAllUsers(): Promise<User[]> {
    return User.find();
  }

  async getUserById(id: string): Promise<User | null> {
    return User.findById(id);
  }

  async createUser(userData: CreateUserRequest): Promise<User> {
    const user = new User(userData);
    return user.save();
  }

  async updateUser(id: string, userData: UpdateUserRequest): Promise<User | null> {
    return User.findByIdAndUpdate(id, userData, { new: true });
  }

  async deleteUser(id: string): Promise<boolean> {
    const result = await User.findByIdAndDelete(id);
    return result !== null;
  }
}
```


---

## 🧪 **Testing with TypeScript**

### **Jest Configuration**


```json
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
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
};
```


### **Unit Tests**


```typescript
// src/__tests__/UserService.test.ts
import { UserService } from '../services/UserService';
import { User } from '../models/User';

// Mock the User model
jest.mock('../models/User');

describe('UserService', () => {
  let userService: UserService;

  beforeEach(() => {
    userService = new UserService();
    jest.clearAllMocks();
  });

  describe('getAllUsers', () => {
    it('should return all users', async () => {
      const mockUsers = [
        { id: '1', name: 'John', email: 'john@example.com' },
        { id: '2', name: 'Jane', email: 'jane@example.com' }
      ];

      (User.find as jest.Mock).mockResolvedValue(mockUsers);

      const result = await userService.getAllUsers();

      expect(result).toEqual(mockUsers);
      expect(User.find).toHaveBeenCalledTimes(1);
    });
  });

  describe('createUser', () => {
    it('should create a new user', async () => {
      const userData = { name: 'John', email: 'john@example.com', age: 30 };
      const mockUser = { id: '1', ...userData };

      (User.prototype.save as jest.Mock).mockResolvedValue(mockUser);

      const result = await userService.createUser(userData);

      expect(result).toEqual(mockUser);
      expect(User.prototype.save).toHaveBeenCalledTimes(1);
    });
  });
});
```


### **Integration Tests**


```typescript
// src/__tests__/integration/users.test.ts
import request from 'supertest';
import app from '../../app';
import { connectDB, disconnectDB } from '../../config/database';

describe('Users API', () => {
  beforeAll(async () => {
    await connectDB();
  });

  afterAll(async () => {
    await disconnectDB();
  });

  describe('GET /users', () => {
    it('should return all users', async () => {
      const response = await request(app)
        .get('/users')
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });
  });

  describe('POST /users', () => {
    it('should create a new user', async () => {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        age: 30
      };

      const response = await request(app)
        .post('/users')
        .send(userData)
        .expect(201);

      expect(response.body).toMatchObject(userData);
      expect(response.body.id).toBeDefined();
    });
  });
});
```


---

## ✅ **Best Practices**

### **1. Use Strict Type Checking**


```typescript
// ✅ Good: Strict type checking
interface User {
  id: string;
  name: string;
  email: string;
}

const createUser = (userData: Omit<User, 'id'>): User => {
  return {
    id: generateId(),
    ...userData
  };
};

// ❌ Avoid: Loose typing
const createUser = (userData: any): any => {
  return {
    id: generateId(),
    ...userData
  };
};
```


### **2. Use Environment Variables**


```typescript
// ✅ Good: Environment variables
const config = {
  port: parseInt(process.env.PORT || '3000'),
  databaseUrl: process.env.DATABASE_URL || 'mongodb://localhost:27017/myapp',
  jwtSecret: process.env.JWT_SECRET || 'default-secret'
};

// ❌ Avoid: Hardcoded values
const config = {
  port: 3000,
  databaseUrl: 'mongodb://localhost:27017/myapp',
  jwtSecret: 'my-secret'
};
```


### **3. Use Dependency Injection**


```typescript
// ✅ Good: Dependency injection
class UserController {
  constructor(private userService: UserService) {}

  async getUsers(req: Request, res: Response) {
    const users = await this.userService.getAllUsers();
    res.json(users);
  }
}

// ❌ Avoid: Hard dependencies
class UserController {
  async getUsers(req: Request, res: Response) {
    const userService = new UserService();
    const users = await userService.getAllUsers();
    res.json(users);
  }
}
```


### **4. Use Error Handling**


```typescript
// ✅ Good: Proper error handling
const getUserById = async (id: string): Promise<User> => {
  try {
    const user = await User.findById(id);
    if (!user) {
      throw new Error('User not found');
    }
    return user;
  } catch (error) {
    throw new Error(`Failed to fetch user: ${error.message}`);
  }
};

// ❌ Avoid: No error handling
const getUserById = async (id: string): Promise<User> => {
  return User.findById(id);
};
```


---

## ❓ **Common Interview Questions**

### **1. How do you set up TypeScript with Node.js?**

**Answer:**
1. Install TypeScript and Node.js types
2. Configure tsconfig.json
3. Set up build scripts
4. Use ts-node for development

### **2. What are the benefits of using TypeScript with Node.js?**

**Answer:**
- **Type safety**: Catch errors at compile time
- **Better IDE support**: IntelliSense and autocomplete
- **Refactoring**: Safer code changes
- **Documentation**: Self-documenting code

### **3. How do you handle environment variables in TypeScript?**

**Answer:**

```typescript
interface ProcessEnv {
  NODE_ENV: 'development' | 'production' | 'test';
  PORT: string;
  DATABASE_URL: string;
}

declare global {
  namespace NodeJS {
    interface ProcessEnv extends ProcessEnv {}
  }
}
```


### **4. How do you test TypeScript Node.js applications?**

**Answer:**
- Use Jest with ts-jest preset
- Mock dependencies
- Write unit and integration tests
- Use supertest for API testing

### **5. What's the difference between development and production TypeScript configuration?**

**Answer:**
- **Development**: Source maps, declarations, comments
- **Production**: No source maps, no declarations, remove comments, optimize

---

## 🧭 Navigation

<div class="navigation">
  <a href="../04-Advanced-TypeScript-Patterns/04-Performance-Optimization.md" class="nav-button">← Previous: Performance Optimization</a>
  <a href="02-TypeScript-React.md" class="nav-button">Next: TypeScript with React →</a>
</div>

*Last updated: December 2025*
