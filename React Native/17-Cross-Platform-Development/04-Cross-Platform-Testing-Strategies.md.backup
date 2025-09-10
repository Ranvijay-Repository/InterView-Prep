# Cross-Platform Testing Strategies in React Native

## Overview

Cross-platform testing in React Native requires comprehensive strategies to ensure your app works consistently across iOS, Android, and web platforms. This guide covers testing approaches, tools, and best practices for maintaining quality across all platforms.

## Testing Architecture

### 1. Testing Pyramid Structure


{% raw %}
```mermaid
graph TD
    A[E2E Tests] --> B[Integration Tests]
    B --> C[Unit Tests]
    C --> D[Component Tests]
    D --> E[Utility Tests]
    
    A1[Platform-Specific E2E] --> A
    B1[API Integration] --> B
    C1[Business Logic] --> C
    D1[UI Components] --> D
    E1[Helper Functions] --> E
```
{% endraw %}


### 2. Cross-Platform Test Structure


{% raw %}
```javascript
// __tests__/setup.js
import { configure } from '@testing-library/react-native';
import { Platform } from 'react-native';

// Configure testing library
configure({
  asyncUtilTimeout: 5000,
  getElementError: (message, container) => {
    const error = new Error(message);
    error.name = 'TestingLibraryElementError';
    error.stack = null;
    return error;
  },
});

// Mock Platform.OS for testing
global.Platform = {
  OS: 'ios', // Default to iOS
  Version: '14.0',
  select: jest.fn((config) => config.ios || config.default),
};

// Mock device dimensions
jest.mock('react-native/Libraries/Utilities/Dimensions', () => ({
  get: jest.fn(() => ({
    width: 375,
    height: 667,
    scale: 2,
    fontScale: 1,
  })),
  addEventListener: jest.fn(),
  removeEventListener: jest.fn(),
}));
```
{% endraw %}


## Platform-Specific Testing

### 1. Platform-Specific Test Utilities


{% raw %}
```javascript
// test-utils/platformTestUtils.js
import { Platform } from 'react-native';

export const mockPlatform = (os, version = '1.0.0') => {
  const originalOS = Platform.OS;
  const originalVersion = Platform.Version;
  const originalSelect = Platform.select;
  
  Platform.OS = os;
  Platform.Version = version;
  Platform.select = jest.fn((config) => config[os] || config.default);
  
  return () => {
    Platform.OS = originalOS;
    Platform.Version = originalVersion;
    Platform.select = originalSelect;
  };
};

export const testOnBothPlatforms = (testFn) => {
  describe('iOS', () => {
    beforeEach(() => {
      mockPlatform('ios', '14.0');
    });
    
    testFn();
  });
  
  describe('Android', () => {
    beforeEach(() => {
      mockPlatform('android', '30');
    });
    
    testFn();
  });
};

export const testOnAllPlatforms = (testFn) => {
  describe('iOS', () => {
    beforeEach(() => {
      mockPlatform('ios', '14.0');
    });
    
    testFn();
  });
  
  describe('Android', () => {
    beforeEach(() => {
      mockPlatform('android', '30');
    });
    
    testFn();
  });
  
  describe('Web', () => {
    beforeEach(() => {
      mockPlatform('web', '1.0.0');
    });
    
    testFn();
  });
};
```
{% endraw %}


### 2. Platform-Specific Component Testing


{% raw %}
```javascript
// __tests__/components/PlatformButton.test.js
import React from 'react';
import { render, fireEvent } from '@testing-library/react-native';
import { testOnBothPlatforms } from '../../test-utils/platformTestUtils';
import PlatformButton from '../PlatformButton';

describe('PlatformButton', () => {
  const defaultProps = {
    title: 'Test Button',
    onPress: jest.fn(),
  };

  testOnBothPlatforms(() => {
    it('should render button with correct title', () => {
      const { getByText } = render(<PlatformButton {...defaultProps} />);
      expect(getByText('Test Button')).toBeTruthy();
    });

    it('should call onPress when pressed', () => {
      const { getByText } = render(<PlatformButton {...defaultProps} />);
      fireEvent.press(getByText('Test Button'));
      expect(defaultProps.onPress).toHaveBeenCalledTimes(1);
    });
  });

  describe('iOS specific behavior', () => {
    beforeEach(() => {
      mockPlatform('ios', '14.0');
    });

    it('should render TouchableOpacity on iOS', () => {
      const { getByTestId } = render(<PlatformButton {...defaultProps} />);
      expect(getByTestId('ios-button')).toBeTruthy();
    });

    it('should have iOS specific styling', () => {
      const { getByTestId } = render(<PlatformButton {...defaultProps} />);
      const button = getByTestId('ios-button');
      expect(button.props.style).toMatchObject({
        borderRadius: 8,
        shadowColor: '#000',
      });
    });
  });

  describe('Android specific behavior', () => {
    beforeEach(() => {
      mockPlatform('android', '30');
    });

    it('should render TouchableNativeFeedback on Android', () => {
      const { getByTestId } = render(<PlatformButton {...defaultProps} />);
      expect(getByTestId('android-button')).toBeTruthy();
    });

    it('should have Android specific styling', () => {
      const { getByTestId } = render(<PlatformButton {...defaultProps} />);
      const button = getByTestId('android-button');
      expect(button.props.style).toMatchObject({
        borderRadius: 4,
        elevation: 5,
      });
    });
  });
});
```
{% endraw %}


## Responsive Design Testing

### 1. Screen Size Testing


{% raw %}
```javascript
// test-utils/responsiveTestUtils.js
import { Dimensions } from 'react-native';

export const mockDimensions = (width, height) => {
  const originalDimensions = Dimensions.get('window');
  
  Dimensions.get = jest.fn(() => ({
    width,
    height,
    scale: 1,
    fontScale: 1,
  }));
  
  return () => {
    Dimensions.get = jest.fn(() => originalDimensions);
  };
};

export const testResponsiveLayout = (component, testCases) => {
  testCases.forEach(({ name, width, height, expectedBehavior }) => {
    it(`should handle ${name} layout (${width}x${height})`, () => {
      const restoreDimensions = mockDimensions(width, height);
      
      try {
        const { getByTestId } = render(component);
        expectedBehavior(getByTestId);
      } finally {
        restoreDimensions();
      }
    });
  });
};

export const testBreakpoints = (component, breakpoints) => {
  Object.entries(breakpoints).forEach(([breakpoint, { width, height, expectedBehavior }]) => {
    it(`should handle ${breakpoint} breakpoint`, () => {
      const restoreDimensions = mockDimensions(width, height);
      
      try {
        const { getByTestId } = render(component);
        expectedBehavior(getByTestId);
      } finally {
        restoreDimensions();
      }
    });
  });
};
```
{% endraw %}


### 2. Responsive Component Testing


{% raw %}
```javascript
// __tests__/components/ResponsiveGrid.test.js
import React from 'react';
import { render } from '@testing-library/react-native';
import { testResponsiveLayout, testBreakpoints } from '../../test-utils/responsiveTestUtils';
import ResponsiveGrid from '../ResponsiveGrid';

describe('ResponsiveGrid', () => {
  const mockData = Array.from({ length: 10 }, (_, i) => ({
    id: i,
    title: `Item ${i}`,
  }));

  const defaultProps = {
    data: mockData,
    renderItem: ({ item }) => <Text testID={`item-${item.id}`}>{item.title}</Text>,
  };

  testResponsiveLayout(
    <ResponsiveGrid {...defaultProps} />,
    [
      {
        name: 'mobile portrait',
        width: 375,
        height: 667,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('mobile-grid')).toBeTruthy();
          expect(getByTestId('item-0')).toBeTruthy();
        },
      },
      {
        name: 'tablet landscape',
        width: 1024,
        height: 768,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('tablet-grid')).toBeTruthy();
          expect(getByTestId('item-0')).toBeTruthy();
        },
      },
    ]
  );

  testBreakpoints(
    <ResponsiveGrid {...defaultProps} />,
    {
      mobile: {
        width: 375,
        height: 667,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('mobile-grid')).toBeTruthy();
        },
      },
      tablet: {
        width: 768,
        height: 1024,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('tablet-grid')).toBeTruthy();
        },
      },
      desktop: {
        width: 1200,
        height: 800,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('desktop-grid')).toBeTruthy();
        },
      },
    }
  );
});
```
{% endraw %}


## Device Capability Testing

### 1. Device Capability Mocking


{% raw %}
```javascript
// test-utils/deviceCapabilityUtils.js
import DeviceInfo from 'react-native-device-info';

export const mockDeviceCapabilities = (capabilities) => {
  const originalMethods = {};
  
  Object.keys(capabilities).forEach(key => {
    if (DeviceInfo[key]) {
      originalMethods[key] = DeviceInfo[key];
      DeviceInfo[key] = jest.fn().mockResolvedValue(capabilities[key]);
    }
  });
  
  return () => {
    Object.keys(originalMethods).forEach(key => {
      DeviceInfo[key] = originalMethods[key];
    });
  };
};

export const testWithDeviceCapabilities = (capabilities, testFn) => {
  describe(`with ${JSON.stringify(capabilities)}`, () => {
    beforeEach(() => {
      mockDeviceCapabilities(capabilities);
    });
    
    testFn();
  });
};

export const testOnDifferentDevices = (testCases) => {
  testCases.forEach(({ deviceName, capabilities, testFn }) => {
    describe(deviceName, () => {
      beforeEach(() => {
        mockDeviceCapabilities(capabilities);
      });
      
      testFn();
    });
  });
};
```
{% endraw %}


### 2. Capability-Based Testing


{% raw %}
```javascript
// __tests__/components/AdaptiveComponent.test.js
import React from 'react';
import { render } from '@testing-library/react-native';
import { testWithDeviceCapabilities } from '../../test-utils/deviceCapabilityUtils';
import AdaptiveComponent from '../AdaptiveComponent';

describe('AdaptiveComponent', () => {
  const defaultProps = {
    children: <Text>Default Content</Text>,
  };

  testWithDeviceCapabilities(
    {
      isTablet: true,
      hasCamera: true,
      hasBiometrics: true,
    },
    () => {
      it('should render tablet-specific features', () => {
        const { getByTestId } = render(<AdaptiveComponent {...defaultProps} />);
        expect(getByTestId('tablet-features')).toBeTruthy();
        expect(getByTestId('camera-feature')).toBeTruthy();
        expect(getByTestId('biometric-feature')).toBeTruthy();
      });
    }
  );

  testWithDeviceCapabilities(
    {
      isTablet: false,
      hasCamera: false,
      hasBiometrics: false,
    },
    () => {
      it('should render phone-specific features', () => {
        const { getByTestId } = render(<AdaptiveComponent {...defaultProps} />);
        expect(getByTestId('phone-features')).toBeTruthy();
        expect(getByTestId('camera-feature')).toBeFalsy();
        expect(getByTestId('biometric-feature')).toBeFalsy();
      });
    }
  );
});
```
{% endraw %}


## Integration Testing

### 1. Cross-Platform Integration Tests


{% raw %}
```javascript
// __tests__/integration/CrossPlatformIntegration.test.js
import React from 'react';
import { render, fireEvent, waitFor } from '@testing-library/react-native';
import { testOnBothPlatforms } from '../../test-utils/platformTestUtils';
import App from '../../App';

describe('Cross-Platform Integration Tests', () => {
  testOnBothPlatforms(() => {
    it('should handle navigation between screens', async () => {
      const { getByText, getByTestId } = render(<App />);
      
      // Navigate to second screen
      fireEvent.press(getByText('Go to Second Screen'));
      
      await waitFor(() => {
        expect(getByTestId('second-screen')).toBeTruthy();
      });
      
      // Navigate back
      fireEvent.press(getByText('Go Back'));
      
      await waitFor(() => {
        expect(getByTestId('first-screen')).toBeTruthy();
      });
    });

    it('should handle data persistence', async () => {
      const { getByText, getByTestId } = render(<App />);
      
      // Save data
      fireEvent.press(getByText('Save Data'));
      
      await waitFor(() => {
        expect(getByText('Data saved successfully')).toBeTruthy();
      });
      
      // Reload app and check data persistence
      const { getByTestId: getByTestIdAfterReload } = render(<App />);
      
      await waitFor(() => {
        expect(getByTestIdAfterReload('saved-data')).toBeTruthy();
      });
    });
  });
});
```
{% endraw %}


### 2. API Integration Testing


{% raw %}
```javascript
// __tests__/integration/APIIntegration.test.js
import { testOnBothPlatforms } from '../../test-utils/platformTestUtils';
import { apiService } from '../../services/apiService';

describe('API Integration Tests', () => {
  testOnBothPlatforms(() => {
    it('should handle successful API calls', async () => {
      const mockData = { id: 1, name: 'Test Item' };
      
      // Mock successful API response
      global.fetch = jest.fn().mockResolvedValue({
        ok: true,
        json: () => Promise.resolve(mockData),
      });
      
      const result = await apiService.getItem(1);
      
      expect(result).toEqual(mockData);
      expect(global.fetch).toHaveBeenCalledWith('/api/items/1');
    });

    it('should handle API errors gracefully', async () => {
      // Mock API error
      global.fetch = jest.fn().mockRejectedValue(new Error('Network error'));
      
      await expect(apiService.getItem(1)).rejects.toThrow('Network error');
    });

    it('should handle network timeouts', async () => {
      // Mock timeout
      global.fetch = jest.fn().mockImplementation(() => 
        new Promise((_, reject) => 
          setTimeout(() => reject(new Error('Timeout')), 100)
        )
      );
      
      await expect(apiService.getItem(1)).rejects.toThrow('Timeout');
    });
  });
});
```
{% endraw %}


## E2E Testing

### 1. Cross-Platform E2E Setup


{% raw %}
```javascript
// e2e/setup.js
import { device, expect, element, by } from 'detox';

describe('Cross-Platform E2E Tests', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
  });

  it('should display welcome screen', async () => {
    await expect(element(by.id('welcome-screen'))).toBeVisible();
  });

  it('should navigate through app screens', async () => {
    // Navigate to second screen
    await element(by.id('navigate-button')).tap();
    await expect(element(by.id('second-screen'))).toBeVisible();
    
    // Navigate back
    await element(by.id('back-button')).tap();
    await expect(element(by.id('welcome-screen'))).toBeVisible();
  });

  it('should handle user input', async () => {
    await element(by.id('input-field')).typeText('Test input');
    await element(by.id('submit-button')).tap();
    await expect(element(by.id('success-message'))).toBeVisible();
  });
});
```
{% endraw %}


### 2. Platform-Specific E2E Tests


{% raw %}
```javascript
// e2e/ios-specific.test.js
import { device, expect, element, by } from 'detox';

describe('iOS Specific E2E Tests', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  it('should handle iOS specific gestures', async () => {
    // Test iOS specific swipe gestures
    await element(by.id('swipeable-item')).swipe('left', 'fast');
    await expect(element(by.id('swipe-action'))).toBeVisible();
  });

  it('should handle iOS specific UI elements', async () => {
    // Test iOS specific UI elements
    await expect(element(by.id('ios-specific-button'))).toBeVisible();
    await element(by.id('ios-specific-button')).tap();
    await expect(element(by.id('ios-specific-modal'))).toBeVisible();
  });
});
```
{% endraw %}



{% raw %}
```javascript
// e2e/android-specific.test.js
import { device, expect, element, by } from 'detox';

describe('Android Specific E2E Tests', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  it('should handle Android specific gestures', async () => {
    // Test Android specific long press
    await element(by.id('long-press-item')).longPress();
    await expect(element(by.id('context-menu'))).toBeVisible();
  });

  it('should handle Android specific UI elements', async () => {
    // Test Android specific UI elements
    await expect(element(by.id('android-specific-button'))).toBeVisible();
    await element(by.id('android-specific-button')).tap();
    await expect(element(by.id('android-specific-snackbar'))).toBeVisible();
  });
});
```
{% endraw %}


## Performance Testing

### 1. Cross-Platform Performance Tests


{% raw %}
```javascript
// __tests__/performance/CrossPlatformPerformance.test.js
import { testOnBothPlatforms } from '../../test-utils/platformTestUtils';
import { render, fireEvent } from '@testing-library/react-native';
import PerformanceComponent from '../PerformanceComponent';

describe('Cross-Platform Performance Tests', () => {
  testOnBothPlatforms(() => {
    it('should render large lists efficiently', () => {
      const largeDataset = Array.from({ length: 1000 }, (_, i) => ({
        id: i,
        title: `Item ${i}`,
      }));

      const startTime = performance.now();
      const { getByTestId } = render(
        <PerformanceComponent data={largeDataset} />
      );
      const endTime = performance.now();

      expect(endTime - startTime).toBeLessThan(1000); // Should render in less than 1 second
      expect(getByTestId('performance-list')).toBeTruthy();
    });

    it('should handle rapid user interactions', () => {
      const { getByTestId } = render(<PerformanceComponent />);
      const button = getByTestId('rapid-interaction-button');

      const startTime = performance.now();
      
      // Simulate rapid button presses
      for (let i = 0; i < 100; i++) {
        fireEvent.press(button);
      }
      
      const endTime = performance.now();

      expect(endTime - startTime).toBeLessThan(500); // Should handle 100 presses in less than 500ms
    });
  });
});
```
{% endraw %}


### 2. Memory Performance Tests


{% raw %}
```javascript
// __tests__/performance/MemoryPerformance.test.js
import { testOnBothPlatforms } from '../../test-utils/platformTestUtils';
import { render, cleanup } from '@testing-library/react-native';

describe('Memory Performance Tests', () => {
  let initialMemory;

  beforeEach(() => {
    initialMemory = global.performance?.memory?.usedJSHeapSize || 0;
  });

  afterEach(() => {
    cleanup();
    if (global.gc) {
      global.gc();
    }
  });

  testOnBothPlatforms(() => {
    it('should not leak memory during component lifecycle', async () => {
      const { unmount } = render(<MemoryIntensiveComponent />);
      
      // Simulate user interactions
      fireEvent.press(screen.getByText('Button'));
      fireEvent.scroll(screen.getByTestId('list'), { 
        nativeEvent: { contentOffset: { y: 1000 } } 
      });
      
      unmount();
      
      // Wait for GC
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      const finalMemory = global.performance?.memory?.usedJSHeapSize || 0;
      const memoryIncrease = finalMemory - initialMemory;
      
      // Allow for 1MB increase (tolerance for test overhead)
      expect(memoryIncrease).toBeLessThan(1024 * 1024);
    });
  });
});
```
{% endraw %}


## Testing Best Practices

### 1. Test Organization


{% raw %}
```javascript
// __tests__/index.js - Test entry point
import './setup';
import './components';
import './integration';
import './performance';
import './e2e';
```
{% endraw %}


### 2. Test Utilities


{% raw %}
```javascript
// test-utils/index.js
export * from './platformTestUtils';
export * from './responsiveTestUtils';
export * from './deviceCapabilityUtils';
export * from './mockUtils';
export * from './testHelpers';
```
{% endraw %}


### 3. Mock Utilities


{% raw %}
```javascript
// test-utils/mockUtils.js
export const mockNavigation = () => ({
  navigate: jest.fn(),
  goBack: jest.fn(),
  reset: jest.fn(),
  setParams: jest.fn(),
  dispatch: jest.fn(),
  canGoBack: jest.fn(() => true),
  isFocused: jest.fn(() => true),
});

export const mockRoute = (params = {}) => ({
  key: 'test-route',
  name: 'TestScreen',
  params,
});

export const mockAsyncStorage = () => ({
  getItem: jest.fn(),
  setItem: jest.fn(),
  removeItem: jest.fn(),
  clear: jest.fn(),
  getAllKeys: jest.fn(),
  multiGet: jest.fn(),
  multiSet: jest.fn(),
  multiRemove: jest.fn(),
});
```
{% endraw %}


## Summary

Cross-platform testing strategies in React Native include:

1. **Testing Architecture**: Testing pyramid, cross-platform test structure
2. **Platform-Specific Testing**: Platform utilities, component testing
3. **Responsive Design Testing**: Screen size testing, breakpoint testing
4. **Device Capability Testing**: Capability mocking, adaptive testing
5. **Integration Testing**: Cross-platform integration, API testing
6. **E2E Testing**: Cross-platform E2E, platform-specific E2E
7. **Performance Testing**: Cross-platform performance, memory testing
8. **Testing Best Practices**: Test organization, utilities, mocking

## Key Takeaways

- Implement comprehensive testing pyramid for all platforms
- Use platform-specific test utilities for consistent testing
- Test responsive design across different screen sizes
- Mock device capabilities for predictable testing
- Implement integration tests for cross-platform functionality
- Use E2E testing for user journey validation
- Monitor performance across platforms
- Organize tests with clear structure and utilities
- Mock external dependencies for reliable testing
- Test both positive and negative scenarios
- Implement proper cleanup in tests
- Use appropriate testing tools for each test type

