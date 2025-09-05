# 🧩 **Core Components**

> **Master the fundamental React Native components that form the building blocks of mobile applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [View Component](#view-component)
- [Text Component](#text-component)
- [Image Component](#image-component)
- [ScrollView Component](#scrollview-component)
- [TouchableOpacity Component](#touchableopacity-component)
- [TextInput Component](#textinput-component)
- [Button Component](#button-component)
- [ActivityIndicator Component](#activityindicator-component)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

React Native provides a set of core components that map to native mobile components. Understanding these components is fundamental to building React Native applications.

### **Core Components Overview**

```
┌─────────────────────────────────────┐
│        Core Components              │
│  ┌─────────────────────────────────┐│
│  │        Layout Components        ││
│  │  - View                         ││
│  │  - ScrollView                   ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Text Components          ││
│  │  - Text                         ││
│  │  - TextInput                    ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Interactive Components   ││
│  │  - TouchableOpacity             ││
│  │  - Button                       ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Media Components         ││
│  │  - Image                        ││
│  │  - ActivityIndicator            ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 📦 **View Component**

The `View` component is the most fundamental component in React Native. It's similar to a `div` in HTML and is used for layout and styling.

### **Basic View Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const BasicView = () => {
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text>Header Content</Text>
      </View>
      <View style={styles.content}>
        <Text>Main Content</Text>
      </View>
      <View style={styles.footer}>
        <Text>Footer Content</Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    height: 60,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
  },
  content: {
    flex: 1,
    padding: 20,
  },
  footer: {
    height: 50,
    backgroundColor: '#333',
    justifyContent: 'center',
    alignItems: 'center',
  },
});

export default BasicView;
```

### **View with Flexbox Layout**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const FlexboxView = () => {
  return (
    <View style={styles.container}>
      <View style={styles.row}>
        <View style={[styles.box, styles.box1]}>
          <Text style={styles.text}>Box 1</Text>
        </View>
        <View style={[styles.box, styles.box2]}>
          <Text style={styles.text}>Box 2</Text>
        </View>
      </View>
      <View style={styles.row}>
        <View style={[styles.box, styles.box3]}>
          <Text style={styles.text}>Box 3</Text>
        </View>
        <View style={[styles.box, styles.box4]}>
          <Text style={styles.text}>Box 4</Text>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  box: {
    width: 150,
    height: 100,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 8,
  },
  box1: { backgroundColor: '#FF6B6B' },
  box2: { backgroundColor: '#4ECDC4' },
  box3: { backgroundColor: '#45B7D1' },
  box4: { backgroundColor: '#96CEB4' },
  text: {
    color: 'white',
    fontWeight: 'bold',
  },
});

export default FlexboxView;
```

---

## 📝 **Text Component**

The `Text` component is used to display text content. It's similar to `span` or `p` in HTML.

### **Basic Text Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const BasicText = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Welcome to React Native</Text>
      <Text style={styles.subtitle}>Building mobile apps with JavaScript</Text>
      <Text style={styles.body}>
        React Native lets you build mobile apps using only JavaScript. 
        It uses the same design as React, letting you compose a rich 
        mobile UI from declarative components.
      </Text>
      <Text style={styles.highlight}>
        This text is highlighted!
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 10,
  },
  subtitle: {
    fontSize: 18,
    color: '#666',
    marginBottom: 20,
  },
  body: {
    fontSize: 16,
    lineHeight: 24,
    color: '#444',
    marginBottom: 20,
  },
  highlight: {
    fontSize: 16,
    color: '#007AFF',
    fontWeight: '600',
    backgroundColor: '#E3F2FD',
    padding: 10,
    borderRadius: 5,
  },
});

export default BasicText;
```

### **Text with Nested Components**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const NestedText = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.paragraph}>
        This is a paragraph with{' '}
        <Text style={styles.bold}>bold text</Text>
        {' '}and{' '}
        <Text style={styles.italic}>italic text</Text>
        {' '}and{' '}
        <Text style={styles.link}>a link</Text>
        {' '}all in one line.
      </Text>
      
      <Text style={styles.paragraph}>
        You can also have{' '}
        <Text style={styles.colored}>colored text</Text>
        {' '}and{' '}
        <Text style={styles.underlined}>underlined text</Text>
        {' '}in the same component.
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  paragraph: {
    fontSize: 16,
    lineHeight: 24,
    marginBottom: 15,
    color: '#333',
  },
  bold: {
    fontWeight: 'bold',
  },
  italic: {
    fontStyle: 'italic',
  },
  link: {
    color: '#007AFF',
    textDecorationLine: 'underline',
  },
  colored: {
    color: '#FF6B6B',
  },
  underlined: {
    textDecorationLine: 'underline',
  },
});

export default NestedText;
```

---

## 🖼️ **Image Component**

The `Image` component is used to display images from various sources.

### **Basic Image Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React from 'react';
import { View, Image, Text, StyleSheet } from 'react-native';

const BasicImage = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Image Examples</Text>
      
      {/* Local image */}
      <View style={styles.imageContainer}>
        <Text style={styles.label}>Local Image:</Text>
        <Image
          source={require('./assets/local-image.png')}
          style={styles.image}
          resizeMode="cover"
        />
      </View>
      
      {/* Network image */}
      <View style={styles.imageContainer}>
        <Text style={styles.label}>Network Image:</Text>
        <Image
          source={{
            uri: 'https://picsum.photos/200/200'
          }}
          style={styles.image}
          resizeMode="cover"
        />
      </View>
      
      {/* Image with error handling */}
      <View style={styles.imageContainer}>
        <Text style={styles.label}>Image with Error Handling:</Text>
        <Image
          source={{
            uri: 'https://example.com/image.jpg'
          }}
          style={styles.image}
          onLoad={() => console.log('Image loaded successfully')}
          onError={(error) => console.log('Image failed to load:', error)}
          defaultSource={require('./assets/placeholder.png')}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
    textAlign: 'center',
  },
  imageContainer: {
    marginBottom: 20,
    alignItems: 'center',
  },
  label: {
    fontSize: 16,
    marginBottom: 10,
    fontWeight: '600',
  },
  image: {
    width: 200,
    height: 200,
    borderRadius: 10,
    borderWidth: 2,
    borderColor: '#ddd',
  },
});

export default BasicImage;
```

### **Image with Loading States**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState } from 'react';
import { View, Image, Text, ActivityIndicator, StyleSheet } from 'react-native';

const ImageWithLoading = () => {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);
  
  const handleLoadStart = () => {
    setLoading(true);
    setError(false);
  };
  
  const handleLoadEnd = () => {
    setLoading(false);
  };
  
  const handleError = () => {
    setLoading(false);
    setError(true);
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Image with Loading State</Text>
      
      <View style={styles.imageContainer}>
        <Image
          source={{
            uri: 'https://picsum.photos/300/300'
          }}
          style={styles.image}
          onLoadStart={handleLoadStart}
          onLoadEnd={handleLoadEnd}
          onError={handleError}
        />
        
        {loading && (
          <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color="#007AFF" />
            <Text style={styles.loadingText}>Loading...</Text>
          </View>
        )}
        
        {error && (
          <View style={styles.errorContainer}>
            <Text style={styles.errorText}>Failed to load image</Text>
          </View>
        )}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
    textAlign: 'center',
  },
  imageContainer: {
    position: 'relative',
    alignItems: 'center',
  },
  image: {
    width: 300,
    height: 300,
    borderRadius: 10,
  },
  loadingContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.1)',
    borderRadius: 10,
  },
  loadingText: {
    marginTop: 10,
    color: '#007AFF',
    fontWeight: '600',
  },
  errorContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(255,0,0,0.1)',
    borderRadius: 10,
  },
  errorText: {
    color: '#FF3B30',
    fontWeight: '600',
  },
});

export default ImageWithLoading;
```

---

## 🧭 Navigation

<div class="navigation">
    <a href="../00-Core-Foundations/02-TypeScript-Essentials-for-RN.md" class="nav-link prev">⬅️ Previous: TypeScript Essentials for RN</a>
    <a href="./02-Styling-Flexbox.md" class="nav-link next">Next: Styling & Flexbox ➡️</a>
</div>

---


*Last updated: December 2024*
