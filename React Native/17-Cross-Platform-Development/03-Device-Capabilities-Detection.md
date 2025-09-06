# Device Capabilities Detection in React Native

## Overview

Device capabilities detection is crucial for creating adaptive React Native applications that can leverage different hardware features and provide appropriate fallbacks. This guide covers comprehensive techniques for detecting and handling various device capabilities.

## Hardware Detection

### 1. Basic Device Information

```javascript
import { Platform, Dimensions, PixelRatio } from 'react-native';
import DeviceInfo from 'react-native-device-info';

const useDeviceInfo = () => {
  const [deviceInfo, setDeviceInfo] = useState(null);

  useEffect(() => {
    const getDeviceInfo = async () => {
      try {
        const info = {
          // Basic device info
          brand: await DeviceInfo.getBrand(),
          model: await DeviceInfo.getModel(),
          systemName: await DeviceInfo.getSystemName(),
          systemVersion: await DeviceInfo.getSystemVersion(),
          deviceId: await DeviceInfo.getDeviceId(),
          deviceName: await DeviceInfo.getDeviceName(),
          
          // Screen info
          screenWidth: Dimensions.get('window').width,
          screenHeight: Dimensions.get('window').height,
          pixelRatio: PixelRatio.get(),
          fontScale: PixelRatio.getFontScale(),
          
          // Device type
          isTablet: await DeviceInfo.isTablet(),
          isEmulator: await DeviceInfo.isEmulator(),
          isPhysicalDevice: await DeviceInfo.isPhysicalDevice(),
          
          // Platform specific
          platform: Platform.OS,
          platformVersion: Platform.Version,
        };
        
        setDeviceInfo(info);
      } catch (error) {
        console.error('Error getting device info:', error);
      }
    };

    getDeviceInfo();
  }, []);

  return deviceInfo;
};
```

### 2. Advanced Device Classification

```javascript
import { Dimensions, PixelRatio } from 'react-native';
import DeviceInfo from 'react-native-device-info';

const classifyDevice = async () => {
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
  
  // Performance classification based on device model
  const model = await DeviceInfo.getModel();
  const systemVersion = await DeviceInfo.getSystemVersion();
  
  let performanceTier = 'low';
  if (model.includes('iPhone 12') || model.includes('iPhone 13') || model.includes('iPhone 14')) {
    performanceTier = 'high';
  } else if (model.includes('iPhone 11') || model.includes('iPhone X')) {
    performanceTier = 'medium';
  }
  
  // Android performance classification
  if (Platform.OS === 'android') {
    const brand = await DeviceInfo.getBrand();
    if (brand === 'Samsung' && model.includes('Galaxy S2')) {
      performanceTier = 'high';
    } else if (brand === 'Samsung' && model.includes('Galaxy S')) {
      performanceTier = 'medium';
    }
  }
  
  return {
    deviceSize,
    performanceTier,
    diagonal,
    pixelRatio,
    isHighPerformance: performanceTier === 'high',
    isLowPerformance: performanceTier === 'low',
  };
};

const useDeviceClassification = () => {
  const [classification, setClassification] = useState(null);

  useEffect(() => {
    classifyDevice().then(setClassification);
  }, []);

  return classification;
};
```

## Camera and Media Capabilities

### 1. Camera Detection

```javascript
import { Platform } from 'react-native';
import { Camera } from 'react-native-camera';

const useCameraCapabilities = () => {
  const [cameraInfo, setCameraInfo] = useState(null);

  useEffect(() => {
    const checkCameraCapabilities = async () => {
      try {
        // Check if camera is available
        const isAvailable = await Camera.checkDeviceAuthorizationStatus();
        
        if (isAvailable) {
          // Get available camera types
          const cameraTypes = await Camera.getAvailableCameraTypes();
          
          // Check for specific camera features
          const hasFlash = await Camera.hasFlash();
          const hasTorch = await Camera.hasTorch();
          
          setCameraInfo({
            isAvailable: true,
            cameraTypes,
            hasFlash,
            hasTorch,
            canTakePhotos: true,
            canRecordVideo: true,
          });
        } else {
          setCameraInfo({
            isAvailable: false,
            cameraTypes: [],
            hasFlash: false,
            hasTorch: false,
            canTakePhotos: false,
            canRecordVideo: false,
          });
        }
      } catch (error) {
        console.error('Error checking camera capabilities:', error);
        setCameraInfo({
          isAvailable: false,
          error: error.message,
        });
      }
    };

    checkCameraCapabilities();
  }, []);

  return cameraInfo;
};
```

### 2. Media Library Detection

```javascript
import { Platform } from 'react-native';
import { MediaLibrary } from 'expo-media-library';

const useMediaLibraryCapabilities = () => {
  const [mediaInfo, setMediaInfo] = useState(null);

  useEffect(() => {
    const checkMediaCapabilities = async () => {
      try {
        // Check media library permissions
        const { status } = await MediaLibrary.requestPermissionsAsync();
        
        if (status === 'granted') {
          // Get available media types
          const mediaTypes = await MediaLibrary.getMediaTypesAsync();
          
          // Check for specific capabilities
          const canCreateAlbum = await MediaLibrary.canCreateAlbumAsync();
          const canDeleteAssets = await MediaLibrary.canDeleteAssetsAsync();
          
          setMediaInfo({
            hasPermission: true,
            mediaTypes,
            canCreateAlbum,
            canDeleteAssets,
            canAccessPhotos: mediaTypes.includes('photo'),
            canAccessVideos: mediaTypes.includes('video'),
            canAccessAudio: mediaTypes.includes('audio'),
          });
        } else {
          setMediaInfo({
            hasPermission: false,
            mediaTypes: [],
            canCreateAlbum: false,
            canDeleteAssets: false,
            canAccessPhotos: false,
            canAccessVideos: false,
            canAccessAudio: false,
          });
        }
      } catch (error) {
        console.error('Error checking media capabilities:', error);
        setMediaInfo({
          hasPermission: false,
          error: error.message,
        });
      }
    };

    checkMediaCapabilities();
  }, []);

  return mediaInfo;
};
```

## Network and Connectivity

### 1. Network Capabilities

```javascript
import NetInfo from '@react-native-netinfo/netinfo';

const useNetworkCapabilities = () => {
  const [networkInfo, setNetworkInfo] = useState(null);

  useEffect(() => {
    const checkNetworkCapabilities = async () => {
      try {
        const state = await NetInfo.fetch();
        
        const capabilities = {
          isConnected: state.isConnected,
          type: state.type,
          isInternetReachable: state.isInternetReachable,
          isWifiEnabled: state.type === 'wifi',
          isCellularEnabled: state.type === 'cellular',
          isEthernetEnabled: state.type === 'ethernet',
          isBluetoothEnabled: state.type === 'bluetooth',
          isWimaxEnabled: state.type === 'wimax',
          isVpnEnabled: state.type === 'vpn',
          isWifiConnected: state.type === 'wifi' && state.isConnected,
          isCellularConnected: state.type === 'cellular' && state.isConnected,
        };
        
        setNetworkInfo(capabilities);
      } catch (error) {
        console.error('Error checking network capabilities:', error);
        setNetworkInfo({
          isConnected: false,
          error: error.message,
        });
      }
    };

    checkNetworkCapabilities();
    
    const unsubscribe = NetInfo.addEventListener(state => {
      setNetworkInfo(prev => ({
        ...prev,
        isConnected: state.isConnected,
        type: state.type,
        isInternetReachable: state.isInternetReachable,
      }));
    });

    return () => unsubscribe();
  }, []);

  return networkInfo;
};
```

### 2. Network Speed Detection

```javascript
import NetInfo from '@react-native-netinfo/netinfo';

const useNetworkSpeed = () => {
  const [networkSpeed, setNetworkSpeed] = useState(null);

  useEffect(() => {
    const measureNetworkSpeed = async () => {
      try {
        const startTime = Date.now();
        
        // Simple speed test by fetching a small resource
        const response = await fetch('https://httpbin.org/bytes/1024');
        const data = await response.blob();
        
        const endTime = Date.now();
        const duration = endTime - startTime;
        const bytesPerSecond = (data.size * 1000) / duration;
        const kbps = bytesPerSecond / 1024;
        const mbps = kbps / 1024;
        
        let speedCategory = 'slow';
        if (mbps > 10) {
          speedCategory = 'fast';
        } else if (mbps > 1) {
          speedCategory = 'medium';
        }
        
        setNetworkSpeed({
          kbps: Math.round(kbps),
          mbps: Math.round(mbps * 100) / 100,
          speedCategory,
          isFast: speedCategory === 'fast',
          isMedium: speedCategory === 'medium',
          isSlow: speedCategory === 'slow',
        });
      } catch (error) {
        console.error('Error measuring network speed:', error);
        setNetworkSpeed({
          kbps: 0,
          mbps: 0,
          speedCategory: 'unknown',
          error: error.message,
        });
      }
    };

    measureNetworkSpeed();
  }, []);

  return networkSpeed;
};
```

## Sensor Capabilities

### 1. Motion Sensors

```javascript
import { Accelerometer, Gyroscope, Magnetometer } from 'react-native-sensors';

const useMotionSensors = () => {
  const [sensorInfo, setSensorInfo] = useState(null);

  useEffect(() => {
    const checkMotionSensors = async () => {
      try {
        // Check accelerometer
        const accelerometerAvailable = await Accelerometer.isAvailable();
        
        // Check gyroscope
        const gyroscopeAvailable = await Gyroscope.isAvailable();
        
        // Check magnetometer
        const magnetometerAvailable = await Magnetometer.isAvailable();
        
        setSensorInfo({
          hasAccelerometer: accelerometerAvailable,
          hasGyroscope: gyroscopeAvailable,
          hasMagnetometer: magnetometerAvailable,
          hasMotionSensors: accelerometerAvailable || gyroscopeAvailable,
          hasCompass: magnetometerAvailable,
        });
      } catch (error) {
        console.error('Error checking motion sensors:', error);
        setSensorInfo({
          hasAccelerometer: false,
          hasGyroscope: false,
          hasMagnetometer: false,
          hasMotionSensors: false,
          hasCompass: false,
          error: error.message,
        });
      }
    };

    checkMotionSensors();
  }, []);

  return sensorInfo;
};
```

### 2. Biometric Sensors

```javascript
import TouchID from 'react-native-touch-id';
import { Platform } from 'react-native';

const useBiometricCapabilities = () => {
  const [biometricInfo, setBiometricInfo] = useState(null);

  useEffect(() => {
    const checkBiometricCapabilities = async () => {
      try {
        if (Platform.OS === 'ios') {
          // Check Touch ID availability
          const touchIdAvailable = await TouchID.isSupported();
          
          // Check Face ID availability
          const faceIdAvailable = await TouchID.isSupported({ type: 'FaceID' });
          
          setBiometricInfo({
            hasTouchID: touchIdAvailable,
            hasFaceID: faceIdAvailable,
            hasBiometrics: touchIdAvailable || faceIdAvailable,
            biometricType: faceIdAvailable ? 'FaceID' : touchIdAvailable ? 'TouchID' : 'none',
          });
        } else if (Platform.OS === 'android') {
          // Check fingerprint availability
          const fingerprintAvailable = await TouchID.isSupported();
          
          setBiometricInfo({
            hasFingerprint: fingerprintAvailable,
            hasBiometrics: fingerprintAvailable,
            biometricType: fingerprintAvailable ? 'Fingerprint' : 'none',
          });
        }
      } catch (error) {
        console.error('Error checking biometric capabilities:', error);
        setBiometricInfo({
          hasBiometrics: false,
          biometricType: 'none',
          error: error.message,
        });
      }
    };

    checkBiometricCapabilities();
  }, []);

  return biometricInfo;
};
```

## Storage Capabilities

### 1. Storage Detection

```javascript
import { Platform } from 'react-native';
import RNFS from 'react-native-fs';

const useStorageCapabilities = () => {
  const [storageInfo, setStorageInfo] = useState(null);

  useEffect(() => {
    const checkStorageCapabilities = async () => {
      try {
        // Get available storage paths
        const paths = {
          mainBundle: RNFS.MainBundlePath,
          cachesDirectory: RNFS.CachesDirectoryPath,
          documentDirectory: RNFS.DocumentDirectoryPath,
          externalDirectory: RNFS.ExternalDirectoryPath,
          externalCachesDirectory: RNFS.ExternalCachesDirectoryPath,
          externalStorageDirectory: RNFS.ExternalStorageDirectoryPath,
        };
        
        // Check available storage space
        const availableSpace = await RNFS.getFSInfo();
        
        // Check if external storage is available
        const externalStorageAvailable = await RNFS.exists(RNFS.ExternalStorageDirectoryPath);
        
        setStorageInfo({
          paths,
          availableSpace,
          externalStorageAvailable,
          canWriteToExternal: externalStorageAvailable,
          canWriteToInternal: true,
          totalSpace: availableSpace.totalSpace,
          freeSpace: availableSpace.freeSpace,
        });
      } catch (error) {
        console.error('Error checking storage capabilities:', error);
        setStorageInfo({
          error: error.message,
        });
      }
    };

    checkStorageCapabilities();
  }, []);

  return storageInfo;
};
```

### 2. Database Capabilities

```javascript
import SQLite from 'react-native-sqlite-storage';

const useDatabaseCapabilities = () => {
  const [dbInfo, setDbInfo] = useState(null);

  useEffect(() => {
    const checkDatabaseCapabilities = async () => {
      try {
        // Check if SQLite is available
        const isAvailable = await SQLite.isAvailable();
        
        if (isAvailable) {
          // Test database creation
          const db = await SQLite.openDatabase({
            name: 'test.db',
            location: 'default',
          });
          
          // Test basic operations
          await db.transaction(tx => {
            tx.executeSql(
              'CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, name TEXT)',
              [],
              () => console.log('Table created successfully'),
              (error) => console.log('Error creating table:', error)
            );
          });
          
          await db.close();
          
          setDbInfo({
            isAvailable: true,
            canCreateTables: true,
            canExecuteQueries: true,
            canHandleTransactions: true,
          });
        } else {
          setDbInfo({
            isAvailable: false,
            canCreateTables: false,
            canExecuteQueries: false,
            canHandleTransactions: false,
          });
        }
      } catch (error) {
        console.error('Error checking database capabilities:', error);
        setDbInfo({
          isAvailable: false,
          error: error.message,
        });
      }
    };

    checkDatabaseCapabilities();
  }, []);

  return dbInfo;
};
```

## Performance Capabilities

### 1. Performance Detection

```javascript
import { Platform } from 'react-native';
import DeviceInfo from 'react-native-device-info';

const usePerformanceCapabilities = () => {
  const [performanceInfo, setPerformanceInfo] = useState(null);

  useEffect(() => {
    const checkPerformanceCapabilities = async () => {
      try {
        // Get device model and system info
        const model = await DeviceInfo.getModel();
        const systemVersion = await DeviceInfo.getSystemVersion();
        const brand = await DeviceInfo.getBrand();
        
        // Determine performance tier based on device
        let performanceTier = 'low';
        let canHandleHeavyAnimations = false;
        let canHandleLargeImages = false;
        let canHandleVideoProcessing = false;
        
        if (Platform.OS === 'ios') {
          if (model.includes('iPhone 12') || model.includes('iPhone 13') || model.includes('iPhone 14')) {
            performanceTier = 'high';
            canHandleHeavyAnimations = true;
            canHandleLargeImages = true;
            canHandleVideoProcessing = true;
          } else if (model.includes('iPhone 11') || model.includes('iPhone X')) {
            performanceTier = 'medium';
            canHandleHeavyAnimations = true;
            canHandleLargeImages = true;
            canHandleVideoProcessing = false;
          }
        } else if (Platform.OS === 'android') {
          if (brand === 'Samsung' && model.includes('Galaxy S2')) {
            performanceTier = 'high';
            canHandleHeavyAnimations = true;
            canHandleLargeImages = true;
            canHandleVideoProcessing = true;
          } else if (brand === 'Samsung' && model.includes('Galaxy S')) {
            performanceTier = 'medium';
            canHandleHeavyAnimations = true;
            canHandleLargeImages = true;
            canHandleVideoProcessing = false;
          }
        }
        
        setPerformanceInfo({
          performanceTier,
          canHandleHeavyAnimations,
          canHandleLargeImages,
          canHandleVideoProcessing,
          isHighPerformance: performanceTier === 'high',
          isMediumPerformance: performanceTier === 'medium',
          isLowPerformance: performanceTier === 'low',
        });
      } catch (error) {
        console.error('Error checking performance capabilities:', error);
        setPerformanceInfo({
          performanceTier: 'unknown',
          error: error.message,
        });
      }
    };

    checkPerformanceCapabilities();
  }, []);

  return performanceInfo;
};
```

### 2. Memory Capabilities

```javascript
import { Platform } from 'react-native';
import DeviceInfo from 'react-native-device-info';

const useMemoryCapabilities = () => {
  const [memoryInfo, setMemoryInfo] = useState(null);

  useEffect(() => {
    const checkMemoryCapabilities = async () => {
      try {
        // Get total memory
        const totalMemory = await DeviceInfo.getTotalMemory();
        
        // Get used memory
        const usedMemory = await DeviceInfo.getUsedMemory();
        
        // Calculate available memory
        const availableMemory = totalMemory - usedMemory;
        
        // Determine memory tier
        let memoryTier = 'low';
        let canHandleLargeDatasets = false;
        let canHandleImageCaching = false;
        let canHandleVideoCaching = false;
        
        if (totalMemory >= 4000000000) { // 4GB
          memoryTier = 'high';
          canHandleLargeDatasets = true;
          canHandleImageCaching = true;
          canHandleVideoCaching = true;
        } else if (totalMemory >= 2000000000) { // 2GB
          memoryTier = 'medium';
          canHandleLargeDatasets = true;
          canHandleImageCaching = true;
          canHandleVideoCaching = false;
        }
        
        setMemoryInfo({
          totalMemory,
          usedMemory,
          availableMemory,
          memoryTier,
          canHandleLargeDatasets,
          canHandleImageCaching,
          canHandleVideoCaching,
          isHighMemory: memoryTier === 'high',
          isMediumMemory: memoryTier === 'medium',
          isLowMemory: memoryTier === 'low',
        });
      } catch (error) {
        console.error('Error checking memory capabilities:', error);
        setMemoryInfo({
          error: error.message,
        });
      }
    };

    checkMemoryCapabilities();
  }, []);

  return memoryInfo;
};
```

## Capability-Based Feature Toggles

### 1. Feature Toggle System

```javascript
import { useMemo } from 'react';
import { useDeviceInfo } from './useDeviceInfo';
import { useCameraCapabilities } from './useCameraCapabilities';
import { useNetworkCapabilities } from './useNetworkCapabilities';
import { usePerformanceCapabilities } from './usePerformanceCapabilities';

const useFeatureToggles = () => {
  const deviceInfo = useDeviceInfo();
  const cameraInfo = useCameraCapabilities();
  const networkInfo = useNetworkCapabilities();
  const performanceInfo = usePerformanceCapabilities();
  
  const featureToggles = useMemo(() => {
    if (!deviceInfo || !cameraInfo || !networkInfo || !performanceInfo) {
      return null;
    }
    
    return {
      // Camera features
      canTakePhotos: cameraInfo.isAvailable && cameraInfo.canTakePhotos,
      canRecordVideo: cameraInfo.isAvailable && cameraInfo.canRecordVideo,
      canUseFlash: cameraInfo.hasFlash,
      
      // Network features
      canSyncData: networkInfo.isConnected && networkInfo.isInternetReachable,
      canDownloadLargeFiles: networkInfo.isConnected && networkInfo.isWifiConnected,
      canStreamVideo: networkInfo.isConnected && networkInfo.isWifiConnected,
      
      // Performance features
      canShowHeavyAnimations: performanceInfo.canHandleHeavyAnimations,
      canProcessLargeImages: performanceInfo.canHandleLargeImages,
      canProcessVideo: performanceInfo.canHandleVideoProcessing,
      
      // Device features
      canUseHapticFeedback: deviceInfo.isPhysicalDevice,
      canUseBiometrics: deviceInfo.isPhysicalDevice,
      canUseLocation: deviceInfo.isPhysicalDevice,
      
      // UI features
      canShowComplexUI: performanceInfo.isHighPerformance,
      canShowLargeImages: performanceInfo.canHandleLargeImages,
      canShowVideoThumbnails: performanceInfo.canHandleVideoProcessing,
    };
  }, [deviceInfo, cameraInfo, networkInfo, performanceInfo]);
  
  return featureToggles;
};
```

### 2. Adaptive Component Rendering

```javascript
import { useFeatureToggles } from './useFeatureToggles';

const AdaptiveComponent = ({ children }) => {
  const featureToggles = useFeatureToggles();
  
  if (!featureToggles) {
    return <LoadingSpinner />;
  }
  
  return (
    <View>
      {featureToggles.canShowHeavyAnimations && (
        <AnimatedComponent />
      )}
      
      {featureToggles.canTakePhotos && (
        <CameraComponent />
      )}
      
      {featureToggles.canSyncData && (
        <SyncComponent />
      )}
      
      {children}
    </View>
  );
};
```

## Summary

Device capabilities detection in React Native includes:

1. **Hardware Detection**: Device info, classification, performance tiers
2. **Camera and Media**: Camera availability, media library access
3. **Network and Connectivity**: Network types, speed detection
4. **Sensor Capabilities**: Motion sensors, biometric sensors
5. **Storage Capabilities**: Storage space, database availability
6. **Performance Capabilities**: Performance tiers, memory capabilities
7. **Feature Toggles**: Capability-based feature enabling/disabling

## Key Takeaways

- Use DeviceInfo library for comprehensive device information
- Implement capability detection for all major hardware features
- Create feature toggles based on device capabilities
- Provide appropriate fallbacks for missing capabilities
- Test on various devices to ensure proper capability detection
- Use capability detection to optimize app performance
- Implement adaptive UI based on device capabilities
- Consider network conditions when enabling features
- Monitor device performance and adjust features accordingly
- Provide graceful degradation for unsupported features

