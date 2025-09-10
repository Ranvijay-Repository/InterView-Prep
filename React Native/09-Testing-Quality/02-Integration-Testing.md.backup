# 🔗 **Integration Testing**

> **Master integration testing strategies, API testing, and component integration testing in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [API Integration Testing](#api-integration-testing)
- [Component Integration Testing](#component-integration-testing)
- [Navigation Testing](#navigation-testing)
- [State Management Testing](#state-management-testing)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Integration testing ensures that different parts of your React Native application work together correctly. It tests the interaction between components, services, and external dependencies.

### **Integration Testing Overview**


{% raw %}
```
┌─────────────────────────────────────┐
│        Integration Testing          │
│  ┌─────────────────────────────────┐│
│  │        Testing Levels           ││
│  │  - Component integration        ││
│  │  - API integration              ││
│  │  - Navigation integration       ││
│  │  - State management integration ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Testing Tools            ││
│  │  - React Testing Library        ││
│  │  - MSW (Mock Service Worker)    ││
│  │  - Supertest                    ││
│  │  - Detox                        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Testing Strategies       ││
│  │  - Mock external dependencies   ││
│  │  - Test real interactions       ││
│  │  - End-to-end scenarios         ││
│  │  - Error handling               ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```
{% endraw %}


---

## 🔗 **API Integration Testing**

### **API Testing Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// __tests__/integration/api.test.js
import { rest } from 'msw';
import { setupServer } from 'msw/node';
import { render, screen, waitFor } from '@testing-library/react-native';
import { ApiService } from '../services/ApiService';
import { UserProfile } from '../components/UserProfile';

// Mock server setup
const server = setupServer(
  rest.get('https://api.example.com/users/:id', (req, res, ctx) => {
    const { id } = req.params;
    return res(
      ctx.json({
        id: parseInt(id),
        name: 'John Doe',
        email: 'john@example.com',
        avatar: 'https://example.com/avatar.jpg',
      })
    );
  }),
  
  rest.post('https://api.example.com/users', (req, res, ctx) => {
    return res(
      ctx.status(201),
      ctx.json({
        id: 123,
        ...req.body,
        createdAt: new Date().toISOString(),
      })
    );
  }),
  
  rest.put('https://api.example.com/users/:id', (req, res, ctx) => {
    const { id } = req.params;
    return res(
      ctx.json({
        id: parseInt(id),
        ...req.body,
        updatedAt: new Date().toISOString(),
      })
    );
  }),
  
  rest.delete('https://api.example.com/users/:id', (req, res, ctx) => {
    return res(ctx.status(204));
  })
);

// Setup and teardown
beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe('API Integration Tests', () => {
  describe('User API', () => {
    it('should fetch user profile successfully', async () => {
      const user = await ApiService.getUser(1);
      
      expect(user).toEqual({
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        avatar: 'https://example.com/avatar.jpg',
      });
    });
    
    it('should create new user successfully', async () => {
      const newUser = {
        name: 'Jane Doe',
        email: 'jane@example.com',
      };
      
      const createdUser = await ApiService.createUser(newUser);
      
      expect(createdUser).toMatchObject({
        id: expect.any(Number),
        name: 'Jane Doe',
        email: 'jane@example.com',
        createdAt: expect.any(String),
      });
    });
    
    it('should update user successfully', async () => {
      const updates = {
        name: 'John Updated',
        email: 'john.updated@example.com',
      };
      
      const updatedUser = await ApiService.updateUser(1, updates);
      
      expect(updatedUser).toMatchObject({
        id: 1,
        name: 'John Updated',
        email: 'john.updated@example.com',
        updatedAt: expect.any(String),
      });
    });
    
    it('should delete user successfully', async () => {
      const result = await ApiService.deleteUser(1);
      
      expect(result).toBe(true);
    });
    
    it('should handle API errors gracefully', async () => {
      server.use(
        rest.get('https://api.example.com/users/:id', (req, res, ctx) => {
          return res(ctx.status(500), ctx.json({ error: 'Internal Server Error' }));
        })
      );
      
      await expect(ApiService.getUser(1)).rejects.toThrow('Internal Server Error');
    });
  });
});
```
{% endraw %}


### **Component Integration Testing**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// __tests__/integration/UserProfile.test.js
import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react-native';
import { rest } from 'msw';
import { setupServer } from 'msw/node';
import { UserProfile } from '../components/UserProfile';
import { UserProvider } from '../contexts/UserContext';

// Mock server
const server = setupServer(
  rest.get('https://api.example.com/users/:id', (req, res, ctx) => {
    return res(
      ctx.json({
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        avatar: 'https://example.com/avatar.jpg',
      })
    );
  }),
  
  rest.put('https://api.example.com/users/:id', (req, res, ctx) => {
    return res(
      ctx.json({
        id: 1,
        ...req.body,
        updatedAt: new Date().toISOString(),
      })
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe('UserProfile Integration Tests', () => {
  const renderWithProvider = (component) => {
    return render(
      <UserProvider>
        {component}
      </UserProvider>
    );
  };
  
  it('should load and display user profile', async () => {
    renderWithProvider(<UserProfile userId={1} />);
    
    // Wait for loading to complete
    await waitFor(() => {
      expect(screen.getByText('John Doe')).toBeTruthy();
    });
    
    expect(screen.getByText('john@example.com')).toBeTruthy();
    expect(screen.getByTestId('user-avatar')).toBeTruthy();
  });
  
  it('should update user profile successfully', async () => {
    renderWithProvider(<UserProfile userId={1} />);
    
    // Wait for initial load
    await waitFor(() => {
      expect(screen.getByText('John Doe')).toBeTruthy();
    });
    
    // Click edit button
    fireEvent.press(screen.getByTestId('edit-button'));
    
    // Update name
    const nameInput = screen.getByTestId('name-input');
    fireEvent.changeText(nameInput, 'John Updated');
    
    // Save changes
    fireEvent.press(screen.getByTestId('save-button'));
    
    // Wait for update to complete
    await waitFor(() => {
      expect(screen.getByText('John Updated')).toBeTruthy();
    });
  });
  
  it('should handle loading state', () => {
    renderWithProvider(<UserProfile userId={1} />);
    
    expect(screen.getByTestId('loading-indicator')).toBeTruthy();
  });
  
  it('should handle error state', async () => {
    server.use(
      rest.get('https://api.example.com/users/:id', (req, res, ctx) => {
        return res(ctx.status(500), ctx.json({ error: 'Server Error' }));
      })
    );
    
    renderWithProvider(<UserProfile userId={1} />);
    
    await waitFor(() => {
      expect(screen.getByText('Error loading profile')).toBeTruthy();
    });
  });
  
  it('should handle network connectivity issues', async () => {
    server.use(
      rest.get('https://api.example.com/users/:id', (req, res, ctx) => {
        return res.networkError('Network error');
      })
    );
    
    renderWithProvider(<UserProfile userId={1} />);
    
    await waitFor(() => {
      expect(screen.getByText('Network error')).toBeTruthy();
    });
  });
});
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Unit-Testing.md" class="nav-link prev">⬅️ Previous: Unit Testing</a>
    <a href="./03-E2E-Testing.md" class="nav-link next">Next: E2E Testing ➡️</a>
</div>

---


*Last updated: December 2024*
