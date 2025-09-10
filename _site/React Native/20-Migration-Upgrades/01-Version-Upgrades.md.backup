# 🔄 **React Native Version Upgrades**

> **Complete guide to upgrading React Native versions, handling dependencies, and managing breaking changes**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Overview](#overview)
- [Pre-Upgrade Preparation](#pre-upgrade-preparation)
- [Upgrade Process](#upgrade-process)
- [Common Upgrade Scenarios](#common-upgrade-scenarios)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Overview**

React Native version upgrades are essential for:
- **Security patches** and bug fixes
- **New features** and performance improvements
- **Long-term support** and maintenance
- **Ecosystem compatibility** with latest libraries

### **Key Concepts**
- **Semantic Versioning**: Major.Minor.Patch releases
- **Breaking Changes**: Incompatible API changes
- **Deprecation Warnings**: Future breaking changes
- **Migration Guides**: Official upgrade documentation

---

## 🔧 **Pre-Upgrade Preparation**

### **1. Backup and Version Control**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Create a backup branch
git checkout -b backup-before-upgrade
git push origin backup-before-upgrade

# Ensure clean working directory
git status
git stash  # if needed
```


### **2. Audit Current Dependencies**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Check current React Native version
npx react-native --version

# List all dependencies
npm list --depth=0

# Check for outdated packages
npm outdated

# Audit for security vulnerabilities
npm audit
```


### **3. Review Release Notes**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Check React Native releases
# Visit: https://github.com/facebook/react-native/releases

# Check for breaking changes
# Visit: https://react-native-community.github.io/upgrade-helper/
```


### **4. Test Current App**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Run tests
npm test

# Test on both platforms
npx react-native run-ios
npx react-native run-android

# Check for deprecation warnings
npx react-native start --verbose
```


---

## 🚀 **Upgrade Process**

### **Method 1: React Native Upgrade Helper (Recommended)**

#### **Step 1: Use Upgrade Helper**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Visit: https://react-native-community.github.io/upgrade-helper/
# Select your current version and target version
# Follow the generated diff
```


#### **Step 2: Apply Changes**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Copy package.json changes
# Update dependencies in package.json

# Install new dependencies
npm install

# For iOS, update Podfile
cd ios && pod install && cd ..
```


#### **Step 3: Update Native Code**

```bash
# iOS: Update Xcode project files
# Android: Update build.gradle files
# Follow the specific changes shown in upgrade helper
```


### **Method 2: Manual Upgrade**

#### **Step 1: Update React Native**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```bash
# Update React Native
npm install react-native@latest

# Update React
npm install react@latest
```


#### **Step 2: Update Platform Dependencies**

```bash
# iOS
cd ios
pod install
cd ..

# Android - update build.gradle
# Check android/build.gradle for:
# - buildToolsVersion
# - compileSdkVersion
# - targetSdkVersion
```


#### **Step 3: Update Metro Configuration**

```javascript
// metro.config.js
const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');

const config = {
  // Your custom configuration
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
```


---

## 📋 **Common Upgrade Scenarios**

### **Scenario 1: Minor Version Upgrade (0.70 → 0.71)**


```bash
# Usually straightforward
npm install react-native@0.71.0
npm install react@18.2.0

# Update iOS pods
cd ios && pod install && cd ..

# Test the app
npx react-native run-ios
npx react-native run-android
```


### **Scenario 2: Major Version Upgrade (0.68 → 0.70)**


```bash
# Use React Native Upgrade Helper
# Visit: https://react-native-community.github.io/upgrade-helper/

# Common changes needed:
# 1. Update package.json dependencies
# 2. Update iOS deployment target
# 3. Update Android compileSdkVersion
# 4. Update Metro configuration
# 5. Handle breaking changes
```


### **Scenario 3: New Architecture Migration (0.68 → 0.70+)**


```bash
# Enable New Architecture
# In android/gradle.properties:
newArchEnabled=true

# In ios/Podfile:
use_frameworks! :linkage => :static
$RCTNewArchEnabled = true

# Update dependencies
npm install react-native@latest
cd ios && pod install && cd ..
```


### **Scenario 4: Expo Managed to Bare Workflow**


```bash
# Eject from Expo
npx expo eject

# Or use Expo prebuild
npx expo prebuild

# Update to latest React Native
npm install react-native@latest
```


---

## 🛠️ **Troubleshooting**

### **Common Issues and Solutions**

#### **1. Metro Bundler Issues**

```bash
# Clear Metro cache
npx react-native start --reset-cache

# Clear npm cache
npm start -- --reset-cache

# Clear watchman
watchman watch-del-all
```


#### **2. iOS Build Issues**

```bash
# Clean iOS build
cd ios
xcodebuild clean
rm -rf build/
pod deintegrate
pod install
cd ..

# Update Xcode and iOS deployment target
# Check ios/YourApp.xcodeproj for deployment target
```


#### **3. Android Build Issues**

```bash
# Clean Android build
cd android
./gradlew clean
cd ..

# Update Android SDK and build tools
# Check android/build.gradle for versions
```


#### **4. Dependency Conflicts**

```bash
# Check for peer dependency warnings
npm install --legacy-peer-deps

# Use yarn for better dependency resolution
yarn install

# Check for conflicting versions
npm ls react-native
npm ls react
```


#### **5. Native Module Issues**

```bash
# Rebuild native modules
npx react-native unlink
npx react-native link

# For iOS, reinstall pods
cd ios && pod install && cd ..

# Check for deprecated native modules
npm audit
```


---

## ✅ **Best Practices**

### **1. Gradual Upgrades**

```bash
# Don't skip major versions
# Upgrade incrementally:
# 0.68 → 0.69 → 0.70 → 0.71

# Test each version before proceeding
```


### **2. Automated Testing**

```javascript
// Add upgrade tests
describe('App after upgrade', () => {
  it('should render without crashing', () => {
    const tree = renderer.create(<App />);
    expect(tree).toBeTruthy();
  });

  it('should handle navigation', () => {
    // Test critical navigation flows
  });
});
```


### **3. Staged Rollout**

```bash
# Use feature flags for gradual rollout
# Test on staging environment first
# Monitor crash reports and performance
```


### **4. Documentation**

```markdown
# Keep upgrade notes
# Document breaking changes
# Maintain compatibility matrix
```


### **5. Dependency Management**

```json
// package.json
{
  "dependencies": {
    "react-native": "0.71.0",
    "react": "18.2.0"
  },
  "devDependencies": {
    "@react-native-community/cli": "^9.0.0"
  }
}
```


---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **How do you upgrade React Native versions?**
   - Use React Native Upgrade Helper
   - Follow official migration guides
   - Test thoroughly after upgrade

2. **What are the steps for a major version upgrade?**
   - Backup current code
   - Review release notes
   - Use upgrade helper
   - Update dependencies
   - Test on both platforms

3. **How do you handle breaking changes?**
   - Read migration guides
   - Update deprecated APIs
   - Test affected functionality
   - Update documentation

### **Intermediate Questions**
4. **What's the difference between minor and major upgrades?**
   - Minor: Usually backward compatible
   - Major: May have breaking changes
   - Patch: Bug fixes only

5. **How do you migrate to the New Architecture?**
   - Enable in gradle.properties and Podfile
   - Update dependencies
   - Test thoroughly
   - Handle breaking changes

6. **What tools help with React Native upgrades?**
   - React Native Upgrade Helper
   - React Native CLI
   - Flipper for debugging
   - Metro bundler

### **Advanced Questions**
7. **How do you handle custom native modules during upgrades?**
   - Check compatibility
   - Update native code
   - Test thoroughly
   - Consider alternatives

8. **What's your strategy for upgrading large React Native apps?**
   - Gradual upgrades
   - Feature flags
   - Automated testing
   - Staged rollout

9. **How do you prevent upgrade issues?**
   - Regular updates
   - Automated testing
   - Dependency monitoring
   - Code reviews

---

## 🔗 **Related Topics**

- [Breaking Changes](./02-Breaking-Changes.md)
- [Architecture Migration](./03-Architecture-Migration.md)
- [Migration Testing](./04-Migration-Testing.md)
- [Advanced Debugging](../19-Advanced-Debugging/01-Debugging-Tools.md)
- [Build Process](../10-Build-Release-CICD/01-Metro-Bundling.md)

---

## 📚 **Resources**

- [React Native Upgrade Helper](https://react-native-community.github.io/upgrade-helper/)
- [React Native Releases](https://github.com/facebook/react-native/releases)
- [Migration Guides](https://react-native-community.github.io/upgrade-helper/)
- [New Architecture Guide](https://reactnative.dev/docs/the-new-architecture/landing-page)

---

## 🧭 Navigation

<div class="navigation">
    <a href="../19-Advanced-Debugging/04-Native-Debugging.md" class="nav-link prev">⬅️ Previous: Native Debugging</a>
    <a href="./02-Breaking-Changes.md" class="nav-link next">Next: Breaking Changes ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
