<link rel="stylesheet" href="../common-styles.css">

---

## 🔧 CommonJS Modules

**CommonJS** is the module system used by Node.js. It uses `require()` and `module.exports` for importing and exporting modules.

### Basic CommonJS Syntax:

#### 1. **Exporting Modules**

```javascript
// math.js - CommonJS exports
const PI = 3.14159;
const E = 2.71828;

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

class Calculator {
    constructor() {
        this.history = [];
    }
    
    calculate(operation, a, b) {
        const result = operation(a, b);
        this.history.push({ operation: operation.name, a, b, result });
        return result;
    }
    
    getHistory() {
        return [...this.history];
    }
}

// Export individual items
module.exports.PI = PI;
module.exports.E = E;
module.exports.add = add;
module.exports.subtract = subtract;
module.exports.Calculator = Calculator;

// Alternative: Export object
module.exports = {
    PI,
    E,
    add,
    subtract,
    Calculator
};

// Alternative: Export at the end
exports.PI = PI;
exports.E = E;
exports.add = add;
exports.subtract = subtract;
exports.Calculator = Calculator;
```


#### 2. **Importing Modules**

```javascript
// main.js - CommonJS imports
const math = require('./math.js');

console.log(math.PI); // 3.14159
console.log(math.add(5, 3)); // 8

const Calculator = math.Calculator;
const calc = new Calculator();
calc.calculate(math.add, 10, 5);

// Destructuring imports
const { PI, add, Calculator: CalcClass } = require('./math.js');

// Renaming imports
const mathUtils = require('./math.js');
const { add: addNumbers } = require('./math.js');
```


### ASCII Diagram: CommonJS vs ES6 Modules

```
COMMONJS vs ES6 MODULES
┌─────────────────────────────────┐    ┌─────────────────────────────────┐
│ CommonJS (Node.js)              │    │ ES6 Modules (Browser/Node)     │
├─────────────────────────────────┤    ├─────────────────────────────────┤
│ module.exports = { ... }        │    │ export { ... }                 │
│ exports.property = value        │    │ export default Class           │
│                                 │    │                                 │
│ const module = require('./file')│    │ import { item } from './file'   │
│ const { item } = require('./file')│  │ import Class from './file'      │
│                                 │    │                                 │
│ Synchronous loading             │    │ Asynchronous loading           │
│ Dynamic imports                 │    │ Static imports                 │
│ Runtime evaluation              │    │ Compile-time analysis          │
└─────────────────────────────────┘    └─────────────────────────────────┘
```


---

## 🔄 Dynamic Imports

**Dynamic imports** allow you to load modules conditionally at runtime using the `import()` function, which returns a promise.

### Basic Dynamic Import:

```javascript
// Dynamic import example
async function loadModule(moduleName) {
    try {
        const module = await import(`./modules/${moduleName}.js`);
        return module;
    } catch (error) {
        console.error(`Failed to load module ${moduleName}:`, error);
        throw error;
    }
}

// Usage
async function main() {
    try {
        const mathModule = await loadModule('math');
        const userModule = await loadModule('user');
        
        console.log(mathModule.add(5, 3));
        const user = new userModule.default('John', 'john@example.com');
        
    } catch (error) {
        console.error('Error loading modules:', error);
    }
}

main();
```


### Conditional Module Loading:

```javascript
// Load different modules based on conditions
async function loadFeature(featureName) {
    let module;
    
    switch (featureName) {
        case 'advanced':
            module = await import('./features/advanced.js');
            break;
        case 'basic':
            module = await import('./features/basic.js');
            break;
        default:
            module = await import('./features/default.js');
    }
    
    return module;
}

// Load modules based on user preferences
async function loadUserInterface(theme) {
    const uiModule = await import(`./ui/${theme}.js`);
    return uiModule.default;
}
```


---

## 📦 Module Bundlers

**Module bundlers** combine multiple JavaScript files into a single file for browser consumption, handling dependencies and transformations.

### Popular Bundlers:

#### 1. **Webpack**

```javascript
// webpack.config.js
const path = require('path');

module.exports = {
    entry: './src/index.js',
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            }
        ]
    },
    resolve: {
        extensions: ['.js', '.jsx', '.ts', '.tsx']
    }
};
```


#### 2. **Vite**

```javascript
// vite.config.js
import { defineConfig } from 'vite';

export default defineConfig({
    build: {
        rollupOptions: {
            input: {
                main: './index.html',
                app: './src/main.js'
            }
        }
    },
    plugins: []
});
```


---

## 🌳 Tree Shaking

**Tree shaking** is a technique to eliminate dead code by removing unused exports during the build process.

### Tree Shaking Example:

```javascript
// utils.js - Multiple exports
export function add(a, b) {
    return a + b;
}

export function subtract(a, b) {
    return a - b;
}

export function multiply(a, b) {
    return a * b;
}

export function divide(a, b) {
    return b !== 0 ? a / b : null;
}

// main.js - Only imports what it uses
import { add, multiply } from './utils.js';

console.log(add(5, 3));      // 8
console.log(multiply(4, 2)); // 8

// subtract and divide functions will be removed from the bundle
```


---

## 💻 Detailed Examples

### Example 1: Building a Modular Application
<div style="position: relative;">
<button onclick="copyCode(this)" style="position: absolute; top: 10px; right: 10px; background: #007acc; color: white; border: none; border-radius: 4px; padding: 5px 10px; cursor: pointer; font-size: 12px;">📋 Copy</button>


```javascript
console.log("=== BUILDING A MODULAR APPLICATION ===");

// config.js - Configuration module
export const config = {
    api: {
        baseURL: 'https://api.example.com',
        timeout: 5000,
        retries: 3
    },
    app: {
        name: 'MyApp',
        version: '1.0.0',
        debug: process.env.NODE_ENV === 'development'
    }
};

// logger.js - Logging module
export class Logger {
    constructor(prefix = '') {
        this.prefix = prefix;
    }
    
    log(message, level = 'info') {
        const timestamp = new Date().toISOString();
        const logMessage = `[${timestamp}] [${level.toUpperCase()}] ${this.prefix}: ${message}`;
        
        if (config.app.debug) {
            console.log(logMessage);
        }
        
        // Could also send to external logging service
        this.sendToExternalService(logMessage, level);
    }
    
    info(message) {
        this.log(message, 'info');
    }
    
    warn(message) {
        this.log(message, 'warn');
    }
    
    error(message) {
        this.log(message, 'error');
    }
    
    sendToExternalService(message, level) {
        // Implementation for external logging
        if (level === 'error') {
            // Send errors to monitoring service
            console.error('Sending to monitoring service:', message);
        }
    }
}

// api.js - API client module
import { config } from './config.js';
import { Logger } from './logger.js';

const logger = new Logger('API');

export class APIClient {
    constructor() {
        this.baseURL = config.api.baseURL;
        this.timeout = config.api.timeout;
        this.retries = config.api.retries;
    }
    
    async request(endpoint, options = {}) {
        const url = `${this.baseURL}${endpoint}`;
        const requestOptions = {
            timeout: this.timeout,
            ...options
        };
        
        logger.info(`Making request to ${endpoint}`);
        
        try {
            const response = await fetch(url, requestOptions);
            
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            
            const data = await response.json();
            logger.info(`Request to ${endpoint} successful`);
            
            return data;
            
        } catch (error) {
            logger.error(`Request to ${endpoint} failed: ${error.message}`);
            throw error;
        }
    }
    
    async get(endpoint) {
        return this.request(endpoint, { method: 'GET' });
    }
    
    async post(endpoint, data) {
        return this.request(endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
    }
}

// user-service.js - User service module
import { APIClient } from './api.js';
import { Logger } from './logger.js';

const logger = new Logger('UserService');

export class UserService {
    constructor() {
        this.api = new APIClient();
    }
    
    async getUsers() {
        logger.info('Fetching users');
        try {
            const users = await this.api.get('/users');
            logger.info(`Successfully fetched ${users.length} users`);
            return users;
        } catch (error) {
            logger.error('Failed to fetch users');
            throw error;
        }
    }
    
    async createUser(userData) {
        logger.info('Creating new user');
        try {
            const user = await this.api.post('/users', userData);
            logger.info(`Successfully created user: ${user.id}`);
            return user;
        } catch (error) {
            logger.error('Failed to create user');
            throw error;
        }
    }
    
    async getUserById(id) {
        logger.info(`Fetching user with ID: ${id}`);
        try {
            const user = await this.api.get(`/users/${id}`);
            logger.info(`Successfully fetched user: ${user.name}`);
            return user;
        } catch (error) {
            logger.error(`Failed to fetch user with ID: ${id}`);
            throw error;
        }
    }
}

// main.js - Main application module
import { config } from './config.js';
import { Logger } from './logger.js';
import { UserService } from './user-service.js';

const logger = new Logger('Main');

async function main() {
    logger.info(`Starting ${config.app.name} v${config.app.version}`);
    
    try {
        const userService = new UserService();
        
        // Get all users
        const users = await userService.getUsers();
        console.log('Users:', users);
        
        // Create a new user
        const newUser = await userService.createUser({
            name: 'John Doe',
            email: 'john@example.com'
        });
        console.log('New user created:', newUser);
        
        // Get the created user
        const fetchedUser = await userService.getUserById(newUser.id);
        console.log('Fetched user:', fetchedUser);
        
        logger.info('Application completed successfully');
        
    } catch (error) {
        logger.error(`Application failed: ${error.message}`);
        process.exit(1);
    }
}

// Run the application
if (import.meta.url === `file://${process.argv[1]}`) {
    main();
}

// Export for testing or other modules
export { main, UserService, APIClient, Logger };
```


---

## ⚠️ Common Pitfalls

### Pitfall 1: Circular Dependencies

```javascript
// ❌ WRONG: Circular dependency
// a.js
import { b } from './b.js';
export const a = 'a';

// b.js
import { a } from './a.js';
export const b = 'b';

// This creates a circular dependency error
```


### Pitfall 2: Missing File Extensions

```javascript
// ❌ WRONG: Missing .js extension (in some environments)
import { add } from './math'; // May not work

// ✅ CORRECT: Include file extension
import { add } from './math.js';
```


### Pitfall 3: Mixing Module Systems

```javascript
// ❌ WRONG: Mixing CommonJS and ES6 modules
const math = require('./math.js'); // CommonJS
import { add } from './math.js';   // ES6

// Stick to one module system per project
```


---

## 🎯 Best Practices

### ✅ Do's:
- **Use consistent module system** throughout your project
- **Keep modules focused** on a single responsibility
- **Use meaningful names** for exports and imports
- **Handle errors** in dynamic imports
- **Use tree shaking** to reduce bundle size
- **Document your modules** with JSDoc comments

### ❌ Don'ts:
- **Don't create circular dependencies**
- **Don't mix module systems** unnecessarily
- **Don't export everything** from a module
- **Don't forget file extensions** in imports
- **Don't ignore build warnings** about unused exports

---

## 🔑 Key Points

- **ES6 Modules** are the native JavaScript module system
- **CommonJS** is used by Node.js with require/module.exports
- **Dynamic imports** allow runtime module loading
- **Module bundlers** combine files for browser use
- **Tree shaking** removes unused code
- **Circular dependencies** should be avoided
- **Consistent module system** is important

---

## ❓ Common Interview Questions

<div class="interview-question">
    <h4>Q1: What's the difference between ES6 modules and CommonJS?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> ES6 modules use static imports/exports with import/export keywords, are asynchronous, support tree shaking, and are the native JavaScript standard. CommonJS uses require()/module.exports, is synchronous, doesn't support tree shaking, and is Node.js-specific. ES6 modules are parsed at compile time, while CommonJS is evaluated at runtime.</p>
    </div>
</div>

<div class="interview-question">
    <h4>Q2: How do you handle circular dependencies?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> Restructure code to avoid circular dependencies by extracting shared functionality into a separate module, using dependency injection, or reorganizing the module hierarchy. Sometimes using dynamic imports can help, but the best approach is to redesign the architecture to eliminate the circular dependency.</p>
    </div>
</div>

<div class="interview-question">
    <h4>Q3: What is tree shaking and how does it work?</h4>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <p><strong>A:</strong> Tree shaking is a technique that eliminates dead code by removing unused exports during the build process. It works by analyzing the dependency graph and removing code that isn't imported anywhere. It's most effective with ES6 modules and requires build tools like Webpack, Rollup, or Vite to implement.</p>
    </div>
</div>

---

## 🏋️ Practice Exercises

<div class="practice-exercise">
    <h4>Exercise 1: Create a Module System for a Library</h4>
    <p>Build a modular library with proper exports, imports, and re-exports. Include utility functions, classes, and configuration.</p>
    <button class="solution-toggle-btn" onclick="toggleSolution(this)">Show Solution</button>
    <div class="solution">
        <div style="position: relative;">
            <button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
            <pre><code>// lib/index.js - Main library entry point
export { default as StringUtils } from './string-utils.js';
export { default as MathUtils } from './math-utils.js';
export { default as DateUtils } from './date-utils.js';
export { default as ArrayUtils } from './array-utils.js';
export { config } from './config.js';

// lib/string-utils.js
class StringUtils {
    static capitalize(str) {
        return str.charAt(0).toUpperCase() + str.slice(1);
    }
    
    static reverse(str) {
        return str.split('').reverse().join('');
    }
    
    static truncate(str, length) {
        return str.length > length ? str.slice(0, length) + '...' : str;
    }
    
    static slugify(str) {
        return str.toLowerCase()
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/^-+|-+$/g, '');
    }
}

export default StringUtils;

// lib/math-utils.js
class MathUtils {
    static sum(...numbers) {
        return numbers.reduce((sum, num) => sum + num, 0);
    }
    
    static average(...numbers) {
        return this.sum(...numbers) / numbers.length;
    }
    
    static factorial(n) {
        if (n <= 1) return 1;
        return n * this.factorial(n - 1);
    }
    
    static isPrime(n) {
        if (n < 2) return false;
        for (let i = 2; i <= Math.sqrt(n); i++) {
            if (n % i === 0) return false;
        }
        return true;
    }
}

export default MathUtils;

// lib/date-utils.js
class DateUtils {
    static format(date, format = 'YYYY-MM-DD') {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        
        return format
            .replace('YYYY', year)
            .replace('MM', month)
            .replace('DD', day);
    }
    
    static addDays(date, days) {
        const result = new Date(date);
        result.setDate(result.getDate() + days);
        return result;
    }
    
    static isWeekend(date) {
        const day = date.getDay();
        return day === 0 || day === 6;
    }
    
    static getDaysBetween(date1, date2) {
        const timeDiff = date2.getTime() - date1.getTime();
        return Math.ceil(timeDiff / (1000 * 3600 * 24));
    }
}

export default DateUtils;

// lib/array-utils.js
class ArrayUtils {
    static chunk(array, size) {
        const chunks = [];
        for (let i = 0; i < array.length; i += size) {
            chunks.push(array.slice(i, i + size));
        }
        return chunks;
    }
    
    static unique(array) {
        return [...new Set(array)];
    }
    
    static shuffle(array) {
        const shuffled = [...array];
        for (let i = shuffled.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
        }
        return shuffled;
    }
    
    static groupBy(array, key) {
        return array.reduce((groups, item) => {
            const group = item[key];
            groups[group] = groups[group] || [];
            groups[group].push(item);
            return groups;
        }, {});
    }
}

export default ArrayUtils;

// lib/config.js
export const config = {
    version: '1.0.0',
    debug: false,
    maxArraySize: 10000,
    dateFormat: 'YYYY-MM-DD'
};

// Usage example
import { StringUtils, MathUtils, DateUtils, ArrayUtils, config } from './lib/index.js';

console.log(StringUtils.capitalize('hello world')); // "Hello world"
console.log(MathUtils.factorial(5)); // 120
console.log(DateUtils.format(new Date())); // "2024-12-19"
console.log(ArrayUtils.chunk([1, 2, 3, 4, 5], 2)); // [[1, 2], [3, 4], [5]]
console.log(config.version); // "1.0.0"</code></pre>
        </div>
    </div>
</div>

---

## 📚 Additional Resources

- [MDN: JavaScript modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)
- [Node.js: Modules](https://nodejs.org/api/modules.html)
- [ES6 Modules in Depth](https://ponyfoo.com/articles/es6-modules-in-depth)
- [Webpack: Module Concepts](https://webpack.js.org/concepts/modules/)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="03-Asynchronous-JavaScript.md" class="nav-link prev">← Previous: Asynchronous JavaScript</a>
    <a href="05-Advanced-Data-Structures.md" class="nav-link next">Next: Advanced Data Structures →</a>
</div>

*Last updated: December 2024*
