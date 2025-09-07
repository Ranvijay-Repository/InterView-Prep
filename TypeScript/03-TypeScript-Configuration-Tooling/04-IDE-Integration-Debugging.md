# 🔧 **IDE Integration & Debugging**

> **Complete guide to TypeScript IDE integration, debugging setup, and development tools**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [IDE Integration Overview](#ide-integration-overview)
- [VS Code Setup](#vs-code-setup)
- [IntelliSense & Autocomplete](#intellisense--autocomplete)
- [Debugging Configuration](#debugging-configuration)
- [Linting & Formatting](#linting--formatting)
- [Advanced IDE Features](#advanced-ide-features)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **IDE Integration Overview**

Modern IDEs provide excellent TypeScript support with IntelliSense, debugging, and development tools.

### **Popular IDEs with TypeScript Support**

```typescript
// IDE comparison for TypeScript
const ideSupport = {
  vscode: {
    features: ["IntelliSense", "Debugging", "Extensions", "Git integration"],
    pros: ["Excellent TypeScript support", "Large ecosystem", "Free"],
    cons: ["Resource intensive", "Complex configuration"]
  },
  webstorm: {
    features: ["Advanced refactoring", "Built-in tools", "Database support"],
    pros: ["Powerful features", "Built-in everything", "Great for large projects"],
    cons: ["Paid", "Heavy", "Steep learning curve"]
  },
  vim: {
    features: ["Lightweight", "Customizable", "Terminal integration"],
    pros: ["Fast", "Lightweight", "Highly customizable"],
    cons: ["Steep learning curve", "Limited GUI features"]
  }
};
```

### **Essential TypeScript IDE Features**

```typescript
// Key features for TypeScript development
const essentialFeatures = {
  intellisense: "Code completion, parameter hints, quick info",
  debugging: "Breakpoints, variable inspection, call stack",
  refactoring: "Rename, extract method, move symbol",
  errorChecking: "Real-time error detection, type checking",
  navigation: "Go to definition, find references, symbol search"
};
```

---

## 💻 **VS Code Setup**

VS Code provides excellent TypeScript support out of the box.

### **Basic VS Code Configuration**

```json
// .vscode/settings.json
{
  "typescript.preferences.importModuleSpecifier": "relative",
  "typescript.suggest.autoImports": true,
  "typescript.updateImportsOnFileMove.enabled": "always",
  "typescript.preferences.includePackageJsonAutoImports": "auto",
  "typescript.suggest.includeCompletionsForModuleExports": true,
  "typescript.suggest.includeCompletionsWithSnippetText": true,
  "typescript.suggest.includeCompletionsWithInsertText": true
}
```

### **Advanced VS Code Configuration**

```json
// .vscode/settings.json
{
  "typescript.preferences.importModuleSpecifier": "relative",
  "typescript.suggest.autoImports": true,
  "typescript.updateImportsOnFileMove.enabled": "always",
  "typescript.preferences.includePackageJsonAutoImports": "auto",
  "typescript.suggest.includeCompletionsForModuleExports": true,
  "typescript.suggest.includeCompletionsWithSnippetText": true,
  "typescript.suggest.includeCompletionsWithInsertText": true,
  "typescript.suggest.includeCompletionsWithReplaceText": true,
  "typescript.suggest.includeCompletionsWithClassMemberSnippets": true,
  "typescript.suggest.includeCompletionsWithObjectLiteralMethodSnippets": true,
  "typescript.suggest.includeCompletionsWithFunctionParameterSnippets": true,
  "typescript.suggest.includeCompletionsWithInsertText": true,
  "typescript.suggest.includeCompletionsWithSnippetText": true,
  "typescript.suggest.includeCompletionsWithReplaceText": true,
  "typescript.suggest.includeCompletionsWithClassMemberSnippets": true,
  "typescript.suggest.includeCompletionsWithObjectLiteralMethodSnippets": true,
  "typescript.suggest.includeCompletionsWithFunctionParameterSnippets": true
}
```

### **VS Code Extensions**

```json
// .vscode/extensions.json
{
  "recommendations": [
    "ms-vscode.vscode-typescript-next",
    "bradlc.vscode-tailwindcss",
    "esbenp.prettier-vscode",
    "ms-vscode.vscode-eslint",
    "ms-vscode.vscode-json",
    "ms-vscode.vscode-css-peek",
    "ms-vscode.vscode-html-css-support",
    "ms-vscode.vscode-typescript-next",
    "ms-vscode.vscode-typescript-next"
  ]
}
```

---

## 🧠 **IntelliSense & Autocomplete**

IntelliSense provides intelligent code completion and suggestions.

### **Basic IntelliSense Features**

```typescript
// IntelliSense provides:
// 1. Code completion
interface User {
  id: number;
  name: string;
  email: string;
}

const user: User = {
  id: 1,
  name: "John",
  email: "john@example.com"
};

// IntelliSense will suggest: id, name, email
user. // <- IntelliSense shows available properties

// 2. Parameter hints
function createUser(name: string, email: string, age?: number): User {
  return { id: Date.now(), name, email };
}

// IntelliSense shows parameter types and names
createUser( // <- Shows: (name: string, email: string, age?: number) => User
```

### **Advanced IntelliSense Configuration**

```json
// .vscode/settings.json
{
  "typescript.suggest.autoImports": true,
  "typescript.suggest.includeCompletionsForModuleExports": true,
  "typescript.suggest.includeCompletionsWithSnippetText": true,
  "typescript.suggest.includeCompletionsWithInsertText": true,
  "typescript.suggest.includeCompletionsWithReplaceText": true,
  "typescript.suggest.includeCompletionsWithClassMemberSnippets": true,
  "typescript.suggest.includeCompletionsWithObjectLiteralMethodSnippets": true,
  "typescript.suggest.includeCompletionsWithFunctionParameterSnippets": true,
  "typescript.suggest.includeCompletionsWithInsertText": true,
  "typescript.suggest.includeCompletionsWithSnippetText": true,
  "typescript.suggest.includeCompletionsWithReplaceText": true,
  "typescript.suggest.includeCompletionsWithClassMemberSnippets": true,
  "typescript.suggest.includeCompletionsWithObjectLiteralMethodSnippets": true,
  "typescript.suggest.includeCompletionsWithFunctionParameterSnippets": true
}
```

### **IntelliSense with Generics**

```typescript
// IntelliSense works with generics
interface ApiResponse<T> {
  data: T;
  status: number;
  message: string;
}

function fetchData<T>(url: string): Promise<ApiResponse<T>> {
  return fetch(url).then(response => response.json());
}

// IntelliSense provides type-specific suggestions
const userResponse = await fetchData<User>("/api/users/1");
// userResponse.data. <- IntelliSense shows User properties

const productResponse = await fetchData<Product[]>("/api/products");
// productResponse.data. <- IntelliSense shows Product[] methods
```

---

## 🐛 **Debugging Configuration**

Proper debugging setup is essential for TypeScript development.

### **VS Code Debug Configuration**

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug TypeScript",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/src/index.ts",
      "outFiles": ["${workspaceFolder}/dist/**/*.js"],
      "sourceMaps": true,
      "env": {
        "NODE_ENV": "development"
      },
      "console": "integratedTerminal"
    },
    {
      "name": "Debug Jest Tests",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/node_modules/.bin/jest",
      "args": ["--runInBand"],
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen"
    },
    {
      "name": "Debug Webpack Dev Server",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/node_modules/.bin/webpack-dev-server",
      "args": ["--mode", "development"],
      "console": "integratedTerminal"
    }
  ]
}
```

### **Node.js Debugging**

```typescript
// Debugging with Node.js
import { createServer } from 'http';

const server = createServer((req, res) => {
  // Set breakpoint here
  const url = req.url;
  const method = req.method;
  
  // Debug variables
  console.log('Request:', { url, method });
  
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ message: 'Hello World' }));
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

### **Browser Debugging**

```typescript
// Browser debugging with source maps
class UserService {
  private users: User[] = [];

  async fetchUser(id: number): Promise<User> {
    // Set breakpoint here
    const response = await fetch(`/api/users/${id}`);
    
    if (!response.ok) {
      throw new Error(`Failed to fetch user: ${response.status}`);
    }
    
    const user = await response.json();
    return user;
  }

  addUser(user: User): void {
    // Set breakpoint here
    this.users.push(user);
  }
}

// Usage
const userService = new UserService();
userService.fetchUser(1); // Debug this call
```

---

## 🔍 **Linting & Formatting**

Linting and formatting ensure code quality and consistency.

### **ESLint Configuration**

```json
// .eslintrc.json
{
  "extends": [
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": 2020,
    "sourceType": "module",
    "project": "./tsconfig.json"
  },
  "plugins": ["@typescript-eslint"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "warn",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-non-null-assertion": "warn",
    "@typescript-eslint/prefer-const": "error",
    "@typescript-eslint/no-var-requires": "error"
  }
}
```

### **Prettier Configuration**

```json
// .prettierrc
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "avoid"
}
```

### **VS Code Formatting Settings**

```json
// .vscode/settings.json
{
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.formatOnType": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },
  "typescript.preferences.organizeImports": true,
  "typescript.suggest.autoImports": true
}
```

---

## 🚀 **Advanced IDE Features**

### **Code Navigation**

```typescript
// Advanced navigation features
class UserService {
  private users: User[] = [];

  async fetchUser(id: number): Promise<User> {
    // Go to definition: Ctrl+Click on User
    const user = await this.findUser(id);
    return user;
  }

  private async findUser(id: number): Promise<User> {
    // Find all references: Shift+F12
    const user = this.users.find(u => u.id === id);
    if (!user) {
      throw new Error('User not found');
    }
    return user;
  }
}

// Rename symbol: F2
const userService = new UserService();
userService.fetchUser(1);
```

### **Refactoring Tools**

```typescript
// Refactoring examples
class DataProcessor {
  // Extract method: Select code and use Ctrl+Shift+R
  processData(data: any[]): any[] {
    return data.map(item => {
      // Extract this logic into a separate method
      if (item.type === 'user') {
        return {
          ...item,
          processed: true,
          timestamp: new Date()
        };
      }
      return item;
    });
  }

  // Extract interface: Select object and use Ctrl+Shift+R
  createUser(userData: any): User {
    return {
      id: userData.id,
      name: userData.name,
      email: userData.email
    };
  }
}
```

### **Code Snippets**

```json
// .vscode/typescript.json
{
  "TypeScript React Component": {
    "prefix": "tsr",
    "body": [
      "import React from 'react';",
      "",
      "interface ${1:ComponentName}Props {",
      "  $2",
      "}",
      "",
      "const ${1:ComponentName}: React.FC<${1:ComponentName}Props> = ({ $3 }) => {",
      "  return (",
      "    <div>",
      "      $4",
      "    </div>",
      "  );",
      "};",
      "",
      "export default ${1:ComponentName};"
    ],
    "description": "TypeScript React Component"
  }
}
```

---

## ✅ **Best Practices**

### **1. Configure IntelliSense Properly**

```json
// ✅ Good: Enable all IntelliSense features
{
  "typescript.suggest.autoImports": true,
  "typescript.suggest.includeCompletionsForModuleExports": true,
  "typescript.suggest.includeCompletionsWithSnippetText": true
}

// ❌ Avoid: Disabling IntelliSense features
{
  "typescript.suggest.autoImports": false,
  "typescript.suggest.includeCompletionsForModuleExports": false
}
```

### **2. Use Source Maps for Debugging**

```json
// ✅ Good: Enable source maps
{
  "compilerOptions": {
    "sourceMap": true,
    "inlineSourceMap": false
  }
}

// ❌ Avoid: Disabling source maps
{
  "compilerOptions": {
    "sourceMap": false
  }
}
```

### **3. Configure Linting and Formatting**

```json
// ✅ Good: Enable linting and formatting
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  }
}

// ❌ Avoid: No linting or formatting
{
  "editor.formatOnSave": false,
  "editor.codeActionsOnSave": {}
}
```

### **4. Use Debug Configurations**

```json
// ✅ Good: Proper debug configuration
{
  "name": "Debug TypeScript",
  "type": "node",
  "request": "launch",
  "program": "${workspaceFolder}/src/index.ts",
  "outFiles": ["${workspaceFolder}/dist/**/*.js"],
  "sourceMaps": true
}

// ❌ Avoid: No debug configuration
{
  "name": "Debug",
  "type": "node",
  "request": "launch",
  "program": "index.js"
}
```

---

## ❓ **Common Interview Questions**

### **1. How do you set up TypeScript debugging in VS Code?**

**Answer:**
Create a `.vscode/launch.json` file with proper configuration:

```json
{
  "name": "Debug TypeScript",
  "type": "node",
  "request": "launch",
  "program": "${workspaceFolder}/src/index.ts",
  "outFiles": ["${workspaceFolder}/dist/**/*.js"],
  "sourceMaps": true
}
```

### **2. What are the benefits of using IntelliSense with TypeScript?**

**Answer:**
- **Code completion**: Automatic suggestions for properties and methods
- **Parameter hints**: Shows function parameters and types
- **Error detection**: Real-time type checking and error highlighting
- **Navigation**: Go to definition, find references, symbol search

### **3. How do you configure ESLint for TypeScript?**

**Answer:**
Use `@typescript-eslint/parser` and `@typescript-eslint/recommended`:

```json
{
  "extends": ["@typescript-eslint/recommended"],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"]
}
```

### **4. What's the difference between source maps and inline source maps?**

**Answer:**
- **Source maps**: Separate `.map` files for debugging
- **Inline source maps**: Source maps embedded in the generated JavaScript

### **5. How do you enable automatic imports in VS Code?**

**Answer:**
Configure in settings:

```json
{
  "typescript.suggest.autoImports": true,
  "typescript.preferences.includePackageJsonAutoImports": "auto"
}
```

---

## 🧭 Navigation

<div class="navigation">
  <a href="03-TypeScript-Build-Tools.md" class="nav-button">← Previous: TypeScript with Build Tools</a>
  <a href="../04-Advanced-TypeScript-Patterns/01-Design-Patterns-TypeScript.md" class="nav-button">Next: Design Patterns in TypeScript →</a>
</div>

*Last updated: December 2024*
