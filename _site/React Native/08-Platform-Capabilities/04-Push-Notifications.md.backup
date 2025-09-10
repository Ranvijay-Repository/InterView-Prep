# 📱 **Push Notifications**

> **Master push notification implementation, APNs, FCM, and notification handling in React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Push Notification Setup](#push-notification-setup)
- [Notification Handling](#notification-handling)
- [Local Notifications](#local-notifications)
- [Notification Scheduling](#notification-scheduling)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

Push notifications are essential for engaging users and keeping them informed about important updates. Understanding push notification implementation, handling, and best practices is crucial for building successful mobile applications.

### **Push Notifications Overview**


{% raw %}
```
┌─────────────────────────────────────┐
│        Push Notifications           │
│  ┌─────────────────────────────────┐│
│  │        Platform Services        ││
│  │  - APNs (iOS)                   ││
│  │  - FCM (Android)                ││
│  │  - Web Push                     ││
│  │  - Cross-platform               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Notification Types       ││
│  │  - Push notifications           ││
│  │  - Local notifications          ││
│  │  - Scheduled notifications      ││
│  │  - Interactive notifications    ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Features                 ││
│  │  - Rich media                   ││
│  │  - Action buttons               ││
│  │  - Deep linking                 ││
│  │  - Analytics tracking           ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```
{% endraw %}


---

## 📱 **Push Notification Setup**

### **Notification Manager Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useState, useEffect, useCallback } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert, Platform } from 'react-native';
import messaging from '@react-native-firebase/messaging';
import PushNotification from 'react-native-push-notification';
import AsyncStorage from '@react-native-async-storage/async-storage';

const NotificationManager = () => {
  const [fcmToken, setFcmToken] = useState(null);
  const [notificationPermission, setNotificationPermission] = useState(null);
  const [notifications, setNotifications] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  
  useEffect(() => {
    initializeNotifications();
    setupNotificationListeners();
  }, []);
  
  // Initialize notifications
  const initializeNotifications = useCallback(async () => {
    try {
      setIsLoading(true);
      
      // Request permission
      const authStatus = await messaging().requestPermission();
      const enabled = authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
                     authStatus === messaging.AuthorizationStatus.PROVISIONAL;
      
      setNotificationPermission(enabled);
      
      if (enabled) {
        // Get FCM token
        const token = await messaging().getToken();
        setFcmToken(token);
        
        // Save token to storage
        await AsyncStorage.setItem('fcmToken', token);
        
        // Configure push notifications
        configurePushNotifications();
        
        console.log('FCM Token:', token);
      }
    } catch (error) {
      console.error('Error initializing notifications:', error);
    } finally {
      setIsLoading(false);
    }
  }, []);
  
  // Configure push notifications
  const configurePushNotifications = useCallback(() => {
    PushNotification.configure({
      onRegister: function (token) {
        console.log('TOKEN:', token);
      },
      
      onNotification: function (notification) {
        console.log('NOTIFICATION:', notification);
        
        // Handle notification
        handleNotification(notification);
      },
      
      onAction: function (notification) {
        console.log('ACTION:', notification.action);
        console.log('NOTIFICATION:', notification);
        
        // Handle notification action
        handleNotificationAction(notification);
      },
      
      onRegistrationError: function(err) {
        console.error(err.message, err);
      },
      
      permissions: {
        alert: true,
        badge: true,
        sound: true,
      },
      
      popInitialNotification: true,
      requestPermissions: true,
    });
  }, []);
  
  // Setup notification listeners
  const setupNotificationListeners = useCallback(() => {
    // Foreground message handler
    const unsubscribeForeground = messaging().onMessage(async remoteMessage => {
      console.log('Foreground message received:', remoteMessage);
      
      // Show local notification when app is in foreground
      showLocalNotification(remoteMessage);
    });
    
    // Background message handler
    messaging().setBackgroundMessageHandler(async remoteMessage => {
      console.log('Background message received:', remoteMessage);
      
      // Handle background message
      handleBackgroundMessage(remoteMessage);
    });
    
    // Notification opened app handler
    const unsubscribeOpenedApp = messaging().onNotificationOpenedApp(remoteMessage => {
      console.log('Notification opened app:', remoteMessage);
      
      // Handle notification opened app
      handleNotificationOpenedApp(remoteMessage);
    });
    
    // Get initial notification
    messaging()
      .getInitialNotification()
      .then(remoteMessage => {
        if (remoteMessage) {
          console.log('Initial notification:', remoteMessage);
          handleInitialNotification(remoteMessage);
        }
      });
    
    return () => {
      unsubscribeForeground();
      unsubscribeOpenedApp();
    };
  }, []);
  
  // Handle notification
  const handleNotification = useCallback((notification) => {
    const newNotification = {
      id: Date.now(),
      title: notification.title || 'Notification',
      message: notification.message || notification.body || 'No message',
      data: notification.data || {},
      timestamp: new Date().toISOString(),
      type: 'received',
    };
    
    setNotifications(prev => [newNotification, ...prev]);
  }, []);
  
  // Handle notification action
  const handleNotificationAction = useCallback((notification) => {
    const actionNotification = {
      id: Date.now(),
      title: 'Action Performed',
      message: `Action: ${notification.action}`,
      data: notification.data || {},
      timestamp: new Date().toISOString(),
      type: 'action',
    };
    
    setNotifications(prev => [actionNotification, ...prev]);
  }, []);
  
  // Handle background message
  const handleBackgroundMessage = useCallback((remoteMessage) => {
    console.log('Handling background message:', remoteMessage);
    
    // Process background message
    // This could include updating local data, syncing, etc.
  }, []);
  
  // Handle notification opened app
  const handleNotificationOpenedApp = useCallback((remoteMessage) => {
    console.log('Handling notification opened app:', remoteMessage);
    
    // Navigate to specific screen based on notification data
    if (remoteMessage.data?.screen) {
      // Navigate to screen
      console.log(`Navigate to: ${remoteMessage.data.screen}`);
    }
  }, []);
  
  // Handle initial notification
  const handleInitialNotification = useCallback((remoteMessage) => {
    console.log('Handling initial notification:', remoteMessage);
    
    // Handle app opened from notification
    if (remoteMessage.data?.screen) {
      // Navigate to screen
      console.log(`Navigate to: ${remoteMessage.data.screen}`);
    }
  }, []);
  
  // Show local notification
  const showLocalNotification = useCallback((remoteMessage) => {
    PushNotification.localNotification({
      title: remoteMessage.notification?.title || 'New Message',
      message: remoteMessage.notification?.body || 'You have a new message',
      data: remoteMessage.data || {},
      soundName: 'default',
      playSound: true,
      vibrate: true,
      vibration: 300,
    });
  }, []);
  
  // Send test notification
  const sendTestNotification = useCallback(async () => {
    try {
      if (!fcmToken) {
        Alert.alert('Error', 'FCM token not available');
        return;
      }
      
      // Send test notification to server
      const response = await fetch('https://api.example.com/send-notification', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          token: fcmToken,
          title: 'Test Notification',
          body: 'This is a test notification',
          data: {
            screen: 'test',
            timestamp: Date.now(),
          },
        }),
      });
      
      if (response.ok) {
        Alert.alert('Success', 'Test notification sent!');
      } else {
        Alert.alert('Error', 'Failed to send notification');
      }
    } catch (error) {
      console.error('Error sending test notification:', error);
      Alert.alert('Error', 'Failed to send notification');
    }
  }, [fcmToken]);
  
  // Schedule local notification
  const scheduleLocalNotification = useCallback(() => {
    PushNotification.localNotificationSchedule({
      title: 'Scheduled Notification',
      message: 'This is a scheduled notification',
      date: new Date(Date.now() + 10 * 1000), // 10 seconds from now
      soundName: 'default',
      playSound: true,
      vibrate: true,
      vibration: 300,
    });
    
    Alert.alert('Success', 'Notification scheduled for 10 seconds from now');
  }, []);
  
  // Clear notifications
  const clearNotifications = useCallback(() => {
    setNotifications([]);
    PushNotification.cancelAllLocalNotifications();
    Alert.alert('Success', 'All notifications cleared');
  }, []);
  
  // Get notification count
  const getNotificationCount = useCallback(() => {
    return notifications.length;
  }, [notifications]);
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Push Notifications</Text>
      
      {/* Status Info */}
      <View style={styles.statusContainer}>
        <Text style={styles.statusTitle}>Notification Status</Text>
        <Text style={styles.statusText}>
          Permission: {notificationPermission ? 'Granted' : 'Denied'}
        </Text>
        <Text style={styles.statusText}>
          FCM Token: {fcmToken ? 'Available' : 'Not Available'}
        </Text>
        <Text style={styles.statusText}>
          Notifications: {getNotificationCount()}
        </Text>
      </View>
      
      {/* Controls */}
      <View style={styles.controlsContainer}>
        <TouchableOpacity
          style={[styles.button, styles.testButton]}
          onPress={sendTestNotification}
          disabled={!fcmToken || isLoading}
        >
          <Text style={styles.buttonText}>
            {isLoading ? 'Loading...' : '📤 Send Test'}
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[styles.button, styles.scheduleButton]}
          onPress={scheduleLocalNotification}
        >
          <Text style={styles.buttonText}>⏰ Schedule</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[styles.button, styles.clearButton]}
          onPress={clearNotifications}
        >
          <Text style={styles.buttonText}>🗑️ Clear</Text>
        </TouchableOpacity>
      </View>
      
      {/* Notifications List */}
      <View style={styles.notificationsContainer}>
        <Text style={styles.notificationsTitle}>Recent Notifications</Text>
        {notifications.length === 0 ? (
          <Text style={styles.noNotificationsText}>No notifications yet</Text>
        ) : (
          notifications.slice(0, 5).map((notification) => (
            <View key={notification.id} style={styles.notificationItem}>
              <Text style={styles.notificationTitle}>{notification.title}</Text>
              <Text style={styles.notificationMessage}>{notification.message}</Text>
              <Text style={styles.notificationTimestamp}>
                {new Date(notification.timestamp).toLocaleTimeString()}
              </Text>
            </View>
          ))
        )}
      </View>
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
  statusContainer: {
    backgroundColor: '#E3F2FD',
    padding: 15,
    borderRadius: 10,
    marginBottom: 20,
  },
  statusTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#1976D2',
    marginBottom: 10,
  },
  statusText: {
    fontSize: 14,
    color: '#1976D2',
    marginBottom: 5,
  },
  controlsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 20,
  },
  button: {
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 8,
    minWidth: 100,
    alignItems: 'center',
  },
  testButton: {
    backgroundColor: '#007AFF',
  },
  scheduleButton: {
    backgroundColor: '#FF9500',
  },
  clearButton: {
    backgroundColor: '#FF3B30',
  },
  buttonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 12,
  },
  notificationsContainer: {
    flex: 1,
    backgroundColor: 'white',
    borderRadius: 10,
    padding: 15,
  },
  notificationsTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#333',
  },
  noNotificationsText: {
    textAlign: 'center',
    color: '#666',
    fontStyle: 'italic',
  },
  notificationItem: {
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  notificationTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  notificationMessage: {
    fontSize: 14,
    color: '#666',
    marginBottom: 5,
  },
  notificationTimestamp: {
    fontSize: 12,
    color: '#999',
  },
});

export default NotificationManager;
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Background-Tasks.md" class="nav-link prev">⬅️ Previous: Background Tasks</a>
    <a href="../09-Testing-Quality/01-Unit-Testing.md" class="nav-link next">Next: Unit Testing ➡️</a>
</div>

---


*Last updated: December 2024*
