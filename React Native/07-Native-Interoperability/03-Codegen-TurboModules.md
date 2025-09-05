# 🔧 **Codegen & TurboModules**

> **Master React Native's code generation system and TurboModules for type-safe native module development**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Codegen Overview](#codegen-overview)
- [TurboModule Implementation](#turbomodule-implementation)
- [Type Safety](#type-safety)
- [Code Generation](#code-generation)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Codegen and TurboModules work together to provide type-safe, high-performance native module development. They automatically generate boilerplate code and ensure type safety across the JavaScript-Native boundary.

### **Codegen & TurboModules Overview**

```
┌─────────────────────────────────────┐
│        Codegen & TurboModules       │
│  ┌─────────────────────────────────┐│
│  │        Codegen                  ││
│  │  - Automatic code generation    ││
│  │  - Type safety enforcement      ││
│  │  - Boilerplate reduction        ││
│  │  - Build-time validation        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        TurboModules             ││
│  │  - Native module system         ││
│  │  - JSI integration              ││
│  │  - Performance optimization     ││
│  │  - Type-safe interfaces         ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Benefits                 ││
│  │  - Reduced development time     ││
│  │  - Better error handling        ││
│  │  - Improved performance         ││
│  │  - Future-proof architecture    ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🔧 **Codegen Overview**

### **TurboModule Specification Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// TurboModule Specification (TypeScript)
// This file defines the interface for the native module

export interface Spec extends TurboModule {
  // Synchronous methods
  add(a: number, b: number): number;
  multiply(a: number, b: number): number;
  
  // Asynchronous methods
  processDataAsync(data: string): Promise<string>;
  fetchDataFromAPI(url: string): Promise<ApiResponse>;
  
  // Methods with complex types
  processUserData(user: UserData): ProcessedUserData;
  validateInput(input: ValidationInput): ValidationResult;
  
  // Methods with arrays and objects
  processArray(items: number[]): number[];
  processObject(data: Record<string, any>): ProcessedObject;
  
  // Methods with enums
  getStatus(): Status;
  setStatus(status: Status): void;
  
  // Methods with optional parameters
  processOptionalData(data?: string): string;
  processWithDefaults(value: number, multiplier?: number): number;
  
  // Methods with callbacks
  processWithCallback(
    data: string,
    callback: (result: string) => void
  ): void;
  
  // Methods with promises and callbacks
  processWithBoth(
    data: string,
    callback: (result: string) => void
  ): Promise<string>;
  
  // Constants
  readonly VERSION: string;
  readonly SUPPORTED_FORMATS: string[];
  
  // Events
  addListener(eventName: string): void;
  removeListeners(count: number): void;
}

// Type definitions
export interface UserData {
  id: number;
  name: string;
  email: string;
  age?: number;
  preferences?: UserPreferences;
}

export interface UserPreferences {
  theme: 'light' | 'dark';
  notifications: boolean;
  language: string;
}

export interface ProcessedUserData {
  id: number;
  displayName: string;
  isValid: boolean;
  processedAt: string;
}

export interface ValidationInput {
  value: string;
  type: 'email' | 'phone' | 'url';
  required: boolean;
}

export interface ValidationResult {
  isValid: boolean;
  errors: string[];
  suggestions?: string[];
}

export interface ApiResponse {
  status: number;
  data: any;
  message: string;
}

export interface ProcessedObject {
  keys: string[];
  values: any[];
  size: number;
}

export enum Status {
  IDLE = 'idle',
  LOADING = 'loading',
  SUCCESS = 'success',
  ERROR = 'error',
}

export default TurboModuleRegistry.get<Spec>('MyTurboModule');
```

### **Generated Code Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Generated TurboModule Usage
import MyTurboModule from './MyTurboModule';

class TurboModuleExample {
  constructor() {
    this.setupModule();
  }
  
  setupModule() {
    // Access constants
    console.log('Module version:', MyTurboModule.VERSION);
    console.log('Supported formats:', MyTurboModule.SUPPORTED_FORMATS);
  }
  
  // Synchronous operations
  performSynchronousOperations() {
    console.log('=== Synchronous Operations ===');
    
    try {
      const sum = MyTurboModule.add(10, 20);
      const product = MyTurboModule.multiply(5, 6);
      
      console.log('Sum:', sum);
      console.log('Product:', product);
      
      return { sum, product };
    } catch (error) {
      console.error('Synchronous operation error:', error);
      throw error;
    }
  }
  
  // Asynchronous operations
  async performAsynchronousOperations() {
    console.log('=== Asynchronous Operations ===');
    
    try {
      const processedData = await MyTurboModule.processDataAsync('test data');
      const apiResponse = await MyTurboModule.fetchDataFromAPI('https://api.example.com/data');
      
      console.log('Processed data:', processedData);
      console.log('API response:', apiResponse);
      
      return { processedData, apiResponse };
    } catch (error) {
      console.error('Asynchronous operation error:', error);
      throw error;
    }
  }
  
  // Complex data operations
  processComplexData() {
    console.log('=== Complex Data Operations ===');
    
    const userData = {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      age: 30,
      preferences: {
        theme: 'dark',
        notifications: true,
        language: 'en'
      }
    };
    
    const validationInput = {
      value: 'test@example.com',
      type: 'email',
      required: true
    };
    
    try {
      const processedUser = MyTurboModule.processUserData(userData);
      const validationResult = MyTurboModule.validateInput(validationInput);
      
      console.log('Processed user:', processedUser);
      console.log('Validation result:', validationResult);
      
      return { processedUser, validationResult };
    } catch (error) {
      console.error('Complex data operation error:', error);
      throw error;
    }
  }
  
  // Array and object operations
  processArraysAndObjects() {
    console.log('=== Array and Object Operations ===');
    
    const numbers = [1, 2, 3, 4, 5];
    const dataObject = {
      key1: 'value1',
      key2: 'value2',
      key3: 123
    };
    
    try {
      const processedArray = MyTurboModule.processArray(numbers);
      const processedObject = MyTurboModule.processObject(dataObject);
      
      console.log('Processed array:', processedArray);
      console.log('Processed object:', processedObject);
      
      return { processedArray, processedObject };
    } catch (error) {
      console.error('Array/object operation error:', error);
      throw error;
    }
  }
  
  // Enum operations
  handleEnums() {
    console.log('=== Enum Operations ===');
    
    try {
      const currentStatus = MyTurboModule.getStatus();
      console.log('Current status:', currentStatus);
      
      MyTurboModule.setStatus('loading');
      console.log('Status set to loading');
      
      MyTurboModule.setStatus('success');
      console.log('Status set to success');
      
      return currentStatus;
    } catch (error) {
      console.error('Enum operation error:', error);
      throw error;
    }
  }
  
  // Optional parameters
  handleOptionalParameters() {
    console.log('=== Optional Parameters ===');
    
    try {
      const result1 = MyTurboModule.processOptionalData('test data');
      const result2 = MyTurboModule.processOptionalData();
      
      const result3 = MyTurboModule.processWithDefaults(10);
      const result4 = MyTurboModule.processWithDefaults(10, 2);
      
      console.log('Optional data result 1:', result1);
      console.log('Optional data result 2:', result2);
      console.log('Defaults result 1:', result3);
      console.log('Defaults result 2:', result4);
      
      return { result1, result2, result3, result4 };
    } catch (error) {
      console.error('Optional parameter error:', error);
      throw error;
    }
  }
  
  // Callback operations
  handleCallbacks() {
    console.log('=== Callback Operations ===');
    
    return new Promise((resolve, reject) => {
      try {
        MyTurboModule.processWithCallback('callback data', (result) => {
          console.log('Callback result:', result);
          resolve(result);
        });
      } catch (error) {
        console.error('Callback operation error:', error);
        reject(error);
      }
    });
  }
  
  // Promise and callback combination
  async handlePromiseAndCallback() {
    console.log('=== Promise and Callback ===');
    
    try {
      const promise = MyTurboModule.processWithBoth('combined data', (result) => {
        console.log('Callback result:', result);
      });
      
      const finalResult = await promise;
      console.log('Promise result:', finalResult);
      
      return finalResult;
    } catch (error) {
      console.error('Promise/callback operation error:', error);
      throw error;
    }
  }
  
  // Event handling
  setupEventHandling() {
    console.log('=== Event Handling ===');
    
    MyTurboModule.addListener('dataProcessed');
    MyTurboModule.addListener('errorOccurred');
    
    // Note: Actual event listeners would be set up in the native module
    console.log('Event listeners added');
  }
  
  cleanup() {
    MyTurboModule.removeListeners(2);
    console.log('Event listeners removed');
  }
}

export default TurboModuleExample;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="./02-JSI-Fabric-TurboModules.md" class="nav-link prev">⬅️ Previous: JSI, Fabric & TurboModules</a>
    <a href="./04-Native-UI-Components.md" class="nav-link next">Next: Native UI Components ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
