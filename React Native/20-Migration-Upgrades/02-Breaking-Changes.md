# ⚠️ **React Native Breaking Changes**

> **Comprehensive guide to handling breaking changes in React Native upgrades, including common patterns and migration strategies**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Overview](#overview)
- [Types of Breaking Changes](#types-of-breaking-changes)
- [Common Breaking Changes](#common-breaking-changes)
- [Migration Strategies](#migration-strategies)
- [Version-Specific Changes](#version-specific-changes)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Overview**

Breaking changes are modifications that:
- **Remove or modify existing APIs**
- **Change default behaviors**
- **Require code updates** to maintain functionality
- **Can cause runtime errors** if not addressed

### **Key Concepts**
- **API Deprecation**: Gradual removal of old APIs
- **Behavioral Changes**: Modified default behaviors
- **Dependency Updates**: Updated third-party libraries
- **Platform Changes**: iOS/Android specific modifications

---

## 🔧 **Types of Breaking Changes**

### **1. API Removals**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// ❌ Old API (removed in 0.70+)
import { AsyncStorage } from 'react-native';

// ✅ New API
import AsyncStorage from '@react-native-async-storage/async-storage';
```


### **2. API Modifications**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// ❌ Old API (changed in 0.69+)
import { Dimensions } from 'react-native';
const { width, height } = Dimensions.get('window');

// ✅ New API
import { useWindowDimensions } from 'react-native';
const { width, height } = useWindowDimensions();
```


### **3. Default Behavior Changes**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// ❌ Old behavior (changed in 0.68+)
// FlatList had different default props

// ✅ New behavior
<FlatList
  removeClippedSubviews={false} // New default
  maxToRenderPerBatch={10}      // New default
/>
```


### **4. Dependency Updates**

```json
// ❌ Old dependencies
{
  "react": "17.0.2",
  "react-native": "0.68.0"
}

// ✅ New dependencies
{
  "react": "18.2.0",
  "react-native": "0.71.0"
}
```


---

## 📋 **Common Breaking Changes**

### **1. AsyncStorage Migration (0.60+)**

#### **Before (Deprecated)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import { AsyncStorage } from 'react-native';

// Usage
AsyncStorage.setItem('key', 'value');
AsyncStorage.getItem('key');
```


#### **After (New Package)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Install new package
npm install @react-native-async-storage/async-storage
```


<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import AsyncStorage from '@react-native-async-storage/async-storage';

// Usage (same API)
AsyncStorage.setItem('key', 'value');
AsyncStorage.getItem('key');
```


### **2. NetInfo Migration (0.60+)**

#### **Before (Deprecated)**

```javascript
import NetInfo from '@react-native-community/netinfo';

// Old API
NetInfo.getConnectionInfo().then(connectionInfo => {
  console.log(connectionInfo);
});
```


#### **After (New API)**

```javascript
import NetInfo from '@react-native-community/netinfo';

// New API
NetInfo.fetch().then(state => {
  console.log(state);
});

// Or with hooks
import { useNetInfo } from '@react-native-community/netinfo';

const netInfo = useNetInfo();
console.log(netInfo);
```


### **3. Dimensions API Changes (0.69+)**

#### **Before (Deprecated)**

```javascript
import { Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');

// Static values, doesn't update on orientation change
```


#### **After (New Hook)**

```javascript
import { useWindowDimensions } from 'react-native';

const { width, height } = useWindowDimensions();

// Dynamic values, updates on orientation change
```


### **4. FlatList Performance Changes (0.68+)**

#### **Before (Old Defaults)**

```javascript
<FlatList
  data={data}
  renderItem={renderItem}
  // Old defaults were different
/>
```


#### **After (New Defaults)**

```javascript
<FlatList
  data={data}
  renderItem={renderItem}
  removeClippedSubviews={false} // New default
  maxToRenderPerBatch={10}      // New default
  windowSize={10}               // New default
/>
```


### **5. New Architecture Changes (0.68+)**

#### **Before (Old Architecture)**

```javascript
// Bridge-based communication
// Slower performance
// Limited type safety
```


#### **After (New Architecture)**

```javascript
// JSI-based communication
// Better performance
// Enhanced type safety
// TurboModules and Fabric
```


---

## 🚀 **Migration Strategies**

### **1. Gradual Migration**

```javascript
// Create compatibility layer
const CompatibleAsyncStorage = {
  setItem: (key, value) => {
    if (AsyncStorage) {
      return AsyncStorage.setItem(key, value);
    }
    // Fallback to new implementation
    return newAsyncStorage.setItem(key, value);
  }
};
```


### **2. Feature Detection**

```javascript
// Check for API availability
const useDimensions = () => {
  if (useWindowDimensions) {
    return useWindowDimensions();
  }
  // Fallback to old API
  const { width, height } = Dimensions.get('window');
  return { width, height };
};
```


### **3. Conditional Imports**

```javascript
// Import based on version
let AsyncStorage;
try {
  AsyncStorage = require('@react-native-async-storage/async-storage').default;
} catch (e) {
  AsyncStorage = require('react-native').AsyncStorage;
}
```


### **4. Wrapper Components**

```javascript
// Create wrapper for breaking changes
const CompatibleFlatList = ({ children, ...props }) => {
  const newProps = {
    ...props,
    removeClippedSubviews: props.removeClippedSubviews ?? false,
    maxToRenderPerBatch: props.maxToRenderPerBatch ?? 10,
  };
  
  return <FlatList {...newProps}>{children}</FlatList>;
};
```


---

## 📅 **Version-Specific Changes**

### **React Native 0.71 Breaking Changes**

```javascript
// 1. New Architecture enabled by default
// 2. Updated Metro configuration
// 3. New Flipper integration
// 4. Updated Android Gradle Plugin

// Migration steps:
// 1. Update package.json
// 2. Update Metro config
// 3. Update Android build files
// 4. Test New Architecture
```


### **React Native 0.70 Breaking Changes**

```javascript
// 1. New Architecture support
// 2. Updated React 18 support
// 3. New Metro configuration
// 4. Updated Android target SDK

// Migration steps:
// 1. Update React to 18.2.0
// 2. Update Metro configuration
// 3. Update Android target SDK
// 4. Test compatibility
```


### **React Native 0.69 Breaking Changes**

```javascript
// 1. Dimensions API changes
// 2. FlatList performance updates
// 3. New Architecture preparation
// 4. Updated dependencies

// Migration steps:
// 1. Update Dimensions usage
// 2. Review FlatList performance
// 3. Update dependencies
// 4. Test performance
```


### **React Native 0.68 Breaking Changes**

```javascript
// 1. New Architecture introduction
// 2. FlatList default changes
// 3. Updated Android support
// 4. New Metro features

// Migration steps:
// 1. Review FlatList usage
// 2. Update Android configuration
// 3. Test New Architecture
// 4. Update Metro config
```


---

## ✅ **Best Practices**

### **1. Stay Updated**

```bash
# Regular updates prevent major breaking changes
npm update react-native

# Check for deprecation warnings
npx react-native start --verbose
```


### **2. Use TypeScript**

```typescript
// TypeScript helps catch breaking changes
interface FlatListProps {
  data: any[];
  renderItem: ({ item }: { item: any }) => React.ReactElement;
  removeClippedSubviews?: boolean; // Optional for compatibility
}
```


### **3. Automated Testing**

```javascript
// Test for breaking changes
describe('Breaking Changes', () => {
  it('should handle AsyncStorage migration', async () => {
    await AsyncStorage.setItem('test', 'value');
    const value = await AsyncStorage.getItem('test');
    expect(value).toBe('value');
  });

  it('should handle Dimensions changes', () => {
    const { width, height } = useWindowDimensions();
    expect(width).toBeGreaterThan(0);
    expect(height).toBeGreaterThan(0);
  });
});
```


### **4. Documentation**

```markdown
# Keep track of breaking changes
# Document migration steps
# Maintain compatibility matrix
```


### **5. Gradual Rollout**

```javascript
// Use feature flags for gradual migration
const useNewAsyncStorage = useFeatureFlag('new-async-storage');

const storage = useNewAsyncStorage ? newAsyncStorage : oldAsyncStorage;
```


---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **What are breaking changes in React Native?**
   - API removals or modifications
   - Changed default behaviors
   - Updated dependencies
   - Platform-specific changes

2. **How do you handle breaking changes?**
   - Read migration guides
   - Update deprecated APIs
   - Test thoroughly
   - Use compatibility layers

3. **What's the difference between deprecation and breaking changes?**
   - Deprecation: Warning about future removal
   - Breaking changes: Immediate incompatibility

### **Intermediate Questions**
4. **How do you migrate from old AsyncStorage to new one?**
   - Install new package
   - Update imports
   - Test functionality
   - Remove old dependencies

5. **What are the benefits of the New Architecture?**
   - Better performance
   - Enhanced type safety
   - Improved debugging
   - Future-proofing

6. **How do you handle FlatList performance changes?**
   - Update default props
   - Test performance
   - Adjust rendering settings
   - Monitor memory usage

### **Advanced Questions**
7. **How do you create a compatibility layer for breaking changes?**
   - Detect API availability
   - Provide fallbacks
   - Maintain same interface
   - Test thoroughly

8. **What's your strategy for handling major version upgrades?**
   - Gradual migration
   - Feature flags
   - Automated testing
   - Staged rollout

9. **How do you prevent breaking changes from affecting users?**
   - Thorough testing
   - Gradual rollout
   - Monitoring
   - Quick rollback capability

---

## 🔗 **Related Topics**

- [Version Upgrades](./01-Version-Upgrades.md)
- [Architecture Migration](./03-Architecture-Migration.md)
- [Migration Testing](./04-Migration-Testing.md)
- [Advanced Debugging](../19-Advanced-Debugging/01-Debugging-Tools.md)
- [Performance Optimization](../05-Lists-Performance-Optimization/01-FlatList-SectionList.md)

---

## 📚 **Resources**

- [React Native Breaking Changes](https://github.com/facebook/react-native/releases)
- [Migration Guides](https://react-native-community.github.io/upgrade-helper/)
- [New Architecture Guide](https://reactnative.dev/docs/the-new-architecture/landing-page)
- [Deprecation Warnings](https://reactnative.dev/docs/deprecated-apis)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Version-Upgrades.md" class="nav-link prev">⬅️ Previous: Version Upgrades</a>
    <a href="./03-Architecture-Migration.md" class="nav-link next">Next: Architecture Migration ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
