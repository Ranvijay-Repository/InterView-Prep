# 🔹 Advanced DOM & Events

> **Comprehensive coverage of advanced DOM concepts: Event Propagation, Event Delegation patterns, and Custom Events & EventTarget**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [DOM & Events Overview](#dom--events-overview)
- [Event Propagation (Capturing vs Bubbling)](#event-propagation-capturing-vs-bubbling)
- [Event Delegation Patterns](#event-delegation-patterns)
- [Custom Events & EventTarget](#custom-events--eventtarget)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 DOM & Events Overview

**Advanced DOM & Events** covers the sophisticated aspects of DOM manipulation, event handling, and browser interaction that are essential for building complex web applications.

### Why Advanced DOM & Events Matter:
- **Performance**: Efficient event handling for large applications
- **Scalability**: Handle dynamic content with event delegation
- **Customization**: Create custom events for complex interactions
- **Browser Compatibility**: Understand cross-browser event behavior
- **User Experience**: Smooth, responsive interactions

---

## 🔄 Event Propagation (Capturing vs Bubbling)

**Event Propagation** describes how events travel through the DOM tree, with three phases: capturing, target, and bubbling.

### Why Event Propagation Matters:
- **Event Order**: Control the sequence of event handling
- **Event Delegation**: Handle events at parent levels
- **Performance**: Optimize event handling for complex UIs
- **Debugging**: Understand event flow in complex applications

### ASCII Diagram: Event Propagation Flow

```
EVENT PROPAGATION FLOW
┌─────────────────────────────────┐
│        DOM TREE STRUCTURE       │
│  ┌─────────────────────────────┐ │
│  │        document             │ │
│  │             │               │ │
│  │             ▼               │ │
│  │           <html>            │ │
│  │             │               │ │
│  │             ▼               │ │
│  │          <body>             │ │
│  │             │               │ │
│  │             ▼               │ │
│  │         <div id="parent">   │ │
│  │             │               │ │
│  │             ▼               │ │
│  │       <button id="child">   │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  CAPTURING    │
        │  Phase 1      │
        │  Top → Down   │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  TARGET       │
        │  Phase 2      │
        │  Element      │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  BUBBLING     │
        │  Phase 3      │
        │  Down → Up    │
        └───────────────┘
```


### Event Phases:
1. **Capturing Phase**: Events travel from root to target (top-down)
2. **Target Phase**: Event reaches the target element
3. **Bubbling Phase**: Events travel from target to root (bottom-up)

### Event Listener Options:

```javascript
// Capturing phase (true = capturing, false = bubbling)
element.addEventListener('click', handler, true);  // Capturing
element.addEventListener('click', handler, false); // Bubbling (default)
element.addEventListener('click', handler);        // Bubbling (default)

// Modern options object
element.addEventListener('click', handler, {
    capture: true,      // Capturing phase
    once: true,         // Remove after first execution
    passive: true,      // Promise not to call preventDefault()
    signal: abortSignal // AbortController signal
});
```


---

## 🎭 Event Delegation Patterns

**Event Delegation** is a technique where you attach event listeners to parent elements to handle events from child elements.

### Why Event Delegation Matters:
- **Performance**: Fewer event listeners for dynamic content
- **Memory Efficiency**: Reduced memory usage in large applications
- **Dynamic Content**: Handle events from elements added later
- **Scalability**: Better performance with many elements

### ASCII Diagram: Event Delegation Pattern

```
EVENT DELEGATION PATTERN
┌─────────────────────────────────┐
│        EVENT HANDLING           │
│  ┌─────────────────────────────┐ │
│  │     Parent Container        │ │
│  │  ┌─────────────────────┐   │ │
│  │  │ Event Listener      │   │ │
│  │  │ (Single Listener)   │   │ │
│  │  └─────────────────────┘   │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  CHILD        │
        │  ELEMENTS     │
        │  (Many)       │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  EVENT        │
        │  BUBBLES UP   │
        │  TO PARENT    │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  TARGET       │
        │  CHECKING     │
        │  & HANDLING   │
        └───────────────┘
```


### Use Cases:
- **Dynamic Lists**: Handle events from items added/removed
- **Large Tables**: Efficient event handling for many rows
- **Form Validation**: Centralized form event handling
- **Navigation Menus**: Handle menu item events efficiently

---

## 🎪 Custom Events & EventTarget

**Custom Events** allow you to create and dispatch your own events, while **EventTarget** provides a base for objects that can receive events.

### Why Custom Events & EventTarget Matter:
- **Component Communication**: Decouple components with events
- **Custom Interactions**: Create domain-specific events
- **Event Architecture**: Build event-driven systems
- **Testing**: Simulate user interactions programmatically

### ASCII Diagram: Custom Event System

```
CUSTOM EVENT SYSTEM
┌─────────────────────────────────┐
│        EVENT DISPATCHER         │
│  ┌─────────────────────────────┐ │
│  │ CustomEvent('userAction')   │ │
│  │                             │ │
│  │ detail: { action, data }    │ │
│  │ bubbles: true               │ │
│  │ cancelable: true            │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  EVENT        │
        │  DISPATCH     │
        │  element.dispatchEvent() │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  EVENT        │
        │  LISTENERS    │
        │  Handle       │
        │  Custom Event │
        └───────────────┘
```


### Custom Event Features:
- **Custom Data**: Pass data through event.detail
- **Event Bubbling**: Control event propagation
- **Event Cancellation**: Allow event.preventDefault()
- **Event Composition**: Build complex event systems

---

## 💻 Detailed Examples

### Example 1: Event Propagation Demonstration
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Event propagation demonstration with all three phases
class EventPropagationDemo {
    constructor() {
        this.setupDOM();
        this.setupEventListeners();
        this.logContainer = document.getElementById('event-log');
    }
    
    setupDOM() {
        const container = document.createElement('div');
        container.innerHTML = `
            <div id="capturing-demo" style="padding: 20px; border: 2px solid #007acc; margin: 10px;">
                <h3>Capturing Phase (Phase 1)</h3>
                <div id="parent" style="padding: 15px; border: 2px solid #28a745; margin: 10px;">
                    <h4>Target Phase (Phase 2)</h4>
                    <button id="child" style="padding: 10px 20px; background: #dc3545; color: white; border: none; border-radius: 4px;">
                        Click Me!
                    </button>
                    <h4>Bubbling Phase (Phase 3)</h4>
                </div>
            </div>
            <div id="event-log" style="background: #f8f9fa; padding: 15px; border: 1px solid #dee2e6; margin-top: 20px; max-height: 300px; overflow-y: auto;">
                <h4>Event Log:</h4>
                <div id="log-content"></div>
            </div>
        `;
        document.body.appendChild(container);
    }
    
    setupEventListeners() {
        const capturingDemo = document.getElementById('capturing-demo');
        const parent = document.getElementById('parent');
        const child = document.getElementById('child');
        
        // Capturing phase listeners (Phase 1)
        capturingDemo.addEventListener('click', this.createHandler('Document (Capturing)', 1), true);
        parent.addEventListener('click', this.createHandler('Parent (Capturing)', 1), true);
        
        // Target phase listener (Phase 2)
        child.addEventListener('click', this.createHandler('Child (Target)', 2), false);
        
        // Bubbling phase listeners (Phase 3)
        parent.addEventListener('click', this.createHandler('Parent (Bubbling)', 3), false);
        capturingDemo.addEventListener('click', this.createHandler('Document (Bubbling)', 3), false);
        
        // Add document-level listener
        document.addEventListener('click', this.createHandler('Document Root (Capturing)', 1), true);
        document.addEventListener('click', this.createHandler('Document Root (Bubbling)', 3), false);
    }
    
    createHandler(name, phase) {
        return (event) => {
            const phaseName = phase === 1 ? 'Capturing' : phase === 2 ? 'Target' : 'Bubbling';
            const timestamp = new Date().toLocaleTimeString();
            
            this.logEvent(`${timestamp} - ${name} (${phaseName} Phase)`);
            
            // Add visual feedback
            event.currentTarget.style.backgroundColor = this.getPhaseColor(phase);
            setTimeout(() => {
                event.currentTarget.style.backgroundColor = '';
            }, 200);
        };
    }
    
    getPhaseColor(phase) {
        switch (phase) {
            case 1: return '#ffeb3b'; // Yellow for capturing
            case 2: return '#4caf50'; // Green for target
            case 3: return '#2196f3'; // Blue for bubbling
            default: return 'transparent';
        }
    }
    
    logEvent(message) {
        const logContent = document.getElementById('log-content');
        const logEntry = document.createElement('div');
        logEntry.style.padding = '5px';
        logEntry.style.borderBottom = '1px solid #dee2e6';
        logEntry.textContent = message;
        logContent.appendChild(logEntry);
        
        // Auto-scroll to bottom
        this.logContainer.scrollTop = this.logContainer.scrollHeight;
    }
    
    clearLog() {
        const logContent = document.getElementById('log-content');
        logContent.innerHTML = '';
    }
}

// Usage
const demo = new EventPropagationDemo();

// Add clear button
const clearButton = document.createElement('button');
clearButton.textContent = 'Clear Log';
clearButton.style.margin = '10px';
clearButton.onclick = () => demo.clearLog();
document.body.appendChild(clearButton);
</code></pre>
</div>

### Example 2: Advanced Event Delegation System
<div style="position: relative;">
<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Advanced event delegation system for dynamic content
class EventDelegationSystem {
    constructor(containerSelector) {
        this.container = document.querySelector(containerSelector);
        this.eventHandlers = new Map();
        this.setupGlobalListeners();
    }
    
    setupGlobalListeners() {
        // Single event listener for the entire container
        this.container.addEventListener('click', this.handleClick.bind(this), false);
        this.container.addEventListener('input', this.handleInput.bind(this), false);
        this.container.addEventListener('change', this.handleChange.bind(this), false);
        this.container.addEventListener('submit', this.handleSubmit.bind(this), false);
    }
    
    // Handle click events with delegation
    handleClick(event) {
        const target = event.target;
        const action = target.dataset.action;
        
        if (!action) return;
        
        // Find the appropriate handler
        const handler = this.eventHandlers.get(action);
        if (handler) {
            handler.call(this, event, target);
        }
    }
    
    // Handle input events with delegation
    handleInput(event) {
        const target = event.target;
        const action = target.dataset.action;
        
        if (action === 'validate') {
            this.validateInput(target);
        }
    }
    
    // Handle change events with delegation
    handleChange(event) {
        const target = event.target;
        const action = target.dataset.action;
        
        if (action === 'update') {
            this.updateRelatedFields(target);
        }
    }
    
    // Handle form submission with delegation
    handleSubmit(event) {
        const target = event.target;
        const action = target.dataset.action;
        
        if (action === 'submit') {
            event.preventDefault();
            this.handleFormSubmission(target);
        }
    }
    
    // Register event handlers
    registerHandler(action, handler) {
        this.eventHandlers.set(action, handler);
    }
    
    // Add dynamic content with event delegation
    addDynamicContent(content, container = this.container) {
        const tempDiv = document.createElement('div');
        tempDiv.innerHTML = content;
        
        // Extract and append nodes
        while (tempDiv.firstChild) {
            container.appendChild(tempDiv.firstChild);
        }
    }
    
    // Remove dynamic content
    removeDynamicContent(selector) {
        const elements = this.container.querySelectorAll(selector);
        elements.forEach(element => element.remove());
    }
    
    // Validation handler
    validateInput(input) {
        const value = input.value;
        const validationType = input.dataset.validation;
        let isValid = true;
        let errorMessage = '';
        
        switch (validationType) {
            case 'email':
                isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
                errorMessage = 'Please enter a valid email address';
                break;
            case 'required':
                isValid = value.trim().length > 0;
                errorMessage = 'This field is required';
                break;
            case 'minLength':
                const minLength = parseInt(input.dataset.minLength);
                isValid = value.length >= minLength;
                errorMessage = `Minimum length is ${minLength} characters`;
                break;
        }
        
        this.showValidationResult(input, isValid, errorMessage);
    }
    
    // Show validation result
    showValidationResult(input, isValid, message) {
        // Remove existing validation message
        const existingMessage = input.parentNode.querySelector('.validation-message');
        if (existingMessage) {
            existingMessage.remove();
        }
        
        if (!isValid) {
            const messageDiv = document.createElement('div');
            messageDiv.className = 'validation-message';
            messageDiv.style.color = 'red';
            messageDiv.style.fontSize = '12px';
            messageDiv.style.marginTop = '5px';
            messageDiv.textContent = message;
            input.parentNode.appendChild(messageDiv);
        }
        
        input.style.borderColor = isValid ? '#28a745' : '#dc3545';
    }
    
    // Update related fields
    updateRelatedFields(changedField) {
        const fieldName = changedField.name;
        const value = changedField.value;
        
        // Find related fields and update them
        const relatedFields = this.container.querySelectorAll(`[data-related-to="${fieldName}"]`);
        relatedFields.forEach(field => {
            if (field.type === 'text') {
                field.value = value;
            } else if (field.type === 'checkbox') {
                field.checked = value === 'true';
            }
        });
    }
    
    // Handle form submission
    handleFormSubmission(form) {
        const formData = new FormData(form);
        const data = Object.fromEntries(formData.entries());
        
        // Validate all required fields
        const requiredFields = form.querySelectorAll('[data-validation="required"]');
        let isValid = true;
        
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                this.validateInput(field);
                isValid = false;
            }
        });
        
        if (isValid) {
            console.log('Form data:', data);
            // Submit form data
            this.submitForm(data);
        }
    }
    
    // Submit form data
    submitForm(data) {
        // Simulate API call
        console.log('Submitting form data:', data);
        
        // Show success message
        const successMessage = document.createElement('div');
        successMessage.style.color = '#28a745';
        successMessage.style.padding = '10px';
        successMessage.style.backgroundColor = '#d4edda';
        successMessage.style.border = '1px solid #c3e6cb';
        successMessage.style.borderRadius = '4px';
        successMessage.style.marginTop = '10px';
        successMessage.textContent = 'Form submitted successfully!';
        
        this.container.appendChild(successMessage);
        
        // Remove message after 3 seconds
        setTimeout(() => {
            successMessage.remove();
        }, 3000);
    }
}

// Usage example
const delegationSystem = new EventDelegationSystem('#app');

// Register custom handlers
delegationSystem.registerHandler('delete', (event, target) => {
    const itemId = target.dataset.id;
    console.log(`Deleting item: ${itemId}`);
    target.closest('.item').remove();
});

delegationSystem.registerHandler('edit', (event, target) => {
    const itemId = target.dataset.id;
    console.log(`Editing item: ${itemId}`);
    // Show edit form
});

// Add dynamic content
delegationSystem.addDynamicContent(`
    <div class="form-container">
        <form data-action="submit">
            <div>
                <label>Email:</label>
                <input type="email" name="email" data-action="validate" data-validation="email" required>
            </div>
            <div>
                <label>Name:</label>
                <input type="text" name="name" data-action="validate" data-validation="required" data-min-length="2">
            </div>
            <div>
                <label>Subscribe:</label>
                <input type="checkbox" name="subscribe" data-related-to="email">
            </div>
            <button type="submit">Submit</button>
        </form>
    </div>
    
    <div class="dynamic-list">
        <div class="item" data-id="1">
            Item 1
            <button data-action="edit" data-id="1">Edit</button>
            <button data-action="delete" data-id="1">Delete</button>
        </div>
        <div class="item" data-id="2">
            Item 2
            <button data-action="edit" data-id="2">Edit</button>
            <button data-action="delete" data-id="2">Delete</button>
        </div>
    </div>
`);
</code></pre>
</div>

### Example 3: Custom Events & EventTarget Implementation
<div style="position: relative;">
<button onclick="copyCode(this)" class="copyCode(this)" class="copy-btn">📋 Copy</button>
<pre><code>// Custom event system with EventTarget
class CustomEventSystem extends EventTarget {
    constructor() {
        super();
        this.eventHistory = [];
        this.maxHistorySize = 100;
    }
    
    // Create and dispatch custom events
    dispatchCustomEvent(eventName, detail = {}, options = {}) {
        const event = new CustomEvent(eventName, {
            detail,
            bubbles: options.bubbles !== false,
            cancelable: options.cancelable !== false,
            composed: options.composed || false
        });
        
        // Store event in history
        this.addToHistory(eventName, detail, options);
        
        // Dispatch the event
        const dispatched = this.dispatchEvent(event);
        
        // Log the event
        console.log(`Custom event '${eventName}' dispatched:`, {
            detail,
            options,
            dispatched,
            timestamp: new Date().toISOString()
        });
        
        return dispatched;
    }
    
    // Add event to history
    addToHistory(eventName, detail, options) {
        this.eventHistory.push({
            name: eventName,
            detail,
            options,
            timestamp: new Date().toISOString()
        });
        
        // Limit history size
        if (this.eventHistory.length > this.maxHistorySize) {
            this.eventHistory.shift();
        }
    }
    
    // Get event history
    getEventHistory(filter = {}) {
        let filtered = this.eventHistory;
        
        if (filter.name) {
            filtered = filtered.filter(event => event.name === filter.name);
        }
        
        if (filter.since) {
            const sinceDate = new Date(filter.since);
            filtered = filtered.filter(event => new Date(event.timestamp) >= sinceDate);
        }
        
        return filtered;
    }
    
    // Clear event history
    clearEventHistory() {
        this.eventHistory = [];
    }
}

// Component base class with custom events
class Component extends EventTarget {
    constructor(name) {
        super();
        this.name = name;
        this.state = {};
        this.children = new Set();
    }
    
    // Set component state
    setState(newState) {
        const oldState = { ...this.state };
        this.state = { ...this.state, ...newState };
        
        // Dispatch state change event
        this.dispatchEvent(new CustomEvent('stateChange', {
            detail: { oldState, newState, component: this.name },
            bubbles: true
        }));
        
        // Update children
        this.children.forEach(child => {
            if (child.onParentStateChange) {
                child.onParentStateChange(this.state);
            }
        });
    }
    
    // Add child component
    addChild(child) {
        this.children.add(child);
        child.parent = this;
        
        // Dispatch child added event
        this.dispatchEvent(new CustomEvent('childAdded', {
            detail: { child, parent: this.name },
            bubbles: true
        }));
    }
    
    // Remove child component
    removeChild(child) {
        this.children.delete(child);
        child.parent = null;
        
        // Dispatch child removed event
        this.dispatchEvent(new CustomEvent('childRemoved', {
            detail: { child, parent: this.name },
            bubbles: true
        }));
    }
    
    // Lifecycle method
    mount() {
        this.dispatchEvent(new CustomEvent('componentMounted', {
            detail: { component: this.name },
            bubbles: true
        }));
    }
    
    // Lifecycle method
    unmount() {
        this.dispatchEvent(new CustomEvent('componentUnmounted', {
            detail: { component: this.name },
            bubbles: true
        }));
    }
}

// Specific component implementations
class UserProfile extends Component {
    constructor() {
        super('UserProfile');
        this.state = {
            name: '',
            email: '',
            avatar: null
        };
    }
    
    // Update user profile
    updateProfile(profileData) {
        this.setState(profileData);
        
        // Dispatch custom event
        this.dispatchEvent(new CustomEvent('profileUpdated', {
            detail: { profile: profileData, component: this.name },
            bubbles: true
        }));
    }
    
    // Handle avatar upload
    uploadAvatar(file) {
        // Simulate file upload
        const reader = new FileReader();
        reader.onload = (e) => {
            this.setState({ avatar: e.target.result });
            
            // Dispatch avatar upload event
            this.dispatchEvent(new CustomEvent('avatarUploaded', {
                detail: { avatar: e.target.result, component: this.name },
                bubbles: true
            }));
        };
        reader.readAsDataURL(file);
    }
}

class NotificationSystem extends Component {
    constructor() {
        super('NotificationSystem');
        this.state = {
            notifications: [],
            isVisible: false
        };
    }
    
    // Add notification
    addNotification(message, type = 'info') {
        const notification = {
            id: Date.now(),
            message,
            type,
            timestamp: new Date().toISOString()
        };
        
        const newNotifications = [...this.state.notifications, notification];
        this.setState({ notifications: newNotifications });
        
        // Dispatch notification added event
        this.dispatchEvent(new CustomEvent('notificationAdded', {
            detail: { notification, component: this.name },
            bubbles: true
        }));
        
        // Auto-remove notification after 5 seconds
        setTimeout(() => {
            this.removeNotification(notification.id);
        }, 5000);
    }
    
    // Remove notification
    removeNotification(id) {
        const newNotifications = this.state.notifications.filter(n => n.id !== id);
        this.setState({ notifications: newNotifications });
        
        // Dispatch notification removed event
        this.dispatchEvent(new CustomEvent('notificationRemoved', {
            detail: { id, component: this.name },
            bubbles: true
        }));
    }
    
    // Toggle visibility
    toggleVisibility() {
        this.setState({ isVisible: !this.state.isVisible });
    }
}

// Usage example
const eventSystem = new CustomEventSystem();
const userProfile = new UserProfile();
const notificationSystem = new NotificationSystem();

// Add components to event system
eventSystem.addChild(userProfile);
eventSystem.addChild(notificationSystem);

// Listen for custom events
eventSystem.addEventListener('stateChange', (event) => {
    console.log('State changed:', event.detail);
});

eventSystem.addEventListener('profileUpdated', (event) => {
    console.log('Profile updated:', event.detail);
    notificationSystem.addNotification('Profile updated successfully!', 'success');
});

eventSystem.addEventListener('avatarUploaded', (event) => {
    console.log('Avatar uploaded:', event.detail);
    notificationSystem.addNotification('Avatar uploaded successfully!', 'success');
});

eventSystem.addEventListener('notificationAdded', (event) => {
    console.log('Notification added:', event.detail);
});

// Mount components
userProfile.mount();
notificationSystem.mount();

// Simulate user actions
setTimeout(() => {
    userProfile.updateProfile({ name: 'John Doe', email: 'john@example.com' });
}, 1000);

setTimeout(() => {
    // Simulate file upload
    const file = new File(['avatar'], 'avatar.png', { type: 'image/png' });
    userProfile.uploadAvatar(file);
}, 2000);

// Get event history
setTimeout(() => {
    const history = eventSystem.getEventHistory({ since: new Date(Date.now() - 10000) });
    console.log('Recent events:', history);
}, 3000);
</code></pre>
</div>

---

## ❓ Common Interview Questions

### Q1: What are the three phases of event propagation and how do they work?
**A:** The three phases are: 1) **Capturing Phase** - Events travel from the root (document) down to the target element, 2) **Target Phase** - The event reaches the target element, and 3) **Bubbling Phase** - Events travel from the target back up to the root. You can control which phase to listen to using the third parameter of addEventListener (true for capturing, false for bubbling).

### Q2: How does event delegation improve performance in large applications?
**A:** Event delegation reduces the number of event listeners by attaching a single listener to a parent element instead of multiple listeners to individual child elements. This improves memory usage, reduces DOM manipulation overhead, and makes it easier to handle dynamic content that's added or removed from the DOM.

### Q3: What are the benefits of using custom events in component architecture?
**A:** Custom events provide loose coupling between components, enable better testing through event simulation, create a clear communication pattern, and allow for event composition and chaining. They're particularly useful in large applications where components need to communicate without direct dependencies.

### Q4: How do you prevent event bubbling and when would you use it?
**A:** Use `event.stopPropagation()` to prevent an event from bubbling up to parent elements, or `event.stopImmediatePropagation()` to prevent other listeners on the same element from executing. Use this when you want to isolate event handling to a specific element or prevent parent handlers from interfering with child element events.

### Q5: What's the difference between EventTarget and HTMLElement for custom events?
**A:** EventTarget is the base interface that provides event handling capabilities and can be extended by any class, while HTMLElement is specifically for DOM elements. EventTarget is more lightweight and suitable for non-DOM objects that need event handling, while HTMLElement provides additional DOM-specific functionality along with event handling.

---

## 🏋️ Practice Exercises

### Exercise 1: Build an Event Propagation Visualizer
Create an interactive tool that visualizes event propagation through a DOM tree, showing the different phases with color coding and timing information.

### Exercise 2: Implement a Dynamic Form System
Build a form system using event delegation that can dynamically add/remove fields, validate input in real-time, and handle form submission with custom events.

### Exercise 3: Create a Component Communication System
Implement a component system using custom events where components can communicate with each other without direct dependencies, including event history and debugging tools.

---

## 📚 Additional Resources

- **Event Propagation**: [MDN Event Propagation](https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase)
- **Event Delegation**: [MDN Event Delegation](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events#Event_delegation)
- **Custom Events**: [MDN CustomEvent](https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent)
- **EventTarget**: [MDN EventTarget](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget)
- **Event Handling**: [JavaScript.info Events](https://javascript.info/events)

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="../02-Advanced-JavaScript-Concepts/08-ES2023-Features.md" class="nav-link prev">← Previous: ES2023+ Features</a>
    <a href="02-Web-APIs-Performance.md" class="nav-link next">Next: Web APIs & Performance →</a>
</div>

*Last updated: December 2024*
