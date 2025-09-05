# 📘 **TypeScript Essentials for React Native**

> **Master TypeScript concepts that are crucial for React Native development, including strict typing, interfaces, generics, and type safety**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [TypeScript Configuration](#typescript-configuration)
- [Basic Types in React Native](#basic-types-in-react-native)
- [Interfaces & Type Definitions](#interfaces--type-definitions)
- [Generics in React Native](#generics-in-react-native)
- [React Native Specific Types](#react-native-specific-types)
- [Custom Hooks with TypeScript](#custom-hooks-with-typescript)
- [Navigation Types](#navigation-types)
- [API Integration Types](#api-integration-types)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

TypeScript brings static type checking to React Native development, helping catch errors at compile time and improving code maintainability. Understanding TypeScript concepts is essential for building robust React Native applications.

### **Benefits of TypeScript in React Native**

- **Type Safety**: Catch errors before runtime
- **Better IDE Support**: Enhanced autocomplete and refactoring
- **Self-Documenting Code**: Types serve as documentation
- **Easier Refactoring**: Safe code changes with type checking
- **Team Collaboration**: Clear contracts between components

---

## ⚙️ **TypeScript Configuration**

### **tsconfig.json Setup**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```json
{
  "compilerOptions": {
    "target": "esnext",
    "lib": ["es2017"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@screens/*": ["src/screens/*"],
      "@utils/*": ["src/utils/*"],
      "@types/*": ["src/types/*"]
    }
  },
  "include": [
    "src/**/*",
    "App.tsx",
    "index.js"
  ],
  "exclude": [
    "node_modules",
    "babel.config.js",
    "metro.config.js",
    "jest.config.js"
  ]
}
```

### **Type Definitions Structure**

```
src/
├── types/
│   ├── index.ts          # Main type exports
│   ├── api.ts           # API response types
│   ├── navigation.ts    # Navigation types
│   ├── user.ts         # User-related types
│   └── common.ts       # Common utility types
├── components/
├── screens/
└── utils/
```

---

## 🔤 **Basic Types in React Native**

### **Primitive Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ Basic type annotations
const userName: string = 'John Doe';
const userAge: number = 25;
const isActive: boolean = true;
const userTags: string[] = ['developer', 'react-native'];
const userScores: number[] = [85, 92, 78];

// ✅ Union types
type Status = 'loading' | 'success' | 'error';
const currentStatus: Status = 'loading';

// ✅ Optional properties
interface User {
  id: number;
  name: string;
  email?: string; // Optional property
  age?: number;
}

// ✅ Function types
type EventHandler = (event: any) => void;
type ApiCall = (url: string) => Promise<any>;
```

### **React Native Component Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

// ✅ Component props interface
interface ButtonProps {
  title: string;
  onPress: () => void;
  disabled?: boolean;
  style?: any;
  textStyle?: any;
}

// ✅ Functional component with TypeScript
const CustomButton: React.FC<ButtonProps> = ({
  title,
  onPress,
  disabled = false,
  style,
  textStyle
}) => {
  return (
    <TouchableOpacity
      style={[styles.button, style, disabled && styles.disabled]}
      onPress={onPress}
      disabled={disabled}
    >
      <Text style={[styles.buttonText, textStyle]}>{title}</Text>
    </TouchableOpacity>
  );
};

// ✅ Styles with TypeScript
const styles = StyleSheet.create({
  button: {
    backgroundColor: '#007AFF',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: '600',
  },
  disabled: {
    backgroundColor: '#CCCCCC',
  },
});

export default CustomButton;
```

---

## 🏗️ **Interfaces & Type Definitions**

### **User Interface Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ User interface definition
interface User {
  id: number;
  name: string;
  email: string;
  avatar?: string;
  isOnline: boolean;
  lastSeen: Date;
  preferences: UserPreferences;
  roles: UserRole[];
}

interface UserPreferences {
  theme: 'light' | 'dark';
  notifications: boolean;
  language: string;
  timezone: string;
}

interface UserRole {
  id: number;
  name: string;
  permissions: Permission[];
}

interface Permission {
  id: number;
  name: string;
  resource: string;
  action: 'read' | 'write' | 'delete';
}

// ✅ API Response types
interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
  errors?: string[];
}

interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

// ✅ Usage in components
const UserProfile: React.FC<{ user: User }> = ({ user }) => {
  return (
    <View style={styles.container}>
      <Text style={styles.name}>{user.name}</Text>
      <Text style={styles.email}>{user.email}</Text>
      <Text style={styles.status}>
        {user.isOnline ? 'Online' : `Last seen: ${user.lastSeen.toLocaleDateString()}`}
      </Text>
    </View>
  );
};
```

### **Form Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ Form validation types
interface LoginForm {
  email: string;
  password: string;
  rememberMe: boolean;
}

interface LoginFormErrors {
  email?: string;
  password?: string;
  general?: string;
}

interface FormState<T> {
  values: T;
  errors: Partial<Record<keyof T, string>>;
  isSubmitting: boolean;
  isValid: boolean;
}

// ✅ Form component with TypeScript
const LoginForm: React.FC = () => {
  const [formState, setFormState] = useState<FormState<LoginForm>>({
    values: {
      email: '',
      password: '',
      rememberMe: false,
    },
    errors: {},
    isSubmitting: false,
    isValid: false,
  });

  const validateForm = (values: LoginForm): LoginFormErrors => {
    const errors: LoginFormErrors = {};
    
    if (!values.email) {
      errors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(values.email)) {
      errors.email = 'Email is invalid';
    }
    
    if (!values.password) {
      errors.password = 'Password is required';
    } else if (values.password.length < 6) {
      errors.password = 'Password must be at least 6 characters';
    }
    
    return errors;
  };

  const handleSubmit = async () => {
    const errors = validateForm(formState.values);
    
    if (Object.keys(errors).length === 0) {
      setFormState(prev => ({ ...prev, isSubmitting: true }));
      
      try {
        // API call here
        await loginUser(formState.values);
      } catch (error) {
        setFormState(prev => ({
          ...prev,
          errors: { general: 'Login failed. Please try again.' }
        }));
      } finally {
        setFormState(prev => ({ ...prev, isSubmitting: false }));
      }
    } else {
      setFormState(prev => ({ ...prev, errors }));
    }
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Email"
        value={formState.values.email}
        onChangeText={(text) => setFormState(prev => ({
          ...prev,
          values: { ...prev.values, email: text },
          errors: { ...prev.errors, email: undefined }
        }))}
      />
      {formState.errors.email && (
        <Text style={styles.errorText}>{formState.errors.email}</Text>
      )}
      
      <TextInput
        style={styles.input}
        placeholder="Password"
        secureTextEntry
        value={formState.values.password}
        onChangeText={(text) => setFormState(prev => ({
          ...prev,
          values: { ...prev.values, password: text },
          errors: { ...prev.errors, password: undefined }
        }))}
      />
      {formState.errors.password && (
        <Text style={styles.errorText}>{formState.errors.password}</Text>
      )}
      
      <CustomButton
        title="Login"
        onPress={handleSubmit}
        disabled={formState.isSubmitting}
      />
    </View>
  );
};
```

---

## 🔄 **Generics in React Native**

### **Generic Hooks**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ Generic API hook
interface UseApiState<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
}

interface UseApiReturn<T> extends UseApiState<T> {
  execute: (url: string, options?: RequestInit) => Promise<T>;
  reset: () => void;
}

function useApi<T>(): UseApiReturn<T> {
  const [state, setState] = useState<UseApiState<T>>({
    data: null,
    loading: false,
    error: null,
  });

  const execute = useCallback(async (url: string, options: RequestInit = {}) => {
    setState(prev => ({ ...prev, loading: true, error: null }));
    
    try {
      const response = await fetch(url, options);
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      
      const data: T = await response.json();
      setState({ data, loading: false, error: null });
      return data;
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Unknown error';
      setState({ data: null, loading: false, error: errorMessage });
      throw error;
    }
  }, []);

  const reset = useCallback(() => {
    setState({ data: null, loading: false, error: null });
  }, []);

  return { ...state, execute, reset };
}

// ✅ Usage with specific types
interface User {
  id: number;
  name: string;
  email: string;
}

const UserProfile: React.FC<{ userId: number }> = ({ userId }) => {
  const { data: user, loading, error, execute } = useApi<User>();
  
  useEffect(() => {
    execute(`/api/users/${userId}`);
  }, [userId, execute]);
  
  if (loading) return <ActivityIndicator />;
  if (error) return <Text>Error: {error}</Text>;
  if (!user) return <Text>No user found</Text>;
  
  return (
    <View>
      <Text>{user.name}</Text>
      <Text>{user.email}</Text>
    </View>
  );
};
```

### **Generic Components**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ Generic list component
interface ListItem {
  id: string | number;
}

interface GenericListProps<T extends ListItem> {
  data: T[];
  renderItem: (item: T, index: number) => React.ReactElement;
  keyExtractor: (item: T) => string;
  onItemPress?: (item: T) => void;
  emptyMessage?: string;
  loading?: boolean;
}

function GenericList<T extends ListItem>({
  data,
  renderItem,
  keyExtractor,
  onItemPress,
  emptyMessage = 'No items found',
  loading = false,
}: GenericListProps<T>) {
  if (loading) {
    return <ActivityIndicator size="large" />;
  }
  
  if (data.length === 0) {
    return (
      <View style={styles.emptyContainer}>
        <Text style={styles.emptyText}>{emptyMessage}</Text>
      </View>
    );
  }
  
  return (
    <FlatList
      data={data}
      keyExtractor={keyExtractor}
      renderItem={({ item, index }) => (
        <TouchableOpacity onPress={() => onItemPress?.(item)}>
          {renderItem(item, index)}
        </TouchableOpacity>
      )}
    />
  );
}

// ✅ Usage with specific types
interface Product extends ListItem {
  id: number;
  name: string;
  price: number;
  image: string;
}

const ProductList: React.FC<{ products: Product[] }> = ({ products }) => {
  const handleProductPress = (product: Product) => {
    // Navigate to product detail
    console.log('Product pressed:', product);
  };
  
  const renderProduct = (product: Product) => (
    <View style={styles.productItem}>
      <Image source={{ uri: product.image }} style={styles.productImage} />
      <Text style={styles.productName}>{product.name}</Text>
      <Text style={styles.productPrice}>${product.price}</Text>
    </View>
  );
  
  return (
    <GenericList
      data={products}
      renderItem={renderProduct}
      keyExtractor={(product) => product.id.toString()}
      onItemPress={handleProductPress}
      emptyMessage="No products available"
    />
  );
};
```

---

## 📱 **React Native Specific Types**

### **StyleSheet Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
import { StyleSheet, ViewStyle, TextStyle, ImageStyle } from 'react-native';

// ✅ Typed styles
interface Styles {
  container: ViewStyle;
  title: TextStyle;
  button: ViewStyle;
  buttonText: TextStyle;
  image: ImageStyle;
}

const styles = StyleSheet.create<Styles>({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 20,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: '600',
  },
  image: {
    width: 100,
    height: 100,
    borderRadius: 50,
  },
});

// ✅ Dynamic styles with TypeScript
interface DynamicStylesProps {
  isActive: boolean;
  theme: 'light' | 'dark';
  size: 'small' | 'medium' | 'large';
}

const getDynamicStyles = ({ isActive, theme, size }: DynamicStylesProps) => {
  const baseStyles: ViewStyle = {
    padding: size === 'small' ? 8 : size === 'medium' ? 12 : 16,
    borderRadius: 8,
  };
  
  const themeStyles: ViewStyle = {
    backgroundColor: theme === 'light' ? '#fff' : '#333',
    borderColor: theme === 'light' ? '#ddd' : '#555',
  };
  
  const activeStyles: ViewStyle = isActive ? {
    backgroundColor: '#007AFF',
    borderColor: '#007AFF',
  } : {};
  
  return StyleSheet.create({
    dynamicButton: {
      ...baseStyles,
      ...themeStyles,
      ...activeStyles,
    },
  });
};
```

### **Platform Specific Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
import { Platform, PlatformOSType } from 'react-native';

// ✅ Platform-specific types
type PlatformStyle<T> = {
  ios?: T;
  android?: T;
  web?: T;
  default?: T;
};

// ✅ Platform-specific component props
interface PlatformButtonProps {
  title: string;
  onPress: () => void;
  style?: PlatformStyle<ViewStyle>;
  textStyle?: PlatformStyle<TextStyle>;
}

const PlatformButton: React.FC<PlatformButtonProps> = ({
  title,
  onPress,
  style,
  textStyle,
}) => {
  const platformStyle = style?.[Platform.OS as PlatformOSType] || style?.default;
  const platformTextStyle = textStyle?.[Platform.OS as PlatformOSType] || textStyle?.default;
  
  return (
    <TouchableOpacity
      style={[styles.button, platformStyle]}
      onPress={onPress}
    >
      <Text style={[styles.buttonText, platformTextStyle]}>{title}</Text>
    </TouchableOpacity>
  );
};

// ✅ Usage
const MyComponent = () => {
  return (
    <PlatformButton
      title="Press Me"
      onPress={() => console.log('Pressed')}
      style={{
        ios: { backgroundColor: '#007AFF' },
        android: { backgroundColor: '#2196F3' },
        default: { backgroundColor: '#6C757D' },
      }}
      textStyle={{
        ios: { fontSize: 16 },
        android: { fontSize: 14 },
        default: { fontSize: 15 },
      }}
    />
  );
};
```

---

## 🪝 **Custom Hooks with TypeScript**

### **Typed Custom Hooks**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ Typed storage hook
interface UseStorageReturn<T> {
  value: T | null;
  setValue: (value: T) => Promise<void>;
  removeValue: () => Promise<void>;
  loading: boolean;
  error: string | null;
}

function useStorage<T>(key: string, initialValue?: T): UseStorageReturn<T> {
  const [value, setValue] = useState<T | null>(initialValue || null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  
  useEffect(() => {
    const loadValue = async () => {
      try {
        setLoading(true);
        setError(null);
        
        const storedValue = await AsyncStorage.getItem(key);
        if (storedValue !== null) {
          setValue(JSON.parse(storedValue));
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Storage error');
      } finally {
        setLoading(false);
      }
    };
    
    loadValue();
  }, [key]);
  
  const setStoredValue = useCallback(async (newValue: T) => {
    try {
      setError(null);
      await AsyncStorage.setItem(key, JSON.stringify(newValue));
      setValue(newValue);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Storage error');
    }
  }, [key]);
  
  const removeStoredValue = useCallback(async () => {
    try {
      setError(null);
      await AsyncStorage.removeItem(key);
      setValue(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Storage error');
    }
  }, [key]);
  
  return {
    value,
    setValue: setStoredValue,
    removeValue: removeStoredValue,
    loading,
    error,
  };
}

// ✅ Usage
const SettingsScreen = () => {
  const { value: theme, setValue: setTheme, loading } = useStorage<'light' | 'dark'>('theme', 'light');
  const { value: notifications, setValue: setNotifications } = useStorage<boolean>('notifications', true);
  
  if (loading) {
    return <ActivityIndicator />;
  }
  
  return (
    <View style={styles.container}>
      <Text>Theme: {theme}</Text>
      <TouchableOpacity onPress={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
        <Text>Toggle Theme</Text>
      </TouchableOpacity>
      
      <Text>Notifications: {notifications ? 'On' : 'Off'}</Text>
      <TouchableOpacity onPress={() => setNotifications(!notifications)}>
        <Text>Toggle Notifications</Text>
      </TouchableOpacity>
    </View>
  );
};
```

---

## 🧭 **Navigation Types**

### **React Navigation Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
import { NavigationProp, RouteProp } from '@react-navigation/native';
import { StackNavigationProp } from '@react-navigation/stack';

// ✅ Navigation parameter types
export type RootStackParamList = {
  Home: undefined;
  Profile: { userId: number };
  Settings: undefined;
  Chat: { chatId: string; title: string };
  ProductDetail: { productId: number; productName: string };
};

// ✅ Navigation prop types
export type HomeScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Home'>;
export type ProfileScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Profile'>;
export type ChatScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Chat'>;

// ✅ Route prop types
export type ProfileScreenRouteProp = RouteProp<RootStackParamList, 'Profile'>;
export type ChatScreenRouteProp = RouteProp<RootStackParamList, 'Chat'>;

// ✅ Screen component types
interface HomeScreenProps {
  navigation: HomeScreenNavigationProp;
}

interface ProfileScreenProps {
  navigation: ProfileScreenNavigationProp;
  route: ProfileScreenRouteProp;
}

interface ChatScreenProps {
  navigation: ChatScreenNavigationProp;
  route: ChatScreenRouteProp;
}

// ✅ Usage in components
const HomeScreen: React.FC<HomeScreenProps> = ({ navigation }) => {
  const handleProfilePress = (userId: number) => {
    navigation.navigate('Profile', { userId });
  };
  
  const handleChatPress = (chatId: string, title: string) => {
    navigation.navigate('Chat', { chatId, title });
  };
  
  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={() => handleProfilePress(123)}>
        <Text>Go to Profile</Text>
      </TouchableOpacity>
      
      <TouchableOpacity onPress={() => handleChatPress('chat-1', 'General Chat')}>
        <Text>Go to Chat</Text>
      </TouchableOpacity>
    </View>
  );
};

const ProfileScreen: React.FC<ProfileScreenProps> = ({ navigation, route }) => {
  const { userId } = route.params;
  
  return (
    <View style={styles.container}>
      <Text>Profile for User ID: {userId}</Text>
      <TouchableOpacity onPress={() => navigation.goBack()}>
        <Text>Go Back</Text>
      </TouchableOpacity>
    </View>
  );
};
```

---

## 🌐 **API Integration Types**

### **API Types**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```typescript
// ✅ API request/response types
interface ApiRequest {
  method: 'GET' | 'POST' | 'PUT' | 'DELETE';
  url: string;
  headers?: Record<string, string>;
  body?: any;
}

interface ApiResponse<T = any> {
  success: boolean;
  data: T;
  message?: string;
  errors?: string[];
  status: number;
}

interface PaginationParams {
  page: number;
  limit: number;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
}

interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
    hasNext: boolean;
    hasPrev: boolean;
  };
}

// ✅ API service with TypeScript
class ApiService {
  private baseUrl: string;
  private defaultHeaders: Record<string, string>;
  
  constructor(baseUrl: string, defaultHeaders: Record<string, string> = {}) {
    this.baseUrl = baseUrl;
    this.defaultHeaders = {
      'Content-Type': 'application/json',
      ...defaultHeaders,
    };
  }
  
  async request<T>(request: ApiRequest): Promise<ApiResponse<T>> {
    try {
      const response = await fetch(`${this.baseUrl}${request.url}`, {
        method: request.method,
        headers: {
          ...this.defaultHeaders,
          ...request.headers,
        },
        body: request.body ? JSON.stringify(request.body) : undefined,
      });
      
      const data = await response.json();
      
      return {
        success: response.ok,
        data,
        status: response.status,
        message: data.message,
        errors: data.errors,
      };
    } catch (error) {
      return {
        success: false,
        data: null as any,
        status: 0,
        message: error instanceof Error ? error.message : 'Unknown error',
        errors: ['Network error'],
      };
    }
  }
  
  async get<T>(url: string, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>({ method: 'GET', url, headers });
  }
  
  async post<T>(url: string, body: any, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>({ method: 'POST', url, body, headers });
  }
  
  async put<T>(url: string, body: any, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>({ method: 'PUT', url, body, headers });
  }
  
  async delete<T>(url: string, headers?: Record<string, string>): Promise<ApiResponse<T>> {
    return this.request<T>({ method: 'DELETE', url, headers });
  }
}

// ✅ Usage
const apiService = new ApiService('https://api.example.com', {
  'Authorization': 'Bearer your-token-here',
});

// Typed API calls
const fetchUsers = async (params: PaginationParams) => {
  const response = await apiService.get<PaginatedResponse<User>>(
    `/users?page=${params.page}&limit=${params.limit}`
  );
  return response;
};

const createUser = async (userData: Omit<User, 'id'>) => {
  const response = await apiService.post<User>('/users', userData);
  return response;
};
```

---

## 🎯 **Interview Questions**

### **Basic Level**

1. **What are the benefits of using TypeScript in React Native?**
2. **How do you define component props with TypeScript?**
3. **What is the difference between `interface` and `type` in TypeScript?**

### **Intermediate Level**

4. **How would you create a generic hook for API calls?**
5. **Explain how to type React Navigation parameters.**
6. **How do you handle optional properties in TypeScript interfaces?**

### **Advanced Level**

7. **How would you implement type-safe form validation with TypeScript?**
8. **Explain the concept of conditional types in TypeScript.**
9. **How would you create a type-safe state management solution?**

---

## 💡 **Best Practices**

### **1. Use Strict Type Checking**

```typescript
// ✅ Enable strict mode in tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true
  }
}
```

### **2. Define Clear Interfaces**

```typescript
// ✅ Clear, specific interfaces
interface User {
  id: number;
  name: string;
  email: string;
  createdAt: Date;
}

// ❌ Avoid overly generic types
interface User {
  [key: string]: any;
}
```

### **3. Use Generic Types**

```typescript
// ✅ Generic types for reusability
interface ApiResponse<T> {
  data: T;
  success: boolean;
}

// Usage
const userResponse: ApiResponse<User> = await fetchUser();
const productResponse: ApiResponse<Product> = await fetchProduct();
```

### **4. Type Guards**

```typescript
// ✅ Type guards for runtime type checking
function isUser(obj: any): obj is User {
  return obj && typeof obj.id === 'number' && typeof obj.name === 'string';
}

// Usage
if (isUser(data)) {
  // TypeScript knows data is User type
  console.log(data.name);
}
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="./01-React-Essentials-for-RN.md" class="nav-link prev">⬅️ Previous: React Essentials for RN</a>
    <a href="../01-React-Native-Fundamentals/01-Core-Components.md" class="nav-link next">Next: Core Components ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
