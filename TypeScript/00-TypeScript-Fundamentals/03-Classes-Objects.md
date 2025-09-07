# 🏗️ **Classes & Objects**

> **Complete guide to TypeScript classes, objects, inheritance, and object-oriented programming features**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Class Declarations](#class-declarations)
- [Class Properties](#class-properties)
- [Class Methods](#class-methods)
- [Access Modifiers](#access-modifiers)
- [Inheritance](#inheritance)
- [Abstract Classes](#abstract-classes)
- [Interfaces vs Classes](#interfaces-vs-classes)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Class Declarations**

TypeScript classes provide a way to define object-oriented structures with type safety.

### **Basic Class Declaration**

```typescript
class Person {
  name: string;
  age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }

  greet(): string {
    return `Hello, I'm ${this.name} and I'm ${this.age} years old.`;
  }
}

// Usage
const person = new Person("John", 30);
console.log(person.greet()); // "Hello, I'm John and I'm 30 years old."
```

### **Class with Optional Properties**

```typescript
class User {
  id: number;
  username: string;
  email?: string; // Optional property
  isActive: boolean = true; // Default value

  constructor(id: number, username: string, email?: string) {
    this.id = id;
    this.username = username;
    this.email = email;
  }
}

// Usage
const user1 = new User(1, "john_doe");
const user2 = new User(2, "jane_doe", "jane@example.com");
```

---

## 📊 **Class Properties**

TypeScript provides several ways to define and initialize class properties.

### **Property Initialization**

```typescript
class Rectangle {
  // Property with type annotation
  width: number;
  height: number;
  
  // Property with default value
  color: string = "blue";
  
  // Readonly property
  readonly id: string;
  
  // Static property
  static totalRectangles: number = 0;

  constructor(width: number, height: number, id: string) {
    this.width = width;
    this.height = height;
    this.id = id;
    Rectangle.totalRectangles++;
  }
}
```

### **Property Parameter Shorthand**

```typescript
class Point {
  // Shorthand property declaration in constructor
  constructor(
    public x: number,
    public y: number,
    private readonly id: string
  ) {
    // x, y, and id are automatically assigned
  }
}

// Equivalent to:
class Point {
  public x: number;
  public y: number;
  private readonly id: string;

  constructor(x: number, y: number, id: string) {
    this.x = x;
    this.y = y;
    this.id = id;
  }
}
```

---

## 🔧 **Class Methods**

TypeScript classes support various types of methods with full type safety.

### **Instance Methods**

```typescript
class Calculator {
  private history: number[] = [];

  add(a: number, b: number): number {
    const result = a + b;
    this.history.push(result);
    return result;
  }

  subtract(a: number, b: number): number {
    const result = a - b;
    this.history.push(result);
    return result;
  }

  getHistory(): number[] {
    return [...this.history]; // Return copy to prevent external modification
  }

  clearHistory(): void {
    this.history = [];
  }
}
```

### **Static Methods**

```typescript
class MathUtils {
  static PI: number = 3.14159;

  static circleArea(radius: number): number {
    return this.PI * radius * radius;
  }

  static distance(x1: number, y1: number, x2: number, y2: number): number {
    return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
  }
}

// Usage
const area = MathUtils.circleArea(5);
const dist = MathUtils.distance(0, 0, 3, 4);
```

### **Getter and Setter Methods**

```typescript
class Temperature {
  private _celsius: number = 0;

  get celsius(): number {
    return this._celsius;
  }

  set celsius(value: number) {
    if (value < -273.15) {
      throw new Error("Temperature cannot be below absolute zero");
    }
    this._celsius = value;
  }

  get fahrenheit(): number {
    return (this._celsius * 9/5) + 32;
  }

  set fahrenheit(value: number) {
    this.celsius = (value - 32) * 5/9;
  }
}

// Usage
const temp = new Temperature();
temp.celsius = 25;
console.log(temp.fahrenheit); // 77
```

---

## 🔒 **Access Modifiers**

TypeScript provides access modifiers to control visibility of class members.

### **Public, Private, and Protected**

```typescript
class BankAccount {
  public accountNumber: string; // Accessible from anywhere
  private balance: number; // Only accessible within this class
  protected owner: string; // Accessible within this class and subclasses

  constructor(accountNumber: string, initialBalance: number, owner: string) {
    this.accountNumber = accountNumber;
    this.balance = initialBalance;
    this.owner = owner;
  }

  public deposit(amount: number): void {
    if (amount > 0) {
      this.balance += amount;
    }
  }

  public withdraw(amount: number): boolean {
    if (amount > 0 && amount <= this.balance) {
      this.balance -= amount;
      return true;
    }
    return false;
  }

  public getBalance(): number {
    return this.balance;
  }
}
```

### **Readonly Modifier**

```typescript
class Product {
  readonly id: string;
  readonly createdAt: Date;
  name: string;
  price: number;

  constructor(id: string, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.createdAt = new Date();
  }

  // Cannot modify readonly properties after initialization
  // this.id = "new-id"; // ❌ Error
}
```

---

## 🔄 **Inheritance**

TypeScript supports class inheritance with the `extends` keyword.

### **Basic Inheritance**

```typescript
class Animal {
  protected name: string;
  protected age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }

  makeSound(): string {
    return "Some generic animal sound";
  }

  getInfo(): string {
    return `${this.name} is ${this.age} years old`;
  }
}

class Dog extends Animal {
  private breed: string;

  constructor(name: string, age: number, breed: string) {
    super(name, age); // Call parent constructor
    this.breed = breed;
  }

  makeSound(): string {
    return "Woof!";
  }

  getBreed(): string {
    return this.breed;
  }
}

// Usage
const dog = new Dog("Buddy", 3, "Golden Retriever");
console.log(dog.makeSound()); // "Woof!"
console.log(dog.getInfo()); // "Buddy is 3 years old"
```

### **Method Overriding**

```typescript
class Vehicle {
  protected speed: number = 0;

  accelerate(amount: number): void {
    this.speed += amount;
  }

  getSpeed(): number {
    return this.speed;
  }
}

class Car extends Vehicle {
  private maxSpeed: number = 120;

  accelerate(amount: number): void {
    // Override parent method with additional logic
    if (this.speed + amount <= this.maxSpeed) {
      super.accelerate(amount); // Call parent method
    } else {
      this.speed = this.maxSpeed;
    }
  }
}
```

---

## 🎭 **Abstract Classes**

Abstract classes provide a base for other classes but cannot be instantiated directly.

### **Abstract Class Definition**

```typescript
abstract class Shape {
  protected color: string;

  constructor(color: string) {
    this.color = color;
  }

  // Abstract method - must be implemented by subclasses
  abstract calculateArea(): number;

  // Concrete method - can be used by subclasses
  getColor(): string {
    return this.color;
  }
}

class Circle extends Shape {
  private radius: number;

  constructor(color: string, radius: number) {
    super(color);
    this.radius = radius;
  }

  calculateArea(): number {
    return Math.PI * this.radius * this.radius;
  }
}

class Rectangle extends Shape {
  private width: number;
  private height: number;

  constructor(color: string, width: number, height: number) {
    super(color);
    this.width = width;
    this.height = height;
  }

  calculateArea(): number {
    return this.width * this.height;
  }
}

// Usage
const circle = new Circle("red", 5);
const rectangle = new Rectangle("blue", 4, 6);

console.log(circle.calculateArea()); // 78.54
console.log(rectangle.calculateArea()); // 24
```

---

## ⚖️ **Interfaces vs Classes**

Understanding when to use interfaces vs classes is crucial in TypeScript.

### **When to Use Classes**

```typescript
// Use classes when you need:
// 1. Implementation details
// 2. Inheritance
// 3. Access modifiers
// 4. Constructors

class DatabaseConnection {
  private connectionString: string;
  private isConnected: boolean = false;

  constructor(connectionString: string) {
    this.connectionString = connectionString;
  }

  connect(): void {
    // Implementation details
    this.isConnected = true;
  }

  disconnect(): void {
    this.isConnected = false;
  }

  isConnectionActive(): boolean {
    return this.isConnected;
  }
}
```

### **When to Use Interfaces**

```typescript
// Use interfaces when you need:
// 1. Type contracts
// 2. Multiple inheritance
// 3. Lightweight type definitions

interface Drawable {
  draw(): void;
}

interface Movable {
  move(x: number, y: number): void;
}

// Class can implement multiple interfaces
class Sprite implements Drawable, Movable {
  private x: number = 0;
  private y: number = 0;

  draw(): void {
    console.log(`Drawing sprite at (${this.x}, ${this.y})`);
  }

  move(x: number, y: number): void {
    this.x = x;
    this.y = y;
  }
}
```

---

## ✅ **Best Practices**

### **1. Use Access Modifiers Appropriately**

```typescript
// ✅ Good: Proper use of access modifiers
class UserService {
  private apiUrl: string;
  protected cache: Map<string, any>;

  constructor(apiUrl: string) {
    this.apiUrl = apiUrl;
    this.cache = new Map();
  }

  public async getUser(id: string): Promise<User> {
    // Public method for external use
    return this.fetchUser(id);
  }

  private async fetchUser(id: string): Promise<User> {
    // Private method for internal use
    // Implementation details
  }
}
```

### **2. Prefer Composition Over Inheritance**

```typescript
// ✅ Good: Composition
class Engine {
  start(): void {
    console.log("Engine started");
  }
}

class Car {
  private engine: Engine;

  constructor(engine: Engine) {
    this.engine = engine;
  }

  start(): void {
    this.engine.start();
  }
}

// ❌ Avoid: Deep inheritance hierarchies
class Vehicle { }
class MotorVehicle extends Vehicle { }
class Car extends MotorVehicle { }
class SportsCar extends Car { }
```

### **3. Use Abstract Classes for Common Behavior**

```typescript
// ✅ Good: Abstract class for shared behavior
abstract class Repository<T> {
  protected items: T[] = [];

  abstract save(item: T): void;
  abstract findById(id: string): T | undefined;

  getAll(): T[] {
    return [...this.items];
  }

  count(): number {
    return this.items.length;
  }
}
```

---

## ❓ **Common Interview Questions**

### **1. What are the differences between classes and interfaces in TypeScript?**

**Answer:**
- **Classes**: Provide implementation, can be instantiated, support inheritance, have access modifiers
- **Interfaces**: Define contracts, cannot be instantiated, support multiple inheritance, are compile-time only

```typescript
// Interface - contract only
interface Drawable {
  draw(): void;
}

// Class - implementation
class Circle implements Drawable {
  draw(): void {
    console.log("Drawing circle");
  }
}
```

### **2. How do access modifiers work in TypeScript?**

**Answer:**
TypeScript provides three access modifiers:
- **`public`**: Accessible from anywhere (default)
- **`private`**: Only accessible within the same class
- **`protected`**: Accessible within the class and its subclasses

### **3. What are abstract classes and when should you use them?**

**Answer:**
Abstract classes:
- Cannot be instantiated directly
- Can contain both abstract and concrete methods
- Provide a base for other classes
- Use when you want to share common behavior while enforcing implementation of specific methods

### **4. How does inheritance work in TypeScript?**

**Answer:**
Inheritance uses the `extends` keyword:
- Child classes inherit all public and protected members
- Use `super()` to call parent constructor
- Methods can be overridden in child classes
- Use `super.methodName()` to call parent methods

### **5. What's the difference between `readonly` and `const`?**

**Answer:**
- **`const`**: Cannot be reassigned, must be initialized at declaration
- **`readonly`**: Cannot be modified after initialization, can be initialized in constructor

```typescript
const PI = 3.14159; // Cannot be reassigned

class Circle {
  readonly radius: number; // Can be set in constructor
  
  constructor(radius: number) {
    this.radius = radius; // OK
  }
}
```

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Functions-Parameters.md" class="nav-button">← Previous: Functions & Parameters</a>
  <a href="../01-Advanced-Type-System/01-Union-Intersection-Types.md" class="nav-button">Next: Union & Intersection Types →</a>
</div>

*Last updated: December 2025*
