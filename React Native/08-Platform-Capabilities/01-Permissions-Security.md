# 🔐 **Permissions & Security**

> **Master permissions handling and security best practices for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Permissions Management](#permissions-management)
- [Security Best Practices](#security-best-practices)
- [Data Protection](#data-protection)
- [Authentication](#authentication)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Permissions and security are crucial aspects of React Native development. Proper handling of permissions and implementing security best practices ensures user trust and app compliance.

### **Permissions & Security Overview**

```
┌─────────────────────────────────────┐
│        Permissions & Security       │
│  ┌─────────────────────────────────┐│
│  │        Permissions              ││
│  │  - Camera access                ││
│  │  - Location services            ││
│  │  - Storage access               ││
│  │  - Microphone access            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Security                 ││
│  │  - Data encryption              ││
│  │  - Secure storage               ││
│  │  - Network security             ││
│  │  - Authentication               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Best Practices           ││
│  │  - Principle of least privilege ││
│  │  - Data minimization            ││
│  │  - Secure communication         ││
│  │  - Regular security audits      ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🔐 **Permissions Management**

### **Permissions Manager Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import { PermissionsAndroid, Platform, Alert } from 'react-native';
import { check, request, PERMISSIONS, RESULTS } from 'react-native-permissions';

class PermissionsManager {
  constructor() {
    this.permissions = {
      camera: PERMISSIONS.ANDROID.CAMERA,
      location: PERMISSIONS.ANDROID.ACCESS_FINE_LOCATION,
      storage: PERMISSIONS.ANDROID.READ_EXTERNAL_STORAGE,
      microphone: PERMISSIONS.ANDROID.RECORD_AUDIO,
      contacts: PERMISSIONS.ANDROID.READ_CONTACTS,
      calendar: PERMISSIONS.ANDROID.READ_CALENDAR,
      phone: PERMISSIONS.ANDROID.CALL_PHONE,
      sms: PERMISSIONS.ANDROID.SEND_SMS,
    };
  }
  
  // Check permission status
  async checkPermission(permission) {
    try {
      const result = await check(permission);
      console.log(`Permission ${permission}: ${result}`);
      return result;
    } catch (error) {
      console.error('Error checking permission:', error);
      return RESULTS.DENIED;
    }
  }
  
  // Request permission
  async requestPermission(permission, rationale) {
    try {
      const result = await request(permission, rationale);
      console.log(`Permission request result: ${result}`);
      return result;
    } catch (error) {
      console.error('Error requesting permission:', error);
      return RESULTS.DENIED;
    }
  }
  
  // Request multiple permissions
  async requestMultiplePermissions(permissions) {
    try {
      const results = await request(permissions);
      console.log('Multiple permissions results:', results);
      return results;
    } catch (error) {
      console.error('Error requesting multiple permissions:', error);
      return {};
    }
  }
  
  // Check and request permission with rationale
  async checkAndRequestPermission(permission, rationale) {
    const currentStatus = await this.checkPermission(permission);
    
    if (currentStatus === RESULTS.GRANTED) {
      return RESULTS.GRANTED;
    }
    
    if (currentStatus === RESULTS.DENIED) {
      return await this.requestPermission(permission, rationale);
    }
    
    if (currentStatus === RESULTS.BLOCKED) {
      this.showPermissionBlockedAlert(permission);
      return RESULTS.BLOCKED;
    }
    
    return currentStatus;
  }
  
  // Show permission blocked alert
  showPermissionBlockedAlert(permission) {
    Alert.alert(
      'Permission Required',
      'This permission is required for the app to function properly. Please enable it in Settings.',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Open Settings', onPress: () => this.openAppSettings() }
      ]
    );
  }
  
  // Open app settings
  openAppSettings() {
    // This would typically use a library like react-native-settings
    console.log('Opening app settings...');
  }
  
  // Camera permission
  async requestCameraPermission() {
    const rationale = {
      title: 'Camera Permission',
      message: 'This app needs access to your camera to take photos.',
      buttonNeutral: 'Ask Me Later',
      buttonNegative: 'Cancel',
      buttonPositive: 'OK',
    };
    
    return await this.checkAndRequestPermission(this.permissions.camera, rationale);
  }
  
  // Location permission
  async requestLocationPermission() {
    const rationale = {
      title: 'Location Permission',
      message: 'This app needs access to your location to provide location-based services.',
      buttonNeutral: 'Ask Me Later',
      buttonNegative: 'Cancel',
      buttonPositive: 'OK',
    };
    
    return await this.checkAndRequestPermission(this.permissions.location, rationale);
  }
  
  // Storage permission
  async requestStoragePermission() {
    const rationale = {
      title: 'Storage Permission',
      message: 'This app needs access to your storage to save and load files.',
      buttonNeutral: 'Ask Me Later',
      buttonNegative: 'Cancel',
      buttonPositive: 'OK',
    };
    
    return await this.checkAndRequestPermission(this.permissions.storage, rationale);
  }
  
  // Microphone permission
  async requestMicrophonePermission() {
    const rationale = {
      title: 'Microphone Permission',
      message: 'This app needs access to your microphone to record audio.',
      buttonNeutral: 'Ask Me Later',
      buttonNegative: 'Cancel',
      buttonPositive: 'OK',
    };
    
    return await this.checkAndRequestPermission(this.permissions.microphone, rationale);
  }
  
  // Get all permissions status
  async getAllPermissionsStatus() {
    const status = {};
    
    for (const [key, permission] of Object.entries(this.permissions)) {
      status[key] = await this.checkPermission(permission);
    }
    
    return status;
  }
  
  // Request all required permissions
  async requestAllRequiredPermissions() {
    const requiredPermissions = [
      this.permissions.camera,
      this.permissions.location,
      this.permissions.storage,
    ];
    
    return await this.requestMultiplePermissions(requiredPermissions);
  }
}

export default PermissionsManager;
```

### **Security Manager Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import { Platform } from 'react-native';
import CryptoJS from 'crypto-js';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { getUniqueId } from 'react-native-device-info';

class SecurityManager {
  constructor() {
    this.encryptionKey = this.generateEncryptionKey();
    this.deviceId = null;
    this.initializeSecurity();
  }
  
  // Initialize security
  async initializeSecurity() {
    try {
      this.deviceId = await getUniqueId();
      await this.setupSecureStorage();
      console.log('Security manager initialized');
    } catch (error) {
      console.error('Error initializing security:', error);
    }
  }
  
  // Generate encryption key
  generateEncryptionKey() {
    const timestamp = Date.now().toString();
    const random = Math.random().toString(36).substring(2);
    return CryptoJS.SHA256(timestamp + random).toString();
  }
  
  // Setup secure storage
  async setupSecureStorage() {
    try {
      const existingKey = await AsyncStorage.getItem('encryption_key');
      if (!existingKey) {
        await AsyncStorage.setItem('encryption_key', this.encryptionKey);
      } else {
        this.encryptionKey = existingKey;
      }
    } catch (error) {
      console.error('Error setting up secure storage:', error);
    }
  }
  
  // Encrypt data
  encryptData(data) {
    try {
      const jsonString = JSON.stringify(data);
      const encrypted = CryptoJS.AES.encrypt(jsonString, this.encryptionKey).toString();
      return encrypted;
    } catch (error) {
      console.error('Error encrypting data:', error);
      return null;
    }
  }
  
  // Decrypt data
  decryptData(encryptedData) {
    try {
      const decrypted = CryptoJS.AES.decrypt(encryptedData, this.encryptionKey);
      const jsonString = decrypted.toString(CryptoJS.enc.Utf8);
      return JSON.parse(jsonString);
    } catch (error) {
      console.error('Error decrypting data:', error);
      return null;
    }
  }
  
  // Secure storage operations
  async setSecureItem(key, value) {
    try {
      const encryptedValue = this.encryptData(value);
      if (encryptedValue) {
        await AsyncStorage.setItem(`secure_${key}`, encryptedValue);
        return true;
      }
      return false;
    } catch (error) {
      console.error('Error setting secure item:', error);
      return false;
    }
  }
  
  async getSecureItem(key) {
    try {
      const encryptedValue = await AsyncStorage.getItem(`secure_${key}`);
      if (encryptedValue) {
        return this.decryptData(encryptedValue);
      }
      return null;
    } catch (error) {
      console.error('Error getting secure item:', error);
      return null;
    }
  }
  
  async removeSecureItem(key) {
    try {
      await AsyncStorage.removeItem(`secure_${key}`);
      return true;
    } catch (error) {
      console.error('Error removing secure item:', error);
      return false;
    }
  }
  
  // Hash password
  hashPassword(password) {
    try {
      const salt = CryptoJS.lib.WordArray.random(128/8);
      const hash = CryptoJS.PBKDF2(password, salt, { keySize: 512/32 });
      return {
        hash: hash.toString(),
        salt: salt.toString()
      };
    } catch (error) {
      console.error('Error hashing password:', error);
      return null;
    }
  }
  
  // Verify password
  verifyPassword(password, hash, salt) {
    try {
      const hashToVerify = CryptoJS.PBKDF2(password, salt, { keySize: 512/32 });
      return hashToVerify.toString() === hash;
    } catch (error) {
      console.error('Error verifying password:', error);
      return false;
    }
  }
  
  // Generate secure token
  generateSecureToken() {
    try {
      const timestamp = Date.now().toString();
      const random = Math.random().toString(36).substring(2);
      const deviceInfo = this.deviceId || 'unknown';
      const combined = timestamp + random + deviceInfo;
      return CryptoJS.SHA256(combined).toString();
    } catch (error) {
      console.error('Error generating secure token:', error);
      return null;
    }
  }
  
  // Validate token
  validateToken(token) {
    try {
      // Basic token validation
      if (!token || typeof token !== 'string') {
        return false;
      }
      
      // Check token format (should be 64 characters for SHA256)
      if (token.length !== 64) {
        return false;
      }
      
      // Check if token contains only valid characters
      const validChars = /^[a-f0-9]+$/i;
      return validChars.test(token);
    } catch (error) {
      console.error('Error validating token:', error);
      return false;
    }
  }
  
  // Secure API request
  async makeSecureRequest(url, data) {
    try {
      const token = this.generateSecureToken();
      const encryptedData = this.encryptData(data);
      
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
          'X-Device-ID': this.deviceId,
          'X-Platform': Platform.OS,
        },
        body: JSON.stringify({
          data: encryptedData,
          timestamp: Date.now(),
        }),
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error making secure request:', error);
      throw error;
    }
  }
  
  // Clear all secure data
  async clearAllSecureData() {
    try {
      const keys = await AsyncStorage.getAllKeys();
      const secureKeys = keys.filter(key => key.startsWith('secure_'));
      
      for (const key of secureKeys) {
        await AsyncStorage.removeItem(key);
      }
      
      // Regenerate encryption key
      this.encryptionKey = this.generateEncryptionKey();
      await AsyncStorage.setItem('encryption_key', this.encryptionKey);
      
      console.log('All secure data cleared');
      return true;
    } catch (error) {
      console.error('Error clearing secure data:', error);
      return false;
    }
  }
  
  // Security audit
  async performSecurityAudit() {
    try {
      const audit = {
        timestamp: new Date().toISOString(),
        deviceId: this.deviceId,
        platform: Platform.OS,
        encryptionKeyExists: !!this.encryptionKey,
        secureItemsCount: 0,
        vulnerabilities: [],
      };
      
      // Count secure items
      const keys = await AsyncStorage.getAllKeys();
      audit.secureItemsCount = keys.filter(key => key.startsWith('secure_')).length;
      
      // Check for common vulnerabilities
      if (!this.encryptionKey) {
        audit.vulnerabilities.push('No encryption key found');
      }
      
      if (audit.secureItemsCount === 0) {
        audit.vulnerabilities.push('No secure data found');
      }
      
      // Check for weak encryption
      if (this.encryptionKey && this.encryptionKey.length < 32) {
        audit.vulnerabilities.push('Weak encryption key');
      }
      
      console.log('Security audit completed:', audit);
      return audit;
    } catch (error) {
      console.error('Error performing security audit:', error);
      return null;
    }
  }
}

export default SecurityManager;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="../07-Native-Interoperability/04-Native-UI-Components.md" class="nav-link prev">⬅️ Previous: Native UI Components</a>
    <a href="./02-Camera-Media-FileSystem.md" class="nav-link next">Next: Camera, Media & File System ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
