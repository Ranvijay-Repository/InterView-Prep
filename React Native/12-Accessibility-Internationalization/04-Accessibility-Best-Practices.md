# 🎯 **Accessibility Best Practices**

> **Master accessibility best practices, guidelines, and implementation strategies for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Accessibility Guidelines](#-accessibility-guidelines)
- [Implementation Strategies](#-implementation-strategies)
- [Performance Considerations](#-performance-considerations)
- [Common Pitfalls](#-common-pitfalls)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 📋 **Accessibility Guidelines**

### **WCAG Compliance**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const WCAGGuidelines = () => {
  const guidelines = {
    perceivable: [
      'Provide text alternatives for images',
      'Use sufficient color contrast',
      'Make content adaptable',
      'Make content distinguishable'
    ],
    operable: [
      'Make all functionality keyboard accessible',
      'Provide enough time to read content',
      'Avoid content that causes seizures',
      'Help users navigate and find content'
    ],
    understandable: [
      'Make text readable and understandable',
      'Make content appear and operate predictably',
      'Help users avoid and correct mistakes'
    ],
    robust: [
      'Maximize compatibility with assistive technologies',
      'Use valid and semantic markup',
      'Ensure content remains accessible over time'
    ]
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>WCAG 2.1 Guidelines</Text>
      {Object.entries(guidelines).map(([principle, items]) => (
        <View key={principle} style={styles.principle}>
          <Text style={styles.principleTitle}>{principle.toUpperCase()}</Text>
          {items.map((item, index) => (
            <Text key={index} style={styles.guidelineItem}>
              • {item}
            </Text>
          ))}
        </View>
      ))}
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
    marginBottom: 20,
    color: '#333',
  },
  principle: {
    marginBottom: 20,
  },
  principleTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#007bff',
  },
  guidelineItem: {
    fontSize: 16,
    marginBottom: 5,
    color: '#666',
  },
});

export default WCAGGuidelines;
```
{% endraw %}


---

## 🛠️ **Implementation Strategies**

### **Accessibility-First Development**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

// Accessibility-first component
const AccessibleButton = ({ 
  title, 
  onPress, 
  accessibilityLabel, 
  accessibilityHint,
  disabled = false,
  variant = 'primary' 
}) => {
  const getAccessibilityState = () => ({
    disabled,
    selected: false,
    checked: false
  });

  const getButtonStyle = () => {
    const baseStyle = [styles.button];
    
    if (variant === 'secondary') {
      baseStyle.push(styles.secondaryButton);
    }
    
    if (disabled) {
      baseStyle.push(styles.disabledButton);
    }
    
    return baseStyle;
  };

  const getTextStyle = () => {
    const baseStyle = [styles.buttonText];
    
    if (variant === 'secondary') {
      baseStyle.push(styles.secondaryButtonText);
    }
    
    if (disabled) {
      baseStyle.push(styles.disabledButtonText);
    }
    
    return baseStyle;
  };

  return (
    <TouchableOpacity
      style={getButtonStyle()}
      onPress={onPress}
      disabled={disabled}
      accessible={true}
      accessibilityRole="button"
      accessibilityLabel={accessibilityLabel || title}
      accessibilityHint={accessibilityHint}
      accessibilityState={getAccessibilityState()}
      accessibilityActions={[
        { name: 'activate', label: 'Activate button' }
      ]}
      onAccessibilityAction={(event) => {
        if (event.nativeEvent.actionName === 'activate') {
          onPress();
        }
}}
    >
      <Text style={getTextStyle()}>{title}</Text>
    </TouchableOpacity>
  );
};

// Accessible form component
const AccessibleForm = ({ children, onSubmit, title }) => {
  return (
    <View 
      style={styles.form}
      accessible={true}
      accessibilityRole="form"
      accessibilityLabel={title}
    >
      <Text 
        style={styles.formTitle}
        accessible={true}
        accessibilityRole="header"
        accessibilityLevel={2}
      >
        {title}
      </Text>
      {children}
    </View>
  );
};

// Accessible input component
const AccessibleInput = ({ 
  label, 
  value, 
  onChangeText, 
  placeholder,
  error,
  required = false,
  ...props 
}) => {
  const getAccessibilityLabel = () => {
    let labelText = label;
    if (required) {
      labelText += ' (required)';
    }
    if (error) {
      labelText += `, Error: ${error}`;
    }
    return labelText;
  };

  const getAccessibilityState = () => ({
    disabled: props.editable === false,
    selected: false,
    checked: false
  });

  return (
    <View style={styles.inputContainer}>
      <Text 
        style={styles.label}
        accessible={true}
        accessibilityRole="text"
      >
        {label}
        {required && <Text style={styles.required}> *</Text>}
      </Text>
      
      <TextInput
        style={[
          styles.input,
          error && styles.errorInput
        ]}
        value={value}
        onChangeText={onChangeText}
        placeholder={placeholder}
        accessible={true}
        accessibilityRole="text"
        accessibilityLabel={getAccessibilityLabel()}
        accessibilityHint={placeholder}
        accessibilityState={getAccessibilityState()}
        {...props}
      />
      
      {error && (
        <Text 
          style={styles.errorText}
          accessible={true}
          accessibilityRole="text"
          accessibilityLiveRegion="polite"
        >
          {error}
        </Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  button: {
    backgroundColor: '#007bff',
    padding: 15,
    borderRadius: 5,
    alignItems: 'center',
    marginBottom: 10,
  },
  secondaryButton: {
    backgroundColor: '#6c757d',
  },
  disabledButton: {
    backgroundColor: '#e9ecef',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  secondaryButtonText: {
    color: '#fff',
  },
  disabledButtonText: {
    color: '#6c757d',
  },
  form: {
    padding: 20,
    backgroundColor: '#fff',
  },
  formTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
  inputContainer: {
    marginBottom: 15,
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 5,
    color: '#333',
  },
  required: {
    color: '#dc3545',
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 5,
    padding: 10,
    fontSize: 16,
    backgroundColor: '#fff',
  },
  errorInput: {
    borderColor: '#dc3545',
  },
  errorText: {
    color: '#dc3545',
    fontSize: 14,
    marginTop: 5,
  },
});

export { AccessibleButton, AccessibleForm, AccessibleInput };
```
{% endraw %}


---

## ⚡ **Performance Considerations**

### **Accessibility Performance**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React, { useMemo, useCallback } from 'react';
import { View, Text, StyleSheet } from 'react-native';

// Optimized accessible list
const OptimizedAccessibleList = ({ items, onItemPress }) => {
  // Memoize accessibility props to prevent unnecessary re-renders
  const getItemAccessibilityProps = useCallback((item, index) => ({
    accessible: true,
    accessibilityRole: 'button',
    accessibilityLabel: item.title,
    accessibilityHint: `Item ${index + 1} of ${items.length}`,
    accessibilityState: { 
      selected: false,
      disabled: false 
    }
  }), [items.length]);

  // Memoize rendered items
  const renderedItems = useMemo(() => 
    items.map((item, index) => (
      <TouchableOpacity
        key={item.id}
        style={styles.listItem}
        onPress={() => onItemPress(item)}
        {...getItemAccessibilityProps(item, index)}
      >
        <Text style={styles.itemTitle}>{item.title}</Text>
        <Text style={styles.itemDescription}>{item.description}</Text>
      </TouchableOpacity>
    )), [items, onItemPress, getItemAccessibilityProps]
  );

  return (
    <View 
      style={styles.list}
      accessible={true}
      accessibilityRole="list"
      accessibilityLabel={`List with ${items.length} items`}
    >
      {renderedItems}
    </View>
  );
};

// Performance monitoring for accessibility
const AccessibilityPerformanceMonitor = () => {
  const [metrics, setMetrics] = useState({
    renderTime: 0,
    accessibilityAnnouncements: 0,
    focusChanges: 0
  });

  const measureAccessibilityPerformance = useCallback(() => {
    const startTime = performance.now();
    
    // Simulate accessibility operations
    setTimeout(() => {
      const endTime = performance.now();
      setMetrics(prev => ({
        ...prev,
        renderTime: endTime - startTime
      }));
    }, 0);
  }, []);

  return {
    metrics,
    measureAccessibilityPerformance
  };
};

const styles = StyleSheet.create({
  list: {
    flex: 1,
  },
  listItem: {
    padding: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#e9ecef',
    backgroundColor: '#fff',
  },
  itemTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginBottom: 5,
  },
  itemDescription: {
    fontSize: 14,
    color: '#666',
  },
});

export { OptimizedAccessibleList, AccessibilityPerformanceMonitor };
```
{% endraw %}


---

## 🚫 **Common Pitfalls**

### **Accessibility Anti-Patterns**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

// ❌ BAD: Missing accessibility props
const BadButton = ({ title, onPress }) => (
  <TouchableOpacity onPress={onPress}>
    <Text>{title}</Text>
  </TouchableOpacity>
);

// ✅ GOOD: Proper accessibility props
const GoodButton = ({ title, onPress }) => (
  <TouchableOpacity
    onPress={onPress}
    accessible={true}
    accessibilityRole="button"
    accessibilityLabel={title}
  >
    <Text>{title}</Text>
  </TouchableOpacity>
);

// ❌ BAD: Inaccessible text
const BadText = () => (
  <Text accessible={false}>
    Important information
  </Text>
);

// ✅ GOOD: Accessible text
const GoodText = () => (
  <Text accessible={true} accessibilityRole="text">
    Important information
  </Text>
);

// ❌ BAD: Missing error announcements
const BadForm = () => {
  const [error, setError] = useState('');
  
  return (
    <View>
      <TextInput />
      {error && <Text>{error}</Text>}
    </View>
  );
};

// ✅ GOOD: Proper error announcements
const GoodForm = () => {
  const [error, setError] = useState('');
  
  return (
    <View>
      <TextInput />
      {error && (
        <Text 
          accessible={true}
          accessibilityRole="text"
          accessibilityLiveRegion="polite"
        >
          {error}
        </Text>
      )}
    </View>
  );
};

export { BadButton, GoodButton, BadText, GoodText, BadForm, GoodForm };
```
{% endraw %}


---

## 🎯 **Best Practices**

### **1. Development**
- Start with accessibility in mind
- Use semantic components
- Test early and often
- Follow WCAG guidelines

### **2. Testing**
- Test with real screen readers
- Validate keyboard navigation
- Check color contrast
- Test with different users

### **3. Maintenance**
- Regular accessibility audits
- Keep up with guidelines
- Monitor performance
- Collect user feedback

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What are the key accessibility best practices?**
2. **How do you ensure WCAG compliance?**
3. **What are common accessibility pitfalls?**

### **Advanced Questions**
1. **How would you implement accessibility-first development?**
2. **Explain accessibility performance considerations.**
3. **How do you handle accessibility in complex UIs?**

### **Practical Questions**
1. **Implement an accessible form component.**
2. **Create accessibility testing guidelines.**
3. **Set up accessibility monitoring.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Accessibility-Testing.md" class="nav-link prev">⬅️ Previous: Accessibility Testing</a>
    <a href="../13-Architecture-Scaling/01-Clean-Architecture.md" class="nav-link next">Next: Clean Architecture ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
