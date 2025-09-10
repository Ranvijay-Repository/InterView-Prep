# ⚛️ **TypeScript with React**

> **Complete guide to using TypeScript with React, including component typing, hooks, and advanced patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [React TypeScript Setup](#react-typescript-setup)
- [Component Typing](#component-typing)
- [Hooks with TypeScript](#hooks-with-typescript)
- [Props and State](#props-and-state)
- [Event Handling](#event-handling)
- [Advanced Patterns](#advanced-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **React TypeScript Setup**

Setting up TypeScript with React requires proper configuration and understanding of React types.

### **Basic Setup**

```bash
# Create React app with TypeScript
npx create-react-app my-app --template typescript

# Or add TypeScript to existing project
npm install --save-dev typescript @types/react @types/react-dom
npm install --save-dev @types/node
```

### **TypeScript Configuration**

```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx"
  },
  "include": ["src"]
}
```

### **Package.json Scripts**

```json
{
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
```

---

## 🧩 **Component Typing**

### **Functional Components**

```typescript
// Basic functional component
import React from 'react';

interface ButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  disabled?: boolean;
}

const Button: React.FC<ButtonProps> = ({ children, onClick, disabled = false }) => {
  return (
    <button onClick={onClick} disabled={disabled}>
      {children}
    </button>
  );
};

export default Button;
```

### **Class Components**

```typescript
// Class component with TypeScript
import React, { Component } from 'react';

interface CounterProps {
  initialCount: number;
}

interface CounterState {
  count: number;
}

class Counter extends Component<CounterProps, CounterState> {
  constructor(props: CounterProps) {
    super(props);
    this.state = {
      count: props.initialCount
    };
  }

  increment = () => {
    this.setState(prevState => ({
      count: prevState.count + 1
    }));
  };

  render() {
    return (
      <div>
        <p>Count: {this.state.count}</p>
        <button onClick={this.increment}>Increment</button>
      </div>
    );
  }
}

export default Counter;
```

### **Component with Children**

```typescript
// Component with children
import React from 'react';

interface CardProps {
  title: string;
  children: React.ReactNode;
  className?: string;
}

const Card: React.FC<CardProps> = ({ title, children, className }) => {
  return (
    <div className={`card ${className || ''}`}>
      <h3>{title}</h3>
      <div className="card-content">
        {children}
      </div>
    </div>
  );
};

export default Card;
```

---

## 🎣 **Hooks with TypeScript**

### **useState Hook**

```typescript
// useState with TypeScript
import React, { useState } from 'react';

const UserForm: React.FC = () => {
  const [name, setName] = useState<string>('');
  const [email, setEmail] = useState<string>('');
  const [age, setAge] = useState<number>(0);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log({ name, email, age });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
        placeholder="Name"
      />
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
      />
      <input
        type="number"
        value={age}
        onChange={(e) => setAge(parseInt(e.target.value))}
        placeholder="Age"
      />
      <button type="submit">Submit</button>
    </form>
  );
};

export default UserForm;
```

### **useEffect Hook**

```typescript
// useEffect with TypeScript
import React, { useState, useEffect } from 'react';

interface User {
  id: number;
  name: string;
  email: string;
}

const UserList: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        setLoading(true);
        const response = await fetch('/api/users');
        const data = await response.json();
        setUsers(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>
          {user.name} - {user.email}
        </li>
      ))}
    </ul>
  );
};

export default UserList;
```

### **Custom Hooks**

```typescript
// Custom hook with TypeScript
import { useState, useEffect } from 'react';

interface UseApiResult<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
  refetch: () => void;
}

const useApi = <T>(url: string): UseApiResult<T> => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetch(url);
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [url]);

  return { data, loading, error, refetch: fetchData };
};

// Usage
const UserProfile: React.FC<{ userId: number }> = ({ userId }) => {
  const { data: user, loading, error, refetch } = useApi<User>(`/api/users/${userId}`);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  if (!user) return <div>User not found</div>;

  return (
    <div>
      <h2>{user.name}</h2>
      <p>{user.email}</p>
      <button onClick={refetch}>Refresh</button>
    </div>
  );
};
```

---

## 📝 **Props and State**

### **Props Typing**

```typescript
// Props with optional and required properties
interface UserCardProps {
  user: User;
  showEmail?: boolean;
  onEdit?: (user: User) => void;
  onDelete?: (userId: number) => void;
}

const UserCard: React.FC<UserCardProps> = ({
  user,
  showEmail = false,
  onEdit,
  onDelete
}) => {
  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      {showEmail && <p>{user.email}</p>}
      <div className="actions">
        {onEdit && (
          <button onClick={() => onEdit(user)}>Edit</button>
        )}
        {onDelete && (
          <button onClick={() => onDelete(user.id)}>Delete</button>
        )}
      </div>
    </div>
  );
};
```

### **State Typing**

```typescript
// Complex state with TypeScript
interface FormState {
  values: {
    name: string;
    email: string;
    age: number;
  };
  errors: {
    name?: string;
    email?: string;
    age?: string;
  };
  isSubmitting: boolean;
}

const UserForm: React.FC = () => {
  const [state, setState] = useState<FormState>({
    values: {
      name: '',
      email: '',
      age: 0
    },
    errors: {},
    isSubmitting: false
  });

  const updateValue = (field: keyof FormState['values'], value: string | number) => {
    setState(prevState => ({
      ...prevState,
      values: {
        ...prevState.values,
        [field]: value
      }
    }));
  };

  const setError = (field: keyof FormState['errors'], error: string) => {
    setState(prevState => ({
      ...prevState,
      errors: {
        ...prevState.errors,
        [field]: error
      }
    }));
  };

  return (
    <form>
      <input
        type="text"
        value={state.values.name}
        onChange={(e) => updateValue('name', e.target.value)}
        placeholder="Name"
      />
      {state.errors.name && <span className="error">{state.errors.name}</span>}
      
      <input
        type="email"
        value={state.values.email}
        onChange={(e) => updateValue('email', e.target.value)}
        placeholder="Email"
      />
      {state.errors.email && <span className="error">{state.errors.email}</span>}
      
      <input
        type="number"
        value={state.values.age}
        onChange={(e) => updateValue('age', parseInt(e.target.value))}
        placeholder="Age"
      />
      {state.errors.age && <span className="error">{state.errors.age}</span>}
      
      <button type="submit" disabled={state.isSubmitting}>
        {state.isSubmitting ? 'Submitting...' : 'Submit'}
      </button>
    </form>
  );
};
```

---

## 🎯 **Event Handling**

### **Event Types**

```typescript
// Event handling with TypeScript
import React, { useState } from 'react';

const EventHandling: React.FC = () => {
  const [inputValue, setInputValue] = useState<string>('');
  const [mousePosition, setMousePosition] = useState<{ x: number; y: number }>({ x: 0, y: 0 });

  // Form events
  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    console.log('Form submitted');
  };

  // Input events
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setInputValue(e.target.value);
  };

  // Mouse events
  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    setMousePosition({ x: e.clientX, y: e.clientY });
  };

  // Keyboard events
  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      console.log('Enter pressed');
    }
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={inputValue}
          onChange={handleInputChange}
          onKeyDown={handleKeyDown}
          placeholder="Type something..."
        />
        <button type="submit">Submit</button>
      </form>
      
      <div
        onMouseMove={handleMouseMove}
        style={{#123;{{#123; width: '100%', height: '200px', border: '1px solid #ccc' }}#125;}}#125;
      >
        Mouse position: {mousePosition.x}, {mousePosition.y}
      </div>
    </div>
  );
};

export default EventHandling;
```

### **Generic Event Handlers**

```typescript
// Generic event handlers
const useForm = <T extends Record<string, any>>(initialValues: T) => {
  const [values, setValues] = useState<T>(initialValues);
  const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({});

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setValues(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    // Handle form submission
  };

  const setError = (field: keyof T, error: string) => {
    setErrors(prev => ({
      ...prev,
      [field]: error
    }));
  };

  return {
    values,
    errors,
    handleChange,
    handleSubmit,
    setError
  };
};

// Usage
const LoginForm: React.FC = () => {
  const { values, errors, handleChange, handleSubmit } = useForm({
    email: '',
    password: ''
  });

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        name="email"
        value={values.email}
        onChange={handleChange}
        placeholder="Email"
      />
      {errors.email && <span className="error">{errors.email}</span>}
      
      <input
        type="password"
        name="password"
        value={values.password}
        onChange={handleChange}
        placeholder="Password"
      />
      {errors.password && <span className="error">{errors.password}</span>}
      
      <button type="submit">Login</button>
    </form>
  );
};
```

---

## 🚀 **Advanced Patterns**

### **Higher-Order Components**

```typescript
// Higher-order component with TypeScript
import React, { ComponentType } from 'react';

interface WithLoadingProps {
  loading: boolean;
}

const withLoading = <P extends object>(
  Component: ComponentType<P>
): ComponentType<P & WithLoadingProps> => {
  return (props: P & WithLoadingProps) => {
    const { loading, ...rest } = props;
    
    if (loading) {
      return <div>Loading...</div>;
    }
    
    return <Component {...(rest as P)} />;
  };
};

// Usage
interface UserListProps {
  users: User[];
}

const UserList: React.FC<UserListProps> = ({ users }) => (
  <ul>
    {users.map(user => (
      <li key={user.id}>{user.name}</li>
    ))}
  </ul>
);

const UserListWithLoading = withLoading(UserList);

// Usage in component
const App: React.FC = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  return (
    <UserListWithLoading users={users} loading={loading} />
  );
};
```

### **Render Props**

```typescript
// Render props pattern with TypeScript
interface DataProviderProps<T> {
  url: string;
  children: (data: {
    data: T | null;
    loading: boolean;
    error: string | null;
    refetch: () => void;
  }) => React.ReactNode;
}

const DataProvider = <T,>({ url, children }: DataProviderProps<T>) => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetch(url);
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [url]);

  return <>{children({ data, loading, error, refetch: fetchData })}</>;
};

// Usage
const UserProfile: React.FC<{ userId: number }> = ({ userId }) => (
  <DataProvider<User> url={`/api/users/${userId}`}>
    {({ data: user, loading, error, refetch }) => {
      if (loading) return <div>Loading...</div>;
      if (error) return <div>Error: {error}</div>;
      if (!user) return <div>User not found</div>;

      return (
        <div>
          <h2>{user.name}</h2>
          <p>{user.email}</p>
          <button onClick={refetch}>Refresh</button>
        </div>
      );
    }}#125;}}#125;
  </DataProvider>
);
```

### **Context with TypeScript**

```typescript
// Context with TypeScript
import React, { createContext, useContext, useState, ReactNode } from 'react';

interface User {
  id: number;
  name: string;
  email: string;
}

interface UserContextType {
  user: User | null;
  login: (user: User) => void;
  logout: () => void;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export const useUser = (): UserContextType => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};

interface UserProviderProps {
  children: ReactNode;
}

export const UserProvider: React.FC<UserProviderProps> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);

  const login = (userData: User) => {
    setUser(userData);
  };

  const logout = () => {
    setUser(null);
  };

  return (
    <UserContext.Provider value={{#123;{{#123; user, login, logout }}#125;}}#125;>
      {children}
    </UserContext.Provider>
  );
};

// Usage
const UserProfile: React.FC = () => {
  const { user, logout } = useUser();

  if (!user) {
    return <div>Please log in</div>;
  }

  return (
    <div>
      <h2>Welcome, {user.name}!</h2>
      <p>Email: {user.email}</p>
      <button onClick={logout}>Logout</button>
    </div>
  );
};
```

---

## ✅ **Best Practices**

### **1. Use Strict Typing**

```typescript
// ✅ Good: Strict typing
interface ButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  disabled?: boolean;
}

const Button: React.FC<ButtonProps> = ({ children, onClick, disabled = false }) => {
  return (
    <button onClick={onClick} disabled={disabled}>
      {children}
    </button>
  );
};

// ❌ Avoid: Loose typing
const Button: React.FC<any> = ({ children, onClick, disabled }) => {
  return (
    <button onClick={onClick} disabled={disabled}>
      {children}
    </button>
  );
};
```

### **2. Use Generic Types for Reusable Components**

```typescript
// ✅ Good: Generic types
interface ListProps<T> {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
  keyExtractor: (item: T) => string | number;
}

const List = <T,>({ items, renderItem, keyExtractor }: ListProps<T>) => {
  return (
    <ul>
      {items.map(item => (
        <li key={keyExtractor(item)}>
          {renderItem(item)}
        </li>
      ))}
    </ul>
  );
};

// ❌ Avoid: Non-generic types
interface ListProps {
  items: any[];
  renderItem: (item: any) => React.ReactNode;
  keyExtractor: (item: any) => string | number;
}
```

### **3. Use Proper Event Types**

```typescript
// ✅ Good: Proper event types
const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  setValue(e.target.value);
};

// ❌ Avoid: Generic event types
const handleInputChange = (e: any) => {
  setValue(e.target.value);
};
```

### **4. Use Custom Hooks for Logic Reuse**

```typescript
// ✅ Good: Custom hook
const useCounter = (initialValue: number = 0) => {
  const [count, setCount] = useState(initialValue);
  
  const increment = () => setCount(prev => prev + 1);
  const decrement = () => setCount(prev => prev - 1);
  const reset = () => setCount(initialValue);
  
  return { count, increment, decrement, reset };
};

// ❌ Avoid: Duplicating logic
const Counter1: React.FC = () => {
  const [count, setCount] = useState(0);
  const increment = () => setCount(prev => prev + 1);
  // ... rest of logic
};

const Counter2: React.FC = () => {
  const [count, setCount] = useState(0);
  const increment = () => setCount(prev => prev + 1);
  // ... duplicate logic
};
```

---

## ❓ **Common Interview Questions**

### **1. How do you type React components in TypeScript?**

**Answer:**
```typescript
interface ComponentProps {
  title: string;
  onClick: () => void;
}

const Component: React.FC<ComponentProps> = ({ title, onClick }) => {
  return <button onClick={onClick}>{title}</button>;
};
```

### **2. How do you type React hooks?**

**Answer:**
```typescript
const [count, setCount] = useState<number>(0);
const [user, setUser] = useState<User | null>(null);
```

### **3. How do you handle events in TypeScript React?**

**Answer:**
```typescript
const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
  e.preventDefault();
  // Handle click
};
```

### **4. How do you create custom hooks with TypeScript?**

**Answer:**
```typescript
const useApi = <T>(url: string): { data: T | null; loading: boolean } => {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  // ... hook logic
  return { data, loading };
};
```

### **5. How do you type React context?**

**Answer:**
```typescript
interface ContextType {
  user: User | null;
  login: (user: User) => void;
}

const Context = createContext<ContextType | undefined>(undefined);
```

---

## 🧭 Navigation

<div class="navigation">
  <a href="01-TypeScript-Nodejs.md" class="nav-button">← Previous: TypeScript with Node.js</a>
  <a href="03-TypeScript-Vuejs.md" class="nav-button">Next: TypeScript with Vue.js →</a>
</div>

*Last updated: December 2025*
