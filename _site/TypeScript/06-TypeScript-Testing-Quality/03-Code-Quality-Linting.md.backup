# 🔍 **Code Quality & Linting**

> **Complete guide to maintaining code quality in TypeScript projects with ESLint, Prettier, and best practices**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Code Quality Overview](#code-quality-overview)
- [ESLint Configuration](#eslint-configuration)
- [Prettier Configuration](#prettier-configuration)
- [TypeScript-Specific Rules](#typescript-specific-rules)
- [Custom Rules and Plugins](#custom-rules-and-plugins)
- [CI/CD Integration](#cicd-integration)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Code Quality Overview**

Code quality tools help maintain consistency, catch errors, and enforce best practices in TypeScript projects.

### **Code Quality Tools**


```typescript
// Code quality tools ecosystem
const codeQualityTools = {
  linting: "ESLint - Catch errors and enforce style",
  formatting: "Prettier - Consistent code formatting",
  typeChecking: "TypeScript - Static type checking",
  testing: "Jest - Unit testing",
  coverage: "Istanbul - Code coverage"
};

// Benefits of code quality tools
const benefits = {
  consistency: "Consistent code style across team",
  errorPrevention: "Catch errors before runtime",
  maintainability: "Easier to maintain and refactor",
  collaboration: "Better team collaboration"
};
```


### **Quality Metrics**


```typescript
// Code quality metrics
const qualityMetrics = {
  cyclomaticComplexity: "Measure code complexity",
  codeCoverage: "Percentage of code tested",
  maintainabilityIndex: "How maintainable the code is",
  technicalDebt: "Time to fix code issues"
};
```


---

## ⚙️ **ESLint Configuration**

### **Basic ESLint Setup**


```bash
# Install ESLint and TypeScript support
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install --save-dev eslint-plugin-import eslint-plugin-node
npm install --save-dev eslint-plugin-promise eslint-plugin-standard
```


### **Basic ESLint Configuration**


```json
// .eslintrc.json
{
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended"
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
  },
  "env": {
    "node": true,
    "es6": true
  }
}
```


### **Advanced ESLint Configuration**


```json
// .eslintrc.json
{
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking",
    "plugin:import/recommended",
    "plugin:import/typescript",
    "plugin:node/recommended",
    "plugin:promise/recommended"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": 2020,
    "sourceType": "module",
    "project": "./tsconfig.json",
    "tsconfigRootDir": "."
  },
  "plugins": [
    "@typescript-eslint",
    "import",
    "node",
    "promise"
  ],
  "rules": {
    // TypeScript specific rules
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "warn",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-non-null-assertion": "warn",
    "@typescript-eslint/prefer-const": "error",
    "@typescript-eslint/no-var-requires": "error",
    "@typescript-eslint/no-floating-promises": "error",
    "@typescript-eslint/await-thenable": "error",
    "@typescript-eslint/no-misused-promises": "error",
    "@typescript-eslint/require-await": "error",
    "@typescript-eslint/return-await": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "@typescript-eslint/no-unnecessary-type-assertion": "error",
    "@typescript-eslint/no-unnecessary-condition": "error",
    "@typescript-eslint/no-unnecessary-type-arguments": "error",
    "@typescript-eslint/prefer-string-starts-ends-with": "error",
    "@typescript-eslint/prefer-includes": "error",
    "@typescript-eslint/prefer-readonly": "error",
    "@typescript-eslint/prefer-readonly-parameter-types": "off",
    "@typescript-eslint/strict-boolean-expressions": "error",
    "@typescript-eslint/prefer-function-type": "error",
    "@typescript-eslint/method-signature-style": "error",
    "@typescript-eslint/consistent-type-definitions": ["error", "interface"],
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/consistent-type-exports": "error",
    "@typescript-eslint/no-import-type-side-effects": "error",
    "@typescript-eslint/no-duplicate-enum-values": "error",
    "@typescript-eslint/no-dynamic-delete": "error",
    "@typescript-eslint/no-extra-non-null-assertion": "error",
    "@typescript-eslint/no-extraneous-class": "error",
    "@typescript-eslint/no-invalid-void-type": "error",
    "@typescript-eslint/no-meaningless-void-operator": "error",
    "@typescript-eslint/no-misused-new": "error",
    "@typescript-eslint/no-namespace": "error",
    "@typescript-eslint/no-non-null-asserted-optional-chain": "error",
    "@typescript-eslint/no-require-imports": "error",
    "@typescript-eslint/no-this-alias": "error",
    "@typescript-eslint/no-type-alias": "off",
    "@typescript-eslint/no-unnecessary-boolean-literal-compare": "error",
    "@typescript-eslint/no-unnecessary-qualifier": "error",
    "@typescript-eslint/no-unnecessary-type-constraint": "error",
    "@typescript-eslint/no-unsafe-argument": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/no-unsafe-call": "error",
    "@typescript-eslint/no-unsafe-member-access": "error",
    "@typescript-eslint/no-unsafe-return": "error",
    "@typescript-eslint/prefer-as-const": "error",
    "@typescript-eslint/prefer-enum-initializers": "error",
    "@typescript-eslint/prefer-for-of": "error",
    "@typescript-eslint/prefer-literal-enum-member": "error",
    "@typescript-eslint/prefer-namespace-keyword": "error",
    "@typescript-eslint/prefer-reduce-type-parameter": "error",
    "@typescript-eslint/prefer-ts-expect-error": "error",
    "@typescript-eslint/restrict-plus-operands": "error",
    "@typescript-eslint/restrict-template-expressions": "error",
    "@typescript-eslint/triple-slash-reference": "error",
    "@typescript-eslint/unbound-method": "error",
    "@typescript-eslint/unified-signatures": "error",
    "@typescript-eslint/use-unknown-in-catch-clause-variable": "error",

    // Import rules
    "import/order": ["error", {
      "groups": [
        "builtin",
        "external",
        "internal",
        "parent",
        "sibling",
        "index"
      ],
      "newlines-between": "always",
      "alphabetize": {
        "order": "asc",
        "caseInsensitive": true
      }
    }],
    "import/no-unresolved": "error",
    "import/no-cycle": "error",
    "import/no-self-import": "error",
    "import/no-useless-path-segments": "error",
    "import/no-duplicates": "error",
    "import/first": "error",
    "import/newline-after-import": "error",
    "import/no-absolute-path": "error",
    "import/no-dynamic-require": "error",
    "import/no-internal-modules": "off",
    "import/no-relative-parent-imports": "off",
    "import/no-restricted-paths": "off",
    "import/no-unused-modules": "error",
    "import/no-webpack-loader-syntax": "error",
    "import/export": "error",
    "import/no-named-as-default": "error",
    "import/no-named-as-default-member": "error",
    "import/no-deprecated": "error",
    "import/no-extraneous-dependencies": "error",
    "import/no-mutable-exports": "error",
    "import/no-named-export": "off",
    "import/no-namespace": "off",
    "import/no-commonjs": "off",
    "import/no-amd": "error",
    "import/no-nodejs-modules": "off",
    "import/no-import-module-exports": "error",
    "import/no-relative-packages": "error",
    "import/no-relative-parent-imports": "off",
    "import/no-restricted-paths": "off",
    "import/no-unused-modules": "error",
    "import/no-webpack-loader-syntax": "error",
    "import/export": "error",
    "import/no-named-as-default": "error",
    "import/no-named-as-default-member": "error",
    "import/no-deprecated": "error",
    "import/no-extraneous-dependencies": "error",
    "import/no-mutable-exports": "error",
    "import/no-named-export": "off",
    "import/no-namespace": "off",
    "import/no-commonjs": "off",
    "import/no-amd": "error",
    "import/no-nodejs-modules": "off",
    "import/no-import-module-exports": "error",
    "import/no-relative-packages": "error",

    // Node.js rules
    "node/no-missing-import": "off",
    "node/no-unsupported-features/es-syntax": "off",
    "node/no-unsupported-features/node-builtins": "off",
    "node/no-unpublished-import": "off",
    "node/no-unpublished-require": "off",
    "node/no-extraneous-import": "off",
    "node/no-extraneous-require": "off",
    "node/no-missing-require": "off",
    "node/no-missing-import": "off",
    "node/no-unsupported-features/es-syntax": "off",
    "node/no-unsupported-features/node-builtins": "off",
    "node/no-unpublished-import": "off",
    "node/no-unpublished-require": "off",
    "node/no-extraneous-import": "off",
    "node/no-extraneous-require": "off",
    "node/no-missing-require": "off",

    // Promise rules
    "promise/always-return": "error",
    "promise/catch-or-return": "error",
    "promise/no-nesting": "error",
    "promise/no-promise-in-callback": "error",
    "promise/no-return-wrap": "error",
    "promise/param-names": "error",
    "promise/prefer-await-to-callbacks": "error",
    "promise/prefer-await-to-then": "error",
    "promise/valid-params": "error",

    // General rules
    "no-console": "warn",
    "no-debugger": "error",
    "no-alert": "error",
    "no-var": "error",
    "prefer-const": "error",
    "prefer-arrow-callback": "error",
    "prefer-template": "error",
    "prefer-destructuring": "error",
    "prefer-spread": "error",
    "prefer-rest-params": "error",
    "prefer-object-spread": "error",
    "prefer-promise-reject-errors": "error",
    "prefer-named-capture-group": "error",
    "prefer-numeric-literals": "error",
    "prefer-regex-literals": "error",
    "prefer-exponentiation-operator": "error",
    "prefer-logical-operator-over-ternary": "error",
    "prefer-nullish-coalescing": "error",
    "prefer-optional-chaining": "error",
    "prefer-readonly-parameter-types": "off",
    "prefer-function-type": "error",
    "prefer-method-signature": "error",
    "prefer-enum-initializers": "error",
    "prefer-for-of": "error",
    "prefer-literal-enum-member": "error",
    "prefer-namespace-keyword": "error",
    "prefer-reduce-type-parameter": "error",
    "prefer-ts-expect-error": "error",
    "restrict-plus-operands": "error",
    "restrict-template-expressions": "error",
    "triple-slash-reference": "error",
    "unbound-method": "error",
    "unified-signatures": "error",
    "use-unknown-in-catch-clause-variable": "error"
  },
  "env": {
    "node": true,
    "es6": true,
    "jest": true
  },
  "settings": {
    "import/resolver": {
      "typescript": {
        "alwaysTryTypes": true,
        "project": "./tsconfig.json"
      }
    }
  }
}
```


---

## 🎨 **Prettier Configuration**

### **Basic Prettier Setup**


```bash
# Install Prettier
npm install --save-dev prettier
npm install --save-dev eslint-config-prettier eslint-plugin-prettier
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
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "quoteProps": "as-needed",
  "jsxSingleQuote": true,
  "bracketSameLine": false,
  "proseWrap": "preserve",
  "htmlWhitespaceSensitivity": "css",
  "embeddedLanguageFormatting": "auto"
}
```


### **Prettier Ignore**


```text
# .prettierignore
node_modules/
dist/
build/
coverage/
*.min.js
*.min.css
package-lock.json
yarn.lock
```


### **ESLint-Prettier Integration**


```json
// .eslintrc.json
{
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended",
    "prettier"
  ],
  "plugins": [
    "@typescript-eslint",
    "prettier"
  ],
  "rules": {
    "prettier/prettier": "error"
  }
}
```


---

## 🔧 **TypeScript-Specific Rules**

### **Type Safety Rules**


```json
// TypeScript type safety rules
{
  "rules": {
    // Type safety
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/no-unsafe-call": "error",
    "@typescript-eslint/no-unsafe-member-access": "error",
    "@typescript-eslint/no-unsafe-return": "error",
    "@typescript-eslint/no-unsafe-argument": "error",
    "@typescript-eslint/no-floating-promises": "error",
    "@typescript-eslint/await-thenable": "error",
    "@typescript-eslint/no-misused-promises": "error",
    "@typescript-eslint/require-await": "error",
    "@typescript-eslint/return-await": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "@typescript-eslint/no-unnecessary-type-assertion": "error",
    "@typescript-eslint/no-unnecessary-condition": "error",
    "@typescript-eslint/no-unnecessary-type-arguments": "error",
    "@typescript-eslint/strict-boolean-expressions": "error",
    "@typescript-eslint/prefer-function-type": "error",
    "@typescript-eslint/method-signature-style": "error",
    "@typescript-eslint/consistent-type-definitions": ["error", "interface"],
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/consistent-type-exports": "error",
    "@typescript-eslint/no-import-type-side-effects": "error",
    "@typescript-eslint/no-duplicate-enum-values": "error",
    "@typescript-eslint/no-dynamic-delete": "error",
    "@typescript-eslint/no-extra-non-null-assertion": "error",
    "@typescript-eslint/no-extraneous-class": "error",
    "@typescript-eslint/no-invalid-void-type": "error",
    "@typescript-eslint/no-meaningless-void-operator": "error",
    "@typescript-eslint/no-misused-new": "error",
    "@typescript-eslint/no-namespace": "error",
    "@typescript-eslint/no-non-null-asserted-optional-chain": "error",
    "@typescript-eslint/no-require-imports": "error",
    "@typescript-eslint/no-this-alias": "error",
    "@typescript-eslint/no-type-alias": "off",
    "@typescript-eslint/no-unnecessary-boolean-literal-compare": "error",
    "@typescript-eslint/no-unnecessary-qualifier": "error",
    "@typescript-eslint/no-unnecessary-type-constraint": "error",
    "@typescript-eslint/prefer-as-const": "error",
    "@typescript-eslint/prefer-enum-initializers": "error",
    "@typescript-eslint/prefer-for-of": "error",
    "@typescript-eslint/prefer-literal-enum-member": "error",
    "@typescript-eslint/prefer-namespace-keyword": "error",
    "@typescript-eslint/prefer-reduce-type-parameter": "error",
    "@typescript-eslint/prefer-ts-expect-error": "error",
    "@typescript-eslint/restrict-plus-operands": "error",
    "@typescript-eslint/restrict-template-expressions": "error",
    "@typescript-eslint/triple-slash-reference": "error",
    "@typescript-eslint/unbound-method": "error",
    "@typescript-eslint/unified-signatures": "error",
    "@typescript-eslint/use-unknown-in-catch-clause-variable": "error"
  }
}
```


### **Code Style Rules**


```json
// TypeScript code style rules
{
  "rules": {
    // Code style
    "@typescript-eslint/prefer-string-starts-ends-with": "error",
    "@typescript-eslint/prefer-includes": "error",
    "@typescript-eslint/prefer-readonly": "error",
    "@typescript-eslint/prefer-readonly-parameter-types": "off",
    "@typescript-eslint/prefer-function-type": "error",
    "@typescript-eslint/method-signature-style": "error",
    "@typescript-eslint/consistent-type-definitions": ["error", "interface"],
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/consistent-type-exports": "error",
    "@typescript-eslint/no-import-type-side-effects": "error",
    "@typescript-eslint/no-duplicate-enum-values": "error",
    "@typescript-eslint/no-dynamic-delete": "error",
    "@typescript-eslint/no-extra-non-null-assertion": "error",
    "@typescript-eslint/no-extraneous-class": "error",
    "@typescript-eslint/no-invalid-void-type": "error",
    "@typescript-eslint/no-meaningless-void-operator": "error",
    "@typescript-eslint/no-misused-new": "error",
    "@typescript-eslint/no-namespace": "error",
    "@typescript-eslint/no-non-null-asserted-optional-chain": "error",
    "@typescript-eslint/no-require-imports": "error",
    "@typescript-eslint/no-this-alias": "error",
    "@typescript-eslint/no-type-alias": "off",
    "@typescript-eslint/no-unnecessary-boolean-literal-compare": "error",
    "@typescript-eslint/no-unnecessary-qualifier": "error",
    "@typescript-eslint/no-unnecessary-type-constraint": "error",
    "@typescript-eslint/prefer-as-const": "error",
    "@typescript-eslint/prefer-enum-initializers": "error",
    "@typescript-eslint/prefer-for-of": "error",
    "@typescript-eslint/prefer-literal-enum-member": "error",
    "@typescript-eslint/prefer-namespace-keyword": "error",
    "@typescript-eslint/prefer-reduce-type-parameter": "error",
    "@typescript-eslint/prefer-ts-expect-error": "error",
    "@typescript-eslint/restrict-plus-operands": "error",
    "@typescript-eslint/restrict-template-expressions": "error",
    "@typescript-eslint/triple-slash-reference": "error",
    "@typescript-eslint/unbound-method": "error",
    "@typescript-eslint/unified-signatures": "error",
    "@typescript-eslint/use-unknown-in-catch-clause-variable": "error"
  }
}
```


---

## 🔌 **Custom Rules and Plugins**

### **Custom ESLint Rules**


```typescript
// custom-rules/no-console-in-production.ts
import { ESLint } from 'eslint';

const rule = {
  meta: {
    type: 'problem',
    docs: {
      description: 'Disallow console statements in production code',
      category: 'Best Practices',
      recommended: true,
    },
    fixable: 'code',
    schema: [],
  },
  create(context) {
    return {
      CallExpression(node) {
        if (
          node.callee.type === 'MemberExpression' &&
          node.callee.object.type === 'Identifier' &&
          node.callee.object.name === 'console'
        ) {
          context.report({
            node,
            message: 'Console statements are not allowed in production code',
          });
        }
      },
    };
  },
};

export default rule;
```


### **Custom Prettier Plugin**


```typescript
// custom-prettier-plugin.ts
import { Plugin } from 'prettier';

const plugin: Plugin = {
  languages: [
    {
      name: 'typescript',
      extensions: ['.ts', '.tsx'],
      parsers: ['typescript'],
    },
  ],
  parsers: {
    typescript: {
      parse: (text) => {
        // Custom parsing logic
        return text;
      },
      astFormat: 'typescript',
      locStart: (node) => node.start,
      locEnd: (node) => node.end,
    },
  },
  printers: {
    typescript: {
      print: (path) => {
        // Custom printing logic
        return path.getValue();
      },
    },
  },
};

export default plugin;
```


---

## 🚀 **CI/CD Integration**

### **GitHub Actions**


```yaml
# .github/workflows/quality.yml
name: Code Quality

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  quality:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run ESLint
      run: npm run lint
    
    - name: Run Prettier check
      run: npm run format:check
    
    - name: Run TypeScript check
      run: npm run type-check
    
    - name: Run tests
      run: npm run test:ci
    
    - name: Run coverage
      run: npm run test:coverage
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage/lcov.info
```


### **Package.json Scripts**


```json
{
  "scripts": {
    "lint": "eslint src --ext .ts,.tsx",
    "lint:fix": "eslint src --ext .ts,.tsx --fix",
    "format": "prettier --write src/**/*.{ts,tsx,json,md}",
    "format:check": "prettier --check src/**/*.{ts,tsx,json,md}",
    "type-check": "tsc --noEmit",
    "test": "jest",
    "test:ci": "jest --ci --coverage --watchAll=false",
    "test:coverage": "jest --coverage",
    "quality": "npm run lint && npm run format:check && npm run type-check && npm run test:ci"
  }
}
```


---

## ✅ **Best Practices**

### **1. Use Strict ESLint Rules**


```json
// ✅ Good: Strict rules
{
  "rules": {
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/strict-boolean-expressions": "error"
  }
}

// ❌ Avoid: Loose rules
{
  "rules": {
    "@typescript-eslint/no-explicit-any": "off",
    "@typescript-eslint/no-unsafe-assignment": "off"
  }
}
```


### **2. Use Prettier for Formatting**


```json
// ✅ Good: Use Prettier
{
  "extends": ["prettier"],
  "plugins": ["prettier"],
  "rules": {
    "prettier/prettier": "error"
  }
}

// ❌ Avoid: Manual formatting rules
{
  "rules": {
    "indent": ["error", 2],
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
```


### **3. Use TypeScript-Specific Rules**


```json
// ✅ Good: TypeScript-specific rules
{
  "rules": {
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "@typescript-eslint/consistent-type-imports": "error"
  }
}

// ❌ Avoid: Generic JavaScript rules
{
  "rules": {
    "no-unused-vars": "error",
    "no-undef": "error"
  }
}
```


### **4. Use Import Organization**


```json
// ✅ Good: Import organization
{
  "rules": {
    "import/order": ["error", {
      "groups": ["builtin", "external", "internal", "parent", "sibling", "index"],
      "newlines-between": "always"
    }]
  }
}

// ❌ Avoid: No import organization
{
  "rules": {
    "import/order": "off"
  }
}
```


---

## ❓ **Common Interview Questions**

### **1. What's the difference between ESLint and Prettier?**

**Answer:**
- **ESLint**: Catches errors and enforces code quality rules
- **Prettier**: Formats code for consistent style
- **ESLint**: Configurable rules, can fix some issues
- **Prettier**: Opinionated formatting, focuses on style

### **2. How do you configure ESLint for TypeScript?**

**Answer:**

```json
{
  "extends": ["@typescript-eslint/recommended"],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"]
}
```


### **3. What are the benefits of using Prettier?**

**Answer:**
- **Consistency**: Uniform code style across team
- **Automation**: Automatic formatting on save
- **Focus**: Developers focus on logic, not formatting
- **Integration**: Works with ESLint and editors

### **4. How do you integrate code quality tools in CI/CD?**

**Answer:**
- Run ESLint for code quality checks
- Run Prettier for formatting validation
- Run TypeScript compiler for type checking
- Run tests with coverage reporting
- Fail builds on quality issues

### **5. What are TypeScript-specific ESLint rules?**

**Answer:**
- `@typescript-eslint/no-explicit-any`: Prevent any types
- `@typescript-eslint/prefer-nullish-coalescing`: Use ?? operator
- `@typescript-eslint/prefer-optional-chain`: Use ?. operator
- `@typescript-eslint/consistent-type-imports`: Consistent import types
- `@typescript-eslint/strict-boolean-expressions`: Strict boolean checks

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Type-Testing-Validation.md" class="nav-button">← Previous: Type Testing & Validation</a>
  <a href="04-Performance-Monitoring.md" class="nav-button">Next: Performance Monitoring →</a>
</div>

*Last updated: December 2025*
