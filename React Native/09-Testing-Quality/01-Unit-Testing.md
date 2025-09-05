# 🧪 **Unit Testing**

> **Master unit testing with Jest, React Testing Library, and testing strategies for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Jest Configuration](#jest-configuration)
- [React Testing Library](#react-testing-library)
- [Component Testing](#component-testing)
- [Hook Testing](#hook-testing)
- [Mocking Strategies](#mocking-strategies)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Unit testing is essential for ensuring code quality and reliability in React Native applications. Understanding testing frameworks, strategies, and best practices helps build robust, maintainable applications.

### **Unit Testing Overview**

```
┌─────────────────────────────────────┐
│        Unit Testing System          │
│  ┌─────────────────────────────────┐│
│  │        Testing Frameworks       ││
│  │  - Jest                         ││
│  │  - React Testing Library        ││
│  │  - Enzyme                       ││
│  │  - Detox                        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Testing Types            ││
│  │  - Component testing            ││
│  │  - Hook testing                 ││
│  │  - Utility function testing     ││
│  │  - Integration testing          ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Testing Strategies       ││
│  │  - Mocking                      ││
│  │  - Test isolation               ││
│  │  - Coverage analysis            ││
│  │  - CI/CD integration            ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🧪 **Jest Configuration**

### **Jest Setup Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// jest.config.js
module.exports = {
  preset: 'react-native',
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  testPathIgnorePatterns: [
    '<rootDir>/node_modules/',
    '<rootDir>/android/',
    '<rootDir>/ios/',
  ],
  transformIgnorePatterns: [
    'node_modules/(?!(react-native|@react-native|@react-navigation|react-native-vector-icons|react-native-gesture-handler|react-native-reanimated|react-native-screens|react-native-safe-area-context)/)',
  ],
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/**/*.stories.{js,jsx,ts,tsx}',
    '!src/**/index.{js,jsx,ts,tsx}',
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^@components/(.*)$': '<rootDir>/src/components/$1',
    '^@utils/(.*)$': '<rootDir>/src/utils/$1',
    '^@services/(.*)$': '<rootDir>/src/services/$1',
  },
  testEnvironment: 'jsdom',
  verbose: true,
};
```

### **Test Setup File**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// src/setupTests.js
import '@testing-library/jest-native/extend-expect';
import 'react-native-gesture-handler/jestSetup';

// Mock react-native-reanimated
jest.mock('react-native-reanimated', () => {
  const Reanimated = require('react-native-reanimated/mock');
  Reanimated.default.call = () => {};
  return Reanimated;
});

// Mock react-native-vector-icons
jest.mock('react-native-vector-icons/MaterialIcons', () => 'Icon');

// Mock AsyncStorage
jest.mock('@react-native-async-storage/async-storage', () =>
  require('@react-native-async-storage/async-storage/jest/async-storage-mock')
);

// Mock react-native-device-info
jest.mock('react-native-device-info', () => ({
  getUniqueId: jest.fn(() => Promise.resolve('mock-device-id')),
  getVersion: jest.fn(() => Promise.resolve('1.0.0')),
  getBuildNumber: jest.fn(() => Promise.resolve('1')),
}));

// Mock react-native-permissions
jest.mock('react-native-permissions', () => ({
  check: jest.fn(() => Promise.resolve('granted')),
  request: jest.fn(() => Promise.resolve('granted')),
  PERMISSIONS: {
    ANDROID: {
      CAMERA: 'android.permission.CAMERA',
      ACCESS_FINE_LOCATION: 'android.permission.ACCESS_FINE_LOCATION',
    },
    IOS: {
      CAMERA: 'ios.permission.CAMERA',
      LOCATION_WHEN_IN_USE: 'ios.permission.LOCATION_WHEN_IN_USE',
    },
  },
  RESULTS: {
    UNAVAILABLE: 'unavailable',
    DENIED: 'denied',
    LIMITED: 'limited',
    GRANTED: 'granted',
    BLOCKED: 'blocked',
  },
}));

// Mock react-native-image-picker
jest.mock('react-native-image-picker', () => ({
  launchCamera: jest.fn(),
  launchImageLibrary: jest.fn(),
}));

// Mock react-native-push-notification
jest.mock('react-native-push-notification', () => ({
  configure: jest.fn(),
  localNotification: jest.fn(),
  localNotificationSchedule: jest.fn(),
  cancelAllLocalNotifications: jest.fn(),
}));

// Mock react-native-firebase
jest.mock('@react-native-firebase/messaging', () => () => ({
  requestPermission: jest.fn(() => Promise.resolve(1)),
  getToken: jest.fn(() => Promise.resolve('mock-fcm-token')),
  onMessage: jest.fn(() => jest.fn()),
  setBackgroundMessageHandler: jest.fn(),
  onNotificationOpenedApp: jest.fn(() => jest.fn()),
  getInitialNotification: jest.fn(() => Promise.resolve(null)),
}));

// Global test utilities
global.mockNavigation = {
  navigate: jest.fn(),
  goBack: jest.fn(),
  reset: jest.fn(),
  setParams: jest.fn(),
  dispatch: jest.fn(),
  canGoBack: jest.fn(() => true),
  isFocused: jest.fn(() => true),
  addListener: jest.fn(() => jest.fn()),
  removeListener: jest.fn(),
};

global.mockRoute = {
  key: 'test-route',
  name: 'TestScreen',
  params: {},
};

// Mock console methods to reduce noise in tests
global.console = {
  ...console,
  log: jest.fn(),
  debug: jest.fn(),
  info: jest.fn(),
  warn: jest.fn(),
  error: jest.fn(),
};
```

---

## 🧪 **React Testing Library**

### **Component Testing Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// __tests__/components/Button.test.js
import React from 'react';
import { render, fireEvent, waitFor } from '@testing-library/react-native';
import { Button } from '../Button';

describe('Button Component', () => {
  const defaultProps = {
    title: 'Test Button',
    onPress: jest.fn(),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders correctly with default props', () => {
    const { getByText } = render(<Button {...defaultProps} />);
    
    expect(getByText('Test Button')).toBeTruthy();
  });

  it('calls onPress when pressed', () => {
    const { getByText } = render(<Button {...defaultProps} />);
    
    fireEvent.press(getByText('Test Button'));
    
    expect(defaultProps.onPress).toHaveBeenCalledTimes(1);
  });

  it('displays loading state when loading prop is true', () => {
    const { getByTestId } = render(
      <Button {...defaultProps} loading={true} />
    );
    
    expect(getByTestId('loading-indicator')).toBeTruthy();
  });

  it('is disabled when disabled prop is true', () => {
    const { getByText } = render(
      <Button {...defaultProps} disabled={true} />
    );
    
    const button = getByText('Test Button');
    expect(button.props.accessibilityState.disabled).toBe(true);
  });

  it('applies custom styles', () => {
    const customStyle = { backgroundColor: 'red' };
    const { getByText } = render(
      <Button {...defaultProps} style={customStyle} />
    );
    
    const button = getByText('Test Button');
    expect(button.props.style).toContainEqual(customStyle);
  });

  it('handles long press events', () => {
    const onLongPress = jest.fn();
    const { getByText } = render(
      <Button {...defaultProps} onLongPress={onLongPress} />
    );
    
    fireEvent(getByText('Test Button'), 'longPress');
    
    expect(onLongPress).toHaveBeenCalledTimes(1);
  });
});
```

### **Hook Testing Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// __tests__/hooks/useCounter.test.js
import { renderHook, act } from '@testing-library/react-hooks';
import { useCounter } from '../useCounter';

describe('useCounter Hook', () => {
  it('initializes with default value', () => {
    const { result } = renderHook(() => useCounter());
    
    expect(result.current.count).toBe(0);
  });

  it('initializes with custom initial value', () => {
    const { result } = renderHook(() => useCounter(10));
    
    expect(result.current.count).toBe(10);
  });

  it('increments count', () => {
    const { result } = renderHook(() => useCounter());
    
    act(() => {
      result.current.increment();
    });
    
    expect(result.current.count).toBe(1);
  });

  it('decrements count', () => {
    const { result } = renderHook(() => useCounter(5));
    
    act(() => {
      result.current.decrement();
    });
    
    expect(result.current.count).toBe(4);
  });

  it('resets count to initial value', () => {
    const { result } = renderHook(() => useCounter(10));
    
    act(() => {
      result.current.increment();
      result.current.increment();
    });
    
    expect(result.current.count).toBe(12);
    
    act(() => {
      result.current.reset();
    });
    
    expect(result.current.count).toBe(10);
  });

  it('sets count to specific value', () => {
    const { result } = renderHook(() => useCounter());
    
    act(() => {
      result.current.setCount(42);
    });
    
    expect(result.current.count).toBe(42);
  });

  it('handles multiple operations', () => {
    const { result } = renderHook(() => useCounter());
    
    act(() => {
      result.current.increment();
      result.current.increment();
      result.current.decrement();
      result.current.setCount(100);
    });
    
    expect(result.current.count).toBe(100);
  });
});
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="../08-Platform-Capabilities/04-Push-Notifications.md" class="nav-link prev">⬅️ Previous: Push Notifications</a>
    <a href="./02-Integration-Testing.md" class="nav-link next">Next: Integration Testing ➡️</a>
</div>

---


*Last updated: December 2024*
