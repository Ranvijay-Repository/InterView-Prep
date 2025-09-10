# 🔹 ES2023+ Features

> **Comprehensive coverage of ES2023+ JavaScript features: Array grouping methods, Hashbang syntax, and Symbol as WeakMap keys**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [ES2023 Overview](#es2023-overview)
- [Array Grouping Methods](#array-grouping-methods)
- [Hashbang Syntax](#hashbang-syntax)
- [Symbol as WeakMap Keys](#symbol-as-weakmap-keys)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 ES2023 Overview

**ES2023** (ECMAScript 2023) introduced several powerful features that enhance JavaScript's array manipulation, script execution, and data structure capabilities.

### Why ES2023+ Features Matter:
- **Better Data Organization**: Array grouping methods for cleaner data processing
- **Script Execution**: Hashbang syntax for better script identification
- **Advanced Data Structures**: Symbol as WeakMap keys for better memory management
- **Performance**: More efficient array operations and data handling
- **Developer Experience**: Cleaner and more intuitive code

---

## 📊 Array Grouping Methods

**Array Grouping Methods** provide built-in ways to group array elements based on criteria, making data organization much cleaner and more efficient.

### Why Array Grouping Methods Matter:
- **Data Organization**: Group related data efficiently
- **Performance**: Built-in methods are more performant than manual grouping
- **Readability**: Cleaner code compared to manual reduce operations
- **Standardization**: Consistent grouping behavior across applications

### ASCII Diagram: Array Grouping Flow

{% raw %}
```
ARRAY GROUPING FLOW
┌─────────────────────────────────┐
│        INPUT ARRAY              │
│  ┌─────────────────────────────┐ │
│  │ [item1, item2, item3, ...] │ │
│  │                             │ │
│  │ Grouping Function           │ │
│  │ (item) => groupKey          │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  GROUPING     │
        │  Process      │
        │  Each Item    │
        │  By Key       │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  GROUPED      │
        │  RESULT       │
        │  Map/Object   │
        │  By Keys      │
        └───────────────┘
```
{% endraw %}


### Available Methods:
1. **Array.prototype.groupBy()**: Groups elements by a key function
2. **Array.prototype.groupByToMap()**: Groups elements into a Map
3. **Array.prototype.toSorted()**: Returns a new sorted array
4. **Array.prototype.toReversed()**: Returns a new reversed array
5. **Array.prototype.with()**: Returns a new array with a modified element

---

## 🚀 Hashbang Syntax

**Hashbang Syntax** allows you to specify the interpreter for a script file, making it easier to run JavaScript files directly from the command line.

### Why Hashbang Syntax Matters:
- **Direct Execution**: Run JavaScript files as executables
- **Cross-Platform**: Consistent behavior across different operating systems
- **Script Identification**: Clear indication of how to execute the file
- **Automation**: Better integration with build tools and scripts

### ASCII Diagram: Hashbang Execution Flow

{% raw %}
```
HASHBANG EXECUTION FLOW
┌─────────────────────────────────┐
│        SCRIPT FILE              │
│  ┌─────────────────────────────┐ │
│  │ #!/usr/bin/env node         │ │
│  │                             │ │
│  │ console.log('Hello World'); │ │
│  │ // JavaScript code...       │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  EXECUTION    │
        │  System       │
        │  Reads        │
        │  Hashbang     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  INTERPRETER  │
        │  Launched     │
        │  With Script  │
        │  As Argument  │
        └───────────────┘
```
{% endraw %}


### Use Cases:
- **CLI Tools**: Create executable JavaScript command-line tools
- **Build Scripts**: Run build processes directly
- **Automation**: Execute scripts in CI/CD pipelines
- **Development**: Quick script testing and execution

---

## 🔑 Symbol as WeakMap Keys

**Symbol as WeakMap Keys** allows you to use Symbols as keys in WeakMaps, providing better memory management and preventing memory leaks.

### Why Symbol as WeakMap Keys Matters:
- **Memory Management**: Symbols can be garbage collected when not referenced
- **Unique Keys**: Symbols provide guaranteed uniqueness
- **Weak References**: Keys don't prevent garbage collection
- **Better Performance**: More efficient than string keys in some scenarios

### ASCII Diagram: Symbol WeakMap Structure

{% raw %}
```
SYMBOL WEAKMAP STRUCTURE
┌─────────────────────────────────┐
│        WEAKMAP INSTANCE         │
│  ┌─────────────────────────────┐ │
│  │ const weakMap = new WeakMap()│ │
│  │                             │ │
│  │ Symbol('key1') → value1     │ │
│  │ Symbol('key2') → value2     │ │
│  │ Symbol('key3') → value3     │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  SYMBOL       │
        │  KEYS         │
        │  Unique       │
        │  Identifiers  │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  WEAK         │
        │  REFERENCES   │
        │  Garbage      │
        │  Collection   │
        └───────────────┘
```
{% endraw %}


### Benefits:
- **Memory Safety**: Keys don't prevent garbage collection
- **Unique Identification**: Symbols are guaranteed to be unique
- **Performance**: Better performance than string keys in WeakMaps
- **Cleanup**: Automatic cleanup when symbols are no longer referenced

---

## 💻 Detailed Examples

### Example 1: Array Grouping Methods in Real Applications
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// E-commerce data processing with array grouping methods
class EcommerceAnalytics {
    constructor() {
        this.orders = [
            { id: 1, customer: 'John', product: 'Laptop', category: 'Electronics', amount: 1200, date: '2024-01-15' },
            { id: 2, customer: 'Jane', product: 'Book', category: 'Books', amount: 25, date: '2024-01-15' },
            { id: 3, customer: 'John', product: 'Mouse', category: 'Electronics', amount: 50, date: '2024-01-16' },
            { id: 4, customer: 'Bob', product: 'Shirt', category: 'Clothing', amount: 75, date: '2024-01-16' },
            { id: 5, customer: 'Jane', product: 'Phone', category: 'Electronics', amount: 800, date: '2024-01-17' },
            { id: 6, customer: 'Bob', product: 'Pants', category: 'Clothing', amount: 60, date: '2024-01-17' },
            { id: 7, customer: 'Alice', product: 'Tablet', category: 'Electronics', amount: 400, date: '2024-01-18' },
            { id: 8, customer: 'Alice', product: 'Novel', category: 'Books', amount: 30, date: '2024-01-18' }
        ];
    }
    
    // Group orders by category using groupBy()
    getOrdersByCategory() {
        return this.orders.groupBy(order => order.category);
    }
    
    // Group orders by customer using groupBy()
    getOrdersByCustomer() {
        return this.orders.groupBy(order => order.customer);
    }
    
    // Group orders by date using groupBy()
    getOrdersByDate() {
        return this.orders.groupBy(order => order.date);
    }
    
    // Group orders by category with Map using groupByToMap()
    getOrdersByCategoryMap() {
        return this.orders.groupByToMap(order => order.category);
    }
    
    // Group orders by price range
    getOrdersByPriceRange() {
        return this.orders.groupBy(order => {
            if (order.amount < 100) return 'Budget';
            if (order.amount < 500) return 'Mid-range';
            return 'Premium';
        });
    }
    
    // Group orders by customer and category
    getOrdersByCustomerAndCategory() {
        const customerGroups = this.orders.groupBy(order => order.customer);
        
        const result = {};
        for (const [customer, orders] of Object.entries(customerGroups)) {
            result[customer] = orders.groupBy(order => order.category);
        }
        
        return result;
    }
    
    // Get sorted orders by amount (non-mutating)
    getSortedOrdersByAmount() {
        return this.orders.toSorted((a, b) => b.amount - a.amount);
    }
    
    // Get reversed orders (non-mutating)
    getReversedOrders() {
        return this.orders.toReversed();
    }
    
    // Update order amount (non-mutating)
    updateOrderAmount(orderId, newAmount) {
        const orderIndex = this.orders.findIndex(order => order.id === orderId);
        if (orderIndex === -1) return null;
        
        return this.orders.with(orderIndex, {
            ...this.orders[orderIndex],
            amount: newAmount
        });
    }
    
    // Get analytics summary
    getAnalyticsSummary() {
        const categoryGroups = this.getOrdersByCategory();
        const customerGroups = this.getOrdersByCustomer();
        
        const summary = {
            totalOrders: this.orders.length,
            totalRevenue: this.orders.reduce((sum, order) => sum + order.amount, 0),
            categories: {},
            topCustomers: [],
            averageOrderValue: 0
        };
        
        // Calculate category statistics
        for (const [category, orders] of Object.entries(categoryGroups)) {
            summary.categories[category] = {
                count: orders.length,
                revenue: orders.reduce((sum, order) => sum + order.amount, 0),
                average: orders.reduce((sum, order) => sum + order.amount, 0) / orders.length
            };
        }
        
        // Calculate customer statistics
        for (const [customer, orders] of Object.entries(customerGroups)) {
            const customerRevenue = orders.reduce((sum, order) => sum + order.amount, 0);
            summary.topCustomers.push({
                customer,
                orderCount: orders.length,
                totalRevenue: customerRevenue,
                averageOrder: customerRevenue / orders.length
            });
        }
        
        // Sort customers by revenue
        summary.topCustomers.sort((a, b) => b.totalRevenue - a.totalRevenue);
        
        // Calculate average order value
        summary.averageOrderValue = summary.totalRevenue / summary.totalOrders;
        
        return summary;
    }
}

// Usage
const analytics = new EcommerceAnalytics();

// Group orders by category
const categoryGroups = analytics.getOrdersByCategory();
console.log('Orders by category:', categoryGroups);

// Group orders by customer
const customerGroups = analytics.getOrdersByCustomer();
console.log('Orders by customer:', customerGroups);

// Group orders by price range
const priceRangeGroups = analytics.getOrdersByPriceRange();
console.log('Orders by price range:', priceRangeGroups);

// Get sorted orders
const sortedOrders = analytics.getSortedOrdersByAmount();
console.log('Top 3 orders by amount:', sortedOrders.slice(0, 3));

// Update an order
const updatedOrders = analytics.updateOrderAmount(1, 1300);
console.log('Updated orders:', updatedOrders);

// Get analytics summary
const summary = analytics.getAnalyticsSummary();
console.log('Analytics summary:', summary);

// Example: Process user data with grouping
const users = [
    { id: 1, name: 'John', age: 25, city: 'New York', role: 'developer' },
    { id: 2, name: 'Jane', age: 30, city: 'San Francisco', role: 'designer' },
    { id: 3, name: 'Bob', age: 25, city: 'New York', role: 'developer' },
    { id: 4, name: 'Alice', age: 35, city: 'Boston', role: 'manager' },
    { id: 5, name: 'Charlie', age: 28, city: 'San Francisco', role: 'developer' }
];

// Group by city
const usersByCity = users.groupBy(user => user.city);
console.log('Users by city:', usersByCity);

// Group by role
const usersByRole = users.groupBy(user => user.role);
console.log('Users by role:', usersByRole);

// Group by age range
const usersByAgeRange = users.groupBy(user => {
    if (user.age < 25) return 'Young';
    if (user.age < 35) return 'Mid-career';
    return 'Senior';
});
console.log('Users by age range:', usersByAgeRange);
</code></pre>
</div>

### Example 2: Hashbang Syntax for CLI Tools
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>#!/usr/bin/env node

// CLI Tool: File Processor
// Usage: ./file-processor.js [options] <files>

import { readFileSync, writeFileSync, existsSync } from 'fs';
import { join, extname, basename } from 'path';

class FileProcessor {
    constructor() {
        this.options = this.parseOptions();
        this.files = this.options._;
    }
    
    parseOptions() {
        const args = process.argv.slice(2);
        const options = {
            output: null,
            format: 'json',
            verbose: false,
            help: false,
            _: []
        };
        
        for (let i = 0; i < args.length; i++) {
            const arg = args[i];
            
            switch (arg) {
                case '-o':
                case '--output':
                    options.output = args[++i];
                    break;
                case '-f':
                case '--format':
                    options.format = args[++i];
                    break;
                case '-v':
                case '--verbose':
                    options.verbose = true;
                    break;
                case '-h':
                case '--help':
                    options.help = true;
                    break;
                default:
                    if (!arg.startsWith('-')) {
                        options._.push(arg);
                    }
            }
        }
        
        return options;
    }
    
    showHelp() {
        console.log(`
File Processor - Process files with various options

Usage: ${basename(process.argv[1])} [options] <files>

Options:
  -o, --output <file>    Output file path
  -f, --format <format>  Output format (json, csv, txt)
  -v, --verbose          Enable verbose output
  -h, --help             Show this help message

Examples:
  ${basename(process.argv[1])} file1.txt file2.txt
  ${basename(process.argv[1])} -o output.json -f json *.txt
  ${basename(process.argv[1])} --verbose --format csv data.txt
        `);
    }
    
    processFile(filePath) {
        try {
            if (!existsSync(filePath)) {
                throw new Error(`File not found: ${filePath}`);
            }
            
            const content = readFileSync(filePath, 'utf8');
            const stats = {
                path: filePath,
                size: content.length,
                lines: content.split('\n').length,
                words: content.split(/\s+/).filter(word => word.length > 0).length,
                extension: extname(filePath),
                processed: new Date().toISOString()
            };
            
            if (this.options.verbose) {
                console.log(`Processed: ${filePath}`);
            }
            
            return stats;
        } catch (error) {
            console.error(`Error processing ${filePath}:`, error.message);
            return null;
        }
    }
    
    processFiles() {
        if (this.options.help) {
            this.showHelp();
            return;
        }
        
        if (this.files.length === 0) {
            console.error('No files specified. Use -h for help.');
            process.exit(1);
        }
        
        const results = this.files
            .map(file => this.processFile(file))
            .filter(result => result !== null);
        
        if (results.length === 0) {
            console.error('No files were processed successfully.');
            process.exit(1);
        }
        
        const output = this.formatOutput(results);
        
        if (this.options.output) {
            try {
                writeFileSync(this.options.output, output);
                console.log(`Results written to: ${this.options.output}`);
            } catch (error) {
                console.error(`Error writing output:`, error.message);
                process.exit(1);
            }
        } else {
            console.log(output);
        }
    }
    
    formatOutput(results) {
        switch (this.options.format) {
            case 'json':
                return JSON.stringify(results, null, 2);
            case 'csv':
                const headers = Object.keys(results[0]).join(',');
                const rows = results.map(r => Object.values(r).join(','));
                return [headers, ...rows].join('\n');
            case 'txt':
                return results.map(r => 
                    Object.entries(r)
                        .map(([key, value]) => `${key}: ${value}`)
                        .join('\n')
                ).join('\n\n');
            default:
                return JSON.stringify(results, null, 2);
        }
    }
}

// Run the CLI tool
const processor = new FileProcessor();
processor.processFiles();

// Example build script with hashbang
#!/usr/bin/env node

// build.js - Build script for project
import { execSync } from 'child_process';
import { existsSync, rmSync } from 'fs';

console.log('🚀 Starting build process...');

try {
    // Clean previous build
    if (existsSync('dist')) {
        console.log('🧹 Cleaning previous build...');
        rmSync('dist', { recursive: true });
    }
    
    // Install dependencies
    console.log('📦 Installing dependencies...');
    execSync('npm install', { stdio: 'inherit' });
    
    // Run tests
    console.log('🧪 Running tests...');
    execSync('npm test', { stdio: 'inherit' });
    
    // Build project
    console.log('🔨 Building project...');
    execSync('npm run build', { stdio: 'inherit' });
    
    // Run linting
    console.log('🔍 Running linting...');
    execSync('npm run lint', { stdio: 'inherit' });
    
    console.log('✅ Build completed successfully!');
} catch (error) {
    console.error('❌ Build failed:', error.message);
    process.exit(1);
}
</code></pre>
</div>

### Example 3: Symbol as WeakMap Keys for Advanced Data Structures
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced data structures using Symbol as WeakMap keys
class SymbolWeakMapManager {
    constructor() {
        this.weakMaps = new Map();
        this.symbolRegistry = new Map();
    }
    
    // Create a new WeakMap with Symbol keys
    createWeakMap(name) {
        const weakMap = new WeakMap();
        this.weakMaps.set(name, weakMap);
        return weakMap;
    }
    
    // Create a unique symbol for a specific purpose
    createSymbol(purpose, description) {
        const symbol = Symbol(description);
        this.symbolRegistry.set(symbol, { purpose, description, createdAt: Date.now() });
        return symbol;
    }
    
    // Store data in a WeakMap using Symbol keys
    storeData(weakMapName, symbol, data) {
        const weakMap = this.weakMaps.get(weakMapName);
        if (!weakMap) {
            throw new Error(`WeakMap '${weakMapName}' not found`);
        }
        
        weakMap.set(symbol, {
            data,
            storedAt: Date.now(),
            accessCount: 0
        });
        
        return true;
    }
    
    // Retrieve data from a WeakMap using Symbol keys
    getData(weakMapName, symbol) {
        const weakMap = this.weakMaps.get(weakMapName);
        if (!weakMap) {
            throw new Error(`WeakMap '${weakMapName}' not found`);
        }
        
        const entry = weakMap.get(symbol);
        if (entry) {
            entry.accessCount++;
            entry.lastAccessed = Date.now();
            return entry.data;
        }
        
        return null;
    }
    
    // Check if data exists in a WeakMap
    hasData(weakMapName, symbol) {
        const weakMap = this.weakMaps.get(weakMapName);
        return weakMap ? weakMap.has(symbol) : false;
    }
    
    // Get WeakMap statistics
    getWeakMapStats(weakMapName) {
        const weakMap = this.weakMaps.get(weakMapName);
        if (!weakMap) return null;
        
        let entryCount = 0;
        let totalAccessCount = 0;
        
        // Note: WeakMap doesn't have size property, so we can't get exact count
        // This is a limitation of WeakMap design
        
        return {
            name: weakMapName,
            entryCount: 'Unknown (WeakMap limitation)',
            totalAccessCount: 'Unknown (WeakMap limitation)'
        };
    }
    
    // Get symbol registry information
    getSymbolInfo(symbol) {
        return this.symbolRegistry.get(symbol);
    }
    
    // List all registered symbols
    listSymbols() {
        return Array.from(this.symbolRegistry.entries()).map(([symbol, info]) => ({
            symbol: symbol.toString(),
            purpose: info.purpose,
            description: info.description,
            createdAt: info.createdAt
        }));
    }
}

// Usage example: Event system with Symbol keys
class EventSystem {
    constructor() {
        this.manager = new SymbolWeakMapManager();
        this.eventMap = this.manager.createWeakMap('events');
        this.listenerMap = this.manager.createWeakMap('listeners');
        
        // Create symbols for different event types
        this.eventSymbols = {
            userLogin: this.manager.createSymbol('event', 'User login event'),
            userLogout: this.manager.createSymbol('event', 'User logout event'),
            dataUpdate: this.manager.createSymbol('event', 'Data update event'),
            error: this.manager.createSymbol('event', 'Error event')
        };
    }
    
    // Add event listener
    addEventListener(eventType, listener) {
        const symbol = this.eventSymbols[eventType];
        if (!symbol) {
            throw new Error(`Unknown event type: ${eventType}`);
        }
        
        const listeners = this.manager.getData('listeners', symbol) || [];
        listeners.push(listener);
        this.manager.storeData('listeners', symbol, listeners);
    }
    
    // Remove event listener
    removeEventListener(eventType, listener) {
        const symbol = this.eventSymbols[eventType];
        if (!symbol) return;
        
        const listeners = this.manager.getData('listeners', symbol) || [];
        const filteredListeners = listeners.filter(l => l !== listener);
        this.manager.storeData('listeners', symbol, filteredListeners);
    }
    
    // Emit event
    emit(eventType, data) {
        const symbol = this.eventSymbols[eventType];
        if (!symbol) return;
        
        const listeners = this.manager.getData('listeners', symbol) || [];
        listeners.forEach(listener => {
            try {
                listener(data);
            } catch (error) {
                console.error('Error in event listener:', error);
            }
        });
        
        // Store event data
        this.manager.storeData('events', symbol, {
            data,
            timestamp: Date.now(),
            listenerCount: listeners.length
        });
    }
    
    // Get event history
    getEventHistory(eventType) {
        const symbol = this.eventSymbols[eventType];
        if (!symbol) return null;
        
        return this.manager.getData('events', symbol);
    }
}

// Usage
const eventSystem = new EventSystem();

// Add event listeners
eventSystem.addEventListener('userLogin', (userData) => {
    console.log('User logged in:', userData);
});

eventSystem.addEventListener('dataUpdate', (updateData) => {
    console.log('Data updated:', updateData);
});

// Emit events
eventSystem.emit('userLogin', { userId: 123, username: 'john_doe' });
eventSystem.emit('dataUpdate', { table: 'users', recordId: 123, changes: { lastLogin: Date.now() } });

// Get event history
const loginHistory = eventSystem.getEventHistory('userLogin');
console.log('Login event history:', loginHistory);

// Example: Cache system with Symbol keys
class SymbolKeyCache {
    constructor() {
        this.manager = new SymbolWeakMapManager();
        this.cacheMap = this.manager.createWeakMap('cache');
        this.metadataMap = this.manager.createWeakMap('metadata');
    }
    
    // Create cache key for an object
    createCacheKey(object, purpose) {
        return this.manager.createSymbol(purpose, `Cache key for ${purpose}`);
    }
    
    // Store data in cache
    set(key, data, ttl = 300000) { // 5 minutes default
        const metadata = {
            storedAt: Date.now(),
            ttl,
            accessCount: 0,
            lastAccessed: Date.now()
        };
        
        this.manager.storeData('cache', key, data);
        this.manager.storeData('metadata', key, metadata);
    }
    
    // Get data from cache
    get(key) {
        const metadata = this.manager.getData('metadata', key);
        if (!metadata) return null;
        
        // Check TTL
        if (Date.now() - metadata.storedAt > metadata.ttl) {
            // Expired, remove from cache
            this.delete(key);
            return null;
        }
        
        // Update access statistics
        metadata.accessCount++;
        metadata.lastAccessed = Date.now();
        this.manager.storeData('metadata', key, metadata);
        
        return this.manager.getData('cache', key);
    }
    
    // Delete from cache
    delete(key) {
        // Note: WeakMap doesn't have delete method that works with our manager
        // In practice, you'd need to implement a different approach
        console.log('Cache entry expired or deleted');
    }
    
    // Check if key exists and is valid
    has(key) {
        const metadata = this.manager.getData('metadata', key);
        if (!metadata) return false;
        
        return Date.now() - metadata.storedAt <= metadata.ttl;
    }
}

// Usage
const cache = new SymbolKeyCache();

// Create cache keys for different objects
const userCacheKey = cache.createCacheKey({}, 'user-data');
const productCacheKey = cache.createCacheKey({}, 'product-data');

// Store data in cache
cache.set(userCacheKey, { id: 123, name: 'John Doe' }, 60000); // 1 minute TTL
cache.set(productCacheKey, { id: 456, name: 'Laptop' }, 300000); // 5 minutes TTL

// Retrieve data
const userData = cache.get(userCacheKey);
const productData = cache.get(productCacheKey);

console.log('User data from cache:', userData);
console.log('Product data from cache:', productData);
console.log('User cache valid:', cache.has(userCacheKey));
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What are the benefits of array grouping methods over manual reduce operations?
**A:** Array grouping methods provide built-in, optimized implementations that are more performant than manual reduce operations. They offer cleaner, more readable code, consistent behavior across applications, and better maintainability. The built-in methods are also optimized by JavaScript engines for better performance.

### Q2: When would you use hashbang syntax in JavaScript files?
**A:** Use hashbang syntax when you want to make JavaScript files directly executable from the command line, create CLI tools, build scripts, or automation scripts. It's particularly useful for development tools, build processes, and scripts that need to be run directly without explicitly calling the interpreter.

### Q3: What are the advantages of using Symbol as WeakMap keys?
**A:** Using Symbol as WeakMap keys provides guaranteed uniqueness, better memory management (keys can be garbage collected), and improved performance compared to string keys. It's useful for creating private data storage, implementing caches, and building advanced data structures where you need unique identifiers that don't prevent garbage collection.

### Q4: How do the new array methods like toSorted() and toReversed() differ from sort() and reverse()?
**A:** The new methods (toSorted, toReversed, with) are non-mutating - they return new arrays instead of modifying the original array. This makes them safer to use in functional programming, prevents unintended side effects, and makes code more predictable. The original methods (sort, reverse) mutate the array in place.

### Q5: What are the performance implications of using WeakMap with Symbol keys?
**A:** WeakMap with Symbol keys provides better memory management since keys don't prevent garbage collection, which can prevent memory leaks in long-running applications. However, WeakMap has limitations like no size property and no iteration methods, so it's best suited for scenarios where you need weak references and don't need to enumerate all entries.

---

## 🏋️ Practice Exercises

### Exercise 1: Build a Data Analytics Dashboard
Create a data analytics system using array grouping methods to process and visualize different types of data (sales, users, products) with various grouping criteria and export options.

### Exercise 2: Implement a CLI Tool Suite
Build a collection of CLI tools using hashbang syntax for common development tasks like file processing, data conversion, and project management.

### Exercise 3: Create an Advanced Caching System
Implement a sophisticated caching system using Symbol as WeakMap keys that supports TTL, automatic cleanup, and different caching strategies for various data types.

---

## 📚 Additional Resources

- **ES2023 Specification**: [ECMAScript 2023](https://tc39.es/ecma262/2023/)
- **Array Grouping Methods**: [MDN Array Grouping](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/groupBy)
- **Hashbang Syntax**: [MDN Hashbang](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#hashbang_comments)
- **Symbol as WeakMap Keys**: [MDN WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)
- **Array Methods**: [MDN Array Methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="07-ES2022-Features.md" class="nav-link next">← Previous: ES2022+ Features</a>
    <a href="05-ES2020-Features.md" class="nav-link next">Next: Back to ES2020+ Features →</a>
</div>

*Last updated: December 2024*
