# Responsive Design Patterns in React Native

## Overview

Responsive design in React Native ensures your app looks and functions well across different screen sizes, orientations, and device types. This guide covers comprehensive patterns for creating adaptive layouts that work seamlessly on phones, tablets, and various screen densities.

## Screen Size Detection

### 1. Basic Screen Size Detection


```javascript
import { Dimensions, PixelRatio, Platform } from 'react-native';

const { width, height } = Dimensions.get('window');
const { width: screenWidth, height: screenHeight } = Dimensions.get('screen');

const getScreenInfo = () => {
  const pixelRatio = PixelRatio.get();
  const fontScale = PixelRatio.getFontScale();
  
  return {
    window: { width, height },
    screen: { width: screenWidth, height: screenHeight },
    pixelRatio,
    fontScale,
    isTablet: width >= 768,
    isPhone: width < 768,
    isLandscape: width > height,
    isPortrait: height > width,
    deviceType: width >= 768 ? 'tablet' : 'phone',
  };
};

const useScreenInfo = () => {
  const [screenInfo, setScreenInfo] = useState(getScreenInfo());

  useEffect(() => {
    const subscription = Dimensions.addEventListener('change', ({ window, screen }) => {
      setScreenInfo({
        window,
        screen,
        pixelRatio: PixelRatio.get(),
        fontScale: PixelRatio.getFontScale(),
        isTablet: window.width >= 768,
        isPhone: window.width < 768,
        isLandscape: window.width > window.height,
        isPortrait: window.height > window.width,
        deviceType: window.width >= 768 ? 'tablet' : 'phone',
      });
    });

    return () => subscription?.remove();
  }, []);

  return screenInfo;
};
```


### 2. Advanced Screen Classification


```javascript
import { Dimensions, PixelRatio } from 'react-native';

const getDeviceClassification = () => {
  const { width, height } = Dimensions.get('window');
  const pixelRatio = PixelRatio.get();
  const diagonal = Math.sqrt(width * width + height * height) / PixelRatio.get();
  
  // Device size classification
  let deviceSize = 'phone';
  if (diagonal >= 7) {
    deviceSize = 'tablet';
  } else if (diagonal >= 6) {
    deviceSize = 'phablet';
  }
  
  // Screen density classification
  let density = 'mdpi';
  if (pixelRatio >= 3) {
    density = 'xxxhdpi';
  } else if (pixelRatio >= 2.5) {
    density = 'xxhdpi';
  } else if (pixelRatio >= 2) {
    density = 'xhdpi';
  } else if (pixelRatio >= 1.5) {
    density = 'hdpi';
  }
  
  return {
    deviceSize,
    density,
    diagonal,
    pixelRatio,
    isHighDensity: pixelRatio >= 2,
    isLowDensity: pixelRatio < 1.5,
  };
};

const useDeviceClassification = () => {
  const [classification, setClassification] = useState(getDeviceClassification());

  useEffect(() => {
    const subscription = Dimensions.addEventListener('change', () => {
      setClassification(getDeviceClassification());
    });

    return () => subscription?.remove();
  }, []);

  return classification;
};
```


## Responsive Layout Patterns

### 1. Flexible Grid System


```javascript
import { View, StyleSheet, Dimensions } from 'react-native';

const { width } = Dimensions.get('window');

const ResponsiveGrid = ({ children, columns = 2, spacing = 16 }) => {
  const itemWidth = (width - (spacing * (columns + 1))) / columns;
  
  const renderGridItem = (item, index) => (
    <View
      key={index}
      style={[
        styles.gridItem,
        {
          width: itemWidth,
          marginRight: (index + 1) % columns === 0 ? 0 : spacing,
          marginBottom: spacing,
        }
      ]}
    >
      {item}
    </View>
  );

  return (
    <View style={styles.gridContainer}>
      {children.map(renderGridItem)}
    </View>
  );
};

const styles = StyleSheet.create({
  gridContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 16,
  },
  gridItem: {
    // Base styles for grid items
  },
});

// Usage example
const ProductGrid = ({ products }) => {
  const { isTablet } = useScreenInfo();
  const columns = isTablet ? 3 : 2;
  
  return (
    <ResponsiveGrid columns={columns} spacing={12}>
      {products.map(product => (
        <ProductCard key={product.id} product={product} />
      ))}
    </ResponsiveGrid>
  );
};
```


### 2. Adaptive Container Sizes


```javascript
import { StyleSheet, Dimensions } from 'react-native';

const { width } = Dimensions.get('window');

const createResponsiveStyles = () => {
  const isTablet = width >= 768;
  const isLandscape = width > Dimensions.get('window').height;
  
  return StyleSheet.create({
    container: {
      flex: 1,
      padding: isTablet ? 24 : 16,
      maxWidth: isTablet ? 1200 : '100%',
      alignSelf: 'center',
    },
    content: {
      flex: 1,
      paddingHorizontal: isTablet ? 32 : 16,
      paddingVertical: isTablet ? 24 : 16,
    },
    card: {
      borderRadius: isTablet ? 12 : 8,
      padding: isTablet ? 24 : 16,
      marginBottom: isTablet ? 20 : 12,
      shadowRadius: isTablet ? 8 : 4,
      elevation: isTablet ? 8 : 4,
    },
    text: {
      fontSize: isTablet ? 18 : 16,
      lineHeight: isTablet ? 28 : 24,
    },
    button: {
      paddingHorizontal: isTablet ? 32 : 24,
      paddingVertical: isTablet ? 16 : 12,
      borderRadius: isTablet ? 8 : 6,
    },
  });
};

const ResponsiveContainer = ({ children }) => {
  const styles = createResponsiveStyles();
  
  return (
    <View style={styles.container}>
      {children}
    </View>
  );
};
```


### 3. Breakpoint-Based Layouts


```javascript
import { useState, useEffect } from 'react';
import { Dimensions } from 'react-native';

const breakpoints = {
  xs: 0,
  sm: 576,
  md: 768,
  lg: 992,
  xl: 1200,
};

const useBreakpoint = () => {
  const [breakpoint, setBreakpoint] = useState('xs');
  const [screenWidth, setScreenWidth] = useState(Dimensions.get('window').width);

  useEffect(() => {
    const subscription = Dimensions.addEventListener('change', ({ window }) => {
      setScreenWidth(window.width);
    });

    return () => subscription?.remove();
  }, []);

  useEffect(() => {
    const currentBreakpoint = Object.keys(breakpoints)
      .reverse()
      .find(bp => screenWidth >= breakpoints[bp]) || 'xs';
    
    setBreakpoint(currentBreakpoint);
  }, [screenWidth]);

  return {
    breakpoint,
    isXs: breakpoint === 'xs',
    isSm: breakpoint === 'sm',
    isMd: breakpoint === 'md',
    isLg: breakpoint === 'lg',
    isXl: breakpoint === 'xl',
    isMobile: breakpoint === 'xs' || breakpoint === 'sm',
    isTablet: breakpoint === 'md',
    isDesktop: breakpoint === 'lg' || breakpoint === 'xl',
  };
};

const ResponsiveLayout = ({ children }) => {
  const { isMobile, isTablet, isDesktop } = useBreakpoint();
  
  const getLayoutStyle = () => {
    if (isMobile) {
      return styles.mobileLayout;
    } else if (isTablet) {
      return styles.tabletLayout;
    } else {
      return styles.desktopLayout;
    }
  };

  return (
    <View style={[styles.baseLayout, getLayoutStyle()]}>
      {children}
    </View>
  );
};
```


## Typography and Spacing

### 1. Responsive Typography


```javascript
import { StyleSheet, Dimensions, PixelRatio } from 'react-native';

const { width, height } = Dimensions.get('window');
const pixelRatio = PixelRatio.get();

const createResponsiveTypography = () => {
  const baseFontSize = 16;
  const scaleFactor = Math.min(width / 375, height / 667); // iPhone 6/7/8 as base
  const scaledFontSize = baseFontSize * scaleFactor;
  
  return StyleSheet.create({
    h1: {
      fontSize: scaledFontSize * 2.25, // 36px on base
      fontWeight: 'bold',
      lineHeight: scaledFontSize * 2.5,
    },
    h2: {
      fontSize: scaledFontSize * 1.875, // 30px on base
      fontWeight: 'bold',
      lineHeight: scaledFontSize * 2.25,
    },
    h3: {
      fontSize: scaledFontSize * 1.5, // 24px on base
      fontWeight: '600',
      lineHeight: scaledFontSize * 1.75,
    },
    body: {
      fontSize: scaledFontSize, // 16px on base
      lineHeight: scaledFontSize * 1.5,
    },
    caption: {
      fontSize: scaledFontSize * 0.875, // 14px on base
      lineHeight: scaledFontSize * 1.25,
    },
    small: {
      fontSize: scaledFontSize * 0.75, // 12px on base
      lineHeight: scaledFontSize * 1,
    },
  });
};

const ResponsiveText = ({ style, children, ...props }) => {
  const typography = createResponsiveTypography();
  
  return (
    <Text style={[typography.body, style]} {...props}>
      {children}
    </Text>
  );
};
```


### 2. Responsive Spacing System


```javascript
import { StyleSheet, Dimensions } from 'react-native';

const { width } = Dimensions.get('window');

const createSpacingSystem = () => {
  const baseSpacing = 8;
  const scaleFactor = width / 375; // iPhone 6/7/8 as base
  const scaledSpacing = baseSpacing * scaleFactor;
  
  return {
    xs: scaledSpacing * 0.5,    // 4px
    sm: scaledSpacing,          // 8px
    md: scaledSpacing * 1.5,    // 12px
    lg: scaledSpacing * 2,      // 16px
    xl: scaledSpacing * 3,      // 24px
    xxl: scaledSpacing * 4,     // 32px
    xxxl: scaledSpacing * 6,    // 48px
  };
};

const useSpacing = () => {
  const [spacing, setSpacing] = useState(createSpacingSystem());

  useEffect(() => {
    const subscription = Dimensions.addEventListener('change', () => {
      setSpacing(createSpacingSystem());
    });

    return () => subscription?.remove();
  }, []);

  return spacing;
};

const ResponsiveSpacing = ({ children, padding, margin }) => {
  const spacing = useSpacing();
  
  const getSpacingValue = (value) => {
    if (typeof value === 'number') return value;
    return spacing[value] || 0;
  };

  const style = {
    padding: getSpacingValue(padding),
    margin: getSpacingValue(margin),
  };

  return (
    <View style={style}>
      {children}
    </View>
  );
};
```


## Image and Media Responsiveness

### 1. Responsive Images


```javascript
import { Image, Dimensions, StyleSheet } from 'react-native';

const { width } = Dimensions.get('window');

const ResponsiveImage = ({ source, aspectRatio = 16/9, maxWidth, ...props }) => {
  const [imageDimensions, setImageDimensions] = useState({ width: 0, height: 0 });
  
  const calculateDimensions = () => {
    const containerWidth = maxWidth || width;
    const imageWidth = containerWidth;
    const imageHeight = imageWidth / aspectRatio;
    
    return { width: imageWidth, height: imageHeight };
  };

  useEffect(() => {
    setImageDimensions(calculateDimensions());
  }, [width, maxWidth, aspectRatio]);

  const handleImageLoad = (event) => {
    const { width: imgWidth, height: imgHeight } = event.nativeEvent.source;
    const calculatedDimensions = calculateDimensions();
    
    // Maintain aspect ratio
    const aspectRatio = imgWidth / imgHeight;
    const finalWidth = calculatedDimensions.width;
    const finalHeight = finalWidth / aspectRatio;
    
    setImageDimensions({ width: finalWidth, height: finalHeight });
  };

  return (
    <Image
      source={source}
      style={[
        styles.responsiveImage,
        imageDimensions,
        props.style
      ]}
      onLoad={handleImageLoad}
      resizeMode="cover"
      {...props}
    />
  );
};

const styles = StyleSheet.create({
  responsiveImage: {
    borderRadius: 8,
  },
});
```


### 2. Responsive Video Player


```javascript
import { View, Dimensions, StyleSheet } from 'react-native';
import Video from 'react-native-video';

const { width } = Dimensions.get('window');

const ResponsiveVideoPlayer = ({ source, aspectRatio = 16/9, ...props }) => {
  const [videoDimensions, setVideoDimensions] = useState({ width: 0, height: 0 });
  
  const calculateVideoDimensions = () => {
    const videoWidth = width;
    const videoHeight = videoWidth / aspectRatio;
    
    return { width: videoWidth, height: videoHeight };
  };

  useEffect(() => {
    setVideoDimensions(calculateVideoDimensions());
  }, [width, aspectRatio]);

  return (
    <View style={[styles.videoContainer, videoDimensions]}>
      <Video
        source={source}
        style={[styles.video, videoDimensions]}
        resizeMode="contain"
        {...props}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  videoContainer: {
    backgroundColor: '#000',
    borderRadius: 8,
    overflow: 'hidden',
  },
  video: {
    // Video styles
  },
});
```


## Navigation Responsiveness

### 1. Responsive Navigation


```javascript
import { useBreakpoint } from './useBreakpoint';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

const Drawer = createDrawerNavigator();
const Tab = createBottomTabNavigator();

const ResponsiveNavigator = () => {
  const { isMobile, isTablet } = useBreakpoint();
  
  if (isMobile) {
    return (
      <Tab.Navigator
        screenOptions={{#123;{{#123;
          tabBarStyle: {
            height: 60,
            paddingBottom: 8,
          },
        }}#125;}}#125;
      >
        <Tab.Screen name="Home" component={HomeScreen} />
        <Tab.Screen name="Profile" component={ProfileScreen} />
      </Tab.Navigator>
    );
  }
  
  if (isTablet) {
    return (
      <Drawer.Navigator
        screenOptions={{#123;{{#123;
          drawerStyle: {
            width: 280,
          },
        }}#125;}}#125;
      >
        <Drawer.Screen name="Home" component={HomeScreen} />
        <Drawer.Screen name="Profile" component={ProfileScreen} />
      </Drawer.Navigator>
    );
  }
  
  // Desktop layout
  return (
    <View style={styles.desktopLayout}>
      <View style={styles.sidebar}>
        <Sidebar />
      </View>
      <View style={styles.mainContent}>
        <MainContent />
      </View>
    </View>
  );
};
```


### 2. Responsive Modal


```javascript
import { Modal, Dimensions, StyleSheet } from 'react-native';

const { width, height } = Dimensions.get('window');

const ResponsiveModal = ({ visible, onClose, children }) => {
  const { isTablet } = useBreakpoint();
  
  const getModalStyle = () => {
    if (isTablet) {
      return {
        width: Math.min(width * 0.8, 600),
        height: Math.min(height * 0.8, 500),
        borderRadius: 12,
      };
    }
    
    return {
      width: width * 0.9,
      height: height * 0.8,
      borderRadius: 8,
    };
  };

  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={onClose}
    >
      <View style={styles.modalOverlay}>
        <View style={[styles.modalContent, getModalStyle()]}>
          {children}
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContent: {
    backgroundColor: '#FFFFFF',
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
  },
});
```


## Performance Optimization

### 1. Responsive Performance Hooks


```javascript
import { useMemo, useCallback } from 'react';
import { useBreakpoint } from './useBreakpoint';

const useResponsivePerformance = () => {
  const { isMobile, isTablet } = useBreakpoint();
  
  // Adjust rendering performance based on device
  const getRenderBatchSize = useCallback(() => {
    if (isMobile) return 10;
    if (isTablet) return 15;
    return 20;
  }, [isMobile, isTablet]);
  
  const getWindowSize = useCallback(() => {
    if (isMobile) return 10;
    if (isTablet) return 15;
    return 20;
  }, [isMobile, isTablet]);
  
  const getUpdateCellsBatchingPeriod = useCallback(() => {
    if (isMobile) return 50;
    if (isTablet) return 100;
    return 150;
  }, [isMobile, isTablet]);
  
  return {
    renderBatchSize: getRenderBatchSize(),
    windowSize: getWindowSize(),
    updateCellsBatchingPeriod: getUpdateCellsBatchingPeriod(),
  };
};

const ResponsiveFlatList = ({ data, renderItem, ...props }) => {
  const { renderBatchSize, windowSize, updateCellsBatchingPeriod } = useResponsivePerformance();
  
  return (
    <FlatList
      data={data}
      renderItem={renderItem}
      maxToRenderPerBatch={renderBatchSize}
      windowSize={windowSize}
      updateCellsBatchingPeriod={updateCellsBatchingPeriod}
      removeClippedSubviews={true}
      {...props}
    />
  );
};
```


### 2. Responsive Image Caching


```javascript
import { useMemo } from 'react';
import { useBreakpoint } from './useBreakpoint';

const useResponsiveImageCache = () => {
  const { isMobile, isTablet } = useBreakpoint();
  
  const getImageQuality = useMemo(() => {
    if (isMobile) return 0.8;
    if (isTablet) return 0.9;
    return 1.0;
  }, [isMobile, isTablet]);
  
  const getImageSize = useMemo(() => {
    if (isMobile) return { width: 300, height: 200 };
    if (isTablet) return { width: 600, height: 400 };
    return { width: 800, height: 600 };
  }, [isMobile, isTablet]);
  
  const getCacheSize = useMemo(() => {
    if (isMobile) return 50; // MB
    if (isTablet) return 100; // MB
    return 200; // MB
  }, [isMobile, isTablet]);
  
  return {
    imageQuality: getImageQuality,
    imageSize: getImageSize,
    cacheSize: getCacheSize,
  };
};
```


## Testing Responsive Design

### 1. Responsive Testing Utilities


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

// Usage example
describe('ResponsiveComponent', () => {
  testResponsiveLayout(
    <ResponsiveComponent />,
    [
      {
        name: 'mobile portrait',
        width: 375,
        height: 667,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('mobile-layout')).toBeTruthy();
        },
      },
      {
        name: 'tablet landscape',
        width: 1024,
        height: 768,
        expectedBehavior: (getByTestId) => {
          expect(getByTestId('tablet-layout')).toBeTruthy();
        },
      },
    ]
  );
});
```


## Summary

Responsive design patterns in React Native include:

1. **Screen Size Detection**: Using Dimensions API and custom hooks
2. **Responsive Layouts**: Flexible grids, adaptive containers, breakpoint-based layouts
3. **Typography and Spacing**: Scalable text and spacing systems
4. **Image and Media**: Responsive images and video players
5. **Navigation**: Adaptive navigation patterns
6. **Performance**: Responsive performance optimization
7. **Testing**: Responsive testing utilities

## Key Takeaways

- Use Dimensions API to detect screen size and orientation changes
- Implement breakpoint-based layouts for different device types
- Create scalable typography and spacing systems
- Optimize images and media for different screen sizes
- Use responsive navigation patterns for better UX
- Implement performance optimizations based on device capabilities
- Test responsive design across different screen sizes
- Consider accessibility and usability in responsive designs
- Use custom hooks for reusable responsive logic
- Implement proper cleanup for dimension change listeners

