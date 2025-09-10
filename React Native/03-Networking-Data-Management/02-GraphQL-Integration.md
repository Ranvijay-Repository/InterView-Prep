# 📊 **GraphQL Integration**

> **Master GraphQL integration in React Native using Apollo Client, URQL, and other GraphQL libraries**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Introduction](#introduction)
- [Apollo Client Setup](#apollo-client-setup)
- [Queries](#queries)
- [Mutations](#mutations)
- [Subscriptions](#subscriptions)
- [Caching](#caching)
- [Error Handling](#error-handling)
- [Common Patterns](#common-patterns)
- [Interview Questions](#interview-questions)
- [Best Practices](#best-practices)

---

## 🎯 **Introduction**

GraphQL provides a more efficient and flexible alternative to REST APIs. React Native applications can benefit from GraphQL's ability to fetch exactly the data needed, reducing over-fetching and improving performance.

### **GraphQL Overview**


```
┌─────────────────────────────────────┐
│        GraphQL System               │
│  ┌─────────────────────────────────┐│
│  │        Operations               ││
│  │  - Queries (read data)          ││
│  │  - Mutations (modify data)      ││
│  │  - Subscriptions (real-time)    ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Client Libraries         ││
│  │  - Apollo Client                ││
│  │  - URQL                         ││
│  │  - Relay                        ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Features                 ││
│  │  - Type safety                  ││
│  │  - Caching                      ││
│  │  - Real-time updates            ││
│  │  - Optimistic updates           ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```


---

## 🚀 **Apollo Client Setup**

### **Basic Apollo Client Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// apollo-client.js
import { ApolloClient, InMemoryCache, createHttpLink } from '@apollo/client';
import { setContext } from '@apollo/client/link/context';
import { onError } from '@apollo/client/link/error';
import AsyncStorage from '@react-native-async-storage/async-storage';

// HTTP Link
const httpLink = createHttpLink({
  uri: 'https://api.example.com/graphql',
});

// Auth Link
const authLink = setContext(async (_, { headers }) => {
  const token = await AsyncStorage.getItem('authToken');
  
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : '',
    },
  };
});

// Error Link
const errorLink = onError(({ graphQLErrors, networkError, operation, forward }) => {
  if (graphQLErrors) {
    graphQLErrors.forEach(({ message, locations, path }) => {
      console.error(
        `GraphQL error: Message: ${message}, Location: ${locations}, Path: ${path}`
      );
    });
  }
  
  if (networkError) {
    console.error(`Network error: ${networkError}`);
  }
});

// Apollo Client
const client = new ApolloClient({
  link: errorLink.concat(authLink.concat(httpLink)),
  cache: new InMemoryCache({
    typePolicies: {
      Query: {
        fields: {
          posts: {
            merge(existing = [], incoming) {
              return [...existing, ...incoming];
            },
          },
        },
      },
    },
  }),
  defaultOptions: {
    watchQuery: {
      errorPolicy: 'all',
    },
    query: {
      errorPolicy: 'all',
    },
  },
});

export default client;
```


### **App Setup with Apollo Provider**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// App.js
import React from 'react';
import { ApolloProvider } from '@apollo/client';
import { NavigationContainer } from '@react-navigation/native';
import client from './apollo-client';
import AppNavigator from './navigation/AppNavigator';

const App = () => {
  return (
    <ApolloProvider client={client}>
      <NavigationContainer>
        <AppNavigator />
      </NavigationContainer>
    </ApolloProvider>
  );
};

export default App;
```


---

## 🔍 **Queries**

### **Basic Query Usage**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
import React from 'react';
import { View, Text, StyleSheet, FlatList, ActivityIndicator } from 'react-native';
import { useQuery, gql } from '@apollo/client';

// GraphQL Query
const GET_POSTS = gql`
  query GetPosts($limit: Int, $offset: Int) {
    posts(limit: $limit, offset: $offset) {
      id
      title
      body
      author {
        id
        name
        email
      }
      createdAt
    }
  }
`;

const PostsScreen = () => {
  const { data, loading, error, fetchMore, refetch } = useQuery(GET_POSTS, {
    variables: {
      limit: 10,
      offset: 0,
    },
    notifyOnNetworkStatusChange: true,
  });
  
  const handleLoadMore = () => {
    if (data?.posts && data.posts.length > 0) {
      fetchMore({
        variables: {
          offset: data.posts.length,
        },
        updateQuery: (prev, { fetchMoreResult }) => {
          if (!fetchMoreResult) return prev;
          return {
            posts: [...prev.posts, ...fetchMoreResult.posts],
          };
        },
      });
    }
  };
  
  const handleRefresh = () => {
    refetch();
  };
  
  if (loading && !data) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#007AFF" />
        <Text style={styles.loadingText}>Loading posts...</Text>
      </View>
    );
  }
  
  if (error) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>Error: {error.message}</Text>
      </View>
    );
  }
  
  const renderPost = ({ item }) => (
    <View style={styles.postContainer}>
      <Text style={styles.postTitle}>{item.title}</Text>
      <Text style={styles.postBody}>{item.body}</Text>
      <View style={styles.postMeta}>
        <Text style={styles.authorText}>By: {item.author.name}</Text>
        <Text style={styles.dateText}>
          {new Date(item.createdAt).toLocaleDateString()}
        </Text>
      </View>
    </View>
  );
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Posts</Text>
      <FlatList
        data={data?.posts || []}
        renderItem={renderPost}
        keyExtractor={(item) => item.id.toString()}
        onEndReached={handleLoadMore}
        onEndReachedThreshold={0.5}
        onRefresh={handleRefresh}
        refreshing={loading}
        ListFooterComponent={
          loading ? (
            <View style={styles.footerLoading}>
              <ActivityIndicator size="small" color="#007AFF" />
            </View>
          ) : null
        }
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
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: 10,
    fontSize: 16,
    color: '#666',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  errorText: {
    fontSize: 16,
    color: '#FF3B30',
    textAlign: 'center',
  },
  postContainer: {
    backgroundColor: 'white',
    margin: 10,
    padding: 15,
    borderRadius: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  postTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#333',
  },
  postBody: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
    marginBottom: 10,
  },
  postMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  authorText: {
    fontSize: 12,
    color: '#007AFF',
    fontWeight: '600',
  },
  dateText: {
    fontSize: 12,
    color: '#999',
  },
  footerLoading: {
    padding: 20,
    alignItems: 'center',
  },
});

export default PostsScreen;
```


---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Networking-Fundamentals.md" class="nav-link prev">⬅️ Previous: Networking Fundamentals</a>
    <a href="./03-Offline-First-Strategies.md" class="nav-link next">Next: Offline-First Strategies ➡️</a>
</div>

---


*Last updated: December 2024*
