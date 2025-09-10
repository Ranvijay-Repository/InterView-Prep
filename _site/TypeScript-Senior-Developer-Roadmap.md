# TypeScript Senior Developer Roadmap - Complete Guide

## Overview

This comprehensive roadmap covers all TypeScript concepts, patterns, and advanced techniques needed for senior-level positions in React, React Native, JavaScript, and backend development. Master these topics to excel in technical interviews and senior developer roles.

## 🎯 **Core TypeScript Fundamentals (Must Know)**

### 1. **Type System Mastery**

{% raw %}
```typescript
// Basic Types
type PrimitiveTypes = {
  string: string;
  number: number;
  boolean: boolean;
  null: null;
  undefined: undefined;
  symbol: symbol;
  bigint: bigint;
};

// Advanced Types
type AdvancedTypes = {
  any: any;                    // Avoid in production
  unknown: unknown;            // Type-safe alternative to any
  never: never;               // Represents unreachable code
  void: void;                 // Function returns nothing
  object: object;             // Non-primitive types
  array: string[];            // Array syntax
  tuple: [string, number];    // Fixed-length arrays
  enum: enum Color { Red, Green, Blue };
  union: string | number;     // Multiple possible types
  intersection: A & B;        // Combine types
  literal: "hello" | "world"; // Specific string values
};

// Type Guards and Narrowing
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function processValue(value: string | number) {
  if (isString(value)) {
    // TypeScript knows value is string here
    return value.toUpperCase();
  }
  // TypeScript knows value is number here
  return value.toFixed(2);
}
```
{% endraw %}


### 2. **Advanced Type Manipulation**

{% raw %}
```typescript
// Utility Types (Built-in)
type UtilityTypes = {
  Partial<T>: Partial<User>;           // Make all properties optional
  Required<T>: Required<User>;         // Make all properties required
  Readonly<T>: Readonly<User>;         // Make all properties readonly
  Record<K, V>: Record<string, number>; // Object with specific key-value types
  Pick<T, K>: Pick<User, 'name' | 'email'>; // Select specific properties
  Omit<T, K>: Omit<User, 'password'>;  // Exclude specific properties
  Exclude<T, U>: Exclude<string | number, string>; // Exclude types
  Extract<T, U>: Extract<string | number, string>; // Extract types
  NonNullable<T>: NonNullable<string | null>; // Remove null/undefined
  ReturnType<T>: ReturnType<typeof fetch>; // Get function return type
  Parameters<T>: Parameters<typeof fetch>; // Get function parameters
  ConstructorParameters<T>: ConstructorParameters<Date>; // Get constructor params
  InstanceType<T>: InstanceType<typeof Date>; // Get instance type
};

// Custom Utility Types
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

type Optional<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;
type Required<T, K extends keyof T> = T & Required<Pick<T, K>>;

// Conditional Types
type IsArray<T> = T extends any[] ? true : false;
type ArrayElement<T> = T extends (infer U)[] ? U : never;
type NonArray<T> = T extends any[] ? never : T;

// Template Literal Types
type EventName<T extends string> = `on${Capitalize<T>}`;
type CSSProperty<T extends string> = `--${T}`;
type APIEndpoint<T extends string> = `/api/${T}`;

// Mapped Types
type Getters<T> = {
  [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K];
};

type Setters<T> = {
  [K in keyof T as `set${Capitalize<string & K>}`]: (value: T[K]) => void;
};
```
{% endraw %}


### 3. **Generics Mastery**

{% raw %}
```typescript
// Basic Generics
function identity<T>(arg: T): T {
  return arg;
}

// Generic Constraints
interface Lengthwise {
  length: number;
}

function logLength<T extends Lengthwise>(arg: T): T {
  console.log(arg.length);
  return arg;
}

// Generic Classes
class GenericNumber<T> {
  zeroValue: T;
  add: (x: T, y: T) => T;
}

// Generic Interfaces
interface GenericInterface<T, U> {
  process: (input: T) => U;
  validate: (input: T) => boolean;
}

// Advanced Generic Patterns
type Flatten<T> = T extends (infer U)[] ? U : T;
type UnwrapPromise<T> = T extends Promise<infer U> ? U : T;
type Head<T extends readonly unknown[]> = T extends readonly [infer H, ...unknown[]] ? H : never;
type Tail<T extends readonly unknown[]> = T extends readonly [unknown, ...infer T] ? T : never;

// Recursive Types
type JSONValue = 
  | string 
  | number 
  | boolean 
  | null 
  | JSONValue[] 
  | { [key: string]: JSONValue };

// Higher-Order Types
type HigherOrderFunction<T> = (fn: T) => T;
type Curry<T extends (...args: any[]) => any> = 
  T extends (first: infer F, ...rest: infer R) => infer Return
    ? R extends []
      ? T
      : (arg: F) => Curry<(...args: R) => Return>
    : never;
```
{% endraw %}


## 🏗️ **Design Patterns & Architecture**

### 1. **Object-Oriented Patterns**

{% raw %}
```typescript
// Singleton Pattern
class Singleton {
  private static instance: Singleton;
  private constructor() {}
  
  static getInstance(): Singleton {
    if (!Singleton.instance) {
      Singleton.instance = new Singleton();
    }
    return Singleton.instance;
  }
}

// Factory Pattern
interface Product {
  operation(): string;
}

class ConcreteProductA implements Product {
  operation(): string {
    return 'Product A';
  }
}

class ConcreteProductB implements Product {
  operation(): string {
    return 'Product B';
  }
}

class ProductFactory {
  static createProduct(type: 'A' | 'B'): Product {
    switch (type) {
      case 'A': return new ConcreteProductA();
      case 'B': return new ConcreteProductB();
      default: throw new Error('Invalid product type');
    }
  }
}

// Builder Pattern
class UserBuilder {
  private user: Partial<User> = {};
  
  setName(name: string): this {
    this.user.name = name;
    return this;
  }
  
  setEmail(email: string): this {
    this.user.email = email;
    return this;
  }
  
  setAge(age: number): this {
    this.user.age = age;
    return this;
  }
  
  build(): User {
    if (!this.user.name || !this.user.email) {
      throw new Error('Name and email are required');
    }
    return this.user as User;
  }
}

// Observer Pattern
interface Observer<T> {
  update(data: T): void;
}

class Subject<T> {
  private observers: Observer<T>[] = [];
  
  subscribe(observer: Observer<T>): void {
    this.observers.push(observer);
  }
  
  unsubscribe(observer: Observer<T>): void {
    this.observers = this.observers.filter(obs => obs !== observer);
  }
  
  notify(data: T): void {
    this.observers.forEach(observer => observer.update(data));
  }
}
```
{% endraw %}


### 2. **Functional Programming Patterns**

{% raw %}
```typescript
// Monad Pattern
interface Monad<T> {
  map<U>(fn: (value: T) => U): Monad<U>;
  flatMap<U>(fn: (value: T) => Monad<U>): Monad<U>;
  value: T;
}

class Maybe<T> implements Monad<T> {
  constructor(public value: T | null) {}
  
  map<U>(fn: (value: T) => U): Maybe<U> {
    return this.value !== null ? new Maybe(fn(this.value)) : new Maybe<U>(null);
  }
  
  flatMap<U>(fn: (value: T) => Maybe<U>): Maybe<U> {
    return this.value !== null ? fn(this.value) : new Maybe<U>(null);
  }
  
  static of<T>(value: T): Maybe<T> {
    return new Maybe(value);
  }
}

// Functor Pattern
interface Functor<T> {
  map<U>(fn: (value: T) => U): Functor<U>;
}

// Applicative Pattern
interface Applicative<T> extends Functor<T> {
  ap<U>(fn: Applicative<(value: T) => U>): Applicative<U>;
  static of<T>(value: T): Applicative<T>;
}

// Currying and Partial Application
const curry = <T extends (...args: any[]) => any>(fn: T) => {
  return function curried(...args: any[]): any {
    if (args.length >= fn.length) {
      return fn.apply(this, args);
    }
    return (...nextArgs: any[]) => curried(...args, ...nextArgs);
  };
};

const add = (a: number, b: number, c: number) => a + b + c;
const curriedAdd = curry(add);
const add5 = curriedAdd(5);
const add5And3 = add5(3);
```
{% endraw %}


### 3. **Architectural Patterns**

{% raw %}
```typescript
// Repository Pattern
interface Repository<T, ID> {
  findById(id: ID): Promise<T | null>;
  findAll(): Promise<T[]>;
  save(entity: T): Promise<T>;
  delete(id: ID): Promise<void>;
}

class UserRepository implements Repository<User, string> {
  async findById(id: string): Promise<User | null> {
    // Implementation
  }
  
  async findAll(): Promise<User[]> {
    // Implementation
  }
  
  async save(user: User): Promise<User> {
    // Implementation
  }
  
  async delete(id: string): Promise<void> {
    // Implementation
  }
}

// Service Layer Pattern
interface UserService {
  createUser(userData: CreateUserDto): Promise<User>;
  getUserById(id: string): Promise<User>;
  updateUser(id: string, userData: UpdateUserDto): Promise<User>;
  deleteUser(id: string): Promise<void>;
}

class UserServiceImpl implements UserService {
  constructor(private userRepository: UserRepository) {}
  
  async createUser(userData: CreateUserDto): Promise<User> {
    // Business logic
    const user = new User(userData);
    return this.userRepository.save(user);
  }
  
  // Other methods...
}

// Dependency Injection
interface Container {
  register<T>(token: string, factory: () => T): void;
  resolve<T>(token: string): T;
}

class DIContainer implements Container {
  private services = new Map<string, () => any>();
  
  register<T>(token: string, factory: () => T): void {
    this.services.set(token, factory);
  }
  
  resolve<T>(token: string): T {
    const factory = this.services.get(token);
    if (!factory) {
      throw new Error(`Service ${token} not found`);
    }
    return factory();
  }
}
```
{% endraw %}


## ⚛️ **React & React Native Specific TypeScript**

### 1. **React Component Typing**

{% raw %}
```typescript
// Component Props
interface ButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  variant?: 'primary' | 'secondary' | 'danger';
  size?: 'small' | 'medium' | 'large';
  disabled?: boolean;
  className?: string;
}

// Functional Component with Generic Props
interface ListProps<T> {
  items: T[];
  renderItem: (item: T, index: number) => React.ReactNode;
  keyExtractor: (item: T) => string | number;
  onItemPress?: (item: T) => void;
}

function List<T>({ items, renderItem, keyExtractor, onItemPress }: ListProps<T>) {
  return (
    <div>
      {items.map((item, index) => (
        <div key={keyExtractor(item)} onClick={() => onItemPress?.(item)}>
          {renderItem(item, index)}
        </div>
      ))}
    </div>
  );
}

// HOC with TypeScript
function withLoading<T extends object>(
  Component: React.ComponentType<T>
): React.ComponentType<T & { loading: boolean }> {
  return function WithLoadingComponent(props: T & { loading: boolean }) {
    if (props.loading) {
      return <div>Loading...</div>;
    }
    return <Component {...props} />;
  };
}

// Custom Hooks with TypeScript
function useApi<T>(url: string) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  
  useEffect(() => {
    fetch(url)
      .then(response => response.json())
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [url]);
  
  return { data, loading, error };
}

// Context with TypeScript
interface ThemeContextType {
  theme: 'light' | 'dark';
  toggleTheme: () => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

function useTheme(): ThemeContextType {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within ThemeProvider');
  }
  return context;
}
```
{% endraw %}


### 2. **React Native Specific Types**

{% raw %}
```typescript
// Navigation Types
type RootStackParamList = {
  Home: undefined;
  Profile: { userId: string };
  Settings: undefined;
};

type RootStackNavigationProp = StackNavigationProp<RootStackParamList>;
type RootStackRouteProp = RouteProp<RootStackParamList, 'Profile'>;

// Component Props with Platform-specific
interface PlatformButtonProps {
  title: string;
  onPress: () => void;
  style?: ViewStyle;
  textStyle?: TextStyle;
}

const PlatformButton: React.FC<PlatformButtonProps> = ({ title, onPress, style, textStyle }) => {
  if (Platform.OS === 'ios') {
    return (
      <TouchableOpacity onPress={onPress} style={style}>
        <Text style={textStyle}>{title}</Text>
      </TouchableOpacity>
    );
  }
  
  return (
    <TouchableNativeFeedback onPress={onPress}>
      <View style={style}>
        <Text style={textStyle}>{title}</Text>
      </View>
    </TouchableNativeFeedback>
  );
};

// Redux with TypeScript
interface RootState {
  user: UserState;
  posts: PostsState;
}

interface UserState {
  currentUser: User | null;
  loading: boolean;
  error: string | null;
}

// Actions
interface SetUserAction {
  type: 'SET_USER';
  payload: User;
}

interface SetLoadingAction {
  type: 'SET_LOADING';
  payload: boolean;
}

type UserAction = SetUserAction | SetLoadingAction;

// Reducer
function userReducer(state: UserState, action: UserAction): UserState {
  switch (action.type) {
    case 'SET_USER':
      return { ...state, currentUser: action.payload };
    case 'SET_LOADING':
      return { ...state, loading: action.payload };
    default:
      return state;
  }
}

// Selectors
const selectCurrentUser = (state: RootState) => state.user.currentUser;
const selectUserLoading = (state: RootState) => state.user.loading;
```
{% endraw %}


### 3. **Advanced React Patterns**

{% raw %}
```typescript
// Render Props Pattern
interface RenderProps<T> {
  render: (data: T) => React.ReactNode;
  children?: (data: T) => React.ReactNode;
}

function DataFetcher<T>({ render, children }: RenderProps<T>) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    // Fetch data
    setLoading(false);
  }, []);
  
  if (loading) return <div>Loading...</div>;
  
  return (
    <>
      {render && render(data!)}
      {children && children(data!)}
    </>
  );
}

// Compound Components
interface TabsProps {
  children: React.ReactNode;
  defaultTab?: string;
}

interface TabProps {
  id: string;
  children: React.ReactNode;
}

interface TabPanelProps {
  id: string;
  children: React.ReactNode;
}

const TabsContext = createContext<{
  activeTab: string;
  setActiveTab: (id: string) => void;
} | null>(null);

function Tabs({ children, defaultTab }: TabsProps) {
  const [activeTab, setActiveTab] = useState(defaultTab || '');
  
  return (
    <TabsContext.Provider value={{#123;{{#123; activeTab, setActiveTab }}#125;}}#125;>
      {children}
    </TabsContext.Provider>
  );
}

function Tab({ id, children }: TabProps) {
  const context = useContext(TabsContext);
  if (!context) throw new Error('Tab must be used within Tabs');
  
  return (
    <button
      onClick={() => context.setActiveTab(id)}
      className={context.activeTab === id ? 'active' : ''}
    >
      {children}
    </button>
  );
}

function TabPanel({ id, children }: TabPanelProps) {
  const context = useContext(TabsContext);
  if (!context) throw new Error('TabPanel must be used within Tabs');
  
  return context.activeTab === id ? <div>{children}</div> : null;
}

// Usage
<Tabs defaultTab="tab1">
  <Tab id="tab1">Tab 1</Tab>
  <Tab id="tab2">Tab 2</Tab>
  <TabPanel id="tab1">Content 1</TabPanel>
  <TabPanel id="tab2">Content 2</TabPanel>
</Tabs>
```
{% endraw %}


## 🚀 **Backend Development with TypeScript**

### 1. **Node.js & Express**

{% raw %}
```typescript
// Express with TypeScript
import express, { Request, Response, NextFunction } from 'express';

interface CustomRequest extends Request {
  user?: User;
}

interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

// Middleware Types
type Middleware = (req: CustomRequest, res: Response, next: NextFunction) => void;
type AsyncMiddleware = (req: CustomRequest, res: Response, next: NextFunction) => Promise<void>;

// Route Handler Types
type RouteHandler<T = any> = (req: CustomRequest, res: Response) => Promise<ApiResponse<T>>;

// Error Handling
class AppError extends Error {
  public statusCode: number;
  public isOperational: boolean;
  
  constructor(message: string, statusCode: number) {
    super(message);
    this.statusCode = statusCode;
    this.isOperational = true;
    
    Error.captureStackTrace(this, this.constructor);
  }
}

// Async Error Wrapper
const asyncHandler = (fn: AsyncMiddleware): Middleware => {
  return (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};

// Controller Example
class UserController {
  async getUsers(req: CustomRequest, res: Response): Promise<void> {
    try {
      const users = await userService.getAllUsers();
      res.json({ success: true, data: users });
    } catch (error) {
      throw new AppError('Failed to fetch users', 500);
    }
  }
  
  async createUser(req: CustomRequest, res: Response): Promise<void> {
    try {
      const userData: CreateUserDto = req.body;
      const user = await userService.createUser(userData);
      res.status(201).json({ success: true, data: user });
    } catch (error) {
      throw new AppError('Failed to create user', 400);
    }
  }
}
```
{% endraw %}


### 2. **Database Integration**

{% raw %}
```typescript
// TypeORM with TypeScript
import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;
  
  @Column({ unique: true })
  email: string;
  
  @Column()
  name: string;
  
  @Column({ nullable: true })
  avatar?: string;
  
  @CreateDateColumn()
  createdAt: Date;
  
  @UpdateDateColumn()
  updatedAt: Date;
}

// Repository Pattern with TypeORM
interface IUserRepository {
  findById(id: string): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  create(userData: CreateUserDto): Promise<User>;
  update(id: string, userData: UpdateUserDto): Promise<User>;
  delete(id: string): Promise<void>;
}

class UserRepository implements IUserRepository {
  constructor(private repository: Repository<User>) {}
  
  async findById(id: string): Promise<User | null> {
    return this.repository.findOne({ where: { id } });
  }
  
  async findByEmail(email: string): Promise<User | null> {
    return this.repository.findOne({ where: { email } });
  }
  
  async create(userData: CreateUserDto): Promise<User> {
    const user = this.repository.create(userData);
    return this.repository.save(user);
  }
  
  async update(id: string, userData: UpdateUserDto): Promise<User> {
    await this.repository.update(id, userData);
    const user = await this.findById(id);
    if (!user) throw new AppError('User not found', 404);
    return user;
  }
  
  async delete(id: string): Promise<void> {
    const result = await this.repository.delete(id);
    if (result.affected === 0) {
      throw new AppError('User not found', 404);
    }
  }
}
```
{% endraw %}


### 3. **API Design & Validation**

{% raw %}
```typescript
// DTOs (Data Transfer Objects)
interface CreateUserDto {
  name: string;
  email: string;
  password: string;
  age?: number;
}

interface UpdateUserDto {
  name?: string;
  email?: string;
  age?: number;
}

interface UserResponseDto {
  id: string;
  name: string;
  email: string;
  age?: number;
  createdAt: Date;
  updatedAt: Date;
}

// Validation with class-validator
import { IsEmail, IsString, IsOptional, IsNumber, Min, Max } from 'class-validator';

export class CreateUserDto {
  @IsString()
  @MinLength(2)
  @MaxLength(50)
  name: string;
  
  @IsEmail()
  email: string;
  
  @IsString()
  @MinLength(8)
  password: string;
  
  @IsOptional()
  @IsNumber()
  @Min(18)
  @Max(120)
  age?: number;
}

// API Response Types
interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

interface ApiError {
  code: string;
  message: string;
  details?: Record<string, any>;
}

// Service Layer
interface IUserService {
  createUser(userData: CreateUserDto): Promise<UserResponseDto>;
  getUserById(id: string): Promise<UserResponseDto>;
  updateUser(id: string, userData: UpdateUserDto): Promise<UserResponseDto>;
  deleteUser(id: string): Promise<void>;
  getUsers(page: number, limit: number): Promise<PaginatedResponse<UserResponseDto>>;
}

class UserService implements IUserService {
  constructor(private userRepository: IUserRepository) {}
  
  async createUser(userData: CreateUserDto): Promise<UserResponseDto> {
    // Validation
    const existingUser = await this.userRepository.findByEmail(userData.email);
    if (existingUser) {
      throw new AppError('Email already exists', 400);
    }
    
    // Hash password
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    
    // Create user
    const user = await this.userRepository.create({
      ...userData,
      password: hashedPassword,
    });
    
    // Return without password
    const { password, ...userResponse } = user;
    return userResponse;
  }
  
  // Other methods...
}
```
{% endraw %}


## 🔧 **Advanced TypeScript Features**

### 1. **Module System & Namespaces**

{% raw %}
```typescript
// Module Declaration
declare module 'custom-module' {
  export interface CustomConfig {
    apiKey: string;
    baseUrl: string;
  }
  
  export function initialize(config: CustomConfig): void;
  export function processData<T>(data: T): T;
}

// Namespace
namespace MyApp {
  export namespace Services {
    export class UserService {
      // Implementation
    }
  }
  
  export namespace Types {
    export interface User {
      id: string;
      name: string;
    }
  }
}

// Ambient Declarations
declare global {
  interface Window {
    myCustomProperty: string;
  }
  
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: 'development' | 'production' | 'test';
      PORT: string;
      DATABASE_URL: string;
    }
  }
}
```
{% endraw %}


### 2. **Decorators & Metadata**

{% raw %}
```typescript
// Class Decorator
function Controller(path: string) {
  return function <T extends { new (...args: any[]): {} }>(constructor: T) {
    return class extends constructor {
      static routePath = path;
    };
  };
}

// Method Decorator
function Get(path: string) {
  return function (target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    descriptor.value = function (...args: any[]) {
      console.log(`GET ${path} called`);
      return originalMethod.apply(this, args);
    };
  };
}

// Property Decorator
function Required(target: any, propertyKey: string) {
  const existingRequired = Reflect.getMetadata('required', target) || [];
  Reflect.defineMetadata('required', [...existingRequired, propertyKey], target);
}

// Parameter Decorator
function Body(target: any, propertyKey: string, parameterIndex: number) {
  const existingBody = Reflect.getMetadata('body', target, propertyKey) || [];
  existingBody[parameterIndex] = true;
  Reflect.defineMetadata('body', existingBody, target, propertyKey);
}

// Usage
@Controller('/users')
class UserController {
  @Required
  private userService: UserService;
  
  @Get('/')
  async getUsers(@Body userData: CreateUserDto) {
    return this.userService.getAllUsers();
  }
}
```
{% endraw %}


### 3. **Advanced Generic Patterns**

{% raw %}
```typescript
// Recursive Type Definitions
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

// Type-level Programming
type Length<T extends readonly any[]> = T['length'];

type Head<T extends readonly any[]> = T extends readonly [infer H, ...any[]] ? H : never;
type Tail<T extends readonly any[]> = T extends readonly [any, ...infer T] ? T : never;

type Last<T extends readonly any[]> = T extends readonly [...any[], infer L] ? L : never;
type Pop<T extends readonly any[]> = T extends readonly [...infer R, any] ? R : never;

// Function Overloading with Generics
function process<T extends string>(input: T): `processed-${T}`;
function process<T extends number>(input: T): T;
function process<T>(input: T): T {
  if (typeof input === 'string') {
    return `processed-${input}` as any;
  }
  return input;
}

// Branded Types
type Brand<T, B> = T & { __brand: B };
type UserId = Brand<string, 'UserId'>;
type ProductId = Brand<string, 'ProductId'>;

function createUserId(id: string): UserId {
  return id as UserId;
}

function createProductId(id: string): ProductId {
  return id as ProductId;
}

// Phantom Types
type Phantom<T, U> = T & { __phantom: U };
type Validated<T> = Phantom<T, 'validated'>;
type Sanitized<T> = Phantom<T, 'sanitized'>;

function validate<T>(input: T): Validated<T> {
  // Validation logic
  return input as Validated<T>;
}

function sanitize<T>(input: T): Sanitized<T> {
  // Sanitization logic
  return input as Sanitized<T>;
}
```
{% endraw %}


## 🧪 **Testing with TypeScript**

### 1. **Unit Testing**

{% raw %}
```typescript
// Jest with TypeScript
import { UserService } from '../services/UserService';
import { UserRepository } from '../repositories/UserRepository';

describe('UserService', () => {
  let userService: UserService;
  let mockUserRepository: jest.Mocked<UserRepository>;
  
  beforeEach(() => {
    mockUserRepository = {
      findById: jest.fn(),
      findByEmail: jest.fn(),
      create: jest.fn(),
      update: jest.fn(),
      delete: jest.fn(),
    } as jest.Mocked<UserRepository>;
    
    userService = new UserService(mockUserRepository);
  });
  
  describe('createUser', () => {
    it('should create a user successfully', async () => {
      const userData: CreateUserDto = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
      };
      
      const expectedUser = {
        id: '1',
        ...userData,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      
      mockUserRepository.findByEmail.mockResolvedValue(null);
      mockUserRepository.create.mockResolvedValue(expectedUser);
      
      const result = await userService.createUser(userData);
      
      expect(mockUserRepository.findByEmail).toHaveBeenCalledWith(userData.email);
      expect(mockUserRepository.create).toHaveBeenCalledWith(
        expect.objectContaining({
          name: userData.name,
          email: userData.email,
        })
      );
      expect(result).toEqual(expect.objectContaining({
        name: userData.name,
        email: userData.email,
      }));
    });
    
    it('should throw error if email already exists', async () => {
      const userData: CreateUserDto = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
      };
      
      const existingUser = {
        id: '1',
        name: 'Existing User',
        email: 'john@example.com',
        password: 'hashed',
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      
      mockUserRepository.findByEmail.mockResolvedValue(existingUser);
      
      await expect(userService.createUser(userData)).rejects.toThrow('Email already exists');
    });
  });
});
```
{% endraw %}


### 2. **Integration Testing**

{% raw %}
```typescript
// Supertest with TypeScript
import request from 'supertest';
import { app } from '../app';
import { AppDataSource } from '../data-source';

describe('User API', () => {
  beforeAll(async () => {
    await AppDataSource.initialize();
  });
  
  afterAll(async () => {
    await AppDataSource.destroy();
  });
  
  beforeEach(async () => {
    // Clean database
    await AppDataSource.synchronize(true);
  });
  
  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
      };
      
      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);
      
      expect(response.body).toMatchObject({
        success: true,
        data: {
          name: userData.name,
          email: userData.email,
        },
      });
      
      expect(response.body.data).not.toHaveProperty('password');
    });
    
    it('should return validation error for invalid data', async () => {
      const invalidData = {
        name: '',
        email: 'invalid-email',
        password: '123',
      };
      
      const response = await request(app)
        .post('/api/users')
        .send(invalidData)
        .expect(400);
      
      expect(response.body).toMatchObject({
        success: false,
        error: expect.any(String),
      });
    });
  });
});
```
{% endraw %}


## 📚 **Essential Libraries & Tools**

### 1. **Development Tools**

{% raw %}
```typescript
// ESLint Configuration
{
  "extends": [
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error"
  }
}

// Prettier Configuration
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2
}

// TypeScript Configuration
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
    "declarationMap": true,
    "sourceMap": true,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitOverride": true,
    "noPropertyAccessFromIndexSignature": true,
    "noUncheckedIndexedAccess": true
  }
}
```
{% endraw %}


### 2. **Utility Libraries**

{% raw %}
```typescript
// Lodash with TypeScript
import _ from 'lodash';

// Type-safe lodash operations
const users: User[] = [];
const activeUsers = _.filter(users, user => user.active);
const userNames = _.map(users, 'name');
const groupedUsers = _.groupBy(users, 'department');

// Date-fns with TypeScript
import { format, addDays, isAfter, parseISO } from 'date-fns';

const today = new Date();
const tomorrow = addDays(today, 1);
const formattedDate = format(today, 'yyyy-MM-dd');
const isFuture = isAfter(tomorrow, today);

// Zod for Runtime Validation
import { z } from 'zod';

const UserSchema = z.object({
  name: z.string().min(2).max(50),
  email: z.string().email(),
  age: z.number().min(18).max(120).optional(),
});

type User = z.infer<typeof UserSchema>;

function validateUser(data: unknown): User {
  return UserSchema.parse(data);
}

// Class Validator
import { validate, IsEmail, IsString, MinLength } from 'class-validator';

class CreateUserDto {
  @IsString()
  @MinLength(2)
  name: string;
  
  @IsEmail()
  email: string;
}

async function validateDto(dto: CreateUserDto): Promise<void> {
  const errors = await validate(dto);
  if (errors.length > 0) {
    throw new Error('Validation failed');
  }
}
```
{% endraw %}


## 🎯 **Interview Preparation Topics**

### 1. **Core Concepts to Master**
- **Type System**: Understanding TypeScript's structural typing
- **Generics**: Advanced generic patterns and constraints
- **Utility Types**: Built-in and custom utility types
- **Conditional Types**: Complex type manipulations
- **Template Literal Types**: String manipulation at type level
- **Mapped Types**: Transforming existing types
- **Branded Types**: Creating distinct types from primitives
- **Phantom Types**: Type-level programming techniques

### 2. **Advanced Patterns**
- **Design Patterns**: Singleton, Factory, Builder, Observer, etc.
- **Functional Programming**: Monads, Functors, Applicatives
- **Architectural Patterns**: Repository, Service Layer, CQRS
- **Dependency Injection**: Container patterns and IoC
- **Event-Driven Architecture**: Pub/Sub patterns
- **Microservices**: Service communication patterns

### 3. **Framework-Specific Knowledge**
- **React**: Component typing, hooks, context, HOCs
- **React Native**: Navigation, platform-specific code
- **Node.js**: Express, middleware, error handling
- **Database**: ORM integration, query optimization
- **Testing**: Unit, integration, E2E testing strategies

### 4. **Performance & Optimization**
- **Type Performance**: Efficient type definitions
- **Bundle Optimization**: Tree shaking, code splitting
- **Runtime Performance**: Type checking overhead
- **Memory Management**: Avoiding memory leaks
- **Caching Strategies**: Type-level caching

### 5. **Best Practices**
- **Code Organization**: Module structure, naming conventions
- **Error Handling**: Type-safe error handling
- **Documentation**: JSDoc, type documentation
- **Version Control**: TypeScript in CI/CD
- **Code Review**: TypeScript review guidelines

## 🚀 **Learning Path & Timeline**

### **Phase 1: Fundamentals (2-3 weeks)**
1. TypeScript basics and type system
2. Generics and advanced types
3. Utility types and type manipulation
4. Basic design patterns

### **Phase 2: Framework Integration (3-4 weeks)**
1. React/React Native with TypeScript
2. Node.js backend development
3. Database integration
4. API design and validation

### **Phase 3: Advanced Patterns (4-5 weeks)**
1. Advanced generic patterns
2. Type-level programming
3. Complex architectural patterns
4. Performance optimization

### **Phase 4: Production Ready (2-3 weeks)**
1. Testing strategies
2. CI/CD integration
3. Code quality tools
4. Best practices and conventions

## 📖 **Recommended Resources**

### **Books**
- "Programming TypeScript" by Boris Cherny
- "Effective TypeScript" by Dan Vanderkam
- "TypeScript Deep Dive" by Basarat Ali Syed

### **Online Courses**
- TypeScript Official Documentation
- Advanced TypeScript courses on Udemy/Pluralsight
- React with TypeScript courses

### **Practice Platforms**
- LeetCode with TypeScript
- HackerRank TypeScript challenges
- TypeScript playground for experimentation

### **Community**
- TypeScript Discord
- Stack Overflow TypeScript tag
- GitHub TypeScript repositories

## 🎯 **Interview Questions to Prepare**

### **Basic Level**
1. What is TypeScript and why use it?
2. Difference between `any` and `unknown`?
3. How do generics work in TypeScript?
4. What are utility types?

### **Intermediate Level**
1. Explain conditional types with examples
2. How to create type-safe APIs?
3. What are branded types and when to use them?
4. How to handle errors in TypeScript?

### **Advanced Level**
1. Implement a type-safe state management system
2. Create a type-safe ORM interface
3. Design a type-safe event system
4. Implement complex generic constraints

### **Senior Level**
1. Design a type-safe microservices architecture
2. Create a type-safe testing framework
3. Implement type-safe dependency injection
4. Design a type-safe plugin system

This roadmap provides a comprehensive path to mastering TypeScript for senior-level positions. Focus on understanding the concepts deeply rather than memorizing syntax, and practice implementing real-world solutions using these patterns.

