# 🎯 **E2E Testing**

> **Master end-to-end testing with Detox, Appium, and automated testing strategies for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Detox Setup](#detox-setup)
- [E2E Test Scenarios](#e2e-test-scenarios)
- [Test Automation](#test-automation)
- [CI/CD Integration](#cicd-integration)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

End-to-end (E2E) testing validates the complete user journey through your React Native application. It ensures that all components work together correctly in a real device environment.

### **E2E Testing Overview**

```
┌─────────────────────────────────────┐
│        E2E Testing System           │
│  ┌─────────────────────────────────┐│
│  │        Testing Tools            ││
│  │  - Detox                        ││
│  │  - Appium                       ││
│  │  - Maestro                      ││
│  │  - WebDriverIO                  ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Test Types               ││
│  │  - User journey tests           ││
│  │  - Critical path tests          ││
│  │  - Regression tests             ││
│  │  - Performance tests            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Test Environments        ││
│  │  - Simulators/Emulators         ││
│  │  - Real devices                 ││
│  │  - Device farms                 ││
│  │  - Cloud testing                ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🎯 **Detox Setup**

### **Detox Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// .detoxrc.js
module.exports = {
  testRunner: 'jest',
  runnerConfig: 'e2e/config.json',
  configurations: {
    'ios.sim.debug': {
      binaryPath: 'ios/build/Build/Products/Debug-iphonesimulator/YourApp.app',
      build: 'xcodebuild -workspace ios/YourApp.xcworkspace -scheme YourApp -configuration Debug -sdk iphonesimulator -derivedDataPath ios/build',
      type: 'ios.simulator',
      device: {
        type: 'iPhone 14',
      },
    },
    'ios.sim.release': {
      binaryPath: 'ios/build/Build/Products/Release-iphonesimulator/YourApp.app',
      build: 'xcodebuild -workspace ios/YourApp.xcworkspace -scheme YourApp -configuration Release -sdk iphonesimulator -derivedDataPath ios/build',
      type: 'ios.simulator',
      device: {
        type: 'iPhone 14',
      },
    },
    'android.emu.debug': {
      binaryPath: 'android/app/build/outputs/apk/debug/app-debug.apk',
      build: 'cd android && ./gradlew assembleDebug assembleAndroidTest -DtestBuildType=debug',
      type: 'android.emulator',
      device: {
        avdName: 'Pixel_4_API_30',
      },
    },
    'android.emu.release': {
      binaryPath: 'android/app/build/outputs/apk/release/app-release.apk',
      build: 'cd android && ./gradlew assembleRelease assembleAndroidTest -DtestBuildType=release',
      type: 'android.emulator',
      device: {
        avdName: 'Pixel_4_API_30',
      },
    },
  },
  testMatch: ['**/e2e/**/*.test.js'],
  testTimeout: 120000,
  retries: 1,
  artifacts: {
    rootDir: './e2e/artifacts',
    pathBuilder: './e2e/artifacts/path-builder.js',
    plugins: {
      screenshot: 'failing',
      video: 'failing',
      instruments: 'failing',
      log: 'failing',
    },
  },
};
```

### **E2E Test Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// e2e/config.json
{
  "testEnvironment": "node",
  "testRunner": "jest-circus/runner",
  "testTimeout": 120000,
  "testRegex": "\\.e2e\\.js$",
  "reporters": ["default"],
  "setupFilesAfterEnv": ["<rootDir>/e2e/init.js"],
  "globalSetup": "detox/runners/jest/globalSetup",
  "globalTeardown": "detox/runners/jest/globalTeardown",
  "testEnvironment": "detox/runners/jest/testEnvironment"
}
```

### **E2E Test Initialization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// e2e/init.js
const { device, expect, element, by, waitFor } = require('detox');

beforeAll(async () => {
  await device.launchApp();
});

beforeEach(async () => {
  await device.reloadReactNative();
});

afterAll(async () => {
  await device.terminateApp();
});

// Global test utilities
global.testUtils = {
  // Wait for element to be visible
  waitForElement: async (testID, timeout = 10000) => {
    await waitFor(element(by.id(testID)))
      .toBeVisible()
      .withTimeout(timeout);
  },
  
  // Tap element by testID
  tapElement: async (testID) => {
    await element(by.id(testID)).tap();
  },
  
  // Type text into input
  typeText: async (testID, text) => {
    await element(by.id(testID)).typeText(text);
  },
  
  // Clear text input
  clearText: async (testID) => {
    await element(by.id(testID)).clearText();
  },
  
  // Scroll to element
  scrollToElement: async (testID, direction = 'down') => {
    await element(by.id(testID)).scroll(100, direction);
  },
  
  // Take screenshot
  takeScreenshot: async (name) => {
    await device.takeScreenshot(name);
  },
  
  // Wait for network requests
  waitForNetworkIdle: async (timeout = 5000) => {
    await new Promise(resolve => setTimeout(resolve, timeout));
  },
};
```

---

## 🎯 **E2E Test Scenarios**

### **User Authentication Flow**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// e2e/auth.e2e.js
const { device, expect, element, by, waitFor } = require('detox');

describe('Authentication Flow', () => {
  beforeEach(async () => {
    await device.reloadReactNative();
  });
  
  it('should display login screen on app launch', async () => {
    await expect(element(by.id('login-screen'))).toBeVisible();
    await expect(element(by.id('email-input'))).toBeVisible();
    await expect(element(by.id('password-input'))).toBeVisible();
    await expect(element(by.id('login-button'))).toBeVisible();
  });
  
  it('should show validation errors for empty fields', async () => {
    await element(by.id('login-button')).tap();
    
    await expect(element(by.id('email-error'))).toBeVisible();
    await expect(element(by.id('password-error'))).toBeVisible();
  });
  
  it('should show validation error for invalid email', async () => {
    await element(by.id('email-input')).typeText('invalid-email');
    await element(by.id('password-input')).typeText('password123');
    await element(by.id('login-button')).tap();
    
    await expect(element(by.id('email-error'))).toBeVisible();
  });
  
  it('should login successfully with valid credentials', async () => {
    await element(by.id('email-input')).typeText('test@example.com');
    await element(by.id('password-input')).typeText('password123');
    await element(by.id('login-button')).tap();
    
    // Wait for login to complete
    await waitFor(element(by.id('home-screen')))
      .toBeVisible()
      .withTimeout(10000);
    
    await expect(element(by.id('welcome-message'))).toBeVisible();
  });
  
  it('should show error for invalid credentials', async () => {
    await element(by.id('email-input')).typeText('wrong@example.com');
    await element(by.id('password-input')).typeText('wrongpassword');
    await element(by.id('login-button')).tap();
    
    await waitFor(element(by.id('error-message')))
      .toBeVisible()
      .withTimeout(5000);
    
    await expect(element(by.id('error-message'))).toHaveText('Invalid credentials');
  });
  
  it('should navigate to forgot password screen', async () => {
    await element(by.id('forgot-password-link')).tap();
    
    await expect(element(by.id('forgot-password-screen'))).toBeVisible();
    await expect(element(by.id('email-input'))).toBeVisible();
    await expect(element(by.id('reset-button'))).toBeVisible();
  });
  
  it('should navigate to signup screen', async () => {
    await element(by.id('signup-link')).tap();
    
    await expect(element(by.id('signup-screen'))).toBeVisible();
    await expect(element(by.id('name-input'))).toBeVisible();
    await expect(element(by.id('email-input'))).toBeVisible();
    await expect(element(by.id('password-input'))).toBeVisible();
    await expect(element(by.id('confirm-password-input'))).toBeVisible();
    await expect(element(by.id('signup-button'))).toBeVisible();
  });
});
```

### **User Profile Management**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// e2e/profile.e2e.js
const { device, expect, element, by, waitFor } = require('detox');

describe('User Profile Management', () => {
  beforeEach(async () => {
    await device.reloadReactNative();
    // Login first
    await element(by.id('email-input')).typeText('test@example.com');
    await element(by.id('password-input')).typeText('password123');
    await element(by.id('login-button')).tap();
    
    await waitFor(element(by.id('home-screen')))
      .toBeVisible()
      .withTimeout(10000);
  });
  
  it('should navigate to profile screen', async () => {
    await element(by.id('profile-tab')).tap();
    
    await expect(element(by.id('profile-screen'))).toBeVisible();
    await expect(element(by.id('user-avatar'))).toBeVisible();
    await expect(element(by.id('user-name'))).toBeVisible();
    await expect(element(by.id('user-email'))).toBeVisible();
  });
  
  it('should edit profile information', async () => {
    await element(by.id('profile-tab')).tap();
    await element(by.id('edit-profile-button')).tap();
    
    await expect(element(by.id('edit-profile-screen'))).toBeVisible();
    
    // Update name
    await element(by.id('name-input')).clearText();
    await element(by.id('name-input')).typeText('Updated Name');
    
    // Update bio
    await element(by.id('bio-input')).clearText();
    await element(by.id('bio-input')).typeText('Updated bio text');
    
    // Save changes
    await element(by.id('save-button')).tap();
    
    // Verify changes
    await waitFor(element(by.id('profile-screen')))
      .toBeVisible()
      .withTimeout(5000);
    
    await expect(element(by.id('user-name'))).toHaveText('Updated Name');
  });
  
  it('should change profile picture', async () => {
    await element(by.id('profile-tab')).tap();
    await element(by.id('edit-profile-button')).tap();
    
    await element(by.id('change-avatar-button')).tap();
    
    // Select from gallery
    await element(by.id('gallery-option')).tap();
    
    // Wait for image picker
    await waitFor(element(by.id('image-picker')))
      .toBeVisible()
      .withTimeout(5000);
    
    // Select first image
    await element(by.id('image-item-0')).tap();
    
    // Confirm selection
    await element(by.id('confirm-button')).tap();
    
    // Verify avatar updated
    await waitFor(element(by.id('profile-screen')))
      .toBeVisible()
      .withTimeout(5000);
  });
  
  it('should logout successfully', async () => {
    await element(by.id('profile-tab')).tap();
    await element(by.id('settings-button')).tap();
    
    await expect(element(by.id('settings-screen'))).toBeVisible();
    
    await element(by.id('logout-button')).tap();
    
    // Confirm logout
    await element(by.id('confirm-logout-button')).tap();
    
    // Verify return to login screen
    await waitFor(element(by.id('login-screen')))
      .toBeVisible()
      .withTimeout(5000);
  });
});
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Integration-Testing.md" class="nav-link prev">⬅️ Previous: Integration Testing</a>
    <a href="./04-Quality-Assurance.md" class="nav-link next">Next: Quality Assurance ➡️</a>
</div>

---


*Last updated: December 2024*
