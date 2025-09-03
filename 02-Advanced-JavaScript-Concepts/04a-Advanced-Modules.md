# 🔹 Advanced Modules & Module Systems

> **Senior-level module concepts: Dynamic imports, code splitting, module federation, and advanced patterns**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [Dynamic Imports & Code Splitting](#dynamic-imports--code-splitting)
- [Module Federation](#module-federation)
- [Advanced Module Patterns](#advanced-module-patterns)
- [Performance Optimization](#performance-optimization)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## ⚡ Dynamic Imports & Code Splitting

**Dynamic imports** allow you to load modules on-demand, enabling code splitting and lazy loading for better performance.

### Why Dynamic Imports Matter:
- **Code Splitting**: Split your bundle into smaller chunks
- **Lazy Loading**: Load code only when needed
- **Performance**: Reduce initial bundle size
- **User Experience**: Faster page loads and better perceived performance

---

## 🔗 Module Federation

**Module Federation** allows multiple applications to share code and dependencies at runtime, enabling micro-frontend architectures.

### Use Cases:
- **Micro-Frontends**: Build applications from independently deployable parts
- **Shared Libraries**: Share common code between applications
- **Runtime Integration**: Integrate applications without build-time coupling
- **Team Autonomy**: Allow teams to work independently

### ASCII Diagram: Module Federation Architecture
```
MODULE FEDERATION ARCHITECTURE
┌─────────────────────────────────┐
│        HOST APPLICATION         │
│  ┌─────────────────────────────┐ │
│  │ import('remote/Button')     │ │
│  │ import('remote/Header')     │ │
│  │ import('shared/utils')      │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  REMOTE       │
        │  APPLICATIONS │
        │  (Expose)     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  SHARED       │
        │  DEPENDENCIES │
        │  (Common)     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  RUNTIME      │
        │  INTEGRATION  │
        │  (Dynamic)    │
        └───────────────┘
```

---

## 🚀 Advanced Module Patterns

### 1. **Conditional Module Loading**
```javascript
// Load different modules based on conditions
const loadModule = async (condition) => {
    if (condition) {
        const { default: ModuleA } = await import('./moduleA.js');
        return ModuleA;
    } else {
        const { default: ModuleB } = await import('./moduleB.js');
        return ModuleB;
    }
};
```

### 2. **Module Preloading**
```javascript
// Preload modules for better performance
const preloadModule = (modulePath) => {
    const link = document.createElement('link');
    link.rel = 'modulepreload';
    link.href = modulePath;
    document.head.appendChild(link);
};
```

---

## 💻 Detailed Examples

### Example 1: Dynamic Imports with Code Splitting
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Lazy loading components based on user interaction
class ComponentLoader {
    constructor() {
        this.loadedComponents = new Map();
        this.loadingPromises = new Map();
    }
    
    async loadComponent(componentName) {
        // Return cached component if already loaded
        if (this.loadedComponents.has(componentName)) {
            return this.loadedComponents.get(componentName);
        }
        
        // Return existing loading promise if already loading
        if (this.loadingPromises.has(componentName)) {
            return this.loadingPromises.get(componentName);
        }
        
        // Start loading the component
        const loadingPromise = this.#loadComponentModule(componentName);
        this.loadingPromises.set(componentName, loadingPromise);
        
        try {
            const component = await loadingPromise;
            this.loadedComponents.set(componentName, component);
            this.loadingPromises.delete(componentName);
            return component;
        } catch (error) {
            this.loadingPromises.delete(componentName);
            throw error;
        }
    }
    
    async #loadComponentModule(componentName) {
        const componentMap = {
            'UserProfile': () => import('./components/UserProfile.js'),
            'ProductList': () => import('./components/ProductList.js'),
            'ShoppingCart': () => import('./components/ShoppingCart.js'),
            'Checkout': () => import('./components/Checkout.js')
        };
        
        if (!componentMap[componentName]) {
            throw new Error(`Unknown component: ${componentName}`);
        }
        
        const module = await componentMap[componentName]();
        return module.default || module;
    }
    
    // Preload components for better UX
    preloadComponents(componentNames) {
        componentNames.forEach(name => {
            if (!this.loadedComponents.has(name) && !this.loadingPromises.has(name)) {
                this.loadComponent(name).catch(() => {
                    // Silent preload failure
                });
            }
        });
    }
}

// Usage
const loader = new ComponentLoader();

// Load component on demand
const loadUserProfile = async () => {
    try {
        const UserProfile = await loader.loadComponent('UserProfile');
        const component = new UserProfile();
        document.getElementById('app').appendChild(component.render());
    } catch (error) {
        console.error('Failed to load UserProfile:', error);
    }
};

// Preload next likely components
loader.preloadComponents(['ProductList', 'ShoppingCart']);

// Event listener for component loading
document.getElementById('profile-btn').addEventListener('click', loadUserProfile);
</code></pre>
</div>

### Example 2: Module Federation with Webpack
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// webpack.config.js - Host Application
const { ModuleFederationPlugin } = require('webpack').container;

module.exports = {
    // ... other config
    plugins: [
        new ModuleFederationPlugin({
            name: 'host',
            remotes: {
                remote: 'remote@http://localhost:3001/remoteEntry.js',
                shared: 'shared@http://localhost:3002/remoteEntry.js'
            },
            shared: {
                react: { singleton: true },
                'react-dom': { singleton: true }
            }
        })
    ]
};

// webpack.config.js - Remote Application
const { ModuleFederationPlugin } = require('webpack').container;

module.exports = {
    // ... other config
    plugins: [
        new ModuleFederationPlugin({
            name: 'remote',
            filename: 'remoteEntry.js',
            exposes: {
                './Button': './src/components/Button',
                './Header': './src/components/Header',
                './utils': './src/utils'
            },
            shared: {
                react: { singleton: true },
                'react-dom': { singleton: true }
            }
        })
    ]
};

// Usage in Host Application
import React, { Suspense, lazy } from 'react';

// Lazy load remote components
const RemoteButton = lazy(() => import('remote/Button'));
const RemoteHeader = lazy(() => import('remote/Header'));
const SharedUtils = lazy(() => import('shared/utils'));

function App() {
    return (
        <div>
            <Suspense fallback={<div>Loading Header...</div>}>
                <RemoteHeader />
            </Suspense>
            
            <main>
                <h1>Host Application</h1>
                <Suspense fallback={<div>Loading Button...</div>}>
                    <RemoteButton />
                </Suspense>
                
                <Suspense fallback={<div>Loading Utils...</div>}>
                    <SharedUtils />
                </Suspense>
            </main>
        </div>
    );
}
</code></pre>
</div>

### Example 3: Advanced Code Splitting Strategies
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced code splitting with route-based and feature-based splitting
class AdvancedCodeSplitter {
    constructor() {
        this.routeChunks = new Map();
        this.featureChunks = new Map();
        this.vendorChunks = new Map();
    }
    
    // Route-based code splitting
    async loadRoute(route) {
        const routeMap = {
            '/': () => import('./routes/Home.js'),
            '/users': () => import('./routes/Users.js'),
            '/products': () => import('./routes/Products.js'),
            '/admin': () => import('./routes/Admin.js')
        };
        
        if (!routeMap[route]) {
            throw new Error(`Unknown route: ${route}`);
        }
        
        // Check if route is already loaded
        if (this.routeChunks.has(route)) {
            return this.routeChunks.get(route);
        }
        
        // Load route module
        const module = await routeMap[route]();
        this.routeChunks.set(route, module);
        return module;
    }
    
    // Feature-based code splitting
    async loadFeature(feature) {
        const featureMap = {
            'analytics': () => import('./features/analytics/index.js'),
            'chat': () => import('./features/chat/index.js'),
            'notifications': () => import('./features/notifications/index.js'),
            'payments': () => import('./features/payments/index.js')
        };
        
        if (!featureMap[feature]) {
            throw new Error(`Unknown feature: ${feature}`);
        }
        
        // Check if feature is already loaded
        if (this.featureChunks.has(feature)) {
            return this.featureChunks.get(feature);
        }
        
        // Load feature module
        const module = await featureMap[feature]();
        this.featureChunks.set(feature, module);
        return module;
    }
    
    // Vendor code splitting
    async loadVendor(vendor) {
        const vendorMap = {
            'lodash': () => import('lodash'),
            'moment': () => import('moment'),
            'chart': () => import('chart.js'),
            'map': () => import('leaflet')
        };
        
        if (!vendorMap[vendor]) {
            throw new Error(`Unknown vendor: ${vendor}`);
        }
        
        // Check if vendor is already loaded
        if (this.vendorChunks.has(vendor)) {
            return this.vendorChunks.get(vendor);
        }
        
        // Load vendor module
        const module = await vendorMap[vendor]();
        this.vendorChunks.set(vendor, module);
        return module;
    }
    
    // Preload strategy
    preloadRoute(route) {
        this.loadRoute(route).catch(() => {
            // Silent preload failure
        });
    }
    
    preloadFeature(feature) {
        this.loadFeature(feature).catch(() => {
            // Silent preload failure
        });
    }
    
    // Get loading statistics
    getStats() {
        return {
            routes: this.routeChunks.size,
            features: this.featureChunks.size,
            vendors: this.vendorChunks.size,
            total: this.routeChunks.size + this.featureChunks.size + this.vendorChunks.size
        };
    }
}

// Usage
const splitter = new AdvancedCodeSplitter();

// Load route on navigation
const navigateToRoute = async (route) => {
    try {
        const RouteComponent = await splitter.loadRoute(route);
        const component = new RouteComponent();
        renderComponent(component);
        
        // Preload next likely routes
        if (route === '/') {
            splitter.preloadRoute('/users');
        } else if (route === '/users') {
            splitter.preloadRoute('/products');
        }
    } catch (error) {
        console.error(`Failed to load route ${route}:`, error);
    }
};

// Load feature on demand
const loadAnalytics = async () => {
    try {
        const analytics = await splitter.loadFeature('analytics');
        analytics.initialize();
    } catch (error) {
        console.error('Failed to load analytics:', error);
    }
};

// Load vendor library
const loadChartLibrary = async () => {
    try {
        const Chart = await splitter.loadVendor('chart');
        // Use Chart.js
    } catch (error) {
        console.error('Failed to load Chart.js:', error);
    }
};

// Get loading statistics
console.log('Loaded chunks:', splitter.getStats());
</code></pre>
</div>

### Example 4: Module Federation with Runtime Configuration
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Runtime module federation configuration
class RuntimeModuleFederation {
    constructor() {
        this.remotes = new Map();
        this.shared = new Map();
        this.config = null;
    }
    
    // Load federation configuration at runtime
    async loadConfiguration(configUrl) {
        try {
            const response = await fetch(configUrl);
            this.config = await response.json();
            
            // Initialize remotes
            await this.initializeRemotes();
            
            // Initialize shared dependencies
            await this.initializeShared();
            
            console.log('Module Federation initialized successfully');
        } catch (error) {
            console.error('Failed to initialize Module Federation:', error);
            throw error;
        }
    }
    
    // Initialize remote applications
    async initializeRemotes() {
        for (const [name, remote] of Object.entries(this.config.remotes)) {
            try {
                await this.loadRemote(name, remote);
            } catch (error) {
                console.warn(`Failed to load remote ${name}:`, error);
            }
        }
    }
    
    // Load a remote application
    async loadRemote(name, remoteConfig) {
        const { url, exposes } = remoteConfig;
        
        // Load remote entry
        const remoteEntry = await this.loadScript(`${url}/remoteEntry.js`);
        
        // Initialize remote
        const remote = remoteEntry.get(name);
        if (remote) {
            this.remotes.set(name, {
                module: remote,
                exposes,
                config: remoteConfig
            });
            console.log(`Remote ${name} loaded successfully`);
        }
    }
    
    // Initialize shared dependencies
    async initializeShared() {
        for (const [name, sharedConfig] of Object.entries(this.config.shared)) {
            try {
                await this.loadShared(name, sharedConfig);
            } catch (error) {
                console.warn(`Failed to load shared ${name}:`, error);
            }
        }
    }
    
    // Load shared dependency
    async loadShared(name, sharedConfig) {
        const { url, version } = sharedConfig;
        
        // Check if already loaded
        if (this.shared.has(name)) {
            return this.shared.get(name);
        }
        
        // Load shared module
        const module = await import(`${url}/${name}@${version}.js`);
        this.shared.set(name, module);
        console.log(`Shared ${name} loaded successfully`);
    }
    
    // Load script dynamically
    loadScript(src) {
        return new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = src;
            script.onload = () => resolve(window[name]);
            script.onerror = reject;
            document.head.appendChild(script);
        });
    }
    
    // Get remote module
    async getRemote(remoteName, moduleName) {
        const remote = this.remotes.get(remoteName);
        if (!remote) {
            throw new Error(`Remote ${remoteName} not found`);
        }
        
        if (!remote.exposes.includes(moduleName)) {
            throw new Error(`Module ${moduleName} not exposed by remote ${remoteName}`);
        }
        
        return remote.module.get(moduleName);
    }
    
    // Get shared module
    getShared(name) {
        return this.shared.get(name);
    }
    
    // Get federation status
    getStatus() {
        return {
            remotes: Array.from(this.remotes.keys()),
            shared: Array.from(this.shared.keys()),
            config: this.config
        };
    }
}

// Configuration file (federation-config.json)
const federationConfig = {
    "remotes": {
        "userApp": {
            "url": "http://localhost:3001",
            "exposes": ["UserList", "UserProfile", "UserForm"]
        },
        "productApp": {
            "url": "http://localhost:3002",
            "exposes": ["ProductList", "ProductDetail", "ProductForm"]
        }
    },
    "shared": {
        "react": {
            "url": "http://localhost:3000",
            "version": "18.2.0"
        },
        "react-dom": {
            "url": "http://localhost:3000",
            "version": "18.2.0"
        }
    }
};

// Usage
const federation = new RuntimeModuleFederation();

// Initialize federation
federation.loadConfiguration('federation-config.json')
    .then(async () => {
        // Load remote components
        const UserList = await federation.getRemote('userApp', 'UserList');
        const ProductList = await federation.getRemote('productApp', 'ProductList');
        
        // Use shared dependencies
        const React = federation.getShared('react');
        
        console.log('Federation status:', federation.getStatus());
    })
    .catch(error => {
        console.error('Federation initialization failed:', error);
    });
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What is code splitting and how does it improve performance?
**A:** Code splitting is a technique that allows you to split your JavaScript bundle into smaller chunks that can be loaded on-demand. It improves performance by reducing the initial bundle size, enabling faster page loads, and allowing users to download only the code they need when they need it. This is especially important for large applications.

### Q2: How do dynamic imports work and when would you use them?
**A:** Dynamic imports use the `import()` function to load modules at runtime. They return a Promise that resolves to the module. You'd use them for route-based code splitting, feature-based loading, conditional module loading, or any scenario where you want to defer module loading until it's actually needed.

### Q3: What is Module Federation and how does it enable micro-frontends?
**A:** Module Federation allows multiple applications to share code and dependencies at runtime. It enables micro-frontends by allowing teams to work independently on different parts of an application, deploy them separately, and integrate them at runtime without build-time coupling. This provides better team autonomy and deployment flexibility.

### Q4: What are the trade-offs of using Module Federation?
**A:** Module Federation provides benefits like team autonomy, independent deployments, and runtime integration. However, it adds complexity to the build system, requires careful dependency management, can increase bundle sizes due to shared dependencies, and requires coordination between teams for shared interfaces and dependencies.

### Q5: How would you implement progressive loading in a React application?
**A:** Progressive loading can be implemented using React.lazy() with Suspense for route-based splitting, dynamic imports for feature-based splitting, and intersection observers for loading components when they come into view. You can also use preloading strategies to load likely-needed components in the background.

---

## 🏋️ Practice Exercises

### Exercise 1: Implement Route-Based Code Splitting
Create a React router that automatically splits code based on routes and preloads adjacent routes for better performance.

### Exercise 2: Build a Feature-Based Loading System
Implement a system that loads features on-demand based on user permissions or feature flags, with proper error handling and fallbacks.

### Exercise 3: Create a Module Federation Host
Build a host application that can dynamically load and integrate remote modules with proper error boundaries and loading states.

---

## 📚 Additional Resources

- **Dynamic Imports**: [MDN Dynamic Import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import#dynamic_imports)
- **Code Splitting**: [Webpack Code Splitting](https://webpack.js.org/guides/code-splitting/)
- **Module Federation**: [Webpack Module Federation](https://webpack.js.org/concepts/module-federation/)
- **Micro-Frontends**: [Micro-Frontends.org](https://micro-frontends.org/)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="04-Modules.md" class="nav-link prev">← Previous: Modules & Module Systems Basics</a>
    <a href="01a-Advanced-Functional-Programming.md" class="nav-link next">Next: Advanced Functional Programming →</a>
</div>

*Last updated: December 2024*
