# 🔗 Prototype & Prototypal Inheritance

> **Understanding JavaScript's inheritance mechanism and how objects share behavior**

<link rel="stylesheet" href="../common-styles.css">

---

## 📋 Table of Contents

- [What is Prototypal Inheritance?](#what-is-prototypal-inheritance)
- [The Prototype Chain](#the-prototype-chain)
- [Prototype vs __proto__](#prototype-vs-__proto__)
- [Object.create()](#objectcreate)
- [Constructor Functions](#constructor-functions)
- [ES6 Classes](#es6-classes)
- [Inheritance Patterns](#inheritance-patterns)
- [Detailed Examples](#detailed-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Key Points](#key-points)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 What is Prototypal Inheritance?

**Prototypal Inheritance** is JavaScript's mechanism for objects to inherit properties and methods from other objects. Unlike classical inheritance, JavaScript uses a prototype chain where objects can share behavior through a linked series of prototypes.

### Why Understanding This Matters:
- **Object-Oriented Design**: Implement inheritance patterns correctly
- **Performance**: Understand property lookup mechanisms
- **Debugging**: Know how to trace property access
- **Modern JavaScript**: Understand how classes work under the hood
- **Library Development**: Create reusable object hierarchies

---

## 🔗 The Prototype Chain

The prototype chain is a series of linked objects that JavaScript traverses when looking for properties.

### ASCII Diagram: Prototype Chain

```
PROTOTYPE CHAIN STRUCTURE
┌─────────────────────────────────┐
│ myObject                        │
│ {                              │
│   name: "John",                │
│   age: 30                      │
│ }                              │
│ __proto__ →                    │
└─────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────┐
│ Object.prototype                │
│ {                              │
│   toString: function,           │
│   hasOwnProperty: function,    │
│   constructor: Object,          │
│   __proto__: null              │
│ }                              │
└─────────────────────────────────┘
```


### How Property Lookup Works:
1. Check if property exists on the object itself
2. If not found, check the object's prototype (`__proto__`)
3. Continue up the chain until `Object.prototype`
4. If still not found, return `undefined`

---

## 🔍 Prototype vs __proto__

### `prototype` Property:
- **Function property** that defines what instances will inherit
- **Only exists on functions** (constructors)
- **Used to add methods/properties** to all instances

### `__proto__` Property:
- **Internal property** that points to the object's prototype
- **Exists on all objects**
- **Read-only** in modern JavaScript (use `Object.getPrototypeOf()`)

### ASCII Diagram: Prototype vs __proto__

```
CONSTRUCTOR FUNCTION          INSTANCE OBJECT
┌─────────────────────────┐   ┌─────────────────────────┐
│ function Person() {}    │   │ const person = {}       │
│                         │   │                         │
│ prototype: {            │   │ __proto__: →            │
│   greet() { ... }       │   │                         │
│ }                       │   │                         │
└─────────────────────────┘   └─────────────────────────┘
         │                              │
         │                              ▼
         └──────────────────────────────┘
                                    │
                                    ▼
                            ┌─────────────────────────┐
                            │ Person.prototype        │
                            │ {                      │
                            │   greet() { ... }       │
                            │ }                      │
                            └─────────────────────────┘
```


---

## 🏗️ Object.create()

`Object.create()` creates a new object with a specified prototype.

### Syntax:

```javascript
Object.create(proto, propertiesObject)
```


### ASCII Diagram: Object.create()

```
OBJECT.CREATE FLOW
┌─────────────────────────────────┐
│ const proto = {                 │
│   greet() { return "Hello"; }   │
│ };                              │
└─────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────┐
│ const obj = Object.create(proto); │
│ __proto__ → proto               │
└─────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────┐
│ obj.greet() → "Hello"          │
│ (inherited from proto)          │
└─────────────────────────────────┘
```


---

## 🔨 Constructor Functions

Constructor functions create objects with shared behavior through prototypes.

### ASCII Diagram: Constructor Function

```
CONSTRUCTOR FUNCTION PATTERN
┌─────────────────────────────────┐
│ function Person(name) {         │
│   this.name = name;             │
│ }                               │
│                                 │
│ Person.prototype.greet =        │
│   function() {                  │
│     return "Hello, " + this.name; │
│   };                            │
└─────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────┐
│ const person = new Person("John"); │
│ {                              │
│   name: "John",                 │
│   __proto__: Person.prototype   │
│ }                              │
└─────────────────────────────────┘
```


---

## 🎓 ES6 Classes

ES6 classes are syntactic sugar over constructor functions and prototypes.

### ASCII Diagram: ES6 Class

```
ES6 CLASS (SYNTACTIC SUGAR)
┌─────────────────────────────────┐
│ class Person {                  │
│   constructor(name) {           │
│     this.name = name;           │
│   }                            │
│                                │
│   greet() {                    │
│     return "Hello, " + this.name; │
│   }                            │
│ }                              │
└─────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────┐
│ Person.prototype = {            │
│   constructor: Person,          │
│   greet: function() { ... }     │
│ }                              │
└─────────────────────────────────┘
```


---

## 🔄 Inheritance Patterns

### 1. **Prototypal Inheritance**

```javascript
const animal = { makeSound() { return "Sound"; } };
const dog = Object.create(animal);
```


### 2. **Constructor Inheritance**

```javascript
function Animal() {}
function Dog() { Animal.call(this); }
Dog.prototype = Object.create(Animal.prototype);
```


### 3. **Class Inheritance**

```javascript
class Animal {}
class Dog extends Animal {}
```


---

## 💻 Detailed Examples

### Example 1: Basic Prototype Chain
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== BASIC PROTOTYPE CHAIN ===");

// Create a base object
const animal = {
    type: "Animal",
    makeSound() {
        return "Some sound";
    },
    getInfo() {
        return `I am a ${this.type}`;
    }
};

console.log("=== Animal object ===");
console.log("animal:", animal);
console.log("animal.type:", animal.type);
console.log("animal.makeSound():", animal.makeSound());

// Create an object that inherits from animal
const dog = Object.create(animal);
dog.name = "Buddy";
dog.breed = "Golden Retriever";

console.log("\n=== Dog object ===");
console.log("dog:", dog);
console.log("dog.name:", dog.name);
console.log("dog.breed:", dog.breed);

// Access inherited properties
console.log("\n=== Inherited properties ===");
console.log("dog.type:", dog.type);                    // Inherited from animal
console.log("dog.makeSound():", dog.makeSound());      // Inherited from animal
console.log("dog.getInfo():", dog.getInfo());          // Inherited from animal

// Check prototype chain
console.log("\n=== Prototype chain ===");
console.log("dog.__proto__ === animal:", dog.__proto__ === animal);
console.log("Object.getPrototypeOf(dog) === animal:", Object.getPrototypeOf(dog) === animal);
console.log("animal.isPrototypeOf(dog):", animal.isPrototypeOf(dog));

// Add method to dog (overrides inherited method)
dog.makeSound = function() {
    return "Woof!";
};

console.log("\n=== After overriding method ===");
console.log("dog.makeSound():", dog.makeSound());      // "Woof!" (overridden)
console.log("animal.makeSound():", animal.makeSound()); // "Some sound" (unchanged)

// Check property ownership
console.log("\n=== Property ownership ===");
console.log("dog.hasOwnProperty('name'):", dog.hasOwnProperty('name'));           // true
console.log("dog.hasOwnProperty('type'):", dog.hasOwnProperty('type'));           // false
console.log("dog.hasOwnProperty('makeSound'):", dog.hasOwnProperty('makeSound')); // true (overridden)
```

</div>

### Example 2: Constructor Functions and Prototypes
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== CONSTRUCTOR FUNCTIONS AND PROTOTYPES ===");

// Constructor function
function Person(name, age) {
    this.name = name;
    this.age = age;
}

// Add methods to prototype (shared by all instances)
Person.prototype.greet = function() {
    return `Hello, I'm ${this.name} and I'm ${this.age} years old`;
};

Person.prototype.haveBirthday = function() {
    this.age++;
    return `Happy birthday! I'm now ${this.age} years old`;
};

// Static method (belongs to constructor, not instances)
Person.createAnonymous = function() {
    return new Person("Anonymous", 0);
};

console.log("=== Person constructor ===");
console.log("Person.prototype:", Person.prototype);
console.log("Person.prototype.constructor:", Person.prototype.constructor);

// Create instances
const person1 = new Person("Alice", 25);
const person2 = new Person("Bob", 30);

console.log("\n=== Person instances ===");
console.log("person1:", person1);
console.log("person2:", person2);

// Check prototype chain
console.log("\n=== Prototype chain ===");
console.log("person1.__proto__ === Person.prototype:", person1.__proto__ === Person.prototype);
console.log("person1.constructor === Person:", person1.constructor === Person);
console.log("person1 instanceof Person:", person1 instanceof Person);

// Use inherited methods
console.log("\n=== Using inherited methods ===");
console.log("person1.greet():", person1.greet());
console.log("person2.greet():", person2.greet());
console.log("person1.haveBirthday():", person1.haveBirthday());

// Check property ownership
console.log("\n=== Property ownership ===");
console.log("person1.hasOwnProperty('name'):", person1.hasOwnProperty('name'));           // true
console.log("person1.hasOwnProperty('greet'):", person1.hasOwnProperty('greet'));       // false
console.log("Person.prototype.hasOwnProperty('greet'):", Person.prototype.hasOwnProperty('greet')); // true

// Use static method
console.log("\n=== Static method ===");
const anonymous = Person.createAnonymous();
console.log("anonymous:", anonymous);
console.log("anonymous.greet():", anonymous.greet());
```

</div>

### Example 3: Inheritance with Constructor Functions
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== INHERITANCE WITH CONSTRUCTOR FUNCTIONS ===");

// Base constructor
function Animal(name) {
    this.name = name;
}

Animal.prototype.makeSound = function() {
    return "Some sound";
};

Animal.prototype.getInfo = function() {
    return `I am ${this.name}`;
};

// Derived constructor
function Dog(name, breed) {
    // Call parent constructor
    Animal.call(this, name);
    this.breed = breed;
}

// Set up inheritance
Dog.prototype = Object.create(Animal.prototype);
Dog.prototype.constructor = Dog;  // Fix constructor reference

// Add Dog-specific methods
Dog.prototype.makeSound = function() {
    return "Woof!";
};

Dog.prototype.getBreedInfo = function() {
    return `I am a ${this.breed}`;
};

console.log("=== Constructor setup ===");
console.log("Animal.prototype:", Animal.prototype);
console.log("Dog.prototype:", Dog.prototype);
console.log("Dog.prototype.constructor:", Dog.prototype.constructor);

// Create instances
const animal = new Animal("Generic Animal");
const dog = new Dog("Buddy", "Golden Retriever");

console.log("\n=== Instances ===");
console.log("animal:", animal);
console.log("dog:", dog);

// Check inheritance
console.log("\n=== Inheritance check ===");
console.log("dog instanceof Dog:", dog instanceof Dog);           // true
console.log("dog instanceof Animal:", dog instanceof Animal);     // true
console.log("dog instanceof Object:", dog instanceof Object);     // true

// Use methods
console.log("\n=== Using methods ===");
console.log("animal.makeSound():", animal.makeSound());          // "Some sound"
console.log("dog.makeSound():", dog.makeSound());                // "Woof!" (overridden)
console.log("dog.getInfo():", dog.getInfo());                    // "I am Buddy" (inherited)
console.log("dog.getBreedInfo():", dog.getBreedInfo());          // "I am a Golden Retriever"

// Check prototype chain
console.log("\n=== Prototype chain ===");
console.log("Dog.prototype.isPrototypeOf(dog):", Dog.prototype.isPrototypeOf(dog));           // true
console.log("Animal.prototype.isPrototypeOf(dog):", Animal.prototype.isPrototypeOf(dog));     // true
console.log("Object.prototype.isPrototypeOf(dog):", Object.prototype.isPrototypeOf(dog));     // true

// Property lookup demonstration
console.log("\n=== Property lookup demonstration ===");
console.log("dog.hasOwnProperty('name'):", dog.hasOwnProperty('name'));           // true
console.log("dog.hasOwnProperty('breed'):", dog.hasOwnProperty('breed'));         // true
console.log("dog.hasOwnProperty('makeSound'):", dog.hasOwnProperty('makeSound')); // false (inherited)
console.log("dog.hasOwnProperty('getInfo'):", dog.hasOwnProperty('getInfo'));     // false (inherited)
```

</div>

### Example 4: ES6 Classes and Inheritance
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== ES6 CLASSES AND INHERITANCE ===");

// Base class
class Vehicle {
    constructor(make, model) {
        this.make = make;
        this.model = model;
    }
    
    getInfo() {
        return `${this.make} ${this.model}`;
    }
    
    start() {
        return "Vehicle starting...";
    }
    
    // Static method
    static create(make, model) {
        return new Vehicle(make, model);
    }
    
    // Getter
    get fullName() {
        return this.getInfo();
    }
    
    // Setter
    set fullName(value) {
        [this.make, this.model] = value.split(' ');
    }
}

// Derived class
class Car extends Vehicle {
    constructor(make, model, year) {
        super(make, model);  // Call parent constructor
        this.year = year;
    }
    
    start() {
        return `${super.start()} Car engine running!`;
    }
    
    getYear() {
        return this.year;
    }
}

console.log("=== Class definitions ===");
console.log("Vehicle.prototype:", Vehicle.prototype);
console.log("Car.prototype:", Car.prototype);
console.log("Car.prototype.constructor:", Car.prototype.constructor);

// Create instances
const vehicle = new Vehicle("Generic", "Vehicle");
const car = new Car("Toyota", "Camry", 2020);

console.log("\n=== Instances ===");
console.log("vehicle:", vehicle);
console.log("car:", car);

// Check inheritance
console.log("\n=== Inheritance check ===");
console.log("car instanceof Car:", car instanceof Car);           // true
console.log("car instanceof Vehicle:", car instanceof Vehicle);   // true
console.log("car instanceof Object:", car instanceof Object);     // true

// Use methods
console.log("\n=== Using methods ===");
console.log("vehicle.getInfo():", vehicle.getInfo());            // "Generic Vehicle"
console.log("car.getInfo():", car.getInfo());                    // "Toyota Camry"
console.log("vehicle.start():", vehicle.start());                // "Vehicle starting..."
console.log("car.start():", car.start());                        // "Vehicle starting... Car engine running!"
console.log("car.getYear():", car.getYear());                    // 2020

// Use getters and setters
console.log("\n=== Getters and setters ===");
console.log("car.fullName:", car.fullName);                      // "Toyota Camry"
car.fullName = "Honda Accord";
console.log("After setting fullName:", car.make, car.model);     // "Honda Accord"

// Use static method
console.log("\n=== Static method ===");
const newVehicle = Vehicle.create("Ford", "Focus");
console.log("newVehicle:", newVehicle);

// Check prototype chain
console.log("\n=== Prototype chain ===");
console.log("Car.prototype.isPrototypeOf(car):", Car.prototype.isPrototypeOf(car));           // true
console.log("Vehicle.prototype.isPrototypeOf(car):", Vehicle.prototype.isPrototypeOf(car));   // true
console.log("Object.prototype.isPrototypeOf(car):", Object.prototype.isPrototypeOf(car));     // true
```

</div>

### Example 5: Advanced Prototype Patterns
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== ADVANCED PROTOTYPE PATTERNS ===");

// Mixin pattern - combining multiple prototypes
const speakerMixin = {
    speak(message) {
        return `${this.name} says: ${message}`;
    }
};

const moverMixin = {
    move(distance) {
        return `${this.name} moved ${distance} units`;
    }
};

// Function to apply mixins
function applyMixins(target, ...mixins) {
    mixins.forEach(mixin => {
        Object.getOwnPropertyNames(mixin).forEach(name => {
            target.prototype[name] = mixin[name];
        });
    });
}

// Base constructor
function Creature(name) {
    this.name = name;
}

// Apply mixins
applyMixins(Creature, speakerMixin, moverMixin);

// Add Creature-specific methods
Creature.prototype.getInfo = function() {
    return `I am ${this.name}`;
};

console.log("=== Mixin application ===");
console.log("Creature.prototype:", Creature.prototype);

// Create instance
const creature = new Creature("Dragon");

console.log("\n=== Creature instance ===");
console.log("creature:", creature);

// Use mixed-in methods
console.log("\n=== Using mixed-in methods ===");
console.log("creature.speak('Hello'):", creature.speak("Hello"));
console.log("creature.move(10):", creature.move(10));
console.log("creature.getInfo():", creature.getInfo());

// Composition over inheritance
console.log("\n=== Composition over inheritance ===");

const behaviors = {
    speak: function(message) {
        return `${this.name} says: ${message}`;
    },
    move: function(distance) {
        return `${this.name} moved ${distance} units`;
    }
};

function createCreature(name, behaviorSet) {
    const creature = { name };
    
    // Compose behaviors
    Object.keys(behaviorSet).forEach(behavior => {
        creature[behavior] = behaviorSet[behavior];
    });
    
    return creature;
}

const composedCreature = createCreature("Phoenix", behaviors);
console.log("composedCreature:", composedCreature);
console.log("composedCreature.speak('Fire!'):", composedCreature.speak("Fire!"));
console.log("composedCreature.move(5):", composedCreature.move(5));

// Prototype pollution prevention
console.log("\n=== Prototype pollution prevention ===");

// Safe way to check properties
function safeHasProperty(obj, prop) {
    return Object.prototype.hasOwnProperty.call(obj, prop);
}

const testObj = { ownProp: "value" };
console.log("safeHasProperty(testObj, 'ownProp'):", safeHasProperty(testObj, 'ownProp'));     // true
console.log("safeHasProperty(testObj, 'toString'):", safeHasProperty(testObj, 'toString'));   // false

// Freezing prototypes to prevent modification
Object.freeze(Object.prototype);
console.log("Object.prototype is frozen:", Object.isFrozen(Object.prototype));                // true
```

</div>

---

## ⚠️ Common Pitfalls

### Pitfall 1: Forgetting to Set Constructor

```javascript
// ❌ WRONG: Constructor reference is wrong
function Dog() {}
Dog.prototype = Object.create(Animal.prototype);
// Dog.prototype.constructor now points to Animal!

// ✅ CORRECT: Fix constructor reference
function Dog() {}
Dog.prototype = Object.create(Animal.prototype);
Dog.prototype.constructor = Dog;  // Fix it!
```


### Pitfall 2: Modifying Built-in Prototypes

```javascript
// ❌ WRONG: Modifying built-in prototypes
Array.prototype.customMethod = function() { return "custom"; };
// This affects ALL arrays and can cause conflicts

// ✅ CORRECT: Use composition or inheritance
const myArray = Object.create(Array.prototype);
myArray.customMethod = function() { return "custom"; };
```


### Pitfall 3: Prototype Chain Too Deep

```javascript
// ❌ WRONG: Very deep inheritance chain
A → B → C → D → E → F → G
// Performance degrades with deep chains

// ✅ CORRECT: Use composition or shallow inheritance
A → B (shallow)
A → C (composition)
```


---

## 🎯 Best Practices

### ✅ Do's:
- **Use `Object.create()`** for simple inheritance
- **Always fix constructor references** when setting up inheritance
- **Prefer composition over inheritance** for complex cases
- **Use ES6 classes** for cleaner syntax
- **Freeze prototypes** when you want to prevent modification

### ❌ Don'ts:
- **Don't modify built-in prototypes** (Array.prototype, Object.prototype, etc.)
- **Don't create very deep inheritance chains**
- **Don't forget to call parent constructors** with `super()`
- **Don't assume** all properties are enumerable

---

## 🔑 Key Points

- **Prototypal inheritance** is JavaScript's native inheritance mechanism
- **Prototype chain** determines property lookup order
- **`prototype`** is a function property, **`__proto__`** is an object property
- **Constructor functions** create objects with shared prototypes
- **ES6 classes** are syntactic sugar over prototypes
- **`Object.create()`** creates objects with specified prototypes
- **Inheritance** should be shallow and prefer composition
- **Always test** prototype chains and property access

---

## ❓ Common Interview Questions

### Q1: What is prototypal inheritance in JavaScript?
**A:** Prototypal inheritance is JavaScript's mechanism where objects can inherit properties and methods from other objects through a prototype chain. When a property is accessed, JavaScript looks up the chain until it finds the property or reaches the end.

### Q2: What's the difference between `prototype` and `__proto__`?
**A:** `prototype` is a property of constructor functions that defines what instances will inherit. `__proto__` is an internal property of objects that points to their prototype. `prototype` is used to set up inheritance, while `__proto__` is used for property lookup.

### Q3: How do you implement inheritance with constructor functions?
**A:** Set the derived constructor's prototype to `Object.create(BaseConstructor.prototype)`, then fix the constructor reference with `DerivedConstructor.prototype.constructor = DerivedConstructor`. Also call the parent constructor with `BaseConstructor.call(this, ...args)`.

### Q4: How do ES6 classes relate to prototypes?
**A:** ES6 classes are syntactic sugar over constructor functions and prototypes. The `class` keyword creates a constructor function, and methods defined in the class are added to the constructor's prototype. `extends` sets up the prototype chain for inheritance.

### Q5: What are the benefits and drawbacks of prototypal inheritance?
**A:** Benefits include memory efficiency (shared methods), dynamic inheritance, and flexibility. Drawbacks include potential for prototype pollution, complex debugging, and the need to understand the prototype chain to predict behavior.

---

## 🏋️ Practice Exercises

### Exercise 1: Prototype Chain Tracker
Create a function that traces and visualizes the prototype chain of any object.

### Exercise 2: Inheritance Implementation
Implement different inheritance patterns (prototypal, constructor, class) and compare their behavior.

### Exercise 3: Mixin System
Build a robust mixin system that allows objects to inherit from multiple sources safely.

---

## 📚 Additional Resources

- [MDN: Inheritance and the prototype chain](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain)
- [JavaScript.info: Prototypal inheritance](https://javascript.info/prototype-inheritance)
- [You Don't Know JS: this & Object Prototypes](https://github.com/getify/You-Dont-Know-JS)
- [Eloquent JavaScript: Object-oriented programming](https://eloquentjavascript.net/06_object.html)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="10-The-this-Keyword.md" class="nav-link prev">← Previous: The `this` Keyword</a>
    <a href="12-Event-Loop-Concurrency.md" class="nav-link next">Next: Event Loop & Concurrency →</a>
</div>

*Last updated: December 2024*
