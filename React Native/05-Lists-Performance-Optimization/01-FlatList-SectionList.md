# 📋 **FlatList & SectionList**

> **Master FlatList and SectionList components for efficient list rendering and performance optimization in React Native**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [FlatList Fundamentals](#flatlist-fundamentals)
- [SectionList Basics](#sectionlist-basics)
- [Performance Optimization](#performance-optimization)
- [Advanced Features](#advanced-features)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

FlatList and SectionList are the primary components for rendering large lists in React Native. They provide virtualization, performance optimizations, and built-in features for common list use cases.

### **List Components Overview**

```
┌─────────────────────────────────────┐
│        List Components              │
│  ┌─────────────────────────────────┐│
│  │        FlatList                 ││
│  │  - Virtual scrolling            ││
│  │  - Performance optimization     ││
│  │  - Pull to refresh              ││
│  │  - Infinite scrolling           ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        SectionList              ││
│  │  - Grouped data                 ││
│  │  - Section headers              ││
│  │  - Section footers              ││
│  │  - Sticky headers               ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Performance Features     ││
│  │  - getItemLayout               ││
│  │  - keyExtractor                ││
│  │  - removeClippedSubviews       ││
│  │  - maxToRenderPerBatch         ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

## 📋 **FlatList Fundamentals**

### **Basic FlatList Example**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
import React, { useState, useCallback } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, FlatList, ActivityIndicator, RefreshControl } from 'react-native';

const FlatListExample = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [page, setPage] = useState(1);
  
  // Generate sample data
  const generateData = (pageNum = 1) => {
    const items = [];
    for (let i = 0; i < 20; i++) {
      items.push({
        id: (pageNum - 1) * 20 + i + 1,
        title: `Item ${(pageNum - 1) * 20 + i + 1}`,
        description: `This is the description for item ${(pageNum - 1) * 20 + i + 1}`,
        category: ['Work', 'Personal', 'Shopping', 'Health'][Math.floor(Math.random() * 4)],
        priority: ['High', 'Medium', 'Low'][Math.floor(Math.random() * 3)],
        completed: Math.random() > 0.5,
      });
    }
    return items;
  };
  
  // Load initial data
  React.useEffect(() => {
    loadData();
  }, []);
  
  const loadData = async (pageNum = 1) => {
    setLoading(true);
    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      const newData = generateData(pageNum);
      
      if (pageNum === 1) {
        setData(newData);
      } else {
        setData(prev => [...prev, ...newData]);
      }
      setPage(pageNum);
    } catch (error) {
      console.error('Error loading data:', error);
    } finally {
      setLoading(false);
    }
  };
  
  const handleRefresh = useCallback(async () => {
    setRefreshing(true);
    await loadData(1);
    setRefreshing(false);
  }, []);
  
  const handleLoadMore = useCallback(() => {
    if (!loading) {
      loadData(page + 1);
    }
  }, [loading, page]);
  
  const toggleItem = useCallback((id) => {
    setData(prev => prev.map(item =>
      item.id === id ? { ...item, completed: !item.completed } : item
    ));
  }, []);
  
  const deleteItem = useCallback((id) => {
    setData(prev => prev.filter(item => item.id !== id));
  }, []);
  
  const renderItem = useCallback(({ item }) => (
    <View style={[styles.itemContainer, item.completed && styles.completedItem]}>
      <View style={styles.itemContent}>
        <Text style={[styles.itemTitle, item.completed && styles.completedText]}>
          {item.title}
        </Text>
        <Text style={styles.itemDescription}>{item.description}</Text>
        <View style={styles.itemMeta}>
          <Text style={[styles.category, { backgroundColor: getCategoryColor(item.category) }]}>
            {item.category}
          </Text>
          <Text style={[styles.priority, { color: getPriorityColor(item.priority) }]}>
            {item.priority}
          </Text>
        </View>
      </View>
      <View style={styles.itemActions}>
        <TouchableOpacity
          style={[styles.actionButton, styles.toggleButton]}
          onPress={() => toggleItem(item.id)}
        >
          <Text style={styles.actionButtonText}>
            {item.completed ? '✓' : '○'}
          </Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={[styles.actionButton, styles.deleteButton]}
          onPress={() => deleteItem(item.id)}
        >
          <Text style={styles.actionButtonText}>×</Text>
        </TouchableOpacity>
      </View>
    </View>
  ), [toggleItem, deleteItem]);
  
  const renderFooter = () => {
    if (!loading) return null;
    return (
      <View style={styles.footerLoader}>
        <ActivityIndicator size="small" color="#007AFF" />
        <Text style={styles.footerText}>Loading more items...</Text>
      </View>
    );
  };
  
  const renderEmpty = () => (
    <View style={styles.emptyContainer}>
      <Text style={styles.emptyText}>No items found</Text>
      <TouchableOpacity style={styles.refreshButton} onPress={handleRefresh}>
        <Text style={styles.refreshButtonText}>Refresh</Text>
      </TouchableOpacity>
    </View>
  );
  
  const getCategoryColor = (category) => {
    const colors = {
      Work: '#FF6B6B',
      Personal: '#4ECDC4',
      Shopping: '#45B7D1',
      Health: '#96CEB4',
    };
    return colors[category] || '#CCCCCC';
  };
  
  const getPriorityColor = (priority) => {
    const colors = {
      High: '#FF3B30',
      Medium: '#FF9500',
      Low: '#34C759',
    };
    return colors[priority] || '#666';
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>FlatList Example</Text>
      
      <FlatList
        data={data}
        renderItem={renderItem}
        keyExtractor={(item) => item.id.toString()}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={handleRefresh}
            colors={['#007AFF']}
            tintColor="#007AFF"
          />
        }
        onEndReached={handleLoadMore}
        onEndReachedThreshold={0.5}
        ListFooterComponent={renderFooter}
        ListEmptyComponent={renderEmpty}
        removeClippedSubviews={true}
        maxToRenderPerBatch={10}
        windowSize={10}
        initialNumToRender={10}
        getItemLayout={(data, index) => ({
          length: 100,
          offset: 100 * index,
          index,
        })}
        style={styles.list}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    padding: 20,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  list: {
    flex: 1,
  },
  itemContainer: {
    backgroundColor: 'white',
    marginHorizontal: 10,
    marginVertical: 5,
    borderRadius: 10,
    padding: 15,
    flexDirection: 'row',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  completedItem: {
    backgroundColor: '#f0f0f0',
    opacity: 0.7,
  },
  itemContent: {
    flex: 1,
  },
  itemTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  completedText: {
    textDecorationLine: 'line-through',
    color: '#666',
  },
  itemDescription: {
    fontSize: 14,
    color: '#666',
    marginBottom: 10,
  },
  itemMeta: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  category: {
    fontSize: 12,
    color: 'white',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    marginRight: 10,
  },
  priority: {
    fontSize: 12,
    fontWeight: '600',
  },
  itemActions: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  actionButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
    marginLeft: 10,
  },
  toggleButton: {
    backgroundColor: '#34C759',
  },
  deleteButton: {
    backgroundColor: '#FF3B30',
  },
  actionButtonText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
  },
  footerLoader: {
    padding: 20,
    alignItems: 'center',
  },
  footerText: {
    marginTop: 10,
    color: '#666',
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  emptyText: {
    fontSize: 18,
    color: '#666',
    marginBottom: 20,
  },
  refreshButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 8,
  },
  refreshButtonText: {
    color: 'white',
    fontWeight: 'bold',
  },
});

export default FlatListExample;
```

---

## 🔗 **Navigation**

<div class="nav-container">
    <a href="../04-State-Management/04-State-Persistence-Hydration.md" class="nav-link prev">⬅️ Previous: State Persistence & Hydration</a>
    <a href="./02-Virtualization-Optimization.md" class="nav-link next">Next: Virtualization & Optimization ➡️</a>
</div>

---

## 📋 Copy Code Functionality

<script src="../../common-scripts.js"></script>

---

*Last updated: December 2024*
