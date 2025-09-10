# 🏪 **Redux Toolkit & RTK Query**

> **Master Redux Toolkit and RTK Query for advanced state management and data fetching in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Redux Toolkit Setup](#redux-toolkit-setup)
- [Slices and Reducers](#slices-and-reducers)
- [RTK Query](#rtk-query)
- [Async Thunks](#async-thunks)
- [Middleware Configuration](#middleware-configuration)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Redux Toolkit (RTK) is the modern way to write Redux logic. It provides utilities to simplify common Redux use cases and includes RTK Query for efficient data fetching and caching.

### **Redux Toolkit Overview**


```
┌─────────────────────────────────────┐
│        Redux Toolkit System         │
│  ┌─────────────────────────────────┐│
│  │        Core Features            ││
│  │  - createSlice                 ││
│  │  - createAsyncThunk            ││
│  │  - configureStore              ││
│  │  - createAction                ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        RTK Query               ││
│  │  - createApi                   ││
│  │  - Automatic caching           ││
│  │  - Background refetching       ││
│  │  - Optimistic updates          ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        DevTools                ││
│  │  - Redux DevTools              ││
│  │  - Time-travel debugging       ││
│  │  - State inspection            ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 🏪 **Redux Toolkit Setup**

### **Basic Store Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// store/index.js
import { configureStore } from '@reduxjs/toolkit';
import { setupListeners } from '@reduxjs/toolkit/query';
import counterSlice from './slices/counterSlice';
import userSlice from './slices/userSlice';
import { api } from './api/apiSlice';

export const store = configureStore({
  reducer: {
    counter: counterSlice,
    user: userSlice,
    [api.reducerPath]: api.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        ignoredActions: [api.util.resetApiState.type],
      },
    }).concat(api.middleware),
});

// Setup listeners for RTK Query
setupListeners(store.dispatch);

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
```


### **App Setup with Provider**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// App.js
import React from 'react';
import { Provider } from 'react-redux';
import { NavigationContainer } from '@react-navigation/native';
import { store } from './store';
import AppNavigator from './navigation/AppNavigator';

const App = () => {
  return (
    <Provider store={store}>
      <NavigationContainer>
        <AppNavigator />
      </NavigationContainer>
    </Provider>
  );
};

export default App;
```


---

## 🔄 **Slices and Reducers**

### **Counter Slice Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// store/slices/counterSlice.js
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface CounterState {
  value: number;
  isLoading: boolean;
  error: string | null;
}

const initialState: CounterState = {
  value: 0,
  isLoading: false,
  error: null,
};

const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment: (state) => {
      state.value += 1;
    },
    decrement: (state) => {
      state.value -= 1;
    },
    incrementByAmount: (state, action: PayloadAction<number>) => {
      state.value += action.payload;
    },
    reset: (state) => {
      state.value = 0;
      state.error = null;
    },
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.isLoading = action.payload;
    },
    setError: (state, action: PayloadAction<string | null>) => {
      state.error = action.payload;
    },
  },
});

export const {
  increment,
  decrement,
  incrementByAmount,
  reset,
  setLoading,
  setError,
} = counterSlice.actions;

export default counterSlice.reducer;
```


### **User Slice with Async Thunk**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// store/slices/userSlice.js
import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';

interface User {
  id: number;
  name: string;
  email: string;
  avatar?: string;
}

interface UserState {
  users: User[];
  currentUser: User | null;
  isLoading: boolean;
  error: string | null;
}

const initialState: UserState = {
  users: [],
  currentUser: null,
  isLoading: false,
  error: null,
};

// Async thunk for fetching users
export const fetchUsers = createAsyncThunk(
  'user/fetchUsers',
  async (_, { rejectWithValue }) => {
    try {
      const response = await fetch('https://jsonplaceholder.typicode.com/users');
      if (!response.ok) {
        throw new Error('Failed to fetch users');
      }
      const users = await response.json();
      return users;
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

// Async thunk for creating user
export const createUser = createAsyncThunk(
  'user/createUser',
  async (userData: Omit<User, 'id'>, { rejectWithValue }) => {
    try {
      const response = await fetch('https://jsonplaceholder.typicode.com/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
      });
      
      if (!response.ok) {
        throw new Error('Failed to create user');
      }
      
      const user = await response.json();
      return user;
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setCurrentUser: (state, action: PayloadAction<User | null>) => {
      state.currentUser = action.payload;
    },
    clearError: (state) => {
      state.error = null;
    },
    updateUser: (state, action: PayloadAction<User>) => {
      const index = state.users.findIndex(user => user.id === action.payload.id);
      if (index !== -1) {
        state.users[index] = action.payload;
      }
      if (state.currentUser?.id === action.payload.id) {
        state.currentUser = action.payload;
      }
    },
  },
  extraReducers: (builder) => {
    builder
      // Fetch users
      .addCase(fetchUsers.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(fetchUsers.fulfilled, (state, action) => {
        state.isLoading = false;
        state.users = action.payload;
      })
      .addCase(fetchUsers.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload as string;
      })
      // Create user
      .addCase(createUser.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(createUser.fulfilled, (state, action) => {
        state.isLoading = false;
        state.users.push(action.payload);
      })
      .addCase(createUser.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload as string;
      });
  },
});

export const { setCurrentUser, clearError, updateUser } = userSlice.actions;
export default userSlice.reducer;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Local-State-Context-API.md" class="nav-link prev">⬅️ Previous: Local State & Context API</a>
    <a href="./03-Modern-State-Solutions.md" class="nav-link next">Next: Modern State Solutions ➡️</a>
</div>

---


*Last updated: December 2024*
