# 🎨 **Design Patterns in TypeScript**

> **Complete guide to implementing design patterns in TypeScript with type safety and modern JavaScript features**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Design Patterns Overview](#design-patterns-overview)
- [Creational Patterns](#creational-patterns)
- [Structural Patterns](#structural-patterns)
- [Behavioral Patterns](#behavioral-patterns)
- [TypeScript-Specific Patterns](#typescript-specific-patterns)
- [Advanced Pattern Implementations](#advanced-pattern-implementations)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Design Patterns Overview**

Design patterns are reusable solutions to common problems in software design. TypeScript enhances these patterns with type safety.

### **Pattern Categories**


{% raw %}
```typescript
// Design pattern categories
interface PatternCategories {
  creational: "Object creation patterns";
  structural: "Object composition patterns";
  behavioral: "Object interaction patterns";
}

// TypeScript benefits for design patterns
const typescriptBenefits = {
  typeSafety: "Compile-time type checking",
  intellisense: "Better IDE support",
  refactoring: "Safer code changes",
  documentation: "Self-documenting code"
};
```
{% endraw %}


### **Pattern Implementation Principles**


{% raw %}
```typescript
// Key principles for TypeScript pattern implementation
const principles = {
  typeSafety: "Use TypeScript's type system to enforce contracts",
  generics: "Leverage generics for reusable patterns",
  interfaces: "Define clear contracts with interfaces",
  composition: "Prefer composition over inheritance"
};
```
{% endraw %}


---

## 🏗️ **Creational Patterns**

Creational patterns deal with object creation mechanisms.

### **Singleton Pattern**


{% raw %}
```typescript
// Singleton pattern with TypeScript
class DatabaseConnection {
  private static instance: DatabaseConnection;
  private connection: string;

  private constructor() {
    this.connection = "Connected to database";
  }

  public static getInstance(): DatabaseConnection {
    if (!DatabaseConnection.instance) {
      DatabaseConnection.instance = new DatabaseConnection();
    }
    return DatabaseConnection.instance;
  }

  public getConnection(): string {
    return this.connection;
  }
}

// Usage
const db1 = DatabaseConnection.getInstance();
const db2 = DatabaseConnection.getInstance();
console.log(db1 === db2); // true
```
{% endraw %}


### **Factory Pattern**


{% raw %}
```typescript
// Factory pattern with TypeScript
interface Animal {
  name: string;
  makeSound(): string;
}

class Dog implements Animal {
  constructor(public name: string) {}
  
  makeSound(): string {
    return "Woof!";
  }
}

class Cat implements Animal {
  constructor(public name: string) {}
  
  makeSound(): string {
    return "Meow!";
  }
}

// Animal factory
class AnimalFactory {
  public static createAnimal(type: "dog" | "cat", name: string): Animal {
    switch (type) {
      case "dog":
        return new Dog(name);
      case "cat":
        return new Cat(name);
      default:
        throw new Error("Unknown animal type");
    }
  }
}

// Usage
const dog = AnimalFactory.createAnimal("dog", "Buddy");
const cat = AnimalFactory.createAnimal("cat", "Whiskers");
```
{% endraw %}


### **Builder Pattern**


{% raw %}
```typescript
// Builder pattern with TypeScript
interface User {
  id: number;
  name: string;
  email: string;
  age?: number;
  phone?: string;
  address?: string;
}

class UserBuilder {
  private user: Partial<User> = {};

  public setId(id: number): UserBuilder {
    this.user.id = id;
    return this;
  }

  public setName(name: string): UserBuilder {
    this.user.name = name;
    return this;
  }

  public setEmail(email: string): UserBuilder {
    this.user.email = email;
    return this;
  }

  public setAge(age: number): UserBuilder {
    this.user.age = age;
    return this;
  }

  public setPhone(phone: string): UserBuilder {
    this.user.phone = phone;
    return this;
  }

  public setAddress(address: string): UserBuilder {
    this.user.address = address;
    return this;
  }

  public build(): User {
    if (!this.user.id || !this.user.name || !this.user.email) {
      throw new Error("Required fields missing");
    }
    return this.user as User;
  }
}

// Usage
const user = new UserBuilder()
  .setId(1)
  .setName("John Doe")
  .setEmail("john@example.com")
  .setAge(30)
  .setPhone("123-456-7890")
  .build();
```
{% endraw %}


---

## 🏛️ **Structural Patterns**

Structural patterns deal with object composition and relationships.

### **Adapter Pattern**


{% raw %}
```typescript
// Adapter pattern with TypeScript
interface OldAPI {
  getData(): string;
}

interface NewAPI {
  fetchData(): Promise<string>;
}

// Old API implementation
class OldAPIService implements OldAPI {
  getData(): string {
    return "Data from old API";
  }
}

// New API implementation
class NewAPIService implements NewAPI {
  async fetchData(): Promise<string> {
    return "Data from new API";
  }
}

// Adapter to make old API compatible with new API
class APIAdapter implements NewAPI {
  constructor(private oldAPI: OldAPI) {}

  async fetchData(): Promise<string> {
    return Promise.resolve(this.oldAPI.getData());
  }
}

// Usage
const oldAPI = new OldAPIService();
const adapter = new APIAdapter(oldAPI);
const data = await adapter.fetchData();
```
{% endraw %}


### **Decorator Pattern**


{% raw %}
```typescript
// Decorator pattern with TypeScript
interface Coffee {
  cost(): number;
  description(): string;
}

class SimpleCoffee implements Coffee {
  cost(): number {
    return 2;
  }

  description(): string {
    return "Simple coffee";
  }
}

// Base decorator
abstract class CoffeeDecorator implements Coffee {
  constructor(protected coffee: Coffee) {}

  cost(): number {
    return this.coffee.cost();
  }

  description(): string {
    return this.coffee.description();
  }
}

// Concrete decorators
class MilkDecorator extends CoffeeDecorator {
  cost(): number {
    return this.coffee.cost() + 0.5;
  }

  description(): string {
    return this.coffee.description() + ", milk";
  }
}

class SugarDecorator extends CoffeeDecorator {
  cost(): number {
    return this.coffee.cost() + 0.2;
  }

  description(): string {
    return this.coffee.description() + ", sugar";
  }
}

// Usage
let coffee: Coffee = new SimpleCoffee();
coffee = new MilkDecorator(coffee);
coffee = new SugarDecorator(coffee);

console.log(coffee.description()); // "Simple coffee, milk, sugar"
console.log(coffee.cost()); // 2.7
```
{% endraw %}


### **Facade Pattern**


{% raw %}
```typescript
// Facade pattern with TypeScript
class CPU {
  freeze(): void {
    console.log("CPU frozen");
  }

  jump(position: number): void {
    console.log(`CPU jumping to position ${position}`);
  }

  execute(): void {
    console.log("CPU executing");
  }
}

class Memory {
  load(position: number, data: string): void {
    console.log(`Memory loading data at position ${position}`);
  }
}

class HardDrive {
  read(lba: number, size: number): string {
    console.log(`Hard drive reading ${size} bytes from LBA ${lba}`);
    return "Boot data";
  }
}

// Facade
class ComputerFacade {
  private cpu: CPU;
  private memory: Memory;
  private hardDrive: HardDrive;

  constructor() {
    this.cpu = new CPU();
    this.memory = new Memory();
    this.hardDrive = new HardDrive();
  }

  start(): void {
    this.cpu.freeze();
    this.memory.load(0, this.hardDrive.read(0, 1024));
    this.cpu.jump(0);
    this.cpu.execute();
  }
}

// Usage
const computer = new ComputerFacade();
computer.start();
```
{% endraw %}


---

## 🎭 **Behavioral Patterns**

Behavioral patterns deal with object interaction and communication.

### **Observer Pattern**


{% raw %}
```typescript
// Observer pattern with TypeScript
interface Observer<T> {
  update(data: T): void;
}

interface Subject<T> {
  attach(observer: Observer<T>): void;
  detach(observer: Observer<T>): void;
  notify(data: T): void;
}

class NewsAgency implements Subject<string> {
  private observers: Observer<string>[] = [];

  attach(observer: Observer<string>): void {
    this.observers.push(observer);
  }

  detach(observer: Observer<string>): void {
    const index = this.observers.indexOf(observer);
    if (index > -1) {
      this.observers.splice(index, 1);
    }
  }

  notify(news: string): void {
    this.observers.forEach(observer => observer.update(news));
  }

  publishNews(news: string): void {
    console.log(`Publishing news: ${news}`);
    this.notify(news);
  }
}

class NewsChannel implements Observer<string> {
  constructor(private name: string) {}

  update(news: string): void {
    console.log(`${this.name} received news: ${news}`);
  }
}

// Usage
const agency = new NewsAgency();
const channel1 = new NewsChannel("CNN");
const channel2 = new NewsChannel("BBC");

agency.attach(channel1);
agency.attach(channel2);

agency.publishNews("Breaking: TypeScript 5.0 released!");
```
{% endraw %}


### **Strategy Pattern**


{% raw %}
```typescript
// Strategy pattern with TypeScript
interface PaymentStrategy {
  pay(amount: number): string;
}

class CreditCardPayment implements PaymentStrategy {
  constructor(private cardNumber: string) {}

  pay(amount: number): string {
    return `Paid $${amount} using credit card ending in ${this.cardNumber.slice(-4)}`;
  }
}

class PayPalPayment implements PaymentStrategy {
  constructor(private email: string) {}

  pay(amount: number): string {
    return `Paid $${amount} using PayPal account ${this.email}`;
  }
}

class BankTransferPayment implements PaymentStrategy {
  constructor(private accountNumber: string) {}

  pay(amount: number): string {
    return `Paid $${amount} using bank transfer to account ${this.accountNumber}`;
  }
}

class PaymentProcessor {
  constructor(private strategy: PaymentStrategy) {}

  setStrategy(strategy: PaymentStrategy): void {
    this.strategy = strategy;
  }

  processPayment(amount: number): string {
    return this.strategy.pay(amount);
  }
}

// Usage
const processor = new PaymentProcessor(new CreditCardPayment("1234567890123456"));
console.log(processor.processPayment(100));

processor.setStrategy(new PayPalPayment("user@example.com"));
console.log(processor.processPayment(50));
```
{% endraw %}


### **Command Pattern**


{% raw %}
```typescript
// Command pattern with TypeScript
interface Command {
  execute(): void;
  undo(): void;
}

class Light {
  private isOn: boolean = false;

  turnOn(): void {
    this.isOn = true;
    console.log("Light is on");
  }

  turnOff(): void {
    this.isOn = false;
    console.log("Light is off");
  }

  getState(): boolean {
    return this.isOn;
  }
}

class LightOnCommand implements Command {
  constructor(private light: Light) {}

  execute(): void {
    this.light.turnOn();
  }

  undo(): void {
    this.light.turnOff();
  }
}

class LightOffCommand implements Command {
  constructor(private light: Light) {}

  execute(): void {
    this.light.turnOff();
  }

  undo(): void {
    this.light.turnOn();
  }
}

class RemoteControl {
  private commands: Command[] = [];
  private currentCommand: number = -1;

  setCommand(command: Command): void {
    this.commands.push(command);
    this.currentCommand = this.commands.length - 1;
  }

  pressButton(): void {
    if (this.currentCommand >= 0) {
      this.commands[this.currentCommand].execute();
    }
  }

  pressUndo(): void {
    if (this.currentCommand >= 0) {
      this.commands[this.currentCommand].undo();
      this.currentCommand--;
    }
  }
}

// Usage
const light = new Light();
const lightOn = new LightOnCommand(light);
const lightOff = new LightOffCommand(light);

const remote = new RemoteControl();
remote.setCommand(lightOn);
remote.pressButton(); // Light is on

remote.setCommand(lightOff);
remote.pressButton(); // Light is off

remote.pressUndo(); // Light is on
```
{% endraw %}


---

## 🎯 **TypeScript-Specific Patterns**

### **Generic Factory Pattern**


{% raw %}
```typescript
// Generic factory pattern
interface Factory<T> {
  create(): T;
}

class UserFactory implements Factory<User> {
  create(): User {
    return {
      id: Date.now(),
      name: "Default User",
      email: "user@example.com"
    };
  }
}

class ProductFactory implements Factory<Product> {
  create(): Product {
    return {
      id: Date.now(),
      name: "Default Product",
      price: 0
    };
  }
}

// Generic factory registry
class FactoryRegistry {
  private factories = new Map<string, Factory<any>>();

  register<T>(type: string, factory: Factory<T>): void {
    this.factories.set(type, factory);
  }

  create<T>(type: string): T {
    const factory = this.factories.get(type);
    if (!factory) {
      throw new Error(`Factory for type ${type} not found`);
    }
    return factory.create();
  }
}

// Usage
const registry = new FactoryRegistry();
registry.register("user", new UserFactory());
registry.register("product", new ProductFactory());

const user = registry.create<User>("user");
const product = registry.create<Product>("product");
```
{% endraw %}


### **Type-Safe Builder Pattern**


{% raw %}
```typescript
// Type-safe builder pattern
interface UserBuilderState {
  id: number;
  name: string;
  email: string;
  age?: number;
  phone?: string;
}

class UserBuilder {
  private state: Partial<UserBuilderState> = {};

  setId(id: number): this {
    this.state.id = id;
    return this;
  }

  setName(name: string): this {
    this.state.name = name;
    return this;
  }

  setEmail(email: string): this {
    this.state.email = email;
    return this;
  }

  setAge(age: number): this {
    this.state.age = age;
    return this;
  }

  setPhone(phone: string): this {
    this.state.phone = phone;
    return this;
  }

  build(): UserBuilderState {
    if (!this.state.id || !this.state.name || !this.state.email) {
      throw new Error("Required fields missing");
    }
    return this.state as UserBuilderState;
  }
}

// Usage
const user = new UserBuilder()
  .setId(1)
  .setName("John Doe")
  .setEmail("john@example.com")
  .setAge(30)
  .build();
```
{% endraw %}


---

## 🚀 **Advanced Pattern Implementations**

### **Dependency Injection Pattern**


{% raw %}
```typescript
// Dependency injection pattern
interface Service {
  execute(): string;
}

class DatabaseService implements Service {
  execute(): string {
    return "Database operation completed";
  }
}

class EmailService implements Service {
  execute(): string {
    return "Email sent successfully";
  }
}

class UserService {
  constructor(
    private databaseService: Service,
    private emailService: Service
  ) {}

  createUser(name: string): string {
    const dbResult = this.databaseService.execute();
    const emailResult = this.emailService.execute();
    return `User ${name} created. ${dbResult} ${emailResult}`;
  }
}

// Dependency injection container
class Container {
  private services = new Map<string, any>();

  register<T>(token: string, service: T): void {
    this.services.set(token, service);
  }

  resolve<T>(token: string): T {
    const service = this.services.get(token);
    if (!service) {
      throw new Error(`Service ${token} not found`);
    }
    return service;
  }
}

// Usage
const container = new Container();
container.register("database", new DatabaseService());
container.register("email", new EmailService());

const userService = new UserService(
  container.resolve<Service>("database"),
  container.resolve<Service>("email")
);

console.log(userService.createUser("John"));
```
{% endraw %}


### **Repository Pattern**


{% raw %}
```typescript
// Repository pattern
interface Repository<T, K> {
  findById(id: K): Promise<T | null>;
  findAll(): Promise<T[]>;
  save(entity: T): Promise<T>;
  delete(id: K): Promise<void>;
}

class UserRepository implements Repository<User, number> {
  private users: User[] = [];

  async findById(id: number): Promise<User | null> {
    return this.users.find(user => user.id === id) || null;
  }

  async findAll(): Promise<User[]> {
    return [...this.users];
  }

  async save(user: User): Promise<User> {
    const existingIndex = this.users.findIndex(u => u.id === user.id);
    if (existingIndex >= 0) {
      this.users[existingIndex] = user;
    } else {
      this.users.push(user);
    }
    return user;
  }

  async delete(id: number): Promise<void> {
    const index = this.users.findIndex(user => user.id === id);
    if (index >= 0) {
      this.users.splice(index, 1);
    }
  }
}

// Usage
const userRepo = new UserRepository();
const user = await userRepo.save({ id: 1, name: "John", email: "john@example.com" });
const foundUser = await userRepo.findById(1);
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Use TypeScript's Type System**


{% raw %}
```typescript
// ✅ Good: Use interfaces for contracts
interface PaymentStrategy {
  pay(amount: number): string;
}

// ❌ Avoid: Using any types
class PaymentProcessor {
  processPayment(strategy: any, amount: any): any {
    return strategy.pay(amount);
  }
}
```
{% endraw %}


### **2. Leverage Generics for Reusability**


{% raw %}
```typescript
// ✅ Good: Use generics for reusable patterns
interface Repository<T, K> {
  findById(id: K): Promise<T | null>;
  save(entity: T): Promise<T>;
}

// ❌ Avoid: Hardcoded types
interface UserRepository {
  findById(id: number): Promise<User | null>;
  save(user: User): Promise<User>;
}
```
{% endraw %}


### **3. Prefer Composition Over Inheritance**


{% raw %}
```typescript
// ✅ Good: Use composition
class CoffeeWithMilk {
  constructor(private coffee: Coffee) {}
  
  cost(): number {
    return this.coffee.cost() + 0.5;
  }
}

// ❌ Avoid: Deep inheritance hierarchies
class CoffeeWithMilk extends Coffee {
  // Implementation
}
```
{% endraw %}


### **4. Use Dependency Injection**


{% raw %}
```typescript
// ✅ Good: Use dependency injection
class UserService {
  constructor(private userRepo: UserRepository) {}
}

// ❌ Avoid: Hard dependencies
class UserService {
  private userRepo = new UserRepository();
}
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. What are design patterns and why are they useful?**

**Answer:**
Design patterns are reusable solutions to common problems in software design. They provide:
- **Consistency**: Standardized approaches to common problems
- **Maintainability**: Easier to understand and modify code
- **Reusability**: Solutions that can be applied across projects
- **Communication**: Common vocabulary for developers

### **2. How do you implement the Singleton pattern in TypeScript?**

**Answer:**

{% raw %}
```typescript
class Singleton {
  private static instance: Singleton;
  
  private constructor() {}
  
  public static getInstance(): Singleton {
    if (!Singleton.instance) {
      Singleton.instance = new Singleton();
    }
    return Singleton.instance;
  }
}
```
{% endraw %}


### **3. What's the difference between the Factory and Builder patterns?**

**Answer:**
- **Factory**: Creates objects without exposing creation logic
- **Builder**: Constructs complex objects step by step

### **4. How do you implement the Observer pattern in TypeScript?**

**Answer:**

{% raw %}
```typescript
interface Observer<T> {
  update(data: T): void;
}

interface Subject<T> {
  attach(observer: Observer<T>): void;
  notify(data: T): void;
}
```
{% endraw %}


### **5. What are the benefits of using design patterns with TypeScript?**

**Answer:**
- **Type safety**: Compile-time type checking
- **IntelliSense**: Better IDE support
- **Refactoring**: Safer code changes
- **Documentation**: Self-documenting code through types

---

## 🧭 Navigation

<div class="navigation">
  <a href="../03-TypeScript-Configuration-Tooling/04-IDE-Integration-Debugging.md" class="nav-button">← Previous: IDE Integration & Debugging</a>
  <a href="02-Functional-Programming-TypeScript.md" class="nav-button">Next: Functional Programming with TypeScript →</a>
</div>

*Last updated: December 2025*
