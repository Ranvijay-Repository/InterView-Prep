# 📷 **Camera, Media & File System**

> **Master camera integration, media handling, and file system operations in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Camera Integration](#camera-integration)
- [Media Handling](#media-handling)
- [File System Operations](#file-system-operations)
- [Image Processing](#image-processing)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Camera, media, and file system capabilities are essential for many React Native applications. Understanding these platform features enables rich user experiences with photo capture, media playback, and file management.

### **Camera, Media & File System Overview**


{% raw %}
```
┌─────────────────────────────────────┐
│        Camera, Media & File System  │
│  ┌─────────────────────────────────┐│
│  │        Camera Features          ││
│  │  - Photo capture                ││
│  │  - Video recording              ││
│  │  - Camera controls              ││
│  │  - Image processing             ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Media Handling           ││
│  │  - Image display                ││
│  │  - Video playback               ││
│  │  - Audio playback               ││
│  │  - Media compression            ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        File System              ││
│  │  - File operations              ││
│  │  - Directory management         ││
│  │  - File sharing                 ││
│  │  - Storage management           ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```
{% endraw %}


---

## 📷 **Camera Integration**

### **Camera Manager Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState, useRef, useCallback } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert, Image } from 'react-native';
import { launchCamera, launchImageLibrary, ImagePickerResponse, MediaType } from 'react-native-image-picker';

const CameraManager = () => {
  const [capturedImage, setCapturedImage] = useState(null);
  const [selectedImage, setSelectedImage] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  
  // Camera options
  const cameraOptions = {
    mediaType: 'photo' as MediaType,
    quality: 0.8,
    maxWidth: 1024,
    maxHeight: 1024,
    includeBase64: false,
    saveToPhotos: true,
  };
  
  // Image library options
  const libraryOptions = {
    mediaType: 'photo' as MediaType,
    quality: 0.8,
    maxWidth: 1024,
    maxHeight: 1024,
    includeBase64: false,
    selectionLimit: 1,
  };
  
  // Launch camera
  const launchCameraCapture = useCallback(() => {
    setIsLoading(true);
    
    launchCamera(cameraOptions, (response: ImagePickerResponse) => {
      setIsLoading(false);
      
      if (response.didCancel) {
        console.log('User cancelled camera');
        return;
      }
      
      if (response.errorMessage) {
        Alert.alert('Error', response.errorMessage);
        return;
      }
      
      if (response.assets && response.assets[0]) {
        const asset = response.assets[0];
        setCapturedImage(asset);
        console.log('Image captured:', asset);
      }
    });
  }, []);
  
  // Launch image library
  const launchImageSelection = useCallback(() => {
    setIsLoading(true);
    
    launchImageLibrary(libraryOptions, (response: ImagePickerResponse) => {
      setIsLoading(false);
      
      if (response.didCancel) {
        console.log('User cancelled image selection');
        return;
      }
      
      if (response.errorMessage) {
        Alert.alert('Error', response.errorMessage);
        return;
      }
      
      if (response.assets && response.assets[0]) {
        const asset = response.assets[0];
        setSelectedImage(asset);
        console.log('Image selected:', asset);
      }
    });
  }, []);
  
  // Capture video
  const captureVideo = useCallback(() => {
    const videoOptions = {
      mediaType: 'video' as MediaType,
      quality: 0.8,
      videoQuality: 'high',
      durationLimit: 60,
      includeBase64: false,
      saveToPhotos: true,
    };
    
    launchCamera(videoOptions, (response: ImagePickerResponse) => {
      if (response.didCancel) {
        console.log('User cancelled video capture');
        return;
      }
      
      if (response.errorMessage) {
        Alert.alert('Error', response.errorMessage);
        return;
      }
      
      if (response.assets && response.assets[0]) {
        const asset = response.assets[0];
        console.log('Video captured:', asset);
        Alert.alert('Success', 'Video captured successfully!');
      }
    });
  }, []);
  
  // Clear images
  const clearImages = useCallback(() => {
    setCapturedImage(null);
    setSelectedImage(null);
  }, []);
  
  // Get image info
  const getImageInfo = useCallback((image) => {
    if (!image) return null;
    
    return {
      uri: image.uri,
      width: image.width,
      height: image.height,
      fileSize: image.fileSize,
      fileName: image.fileName,
      type: image.type,
    };
  }, []);
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Camera & Media Manager</Text>
      
      {/* Image Display */}
      <View style={styles.imageContainer}>
        {capturedImage && (
          <View style={styles.imageSection}>
            <Text style={styles.sectionTitle}>Captured Image</Text>
            <Image source={{#123;{{#123; uri: capturedImage.uri }}#125;}}#125; style={styles.image} />
            <Text style={styles.imageInfo}>
              Size: {capturedImage.width}x{capturedImage.height}
            </Text>
            <Text style={styles.imageInfo}>
              File Size: {(capturedImage.fileSize / 1024).toFixed(2)} KB
            </Text>
          </View>
        )}
        
        {selectedImage && (
          <View style={styles.imageSection}>
            <Text style={styles.sectionTitle}>Selected Image</Text>
            <Image source={{#123;{{#123; uri: selectedImage.uri }}#125;}}#125; style={styles.image} />
            <Text style={styles.imageInfo}>
              Size: {selectedImage.width}x{selectedImage.height}
            </Text>
            <Text style={styles.imageInfo}>
              File Size: {(selectedImage.fileSize / 1024).toFixed(2)} KB
            </Text>
          </View>
        )}
      </View>
      
      {/* Controls */}
      <View style={styles.controlsContainer}>
        <View style={styles.buttonRow}>
          <TouchableOpacity
            style={[styles.button, styles.cameraButton]}
            onPress={launchCameraCapture}
            disabled={isLoading}
          >
            <Text style={styles.buttonText}>
              {isLoading ? 'Loading...' : '📷 Take Photo'}
            </Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={[styles.button, styles.libraryButton]}
            onPress={launchImageSelection}
            disabled={isLoading}
          >
            <Text style={styles.buttonText}>
              {isLoading ? 'Loading...' : '🖼️ Select Image'}
            </Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.buttonRow}>
          <TouchableOpacity
            style={[styles.button, styles.videoButton]}
            onPress={captureVideo}
          >
            <Text style={styles.buttonText}>🎥 Record Video</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={[styles.button, styles.clearButton]}
            onPress={clearImages}
          >
            <Text style={styles.buttonText}>🗑️ Clear</Text>
          </TouchableOpacity>
        </View>
      </View>
      
      {/* Image Info */}
      {(capturedImage || selectedImage) && (
        <View style={styles.infoContainer}>
          <Text style={styles.infoTitle}>Image Information</Text>
          {capturedImage && (
            <View style={styles.infoSection}>
              <Text style={styles.infoText}>Captured Image:</Text>
              <Text style={styles.infoText}>• URI: {capturedImage.uri}</Text>
              <Text style={styles.infoText}>• Type: {capturedImage.type}</Text>
              <Text style={styles.infoText}>• File Name: {capturedImage.fileName}</Text>
            </View>
          )}
          {selectedImage && (
            <View style={styles.infoSection}>
              <Text style={styles.infoText}>Selected Image:</Text>
              <Text style={styles.infoText}>• URI: {selectedImage.uri}</Text>
              <Text style={styles.infoText}>• Type: {selectedImage.type}</Text>
              <Text style={styles.infoText}>• File Name: {selectedImage.fileName}</Text>
            </View>
          )}
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 30,
  },
  imageContainer: {
    flex: 1,
    justifyContent: 'center',
  },
  imageSection: {
    alignItems: 'center',
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  image: {
    width: 200,
    height: 200,
    borderRadius: 10,
    marginBottom: 10,
  },
  imageInfo: {
    fontSize: 12,
    color: '#666',
    marginBottom: 5,
  },
  controlsContainer: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 15,
  },
  button: {
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 8,
    minWidth: 120,
    alignItems: 'center',
  },
  cameraButton: {
    backgroundColor: '#007AFF',
  },
  libraryButton: {
    backgroundColor: '#34C759',
  },
  videoButton: {
    backgroundColor: '#FF9500',
  },
  clearButton: {
    backgroundColor: '#FF3B30',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 14,
  },
  infoContainer: {
    backgroundColor: '#E3F2FD',
    padding: 15,
    borderRadius: 10,
  },
  infoTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#1976D2',
    marginBottom: 10,
  },
  infoSection: {
    marginBottom: 10,
  },
  infoText: {
    fontSize: 12,
    color: '#1976D2',
    marginBottom: 2,
  },
});

export default CameraManager;
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Permissions-Security.md" class="nav-link prev">⬅️ Previous: Permissions & Security</a>
    <a href="./03-Background-Tasks.md" class="nav-link next">Next: Background Tasks ➡️</a>
</div>

---


*Last updated: December 2024*
