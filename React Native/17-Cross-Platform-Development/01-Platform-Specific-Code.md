# Platform-Specific Code in React Native

## Overview

React Native provides powerful tools for writing platform-specific code while maintaining a shared codebase. This guide covers various techniques for handling platform differences, from simple conditional rendering to complex platform-specific implementations.

## Platform Detection

### 1. Basic Platform Detection

```javascript
import { Platform, StyleSheet, View, Text } from 'react-native';

const PlatformSpecificComponent = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>
        Running on {Platform.OS}
      </Text>
      <Text style={styles.text}>
        Version: {Platform.Version}
      </Text>
      {Platform.OS === 'ios' && (
        <Text style={styles.iosText}>iOS specific content</Text>
      )}
      {Platform.OS === 'android' && (
        <Text style={styles.androidText}>Android specific content</Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  text: {
    fontSize: 16,
    marginBottom: 10,
  },
  iosText: {
    color: '#007AFF',
    fontWeight: 'bold',
  },
  androidText: {
    color: '#4CAF50',
    fontWeight: 'bold',
  },
});
```

### 2. Advanced Platform Detection

```javascript
import { Platform, Dimensions } from 'react-native';

const getPlatformInfo = () => {
  const { width, height } = Dimensions.get('window');
  
  return {
    os: Platform.OS,
    version: Platform.Version,
    isIOS: Platform.OS === 'ios',
    isAndroid: Platform.OS === 'android',
    isWeb: Platform.OS === 'web',
    isTablet: width >= 768,
    isPhone: width < 768,
    screenSize: { width, height },
    // iOS specific
    isIOS13Plus: Platform.OS === 'ios' && Platform.Version >= 13,
    isIOS14Plus: Platform.OS === 'ios' && Platform.Version >= 14,
    // Android specific
    isAndroid10Plus: Platform.OS === 'android' && Platform.Version >= 29,
    isAndroid11Plus: Platform.OS === 'android' && Platform.Version >= 30,
  };
};

const usePlatformInfo = () => {
  const [platformInfo, setPlatformInfo] = useState(getPlatformInfo());

  useEffect(() => {
    const subscription = Dimensions.addEventListener('change', ({ window }) => {
      setPlatformInfo(prev => ({
        ...prev,
        isTablet: window.width >= 768,
        isPhone: window.width < 768,
        screenSize: { width: window.width, height: window.height },
      }));
    });

    return () => subscription?.remove();
  }, []);

  return platformInfo;
};
```

## Platform-Specific Styling

### 1. Platform-Specific Styles

```javascript
import { Platform, StyleSheet } from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    // Platform-specific styles
    paddingTop: Platform.OS === 'ios' ? 44 : 24, // Status bar height
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  button: {
    padding: 12,
    borderRadius: Platform.OS === 'ios' ? 8 : 4,
    backgroundColor: Platform.OS === 'ios' ? '#007AFF' : '#2196F3',
    // iOS specific
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.25,
        shadowRadius: 3.84,
      },
      // Android specific
      android: {
        elevation: 5,
      },
    }),
  },
  text: {
    fontSize: 16,
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
    color: Platform.OS === 'ios' ? '#000000' : '#212121',
  },
});
```

### 2. Dynamic Style Generation

```javascript
import { Platform, StyleSheet, Dimensions } from 'react-native';

const createPlatformStyles = (baseStyles) => {
  const { width, height } = Dimensions.get('window');
  const isTablet = width >= 768;
  
  return StyleSheet.create({
    ...baseStyles,
    // Responsive styles
    container: {
      ...baseStyles.container,
      padding: isTablet ? 24 : 16,
    },
    // Platform-specific overrides
    ...Platform.select({
      ios: {
        header: {
          ...baseStyles.header,
          backgroundColor: '#F2F2F7',
          borderBottomWidth: 0.5,
          borderBottomColor: '#C6C6C8',
        },
        button: {
          ...baseStyles.button,
          borderRadius: 8,
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.25,
          shadowRadius: 3.84,
        },
      },
      android: {
        header: {
          ...baseStyles.header,
          backgroundColor: '#FFFFFF',
          elevation: 4,
        },
        button: {
          ...baseStyles.button,
          borderRadius: 4,
          elevation: 5,
        },
      },
    }),
  });
};

const baseStyles = {
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  header: {
    height: 56,
    justifyContent: 'center',
    alignItems: 'center',
  },
  button: {
    padding: 12,
    backgroundColor: '#007AFF',
  },
};

const styles = createPlatformStyles(baseStyles);
```

## Platform-Specific Components

### 1. Conditional Component Rendering

```javascript
import { Platform, View, Text, TouchableOpacity, TouchableNativeFeedback } from 'react-native';

const PlatformButton = ({ title, onPress, style, textStyle }) => {
  if (Platform.OS === 'ios') {
    return (
      <TouchableOpacity onPress={onPress} style={style}>
        <Text style={textStyle}>{title}</Text>
      </TouchableOpacity>
    );
  }

  return (
    <TouchableNativeFeedback onPress={onPress}>
      <View style={style}>
        <Text style={textStyle}>{title}</Text>
      </View>
    </TouchableNativeFeedback>
  );
};

const PlatformAlert = ({ title, message, buttons }) => {
  if (Platform.OS === 'ios') {
    return (
      <View style={styles.iosAlert}>
        <Text style={styles.alertTitle}>{title}</Text>
        <Text style={styles.alertMessage}>{message}</Text>
        <View style={styles.alertButtons}>
          {buttons.map((button, index) => (
            <TouchableOpacity
              key={index}
              onPress={button.onPress}
              style={styles.alertButton}
            >
              <Text style={styles.alertButtonText}>{button.text}</Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>
    );
  }

  // Android implementation
  return (
    <View style={styles.androidAlert}>
      <Text style={styles.alertTitle}>{title}</Text>
      <Text style={styles.alertMessage}>{message}</Text>
      <View style={styles.alertButtons}>
        {buttons.map((button, index) => (
          <TouchableNativeFeedback key={index} onPress={button.onPress}>
            <View style={styles.alertButton}>
              <Text style={styles.alertButtonText}>{button.text}</Text>
            </View>
          </TouchableNativeFeedback>
        ))}
      </View>
    </View>
  );
};
```

### 2. Platform-Specific Hooks

```javascript
import { Platform, useCallback } from 'react';
import { Alert, Linking } from 'react-native';

const usePlatformActions = () => {
  const showAlert = useCallback((title, message, buttons) => {
    if (Platform.OS === 'ios') {
      Alert.alert(title, message, buttons);
    } else {
      // Android-specific alert implementation
      Alert.alert(title, message, buttons, { cancelable: true });
    }
  }, []);

  const openURL = useCallback(async (url) => {
    try {
      const supported = await Linking.canOpenURL(url);
      if (supported) {
        await Linking.openURL(url);
      } else {
        showAlert('Error', 'Cannot open this URL');
      }
    } catch (error) {
      showAlert('Error', 'Failed to open URL');
    }
  }, [showAlert]);

  const shareContent = useCallback((content) => {
    if (Platform.OS === 'ios') {
      // iOS sharing implementation
      import('react-native-share').then(({ default: Share }) => {
        Share.open({
          title: content.title,
          message: content.message,
          url: content.url,
        });
      });
    } else {
      // Android sharing implementation
      import('react-native-share').then(({ default: Share }) => {
        Share.open({
          title: content.title,
          message: content.message,
          url: content.url,
        });
      });
    }
  }, []);

  return {
    showAlert,
    openURL,
    shareContent,
  };
};
```

## Platform-Specific File Structure

### 1. File Extension Approach

```javascript
// Button.ios.js
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

const Button = ({ title, onPress, style }) => {
  return (
    <TouchableOpacity onPress={onPress} style={[styles.button, style]}>
      <Text style={styles.text}>{title}</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: {
    padding: 12,
    borderRadius: 8,
    backgroundColor: '#007AFF',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  text: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
  },
});

export default Button;
```

```javascript
// Button.android.js
import { TouchableNativeFeedback, Text, View, StyleSheet } from 'react-native';

const Button = ({ title, onPress, style }) => {
  return (
    <TouchableNativeFeedback onPress={onPress}>
      <View style={[styles.button, style]}>
        <Text style={styles.text}>{title}</Text>
      </View>
    </TouchableNativeFeedback>
  );
};

const styles = StyleSheet.create({
  button: {
    padding: 12,
    borderRadius: 4,
    backgroundColor: '#2196F3',
    elevation: 5,
  },
  text: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
});

export default Button;
```

### 2. Platform-Specific Directories

```javascript
// components/Button/index.js
import { Platform } from 'react-native';

const Button = Platform.OS === 'ios' 
  ? require('./Button.ios').default
  : require('./Button.android').default;

export default Button;
```

```javascript
// components/Button/Button.ios.js
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

const Button = ({ title, onPress, style }) => {
  return (
    <TouchableOpacity onPress={onPress} style={[styles.button, style]}>
      <Text style={styles.text}>{title}</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: {
    padding: 12,
    borderRadius: 8,
    backgroundColor: '#007AFF',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  text: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
  },
});

export default Button;
```

```javascript
// components/Button/Button.android.js
import { TouchableNativeFeedback, Text, View, StyleSheet } from 'react-native';

const Button = ({ title, onPress, style }) => {
  return (
    <TouchableNativeFeedback onPress={onPress}>
      <View style={[styles.button, style]}>
        <Text style={styles.text}>{title}</Text>
      </View>
    </TouchableNativeFeedback>
  );
};

const styles = StyleSheet.create({
  button: {
    padding: 12,
    borderRadius: 4,
    backgroundColor: '#2196F3',
    elevation: 5,
  },
  text: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
});

export default Button;
```

## Platform-Specific APIs

### 1. Native Module Integration

```javascript
import { Platform, NativeModules } from 'react-native';

const { PlatformSpecificModule } = NativeModules;

const usePlatformAPI = () => {
  const callPlatformAPI = useCallback(async (action, data) => {
    try {
      if (Platform.OS === 'ios') {
        return await PlatformSpecificModule.iosAction(action, data);
      } else if (Platform.OS === 'android') {
        return await PlatformSpecificModule.androidAction(action, data);
      }
    } catch (error) {
      console.error('Platform API error:', error);
      throw error;
    }
  }, []);

  const getPlatformInfo = useCallback(() => {
    return PlatformSpecificModule.getPlatformInfo();
  }, []);

  return {
    callPlatformAPI,
    getPlatformInfo,
  };
};
```

### 2. Platform-Specific Permissions

```javascript
import { Platform, PermissionsAndroid, Alert } from 'react-native';

const usePlatformPermissions = () => {
  const requestCameraPermission = useCallback(async () => {
    if (Platform.OS === 'ios') {
      // iOS permissions are handled in Info.plist
      return true;
    } else if (Platform.OS === 'android') {
      try {
        const granted = await PermissionsAndroid.request(
          PermissionsAndroid.PERMISSIONS.CAMERA,
          {
            title: 'Camera Permission',
            message: 'This app needs access to your camera to take photos.',
            buttonNeutral: 'Ask Me Later',
            buttonNegative: 'Cancel',
            buttonPositive: 'OK',
          }
        );
        return granted === PermissionsAndroid.RESULTS.GRANTED;
      } catch (error) {
        console.error('Permission error:', error);
        return false;
      }
    }
    return false;
  }, []);

  const requestLocationPermission = useCallback(async () => {
    if (Platform.OS === 'ios') {
      // iOS permissions are handled in Info.plist
      return true;
    } else if (Platform.OS === 'android') {
      try {
        const granted = await PermissionsAndroid.request(
          PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
          {
            title: 'Location Permission',
            message: 'This app needs access to your location to show nearby places.',
            buttonNeutral: 'Ask Me Later',
            buttonNegative: 'Cancel',
            buttonPositive: 'OK',
          }
        );
        return granted === PermissionsAndroid.RESULTS.GRANTED;
      } catch (error) {
        console.error('Permission error:', error);
        return false;
      }
    }
    return false;
  }, []);

  return {
    requestCameraPermission,
    requestLocationPermission,
  };
};
```

## Platform-Specific Navigation

### 1. Platform-Specific Navigation Styles

```javascript
import { Platform, StyleSheet } from 'react-native';

const createNavigationOptions = (title) => ({
  title,
  headerStyle: {
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
    borderBottomWidth: Platform.OS === 'ios' ? 0.5 : 0,
    borderBottomColor: Platform.OS === 'ios' ? '#C6C6C8' : 'transparent',
    elevation: Platform.OS === 'android' ? 4 : 0,
  },
  headerTitleStyle: {
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
    fontSize: Platform.OS === 'ios' ? 17 : 20,
  },
  headerTintColor: Platform.OS === 'ios' ? '#007AFF' : '#2196F3',
  headerBackTitle: Platform.OS === 'ios' ? 'Back' : undefined,
  headerBackTitleVisible: Platform.OS === 'ios' ? true : false,
});

const usePlatformNavigation = () => {
  const navigation = useNavigation();

  const navigateWithPlatformStyle = useCallback((screenName, params) => {
    navigation.navigate(screenName, {
      ...params,
      platform: Platform.OS,
    });
  }, [navigation]);

  return {
    navigateWithPlatformStyle,
    createNavigationOptions,
  };
};
```

### 2. Platform-Specific Tab Navigation

```javascript
import { Platform, StyleSheet } from 'react-native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

const Tab = createBottomTabNavigator();

const PlatformTabNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={{
        tabBarStyle: {
          backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
          borderTopWidth: Platform.OS === 'ios' ? 0.5 : 0,
          borderTopColor: Platform.OS === 'ios' ? '#C6C6C8' : 'transparent',
          elevation: Platform.OS === 'android' ? 8 : 0,
          height: Platform.OS === 'ios' ? 83 : 60,
          paddingBottom: Platform.OS === 'ios' ? 20 : 8,
        },
        tabBarLabelStyle: {
          fontSize: Platform.OS === 'ios' ? 10 : 12,
          fontWeight: Platform.OS === 'ios' ? '500' : 'bold',
        },
        tabBarActiveTintColor: Platform.OS === 'ios' ? '#007AFF' : '#2196F3',
        tabBarInactiveTintColor: Platform.OS === 'ios' ? '#8E8E93' : '#757575',
      }}
    >
      <Tab.Screen name="Home" component={HomeScreen} />
      <Tab.Screen name="Profile" component={ProfileScreen} />
    </Tab.Navigator>
  );
};
```

## Platform-Specific Testing

### 1. Platform-Specific Test Setup

```javascript
// __tests__/PlatformSpecific.test.js
import { Platform } from 'react-native';
import { render } from '@testing-library/react-native';
import PlatformSpecificComponent from '../PlatformSpecificComponent';

describe('Platform Specific Component', () => {
  beforeEach(() => {
    // Mock Platform.OS
    Platform.OS = 'ios';
  });

  it('renders iOS specific content on iOS', () => {
    Platform.OS = 'ios';
    const { getByText } = render(<PlatformSpecificComponent />);
    expect(getByText('iOS specific content')).toBeTruthy();
  });

  it('renders Android specific content on Android', () => {
    Platform.OS = 'android';
    const { getByText } = render(<PlatformSpecificComponent />);
    expect(getByText('Android specific content')).toBeTruthy();
  });
});
```

### 2. Platform-Specific Test Utilities

```javascript
// test-utils/platformUtils.js
import { Platform } from 'react-native';

export const mockPlatform = (os, version = '1.0.0') => {
  Platform.OS = os;
  Platform.Version = version;
};

export const withPlatform = (os, version, testFn) => {
  const originalOS = Platform.OS;
  const originalVersion = Platform.Version;
  
  mockPlatform(os, version);
  
  try {
    testFn();
  } finally {
    Platform.OS = originalOS;
    Platform.Version = originalVersion;
  }
};

export const testOnBothPlatforms = (testFn) => {
  describe('iOS', () => {
    withPlatform('ios', '14.0', testFn);
  });
  
  describe('Android', () => {
    withPlatform('android', '30', testFn);
  });
};
```

## Best Practices

### 1. Platform-Specific Code Organization

```javascript
// utils/platform.js
import { Platform, Dimensions } from 'react-native';

export const isIOS = Platform.OS === 'ios';
export const isAndroid = Platform.OS === 'android';
export const isWeb = Platform.OS === 'web';

export const isTablet = () => {
  const { width } = Dimensions.get('window');
  return width >= 768;
};

export const isPhone = () => {
  const { width } = Dimensions.get('window');
  return width < 768;
};

export const getPlatformVersion = () => Platform.Version;

export const isIOS13Plus = isIOS && Platform.Version >= 13;
export const isAndroid10Plus = isAndroid && Platform.Version >= 29;

export const platformSelect = (ios, android, web = null) => {
  if (isIOS) return ios;
  if (isAndroid) return android;
  if (isWeb && web) return web;
  return android; // fallback
};
```

### 2. Platform-Specific Constants

```javascript
// constants/platform.js
import { Platform } from 'react-native';

export const PLATFORM_CONSTANTS = {
  statusBarHeight: Platform.OS === 'ios' ? 44 : 24,
  headerHeight: Platform.OS === 'ios' ? 44 : 56,
  tabBarHeight: Platform.OS === 'ios' ? 83 : 60,
  borderRadius: Platform.OS === 'ios' ? 8 : 4,
  shadowColor: Platform.OS === 'ios' ? '#000' : 'transparent',
  elevation: Platform.OS === 'android' ? 5 : 0,
  colors: {
    primary: Platform.OS === 'ios' ? '#007AFF' : '#2196F3',
    background: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
    text: Platform.OS === 'ios' ? '#000000' : '#212121',
  },
};
```

## Summary

Platform-specific code in React Native involves:

1. **Platform Detection**: Using Platform.OS and Platform.Version
2. **Platform-Specific Styling**: Conditional styles and Platform.select()
3. **Platform-Specific Components**: Conditional rendering and file extensions
4. **Platform-Specific APIs**: Native module integration and permissions
5. **Platform-Specific Navigation**: Different navigation styles and behaviors
6. **Platform-Specific Testing**: Mocking platform values and testing utilities

## Key Takeaways

- Use Platform.OS and Platform.Version for platform detection
- Leverage Platform.select() for conditional styles and values
- Use file extensions (.ios.js, .android.js) for platform-specific components
- Implement platform-specific APIs and permissions
- Test platform-specific code with proper mocking
- Organize platform-specific code in dedicated utilities and constants
- Consider platform differences in navigation and user experience
- Use platform-specific testing utilities for comprehensive coverage
