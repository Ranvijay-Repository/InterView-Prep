# 🔹 Advanced Design Patterns

> **Comprehensive coverage of advanced design patterns: Revealing Module Pattern, Factory Pattern variations, Command Pattern, and Chain of Responsibility**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [Advanced Design Patterns Overview](#advanced-design-patterns-overview)
- [Revealing Module Pattern](#revealing-module-pattern)
- [Factory Pattern Variations](#factory-pattern-variations)
- [Command Pattern](#command-pattern)
- [Chain of Responsibility](#chain-of-responsibility)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 Advanced Design Patterns Overview

**Advanced Design Patterns** provide sophisticated solutions to complex software design problems, enabling scalable, maintainable, and flexible code architecture.

### Why Advanced Design Patterns Matter:
- **Scalability**: Handle complex systems with clear structure
- **Maintainability**: Code that's easy to understand and modify
- **Flexibility**: Adapt to changing requirements gracefully
- **Team Collaboration**: Standardized approaches for team development
- **Performance**: Optimized solutions for specific use cases

---

## 📦 Revealing Module Pattern

**Revealing Module Pattern** is an advanced module pattern that provides better encapsulation and control over what's exposed from a module.

### Why Revealing Module Pattern Matters:
- **Encapsulation**: Hide internal implementation details
- **API Control**: Expose only what's necessary
- **Testing**: Easier to test private vs public methods
- **Refactoring**: Safe internal changes without breaking API
- **Performance**: Optimize internal operations

### ASCII Diagram: Revealing Module Pattern Structure

{% raw %}
```
REVEALING MODULE PATTERN
┌─────────────────────────────────┐
│        PRIVATE SCOPE            │
│  ┌─────────────────────────────┐ │
│  │ Private Variables           │ │
│  │ Private Functions           │ │
│  │ Internal Logic              │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  PUBLIC API   │
        │  (Revealed)   │
        │               │
        │  - method1()  │
        │  - method2()  │
        │  - property   │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  EXTERNAL     │
        │  USAGE        │
        │               │
        │  module.method1() │
        │  module.property  │
        └───────────────┘
```
{% endraw %}


### Use Cases:
- **Library Development**: Control public API surface
- **Plugin Systems**: Expose only necessary functionality
- **Service Modules**: Hide internal implementation
- **Configuration Objects**: Manage complex settings
- **Utility Libraries**: Organize helper functions

---

## 🏭 Factory Pattern Variations

**Factory Pattern Variations** extend the basic factory pattern to handle more complex object creation scenarios.

### Why Factory Pattern Variations Matter:
- **Complex Creation**: Handle objects with complex initialization
- **Dependency Injection**: Manage object dependencies
- **Configuration**: Support different object configurations
- **Caching**: Optimize object creation and reuse
- **Validation**: Ensure object creation requirements

### ASCII Diagram: Factory Pattern Variations

{% raw %}
```
FACTORY PATTERN VARIATIONS
┌─────────────────────────────────┐
│        ABSTRACT FACTORY         │
│  ┌─────────────────────────────┐ │
│  │ createProductA()            │ │
│  │ createProductB()            │ │
│  │ createProductC()            │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  CONCRETE     │
        │  FACTORIES    │
        │               │
        │  Factory1     │
        │  Factory2     │
        │  Factory3     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  PRODUCTS     │
        │               │
        │  ProductA1    │
        │  ProductB1    │
        │  ProductC1    │
        └───────────────┘
```
{% endraw %}


### Factory Types:
- **Simple Factory**: Basic object creation
- **Factory Method**: Subclass-based creation
- **Abstract Factory**: Family of related objects
- **Builder Pattern**: Complex object construction
- **Object Pool**: Reuse expensive objects

---

## 🎯 Command Pattern

**Command Pattern** encapsulates a request as an object, allowing you to parameterize clients with different requests, queue operations, and support undo operations.

### Why Command Pattern Matters:
- **Decoupling**: Separate request sender from receiver
- **Undo/Redo**: Support for reversible operations
- **Queue Operations**: Batch and schedule commands
- **Logging**: Track all operations for audit
- **Macro Commands**: Combine multiple commands

### ASCII Diagram: Command Pattern Flow

{% raw %}
```
COMMAND PATTERN FLOW
┌─────────────────────────────────┐
│        CLIENT                   │
│  ┌─────────────────────────────┐ │
│  │ Creates Commands            │ │
│  │ Sets Receivers              │ │
│  │ Executes Commands           │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  COMMAND      │
        │  INTERFACE    │
        │               │
        │  execute()    │
        │  undo()       │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  CONCRETE     │
        │  COMMANDS     │
        │               │
        │  CopyCommand  │
        │  PasteCommand │
        │  DeleteCommand│
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  RECEIVER     │
        │               │
        │  Action       │
        │  Execution    │
        │  State Change │
        └───────────────┘
```
{% endraw %}


### Use Cases:
- **Text Editors**: Copy, paste, undo operations
- **Game Systems**: Player actions and commands
- **GUI Applications**: Button clicks and menu actions
- **Transaction Systems**: Database operations
- **Remote Control**: API command execution

---

## 🔗 Chain of Responsibility

**Chain of Responsibility** passes requests along a chain of handlers, with each handler deciding whether to process the request or pass it to the next handler.

### Why Chain of Responsibility Matters:
- **Request Processing**: Handle requests through multiple handlers
- **Flexibility**: Dynamic handler chains
- **Single Responsibility**: Each handler has one job
- **Extensibility**: Easy to add new handlers
- **Fallback Handling**: Graceful degradation

### ASCII Diagram: Chain of Responsibility

{% raw %}
```
CHAIN OF RESPONSIBILITY
┌─────────────────────────────────┐
│        CLIENT                   │
│  ┌─────────────────────────────┐ │
│  │ Creates Request             │ │
│  │ Sends to First Handler      │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  HANDLER 1    │
        │               │
        │  Can Handle?  │
        │  Yes → Process│
        │  No → Next    │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  HANDLER 2    │
        │               │
        │  Can Handle?  │
        │  Yes → Process│
        │  No → Next    │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  HANDLER N    │
        │               │
        │  Can Handle?  │
        │  Yes → Process│
        │  No → Default │
        └───────────────┘
```
{% endraw %}


### Use Cases:
- **Request Processing**: HTTP middleware chains
- **Event Handling**: DOM event propagation
- **Logging Systems**: Multiple log handlers
- **Authentication**: Multiple auth providers
- **Error Handling**: Cascading error processors

---

## 💻 Detailed Examples

### Example 1: Revealing Module Pattern Implementation
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced Revealing Module Pattern with performance optimization
const UserService = (function() {
    // Private variables and state
    let userCache = new Map();
    let cacheExpiry = new Map();
    const CACHE_TTL = 5 * 60 * 1000; // 5 minutes
    
    // Private helper functions
    function isCacheValid(userId) {
        const expiry = cacheExpiry.get(userId);
        return expiry && Date.now() < expiry;
    }
    
    function updateCache(userId, userData) {
        userCache.set(userId, userData);
        cacheExpiry.set(userId, Date.now() + CACHE_TTL);
    }
    
    function clearExpiredCache() {
        const now = Date.now();
        for (const [userId, expiry] of cacheExpiry.entries()) {
            if (now >= expiry) {
                userCache.delete(userId);
                cacheExpiry.delete(userId);
            }
        }
    }
    
    // Private API methods
    async function fetchUserFromAPI(userId) {
        try {
            const response = await fetch(`/api/users/${userId}`);
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            return await response.json();
        } catch (error) {
            console.error(`Failed to fetch user ${userId}:`, error);
            throw error;
        }
    }
    
    function validateUserData(userData) {
        const required = ['id', 'name', 'email'];
        const missing = required.filter(field => !userData[field]);
        
        if (missing.length > 0) {
            throw new Error(`Missing required fields: ${missing.join(', ')}`);
        }
        
        if (!userData.email.includes('@')) {
            throw new Error('Invalid email format');
        }
        
        return true;
    }
    
    // Public API (revealed)
    return {
        // User management
        async getUser(userId) {
            try {
                // Check cache first
                if (isCacheValid(userId)) {
                    return userCache.get(userId);
                }
                
                // Fetch from API
                const userData = await fetchUserFromAPI(userId);
                validateUserData(userData);
                
                // Update cache
                updateCache(userId, userData);
                
                return userData;
            } catch (error) {
                console.error(`Error getting user ${userId}:`, error);
                throw error;
            }
        },
        
        async updateUser(userId, updates) {
            try {
                // Validate updates
                if (updates.email && !updates.email.includes('@')) {
                    throw new Error('Invalid email format');
                }
                
                // Update via API
                const response = await fetch(`/api/users/${userId}`, {
                    method: 'PATCH',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(updates)
                });
                
                if (!response.ok) {
                    throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                }
                
                const updatedUser = await response.json();
                
                // Update cache
                updateCache(userId, updatedUser);
                
                return updatedUser;
            } catch (error) {
                console.error(`Error updating user ${userId}:`, error);
                throw error;
            }
        },
        
        // Cache management
        clearCache() {
            userCache.clear();
            cacheExpiry.clear();
        },
        
        getCacheStats() {
            return {
                size: userCache.size,
                keys: Array.from(userCache.keys()),
                expiries: Object.fromEntries(cacheExpiry)
            };
        },
        
        // Maintenance
        startCacheCleanup() {
            setInterval(clearExpiredCache, 60000); // Clean every minute
        }
    };
})();

// Usage example
UserService.startCacheCleanup();

// Get user with caching
UserService.getUser(123).then(user => {
    console.log('User:', user);
    
    // Update user
    return UserService.updateUser(123, { name: 'John Updated' });
}).then(updatedUser => {
    console.log('Updated user:', updatedUser);
    
    // Check cache stats
    console.log('Cache stats:', UserService.getCacheStats());
}).catch(error => {
    console.error('Error:', error);
});
</code></pre>
</div>

### Example 2: Advanced Factory Pattern with Caching and Validation

### Example 3: Command Pattern with Undo/Redo and Logging
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced Command Pattern with undo/redo, logging, and macro commands
class CommandManager {
    constructor() {
        this.commandHistory = [];
        this.redoStack = [];
        this.maxHistorySize = 100;
        this.logger = new CommandLogger();
    }
    
    executeCommand(command) {
        try {
            // Execute the command
            const result = command.execute();
            
            // Log the execution
            this.logger.log('EXECUTE', command.constructor.name, result);
            
            // Add to history
            this.commandHistory.push(command);
            
            // Clear redo stack when new command is executed
            this.redoStack = [];
            
            // Maintain history size
            if (this.commandHistory.length > this.maxHistorySize) {
                this.commandHistory.shift();
            }
            
            return result;
        } catch (error) {
            this.logger.log('ERROR', command.constructor.name, error.message);
            throw error;
        }
    }
    
    undo() {
        if (this.commandHistory.length === 0) {
            throw new Error('No commands to undo');
        }
        
        const command = this.commandHistory.pop();
        
        try {
            const result = command.undo();
            this.logger.log('UNDO', command.constructor.name, result);
            
            // Add to redo stack
            this.redoStack.push(command);
            
            return result;
        } catch (error) {
            this.logger.log('UNDO_ERROR', command.constructor.name, error.message);
            throw error;
        }
    }
    
    redo() {
        if (this.redoStack.length === 0) {
            throw new Error('No commands to redo');
        }
        
        const command = this.redoStack.pop();
        
        try {
            const result = command.execute();
            this.logger.log('REDO', command.constructor.name, result);
            
            // Add back to history
            this.commandHistory.push(command);
            
            return result;
        } catch (error) {
            this.logger.log('REDO_ERROR', command.constructor.name, error.message);
            throw error;
        }
    }
    
    // Macro command for executing multiple commands
    executeMacro(commands) {
        const macroCommand = new MacroCommand(commands);
        return this.executeCommand(macroCommand);
    }
    
    // Get command history
    getHistory() {
        return this.commandHistory.map((cmd, index) => ({
            index,
            command: cmd.constructor.name,
            timestamp: cmd.timestamp,
            description: cmd.description
        }));
    }
    
    // Clear history
    clearHistory() {
        this.commandHistory = [];
        this.redoStack = [];
        this.logger.clear();
    }
}

// Command interface
class Command {
    constructor(description = '') {
        this.description = description;
        this.timestamp = new Date();
    }
    
    execute() {
        throw new Error('execute() method must be implemented');
    }
    
    undo() {
        throw new Error('undo() method must be implemented');
    }
}

// Concrete commands
class CopyCommand extends Command {
    constructor(receiver, text) {
        super(`Copy text: "${text.substring(0, 20)}..."`);
        this.receiver = receiver;
        this.text = text;
        this.previousClipboard = '';
    }
    
    execute() {
        this.previousClipboard = this.receiver.getClipboard();
        this.receiver.setClipboard(this.text);
        return `Copied: ${this.text}`;
    }
    
    undo() {
        this.receiver.setClipboard(this.previousClipboard);
        return `Restored clipboard: ${this.previousClipboard}`;
    }
}

class PasteCommand extends Command {
    constructor(receiver, position) {
        super(`Paste at position ${position}`);
        this.receiver = receiver;
        this.position = position;
        this.previousContent = '';
        this.clipboardContent = '';
    }
    
    execute() {
        this.previousContent = this.receiver.getContent();
        this.clipboardContent = this.receiver.getClipboard();
        
        const newContent = this.receiver.getContent().slice(0, this.position) +
                          this.clipboardContent +
                          this.receiver.getContent().slice(this.position);
        
        this.receiver.setContent(newContent);
        return `Pasted at position ${this.position}`;
    }
    
    undo() {
        this.receiver.setContent(this.previousContent);
        return `Restored content`;
    }
}

class DeleteCommand extends Command {
    constructor(receiver, start, end) {
        super(`Delete from ${start} to ${end}`);
        this.receiver = receiver;
        this.start = start;
        this.end = end;
        this.deletedContent = '';
    }
    
    execute() {
        this.deletedContent = this.receiver.getContent().slice(this.start, this.end);
        const newContent = this.receiver.getContent().slice(0, this.start) +
                          this.receiver.getContent().slice(this.end);
        this.receiver.setContent(newContent);
        return `Deleted: "${this.deletedContent}"`;
    }
    
    undo() {
        const currentContent = this.receiver.getContent();
        const newContent = currentContent.slice(0, this.start) +
                          this.deletedContent +
                          currentContent.slice(this.start);
        this.receiver.setContent(newContent);
        return `Restored deleted content`;
    }
}

// Macro command for combining multiple commands
class MacroCommand extends Command {
    constructor(commands) {
        super(`Macro: ${commands.length} commands`);
        this.commands = commands;
    }
    
    execute() {
        const results = [];
        for (const command of this.commands) {
            results.push(command.execute());
        }
        return `Macro executed: ${results.join(', ')}`;
    }
    
    undo() {
        const results = [];
        // Undo in reverse order
        for (let i = this.commands.length - 1; i >= 0; i--) {
            results.push(this.commands[i].undo());
        }
        return `Macro undone: ${results.join(', ')}`;
    }
}

// Receiver class
class TextEditor {
    constructor() {
        this.content = '';
        this.clipboard = '';
        this.selection = { start: 0, end: 0 };
    }
    
    getContent() {
        return this.content;
    }
    
    setContent(content) {
        this.content = content;
    }
    
    getClipboard() {
        return this.clipboard;
    }
    
    setClipboard(text) {
        this.clipboard = text;
    }
    
    setSelection(start, end) {
        this.selection = { start, end };
    }
    
    getSelection() {
        return this.content.slice(this.selection.start, this.selection.end);
    }
}

// Command logger
class CommandLogger {
    constructor() {
        this.logs = [];
        this.maxLogs = 1000;
    }
    
    log(action, commandName, result) {
        const logEntry = {
            timestamp: new Date(),
            action,
            command: commandName,
            result: typeof result === 'string' ? result : JSON.stringify(result)
        };
        
        this.logs.push(logEntry);
        
        if (this.logs.length > this.maxLogs) {
            this.logs.shift();
        }
        
        console.log(`[${logEntry.timestamp.toISOString()}] ${action}: ${commandName} - ${logEntry.result}`);
    }
    
    getLogs() {
        return this.logs;
    }
    
    clear() {
        this.logs = [];
    }
}

// Usage example
const editor = new TextEditor();
const commandManager = new CommandManager();

// Set initial content
editor.setContent('Hello World! This is a test document.');

// Execute commands
commandManager.executeCommand(new CopyCommand(editor, 'Hello World!'));
commandManager.executeCommand(new PasteCommand(editor, 25));
commandManager.executeCommand(new DeleteCommand(editor, 0, 12));

console.log('Current content:', editor.getContent());

// Undo last command
commandManager.undo();
console.log('After undo:', editor.getContent());

// Redo
commandManager.redo();
console.log('After redo:', editor.getContent());

// Execute macro
const macroCommands = [
    new CopyCommand(editor, 'Macro Test'),
    new PasteCommand(editor, 0),
    new DeleteCommand(editor, 30, 40)
];

commandManager.executeMacro(macroCommands);
console.log('After macro:', editor.getContent());

// View history
console.log('Command history:', commandManager.getHistory());
</code></pre>
</div>

### Example 4: Chain of Responsibility with Dynamic Handler Management
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced Chain of Responsibility with dynamic handler management
class Request {
    constructor(type, data, priority = 'normal') {
        this.type = type;
        this.data = data;
        this.priority = priority;
        this.handled = false;
        this.handlerChain = [];
        this.timestamp = new Date();
    }
    
    markHandled(handlerName) {
        this.handled = true;
        this.handlerChain.push(handlerName);
    }
    
    getHandlerChain() {
        return this.handlerChain;
    }
}

// Abstract handler
class Handler {
    constructor(name, priority = 0) {
        this.name = name;
        this.priority = priority;
        this.nextHandler = null;
        this.canHandle = null;
        this.processRequest = null;
    }
    
    setNext(handler) {
        this.nextHandler = handler;
        return handler;
    }
    
    handle(request) {
        // Check if this handler can process the request
        if (this.canHandle && this.canHandle(request)) {
            try {
                const result = this.processRequest(request);
                request.markHandled(this.name);
                return result;
            } catch (error) {
                console.error(`Handler ${this.name} failed:`, error);
                // Continue to next handler even if this one fails
            }
        }
        
        // Pass to next handler
        if (this.nextHandler) {
            return this.nextHandler.handle(request);
        }
        
        // No handler could process the request
        throw new Error(`No handler found for request type: ${request.type}`);
    }
    
    // Set custom canHandle function
    setCanHandle(predicate) {
        this.canHandle = predicate;
        return this;
    }
    
    // Set custom processRequest function
    setProcessRequest(processor) {
        this.processRequest = processor;
        return this;
    }
}

// Concrete handlers
class AuthenticationHandler extends Handler {
    constructor() {
        super('Authentication', 100);
        
        this.setCanHandle(request => 
            request.type === 'api' || 
            request.type === 'secure' ||
            request.data.requiresAuth
        );
        
        this.setProcessRequest(request => {
            // Simulate authentication check
            if (!request.data.token || request.data.token === 'invalid') {
                throw new Error('Authentication failed: Invalid token');
            }
            
            if (request.data.token === 'expired') {
                throw new Error('Authentication failed: Token expired');
            }
            
            console.log(`[${this.name}] Authenticated request: ${request.type}`);
            return { ...request.data, authenticated: true };
        });
    }
}

class ValidationHandler extends Handler {
    constructor() {
        super('Validation', 200);
        
        this.setCanHandle(request => 
            request.type === 'api' || 
            request.type === 'form' ||
            request.data.requiresValidation
        );
        
        this.setProcessRequest(request => {
            const { data } = request;
            
            // Validate required fields
            if (data.requiredFields) {
                for (const field of data.requiredFields) {
                    if (!data[field]) {
                        throw new Error(`Validation failed: Missing required field: ${field}`);
                    }
                }
            }
            
            // Validate data types
            if (data.email && !this.isValidEmail(data.email)) {
                throw new Error('Validation failed: Invalid email format');
            }
            
            if (data.age && (typeof data.age !== 'number' || data.age < 0)) {
                throw new Error('Validation failed: Invalid age');
            }
            
            console.log(`[${this.name}] Validated request: ${request.type}`);
            return { ...request.data, validated: true };
        });
    }
    
    isValidEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }
}

class RateLimitHandler extends Handler {
    constructor() {
        super('RateLimit', 300);
        this.requestCounts = new Map();
        this.limits = new Map();
    }
    
    setLimit(identifier, maxRequests, timeWindow) {
        this.limits.set(identifier, { maxRequests, timeWindow, resetTime: Date.now() + timeWindow });
    }
    
    setCanHandle(request => 
        request.type === 'api' || 
        request.data.requiresRateLimit
    );
    
    setProcessRequest(request => {
        const identifier = request.data.userId || request.data.ip || 'default';
        const limit = this.limits.get(identifier) || { maxRequests: 100, timeWindow: 60000 };
        
        // Reset counter if time window has passed
        if (Date.now() > limit.resetTime) {
            this.requestCounts.set(identifier, 0);
            limit.resetTime = Date.now() + limit.timeWindow;
        }
        
        const currentCount = this.requestCounts.get(identifier) || 0;
        
        if (currentCount >= limit.maxRequests) {
            throw new Error(`Rate limit exceeded: ${limit.maxRequests} requests per ${limit.timeWindow}ms`);
        }
        
        this.requestCounts.set(identifier, currentCount + 1);
        console.log(`[${this.name}] Rate limit check passed for ${identifier}: ${currentCount + 1}/${limit.maxRequests}`);
        return request.data;
    });
}

class LoggingHandler extends Handler {
    constructor() {
        super('Logging', 400);
        this.logs = [];
    }
    
    setCanHandle(() => true); // Log all requests
    
    setProcessRequest(request => {
        const logEntry = {
            timestamp: new Date(),
            type: request.type,
            data: request.data,
            priority: request.priority,
            handlerChain: request.getHandlerChain()
        };
        
        this.logs.push(logEntry);
        console.log(`[${this.name}] Logged request:`, logEntry);
        return request.data;
    });
    
    getLogs() {
        return this.logs;
    }
    
    clearLogs() {
        this.logs = [];
    }
}

class BusinessLogicHandler extends Handler {
    constructor() {
        super('BusinessLogic', 500);
        
        this.setCanHandle(request => 
            request.type === 'api' || 
            request.type === 'business'
        );
        
        this.setProcessRequest(request => {
            const { data } = request;
            
            // Apply business rules
            if (data.type === 'order' && data.amount > 1000) {
                data.requiresApproval = true;
                data.approvalLevel = 'manager';
            }
            
            if (data.type === 'user' && data.role === 'admin') {
                data.permissions = ['read', 'write', 'delete', 'admin'];
            }
            
            console.log(`[${this.name}] Applied business logic: ${request.type}`);
            return { ...data, processed: true };
        });
    }
}

// Chain builder for easy setup
class HandlerChainBuilder {
    constructor() {
        this.handlers = [];
    }
    
    addHandler(handler) {
        this.handlers.push(handler);
        return this;
    }
    
    build() {
        if (this.handlers.length === 0) {
            throw new Error('No handlers added to chain');
        }
        
        // Sort handlers by priority
        this.handlers.sort((a, b) => a.priority - b.priority);
        
        // Link handlers
        for (let i = 0; i < this.handlers.length - 1; i++) {
            this.handlers[i].setNext(this.handlers[i + 1]);
        }
        
        return this.handlers[0]; // Return first handler
    }
}

// Usage example
const chain = new HandlerChainBuilder()
    .addHandler(new AuthenticationHandler())
    .addHandler(new ValidationHandler())
    .addHandler(new RateLimitHandler())
    .addHandler(new BusinessLogicHandler())
    .addHandler(new LoggingHandler())
    .build();

// Set rate limits
const rateLimitHandler = chain.nextHandler.nextHandler; // Get RateLimitHandler
rateLimitHandler.setLimit('user123', 10, 60000); // 10 requests per minute

// Create and process requests
const requests = [
    new Request('api', { 
        token: 'valid_token_123', 
        userId: 'user123', 
        email: 'test@example.com',
        age: 25,
        type: 'order',
        amount: 1500,
        requiresAuth: true,
        requiresValidation: true,
        requiresRateLimit: true
    }),
    
    new Request('form', { 
        email: 'invalid-email',
        age: -5,
        requiresValidation: true
    }),
    
    new Request('api', { 
        token: 'expired',
        userId: 'user123',
        requiresAuth: true
    })
];

// Process requests
requests.forEach((request, index) => {
    try {
        console.log(`\n--- Processing Request ${index + 1} ---`);
        const result = chain.handle(request);
        console.log('Result:', result);
    } catch (error) {
        console.error('Error:', error.message);
    }
});

// Get logs from logging handler
const loggingHandler = chain.nextHandler.nextHandler.nextHandler.nextHandler;
console.log('\n--- Request Logs ---');
console.log(loggingHandler.getLogs());
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What are the key benefits of the Revealing Module Pattern over traditional module patterns?
**A:** The Revealing Module Pattern provides better encapsulation by hiding internal implementation details, offers precise control over the public API surface, makes testing easier by clearly separating private vs public methods, enables safe internal refactoring without breaking external contracts, and allows for performance optimization of internal operations.

### Q2: How does the Factory Pattern handle complex object creation scenarios?
**A:** Factory Pattern variations handle complex creation through validation layers, dependency injection, configuration management, object caching for performance, and support for different object types. Advanced factories can create product families, support builder patterns, implement object pooling, and provide fallback creation strategies.

### Q3: What are the main advantages of implementing the Command Pattern with undo/redo functionality?
**A:** Command Pattern with undo/redo provides complete operation history, enables user experience improvements through reversible actions, supports macro commands for batch operations, provides audit trails for compliance, enables debugging through command replay, and allows for command queuing and scheduling.

### Q4: How does Chain of Responsibility improve system flexibility and maintainability?
**A:** Chain of Responsibility improves flexibility by allowing dynamic handler chains, enables easy addition of new handlers without modifying existing code, provides single responsibility for each handler, supports graceful degradation through fallback handling, and allows for conditional processing based on request characteristics.

### Q5: What are the performance considerations when implementing these design patterns?
**A:** Performance considerations include caching strategies for factory patterns, command history size limits, handler chain optimization, memory management for command objects, efficient validation in chain handlers, and proper resource cleanup for long-running command chains.

---

## 🏋️ Practice Exercises

### Exercise 1: Build a Plugin System with Revealing Module Pattern
Create a plugin architecture where plugins can register themselves, expose only necessary APIs, and be loaded/unloaded dynamically while maintaining encapsulation.

### Exercise 2: Implement a Smart Factory with Validation and Caching
Build a factory system that can create different types of objects with automatic validation, caching, and fallback strategies for different creation scenarios.

### Exercise 3: Create a Command System with Persistence
Implement a command system that can persist commands to storage, support remote execution, and provide command analytics and reporting.

### Exercise 4: Design a Dynamic Handler Chain
Build a chain of responsibility system that can dynamically add/remove handlers, support conditional processing, and provide performance monitoring and metrics.

---

## 📚 Additional Resources

- **Design Patterns**: [Gang of Four Patterns](https://en.wikipedia.org/wiki/Design_Patterns)
- **JavaScript Patterns**: [JavaScript Design Patterns](https://addyosmani.com/resources/essentialjsdesignpatterns/book/)
- **Module Patterns**: [JavaScript Module Patterns](https://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html)
- **Command Pattern**: [Command Pattern Tutorial](https://refactoring.guru/design-patterns/command)
- **Chain of Responsibility**: [Chain of Responsibility Pattern](https://refactoring.guru/design-patterns/chain-of-responsibility)

---

## 📋 Copy Code Functionality
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced Factory Pattern with multiple variations and caching
class ProductFactory {
    constructor() {
        this.cache = new Map();
        this.validators = new Map();
        this.creators = new Map();
        this.setupValidators();
        this.setupCreators();
    }
    
    setupValidators() {
        // Product type validators
        this.validators.set('electronics', (config) => {
            const required = ['name', 'price', 'warranty'];
            const missing = required.filter(field => !config[field]);
            
            if (missing.length > 0) {
                throw new Error(`Missing required fields: ${missing.join(', ')}`);
            }
            
            if (config.price <= 0) {
                throw new Error('Price must be positive');
            }
            
            if (config.warranty < 0) {
                throw new Error('Warranty cannot be negative');
            }
            
            return true;
        });
        
        this.validators.set('clothing', (config) => {
            const required = ['name', 'price', 'size', 'material'];
            const missing = required.filter(field => !config[field]);
            
            if (missing.length > 0) {
                throw new Error(`Missing required fields: ${missing.join(', ')}`);
            }
            
            const validSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
            if (!validSizes.includes(config.size)) {
                throw new Error(`Invalid size. Must be one of: ${validSizes.join(', ')}`);
            }
            
            return true;
        });
        
        this.validators.set('books', (config) => {
            const required = ['title', 'author', 'price', 'isbn'];
            const missing = required.filter(field => !config[field]);
            
            if (missing.length > 0) {
                throw new Error(`Missing required fields: ${missing.join(', ')}`);
            }
            
            if (config.isbn.length !== 13) {
                throw new Error('ISBN must be 13 characters long');
            }
            
            return true;
        });
    }
    
    setupCreators() {
        // Product creators for different types
        this.creators.set('electronics', (config) => ({
            id: this.generateId(),
            type: 'electronics',
            name: config.name,
            price: config.price,
            warranty: config.warranty,
            features: config.features || [],
            createdAt: new Date(),
            getWarrantyInfo() {
                return `${this.warranty} months warranty`;
            },
            getPriceWithTax() {
                return this.price * 1.1; // 10% tax
            }
        }));
        
        this.creators.set('clothing', (config) => ({
            id: this.generateId(),
            type: 'clothing',
            name: config.name,
            price: config.price,
            size: config.size,
            material: config.material,
            colors: config.colors || ['black'],
            createdAt: new Date(),
            getSizeInfo() {
                return `Size: ${this.size}`;
            },
            getPriceWithTax() {
                return this.price * 1.08; // 8% tax
            }
        }));
        
        this.creators.set('books', (config) => ({
            id: this.generateId(),
            type: 'books',
            title: config.title,
            author: config.author,
            price: config.price,
            isbn: config.isbn,
            genre: config.genre || 'General',
            pages: config.pages || 0,
            createdAt: new Date(),
            getBookInfo() {
                return `${this.title} by ${this.author}`;
            },
            getPriceWithTax() {
                return this.price * 1.05; // 5% tax
            }
        }));
    }
    
    generateId() {
        return Date.now().toString(36) + Math.random().toString(36).substr(2);
    }
    
    // Main factory method
    createProduct(type, config) {
        try {
            // Validate input
            if (!this.validators.has(type)) {
                throw new Error(`Unknown product type: ${type}`);
            }
            
            // Validate configuration
            this.validators.get(type)(config);
            
            // Check cache
            const cacheKey = `${type}-${JSON.stringify(config)}`;
            if (this.cache.has(cacheKey)) {
                return this.cache.get(cacheKey);
            }
            
            // Create product
            const creator = this.creators.get(type);
            const product = creator(config);
            
            // Cache the product
            this.cache.set(cacheKey, product);
            
            return product;
        } catch (error) {
            console.error(`Error creating ${type} product:`, error);
            throw error;
        }
    }
    
    // Factory method for creating multiple products
    createProducts(type, configs) {
        return configs.map(config => this.createProduct(type, config));
    }
    
    // Abstract factory for creating product families
    createProductFamily(familyType) {
        const families = {
            'gaming': {
                electronics: { name: 'Gaming Console', price: 499, warranty: 24, features: ['4K', 'VR Ready'] },
                clothing: { name: 'Gaming T-Shirt', price: 25, size: 'L', material: 'Cotton', colors: ['Black', 'Red'] },
                books: { title: 'Game Development Guide', author: 'Game Dev Pro', price: 39, isbn: '1234567890123', genre: 'Technology' }
            },
            'professional': {
                electronics: { name: 'Laptop', price: 1299, warranty: 36, features: ['16GB RAM', '512GB SSD'] },
                clothing: { name: 'Business Suit', price: 299, size: 'M', material: 'Wool', colors: ['Navy', 'Charcoal'] },
                books: { title: 'Business Strategy', author: 'Business Expert', price: 49, isbn: '9876543210987', genre: 'Business' }
            }
        };
        
        if (!families[familyType]) {
            throw new Error(`Unknown family type: ${familyType}`);
        }
        
        const family = families[familyType];
        return {
            electronics: this.createProduct('electronics', family.electronics),
            clothing: this.createProduct('clothing', family.clothing),
            books: this.createProduct('books', family.books)
        };
    }
    
    // Cache management
    clearCache() {
        this.cache.clear();
    }
    
    getCacheStats() {
        return {
            size: this.cache.size,
            keys: Array.from(this.cache.keys())
        };
    }
}

// Usage example
const factory = new ProductFactory();

// Create individual products
const laptop = factory.createProduct('electronics', {
    name: 'High-Performance Laptop',
    price: 1499,
    warranty: 36,
    features: ['32GB RAM', '1TB SSD', 'RTX 4080']
});

const tshirt = factory.createProduct('clothing', {
    name: 'Premium T-Shirt',
    price: 35,
    size: 'L',
    material: 'Organic Cotton',
    colors: ['White', 'Black', 'Navy']
});

// Create product family
const gamingFamily = factory.createProductFamily('gaming');
console.log('Gaming family:', gamingFamily);

// Check cache stats
console.log('Cache stats:', factory.getCacheStats());
</code></pre>
</div>

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="../02-Advanced-JavaScript-Concepts/08-ES2023-Features.md" class="nav-link prev">← Previous: ES2023 Features</a>
    <a href="02-Functional-Programming-Patterns.md" class="nav-link next">Next: Functional Programming Patterns →</a>
</div>

*Last updated: December 2024*
