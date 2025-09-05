# 🔄 **Background Tasks**

> **Master background task execution, Headless JS, and background processing in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Headless JS](#headless-js)
- [Background Fetch](#background-fetch)
- [Background Sync](#background-sync)
- [Task Scheduling](#task-scheduling)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Background tasks enable React Native applications to perform operations when the app is not in the foreground. Understanding background task management is crucial for building robust applications with offline capabilities and data synchronization.

### **Background Tasks Overview**

```
┌─────────────────────────────────────┐
│        Background Tasks             │
│  ┌─────────────────────────────────┐│
│  │        Headless JS              ││
│  │  - Background execution         ││
│  │  - Task scheduling              ││
│  │  - Data processing              ││
│  │  - Notification handling        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Background Fetch         ││
│  │  - Periodic updates             ││
│  │  - Data synchronization         ││
│  │  - Content refresh              ││
│  │  - Offline support              ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Background Sync          ││
│  │  - Data synchronization         ││
│  │  - Conflict resolution          ││
│  │  - Queue management             ││
│  │  - Error handling               ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 🔄 **Headless JS**

### **Background Task Manager Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import { AppRegistry, NativeModules } from 'react-native';
import BackgroundJob from 'react-native-background-job';
import AsyncStorage from '@react-native-async-storage/async-storage';

class BackgroundTaskManager {
  constructor() {
    this.isRunning = false;
    this.taskId = null;
    this.setupBackgroundTasks();
  }
  
  // Setup background tasks
  setupBackgroundTasks() {
    // Register background task
    AppRegistry.registerHeadlessTask('BackgroundTask', () => this.backgroundTask);
    
    // Setup background job
    BackgroundJob.register({
      jobKey: 'backgroundSync',
      period: 15000, // 15 seconds
    });
  }
  
  // Background task function
  backgroundTask = async () => {
    console.log('Background task started');
    
    try {
      // Perform background operations
      await this.performBackgroundSync();
      await this.processPendingData();
      await this.updateLocalCache();
      
      console.log('Background task completed successfully');
      return 'success';
    } catch (error) {
      console.error('Background task failed:', error);
      return 'error';
    }
  };
  
  // Start background task
  async startBackgroundTask() {
    try {
      if (this.isRunning) {
        console.log('Background task already running');
        return;
      }
      
      this.isRunning = true;
      
      // Start background job
      BackgroundJob.start({
        jobKey: 'backgroundSync',
        callback: this.backgroundTask,
      });
      
      console.log('Background task started');
    } catch (error) {
      console.error('Error starting background task:', error);
      this.isRunning = false;
    }
  }
  
  // Stop background task
  async stopBackgroundTask() {
    try {
      if (!this.isRunning) {
        console.log('Background task not running');
        return;
      }
      
      this.isRunning = false;
      
      // Stop background job
      BackgroundJob.stop({
        jobKey: 'backgroundSync',
      });
      
      console.log('Background task stopped');
    } catch (error) {
      console.error('Error stopping background task:', error);
    }
  }
  
  // Perform background sync
  async performBackgroundSync() {
    try {
      console.log('Performing background sync...');
      
      // Get pending data
      const pendingData = await this.getPendingData();
      
      if (pendingData.length === 0) {
        console.log('No pending data to sync');
        return;
      }
      
      // Sync data with server
      for (const item of pendingData) {
        try {
          await this.syncDataItem(item);
          await this.markDataAsSynced(item.id);
        } catch (error) {
          console.error(`Failed to sync item ${item.id}:`, error);
        }
      }
      
      console.log(`Synced ${pendingData.length} items`);
    } catch (error) {
      console.error('Background sync failed:', error);
    }
  }
  
  // Process pending data
  async processPendingData() {
    try {
      console.log('Processing pending data...');
      
      const pendingData = await this.getPendingData();
      
      for (const item of pendingData) {
        // Process data based on type
        switch (item.type) {
          case 'image':
            await this.processImageData(item);
            break;
          case 'document':
            await this.processDocumentData(item);
            break;
          case 'audio':
            await this.processAudioData(item);
            break;
          default:
            console.log(`Unknown data type: ${item.type}`);
        }
      }
      
      console.log('Pending data processing completed');
    } catch (error) {
      console.error('Pending data processing failed:', error);
    }
  }
  
  // Update local cache
  async updateLocalCache() {
    try {
      console.log('Updating local cache...');
      
      // Get cache update timestamp
      const lastUpdate = await AsyncStorage.getItem('lastCacheUpdate');
      const now = Date.now();
      
      // Update cache if needed
      if (!lastUpdate || (now - parseInt(lastUpdate)) > 300000) { // 5 minutes
        await this.refreshCache();
        await AsyncStorage.setItem('lastCacheUpdate', now.toString());
      }
      
      console.log('Local cache updated');
    } catch (error) {
      console.error('Cache update failed:', error);
    }
  }
  
  // Get pending data
  async getPendingData() {
    try {
      const pendingData = await AsyncStorage.getItem('pendingData');
      return pendingData ? JSON.parse(pendingData) : [];
    } catch (error) {
      console.error('Error getting pending data:', error);
      return [];
    }
  }
  
  // Sync data item
  async syncDataItem(item) {
    try {
      const response = await fetch('https://api.example.com/sync', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(item),
      });
      
      if (!response.ok) {
        throw new Error(`Sync failed: ${response.status}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Sync error:', error);
      throw error;
    }
  }
  
  // Mark data as synced
  async markDataAsSynced(id) {
    try {
      const pendingData = await this.getPendingData();
      const updatedData = pendingData.filter(item => item.id !== id);
      await AsyncStorage.setItem('pendingData', JSON.stringify(updatedData));
    } catch (error) {
      console.error('Error marking data as synced:', error);
    }
  }
  
  // Process image data
  async processImageData(item) {
    console.log(`Processing image data: ${item.id}`);
    // Image processing logic here
  }
  
  // Process document data
  async processDocumentData(item) {
    console.log(`Processing document data: ${item.id}`);
    // Document processing logic here
  }
  
  // Process audio data
  async processAudioData(item) {
    console.log(`Processing audio data: ${item.id}`);
    // Audio processing logic here
  }
  
  // Refresh cache
  async refreshCache() {
    try {
      // Fetch fresh data from server
      const response = await fetch('https://api.example.com/cache');
      const data = await response.json();
      
      // Update local cache
      await AsyncStorage.setItem('cachedData', JSON.stringify(data));
    } catch (error) {
      console.error('Cache refresh failed:', error);
    }
  }
  
  // Get task status
  getTaskStatus() {
    return {
      isRunning: this.isRunning,
      taskId: this.taskId,
      lastRun: new Date().toISOString(),
    };
  }
}

export default BackgroundTaskManager;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="./02-Camera-Media-FileSystem.md" class="nav-link prev">⬅️ Previous: Camera, Media & File System</a>
    <a href="./04-Push-Notifications.md" class="nav-link next">Next: Push Notifications ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
