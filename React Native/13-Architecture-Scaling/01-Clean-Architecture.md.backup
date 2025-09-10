# 🏗️ **Clean Architecture**

> **Master clean architecture principles, patterns, and implementation for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Clean Architecture Overview](#-clean-architecture-overview)
- [Architecture Layers](#-architecture-layers)
- [Dependency Injection](#-dependency-injection)
- [Repository Pattern](#-repository-pattern)
- [Use Cases](#-use-cases)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 🏗️ **Clean Architecture Overview**

### **Architecture Principles**


{% raw %}
```mermaid
graph TD
    A[Presentation Layer] --> B[Domain Layer]
    B --> C[Data Layer]
    
    D[Use Cases] --> B
    E[Entities] --> B
    F[Repositories] --> C
    G[Data Sources] --> C
```
{% endraw %}


### **Key Principles**
- **Dependency Inversion**: Depend on abstractions, not concretions
- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Easy to test in isolation
- **Maintainability**: Easy to modify and extend

---

## 🎯 **Architecture Layers**

### **Domain Layer Implementation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// Domain entities
const User = {
  id: null,
  name: '',
  email: '',
  createdAt: null,
  
  create: (userData) => ({
    id: userData.id,
    name: userData.name,
    email: userData.email,
    createdAt: new Date(),
  }),
  
  validate: (user) => {
    const errors = [];
    
    if (!user.name || user.name.trim().length === 0) {
      errors.push('Name is required');
    }
    
    if (!user.email || !isValidEmail(user.email)) {
      errors.push('Valid email is required');
    }
    
    return errors;
  }
};

// Domain repositories (interfaces)
const UserRepository = {
  findById: async (id) => {
    throw new Error('Method must be implemented');
  },
  
  findByEmail: async (email) => {
    throw new Error('Method must be implemented');
  },
  
  save: async (user) => {
    throw new Error('Method must be implemented');
  },
  
  delete: async (id) => {
    throw new Error('Method must be implemented');
  }
};

// Use cases
const CreateUserUseCase = {
  execute: async (userData, userRepository) => {
    try {
      // Validate user data
      const user = User.create(userData);
      const validationErrors = User.validate(user);
      
      if (validationErrors.length > 0) {
        throw new Error(`Validation failed: ${validationErrors.join(', ')}`);
      }
      
      // Check if user already exists
      const existingUser = await userRepository.findByEmail(user.email);
      if (existingUser) {
        throw new Error('User with this email already exists');
      }
      
      // Save user
      const savedUser = await userRepository.save(user);
      return savedUser;
    } catch (error) {
      throw new Error(`Failed to create user: ${error.message}`);
    }
  }
};

const GetUserUseCase = {
  execute: async (userId, userRepository) => {
    try {
      if (!userId) {
        throw new Error('User ID is required');
      }
      
      const user = await userRepository.findById(userId);
      if (!user) {
        throw new Error('User not found');
      }
      
      return user;
    } catch (error) {
      throw new Error(`Failed to get user: ${error.message}`);
    }
  }
};

// Utility functions
const isValidEmail = (email) => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export { User, UserRepository, CreateUserUseCase, GetUserUseCase };
```
{% endraw %}


### **Data Layer Implementation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import AsyncStorage from '@react-native-async-storage/async-storage';

// Data models
const UserDataModel = {
  id: null,
  name: '',
  email: '',
  createdAt: null,
  
  fromDomain: (user) => ({
    id: user.id,
    name: user.name,
    email: user.email,
    createdAt: user.createdAt?.toISOString(),
  }),
  
  toDomain: (userData) => ({
    id: userData.id,
    name: userData.name,
    email: userData.email,
    createdAt: userData.createdAt ? new Date(userData.createdAt) : null,
  })
};

// Local data source
const LocalUserDataSource = {
  async findById(id) {
    try {
      const users = await this.getAllUsers();
      return users.find(user => user.id === id) || null;
    } catch (error) {
      throw new Error(`Failed to find user by ID: ${error.message}`);
    }
  },
  
  async findByEmail(email) {
    try {
      const users = await this.getAllUsers();
      return users.find(user => user.email === email) || null;
    } catch (error) {
      throw new Error(`Failed to find user by email: ${error.message}`);
    }
  },
  
  async save(user) {
    try {
      const users = await this.getAllUsers();
      const userData = UserDataModel.fromDomain(user);
      
      const existingIndex = users.findIndex(u => u.id === user.id);
      if (existingIndex >= 0) {
        users[existingIndex] = userData;
      } else {
        users.push(userData);
      }
      
      await AsyncStorage.setItem('users', JSON.stringify(users));
      return UserDataModel.toDomain(userData);
    } catch (error) {
      throw new Error(`Failed to save user: ${error.message}`);
    }
  },
  
  async delete(id) {
    try {
      const users = await this.getAllUsers();
      const filteredUsers = users.filter(user => user.id !== id);
      await AsyncStorage.setItem('users', JSON.stringify(filteredUsers));
      return true;
    } catch (error) {
      throw new Error(`Failed to delete user: ${error.message}`);
    }
  },
  
  async getAllUsers() {
    try {
      const usersJson = await AsyncStorage.getItem('users');
      return usersJson ? JSON.parse(usersJson) : [];
    } catch (error) {
      throw new Error(`Failed to get users: ${error.message}`);
    }
  }
};

// Remote data source
const RemoteUserDataSource = {
  async findById(id) {
    try {
      const response = await fetch(`/api/users/${id}`);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const userData = await response.json();
      return UserDataModel.toDomain(userData);
    } catch (error) {
      throw new Error(`Failed to fetch user: ${error.message}`);
    }
  },
  
  async findByEmail(email) {
    try {
      const response = await fetch(`/api/users?email=${email}`);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const users = await response.json();
      return users.length > 0 ? UserDataModel.toDomain(users[0]) : null;
    } catch (error) {
      throw new Error(`Failed to fetch user by email: ${error.message}`);
    }
  },
  
  async save(user) {
    try {
      const userData = UserDataModel.fromDomain(user);
      const response = await fetch('/api/users', {
        method: user.id ? 'PUT' : 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const savedUserData = await response.json();
      return UserDataModel.toDomain(savedUserData);
    } catch (error) {
      throw new Error(`Failed to save user: ${error.message}`);
    }
  },
  
  async delete(id) {
    try {
      const response = await fetch(`/api/users/${id}`, {
        method: 'DELETE',
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      return true;
    } catch (error) {
      throw new Error(`Failed to delete user: ${error.message}`);
    }
  }
};

export { UserDataModel, LocalUserDataSource, RemoteUserDataSource };
```
{% endraw %}


---

## 💉 **Dependency Injection**

### **DI Container Implementation**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// Dependency injection container
const createDIContainer = () => {
  const services = new Map();
  const factories = new Map();
  
  return {
    // Register a service instance
    register: (name, instance) => {
      services.set(name, instance);
    },
    
    // Register a factory function
    registerFactory: (name, factory) => {
      factories.set(name, factory);
    },
    
    // Get a service instance
    get: (name) => {
      if (services.has(name)) {
        return services.get(name);
      }
      
      if (factories.has(name)) {
        const factory = factories.get(name);
        const instance = factory();
        services.set(name, instance);
        return instance;
      }
      
      throw new Error(`Service '${name}' not found`);
    },
    
    // Check if service is registered
    has: (name) => {
      return services.has(name) || factories.has(name);
    },
    
    // Clear all services
    clear: () => {
      services.clear();
      factories.clear();
    }
  };
};

// Repository implementation with DI
const UserRepositoryImpl = (localDataSource, remoteDataSource) => {
  return {
    async findById(id) {
      try {
        // Try remote first, fallback to local
        return await remoteDataSource.findById(id);
      } catch (error) {
        console.warn('Remote fetch failed, trying local:', error.message);
        return await localDataSource.findById(id);
      }
    },
    
    async findByEmail(email) {
      try {
        // Try remote first, fallback to local
        return await remoteDataSource.findByEmail(email);
      } catch (error) {
        console.warn('Remote fetch failed, trying local:', error.message);
        return await localDataSource.findByEmail(email);
      }
    },
    
    async save(user) {
      try {
        // Save to remote first
        const savedUser = await remoteDataSource.save(user);
        // Then save to local cache
        await localDataSource.save(savedUser);
        return savedUser;
      } catch (error) {
        console.warn('Remote save failed, saving locally:', error.message);
        return await localDataSource.save(user);
      }
    },
    
    async delete(id) {
      try {
        // Delete from remote first
        await remoteDataSource.delete(id);
        // Then delete from local
        await localDataSource.delete(id);
        return true;
      } catch (error) {
        console.warn('Remote delete failed, deleting locally:', error.message);
        return await localDataSource.delete(id);
      }
    }
  };
};

// Service factory
const createUserService = (container) => {
  const userRepository = container.get('userRepository');
  
  return {
    async createUser(userData) {
      return await CreateUserUseCase.execute(userData, userRepository);
    },
    
    async getUser(userId) {
      return await GetUserUseCase.execute(userId, userRepository);
    },
    
    async updateUser(userId, userData) {
      const existingUser = await userRepository.findById(userId);
      if (!existingUser) {
        throw new Error('User not found');
      }
      
      const updatedUser = { ...existingUser, ...userData };
      return await userRepository.save(updatedUser);
    },
    
    async deleteUser(userId) {
      return await userRepository.delete(userId);
    }
  };
};

// Initialize DI container
const initializeContainer = () => {
  const container = createDIContainer();
  
  // Register data sources
  container.register('localUserDataSource', LocalUserDataSource);
  container.register('remoteUserDataSource', RemoteUserDataSource);
  
  // Register repository
  container.registerFactory('userRepository', () => {
    const localDataSource = container.get('localUserDataSource');
    const remoteDataSource = container.get('remoteUserDataSource');
    return UserRepositoryImpl(localDataSource, remoteDataSource);
  });
  
  // Register services
  container.registerFactory('userService', () => createUserService(container));
  
  return container;
};

export { createDIContainer, UserRepositoryImpl, createUserService, initializeContainer };
```
{% endraw %}


---

## 🎯 **Best Practices**

### **1. Architecture Design**
- Follow SOLID principles
- Use dependency injection
- Separate concerns properly
- Keep layers independent

### **2. Implementation**
- Use interfaces for contracts
- Implement proper error handling
- Add comprehensive logging
- Write unit tests

### **3. Maintenance**
- Regular code reviews
- Refactor when needed
- Monitor performance
- Update dependencies

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What is clean architecture?**
2. **How do you implement dependency injection?**
3. **What is the repository pattern?**

### **Advanced Questions**
1. **How would you design a scalable React Native architecture?**
2. **Explain the benefits of clean architecture.**
3. **How do you handle data synchronization between layers?**

### **Practical Questions**
1. **Implement a clean architecture for a user management system.**
2. **Create a dependency injection container.**
3. **Design a repository pattern for data access.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="../12-Accessibility-Internationalization/04-Accessibility-Best-Practices.md" class="nav-link prev">⬅️ Previous: Accessibility Best Practices</a>
    <a href="./02-MVVM-Pattern.md" class="nav-link next">Next: MVVM Pattern ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
