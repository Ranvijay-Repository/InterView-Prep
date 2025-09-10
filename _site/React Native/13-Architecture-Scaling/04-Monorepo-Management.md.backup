# 📦 **Monorepo Management**

> **Master monorepo management, workspace organization, and build optimization for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Monorepo Overview](#-monorepo-overview)
- [Workspace Setup](#-workspace-setup)
- [Build Optimization](#-build-optimization)
- [Dependency Management](#-dependency-management)
- [CI/CD Integration](#-cicd-integration)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 📦 **Monorepo Overview**

### **Monorepo Structure**


```mermaid
graph TD
    A[monorepo/] --> B[apps/]
    A --> C[packages/]
    A --> D[tools/]
    
    B --> E[mobile/]
    B --> F[web/]
    B --> G[desktop/]
    
    C --> H[shared/]
    C --> I[ui/]
    C --> J[utils/]
    
    D --> K[build/]
    D --> L[scripts/]
    D --> M[config/]
```


### **Benefits**
- **Code Sharing**: Shared components and utilities
- **Consistent Tooling**: Unified build and test processes
- **Atomic Changes**: Cross-package changes in single commit
- **Simplified Dependencies**: Centralized dependency management

---

## 🏗️ **Workspace Setup**

### **Yarn Workspaces Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```json
{
  "name": "react-native-monorepo",
  "version": "1.0.0",
  "private": true,
  "workspaces": [
    "apps/*",
    "packages/*",
    "tools/*"
  ],
  "scripts": {
    "build": "turbo run build",
    "test": "turbo run test",
    "lint": "turbo run lint",
    "dev": "turbo run dev",
    "clean": "turbo run clean",
    "type-check": "turbo run type-check"
  },
  "devDependencies": {
    "turbo": "^1.10.0",
    "typescript": "^5.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0"
  }
}
```


### **Turbo Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```json
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": ["**/.env.*local"],
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", "build/**", ".next/**", "!.next/cache/**"]
    },
    "test": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    },
    "lint": {
      "outputs": []
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "clean": {
      "cache": false
    },
    "type-check": {
      "dependsOn": ["^build"],
      "outputs": []
    }
  }
}
```


### **Package Structure**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// packages/shared/package.json
{
  "name": "@monorepo/shared",
  "version": "1.0.0",
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "scripts": {
    "build": "tsc",
    "dev": "tsc --watch",
    "test": "jest",
    "lint": "eslint src/**/*.ts",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "react": "^18.0.0",
    "react-native": "^0.72.0"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/react": "^18.0.0",
    "@types/react-native": "^0.72.0"
  }
}

// apps/mobile/package.json
{
  "name": "@monorepo/mobile",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "android": "react-native run-android",
    "ios": "react-native run-ios",
    "start": "react-native start",
    "test": "jest",
    "lint": "eslint .",
    "build:android": "cd android && ./gradlew assembleRelease",
    "build:ios": "cd ios && xcodebuild -workspace Mobile.xcworkspace -scheme Mobile -configuration Release"
  },
  "dependencies": {
    "react": "^18.0.0",
    "react-native": "^0.72.0",
    "@monorepo/shared": "workspace:*",
    "@monorepo/ui": "workspace:*"
  }
}
```


---

## ⚡ **Build Optimization**

### **Build Pipeline**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// tools/build/build-pipeline.js
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const BuildPipeline = {
  // Build all packages
  buildAll: async () => {
    console.log('🚀 Starting build pipeline...');
    
    try {
      // Clean previous builds
      await BuildPipeline.clean();
      
      // Build shared packages first
      await BuildPipeline.buildPackages();
      
      // Build applications
      await BuildPipeline.buildApps();
      
      // Generate build report
      await BuildPipeline.generateReport();
      
      console.log('✅ Build pipeline completed successfully');
    } catch (error) {
      console.error('❌ Build pipeline failed:', error);
      process.exit(1);
    }
  },
  
  // Clean build artifacts
  clean: async () => {
    console.log('🧹 Cleaning build artifacts...');
    
    const cleanCommands = [
      'turbo run clean',
      'rm -rf node_modules/.cache',
      'rm -rf apps/*/node_modules/.cache',
      'rm -rf packages/*/node_modules/.cache'
    ];
    
    for (const command of cleanCommands) {
      execSync(command, { stdio: 'inherit' });
    }
  },
  
  // Build packages
  buildPackages: async () => {
    console.log('📦 Building packages...');
    
    const packages = [
      '@monorepo/shared',
      '@monorepo/ui',
      '@monorepo/utils'
    ];
    
    for (const packageName of packages) {
      console.log(`Building ${packageName}...`);
      execSync(`turbo run build --filter=${packageName}`, { stdio: 'inherit' });
    }
  },
  
  // Build applications
  buildApps: async () => {
    console.log('📱 Building applications...');
    
    const apps = [
      '@monorepo/mobile',
      '@monorepo/web',
      '@monorepo/desktop'
    ];
    
    for (const appName of apps) {
      console.log(`Building ${appName}...`);
      execSync(`turbo run build --filter=${appName}`, { stdio: 'inherit' });
    }
  },
  
  // Generate build report
  generateReport: async () => {
    console.log('📊 Generating build report...');
    
    const report = {
      timestamp: new Date().toISOString(),
      packages: await BuildPipeline.getPackageInfo(),
      buildTime: process.uptime(),
      memoryUsage: process.memoryUsage()
    };
    
    fs.writeFileSync(
      path.join(process.cwd(), 'build-report.json'),
      JSON.stringify(report, null, 2)
    );
  },
  
  // Get package information
  getPackageInfo: async () => {
    const packages = [];
    const packageDirs = ['packages', 'apps'];
    
    for (const dir of packageDirs) {
      const items = fs.readdirSync(dir);
      for (const item of items) {
        const packagePath = path.join(dir, item, 'package.json');
        if (fs.existsSync(packagePath)) {
          const packageJson = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
          packages.push({
            name: packageJson.name,
            version: packageJson.version,
            path: path.join(dir, item)
          });
        }
      }
    }
    
    return packages;
  }
};

export default BuildPipeline;
```


### **Bundle Analysis**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// tools/analyze/bundle-analyzer.js
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const BundleAnalyzer = {
  // Analyze bundle sizes
  analyze: async (appName) => {
    console.log(`📊 Analyzing bundle for ${appName}...`);
    
    try {
      // Generate bundle analysis
      await BundleAnalyzer.generateAnalysis(appName);
      
      // Compare with previous builds
      await BundleAnalyzer.compareBuilds(appName);
      
      // Generate recommendations
      await BundleAnalyzer.generateRecommendations(appName);
      
      console.log('✅ Bundle analysis completed');
    } catch (error) {
      console.error('❌ Bundle analysis failed:', error);
    }
  },
  
  // Generate bundle analysis
  generateAnalysis: async (appName) => {
    const analysisPath = path.join(process.cwd(), 'analysis', appName);
    
    // Create analysis directory
    if (!fs.existsSync(analysisPath)) {
      fs.mkdirSync(analysisPath, { recursive: true });
    }
    
    // Run bundle analysis
    execSync(`turbo run analyze --filter=${appName}`, { stdio: 'inherit' });
  },
  
  // Compare with previous builds
  compareBuilds: async (appName) => {
    const currentAnalysis = path.join(process.cwd(), 'analysis', appName, 'current.json');
    const previousAnalysis = path.join(process.cwd(), 'analysis', appName, 'previous.json');
    
    if (fs.existsSync(previousAnalysis)) {
      const current = JSON.parse(fs.readFileSync(currentAnalysis, 'utf8'));
      const previous = JSON.parse(fs.readFileSync(previousAnalysis, 'utf8'));
      
      const comparison = BundleAnalyzer.compareBundles(current, previous);
      
      fs.writeFileSync(
        path.join(process.cwd(), 'analysis', appName, 'comparison.json'),
        JSON.stringify(comparison, null, 2)
      );
    }
  },
  
  // Compare bundle sizes
  compareBundles: (current, previous) => {
    const comparison = {
      totalSize: {
        current: current.totalSize,
        previous: previous.totalSize,
        difference: current.totalSize - previous.totalSize,
        percentage: ((current.totalSize - previous.totalSize) / previous.totalSize) * 100
      },
      modules: []
    };
    
    // Compare individual modules
    for (const [moduleName, currentSize] of Object.entries(current.modules)) {
      const previousSize = previous.modules[moduleName] || 0;
      const difference = currentSize - previousSize;
      const percentage = previousSize > 0 ? (difference / previousSize) * 100 : 0;
      
      comparison.modules.push({
        name: moduleName,
        current: currentSize,
        previous: previousSize,
        difference,
        percentage
      });
    }
    
    return comparison;
  },
  
  // Generate recommendations
  generateRecommendations: async (appName) => {
    const analysisPath = path.join(process.cwd(), 'analysis', appName);
    const comparisonPath = path.join(analysisPath, 'comparison.json');
    
    if (fs.existsSync(comparisonPath)) {
      const comparison = JSON.parse(fs.readFileSync(comparisonPath, 'utf8'));
      const recommendations = BundleAnalyzer.generateRecommendationsFromComparison(comparison);
      
      fs.writeFileSync(
        path.join(analysisPath, 'recommendations.json'),
        JSON.stringify(recommendations, null, 2)
      );
    }
  },
  
  // Generate recommendations from comparison
  generateRecommendationsFromComparison: (comparison) => {
    const recommendations = [];
    
    // Check total size increase
    if (comparison.totalSize.percentage > 10) {
      recommendations.push({
        type: 'warning',
        message: `Bundle size increased by ${comparison.totalSize.percentage.toFixed(2)}%`,
        suggestion: 'Consider code splitting or removing unused dependencies'
      });
    }
    
    // Check individual module increases
    comparison.modules
      .filter(module => module.percentage > 20)
      .forEach(module => {
        recommendations.push({
          type: 'info',
          message: `Module ${module.name} increased by ${module.percentage.toFixed(2)}%`,
          suggestion: 'Review this module for optimization opportunities'
        });
      });
    
    return recommendations;
  }
};

export default BundleAnalyzer;
```


---

## 🔧 **Dependency Management**

### **Dependency Management System**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// tools/deps/dependency-manager.js
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const DependencyManager = {
  // Update all dependencies
  updateAll: async () => {
    console.log('🔄 Updating all dependencies...');
    
    try {
      // Update root dependencies
      await DependencyManager.updateRootDependencies();
      
      // Update workspace dependencies
      await DependencyManager.updateWorkspaceDependencies();
      
      // Check for security vulnerabilities
      await DependencyManager.checkSecurity();
      
      // Generate dependency report
      await DependencyManager.generateReport();
      
      console.log('✅ Dependencies updated successfully');
    } catch (error) {
      console.error('❌ Dependency update failed:', error);
    }
  },
  
  // Update root dependencies
  updateRootDependencies: async () => {
    console.log('📦 Updating root dependencies...');
    
    execSync('yarn upgrade-interactive --latest', { stdio: 'inherit' });
  },
  
  // Update workspace dependencies
  updateWorkspaceDependencies: async () => {
    console.log('📦 Updating workspace dependencies...');
    
    const workspaces = DependencyManager.getWorkspaces();
    
    for (const workspace of workspaces) {
      console.log(`Updating ${workspace.name}...`);
      execSync(`cd ${workspace.path} && yarn upgrade-interactive --latest`, { stdio: 'inherit' });
    }
  },
  
  // Check security vulnerabilities
  checkSecurity: async () => {
    console.log('🔒 Checking security vulnerabilities...');
    
    try {
      execSync('yarn audit', { stdio: 'inherit' });
    } catch (error) {
      console.warn('⚠️ Security vulnerabilities found. Run yarn audit --fix to fix them.');
    }
  },
  
  // Generate dependency report
  generateReport: async () => {
    console.log('📊 Generating dependency report...');
    
    const report = {
      timestamp: new Date().toISOString(),
      workspaces: await DependencyManager.getWorkspaceInfo(),
      security: await DependencyManager.getSecurityInfo()
    };
    
    fs.writeFileSync(
      path.join(process.cwd(), 'dependency-report.json'),
      JSON.stringify(report, null, 2)
    );
  },
  
  // Get workspace information
  getWorkspaceInfo: async () => {
    const workspaces = DependencyManager.getWorkspaces();
    const workspaceInfo = [];
    
    for (const workspace of workspaces) {
      const packagePath = path.join(workspace.path, 'package.json');
      if (fs.existsSync(packagePath)) {
        const packageJson = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
        workspaceInfo.push({
          name: packageJson.name,
          version: packageJson.version,
          dependencies: Object.keys(packageJson.dependencies || {}),
          devDependencies: Object.keys(packageJson.devDependencies || {})
        });
      }
    }
    
    return workspaceInfo;
  },
  
  // Get security information
  getSecurityInfo: async () => {
    try {
      const auditOutput = execSync('yarn audit --json', { encoding: 'utf8' });
      const auditLines = auditOutput.trim().split('\n');
      const vulnerabilities = auditLines
        .filter(line => line.startsWith('{'))
        .map(line => JSON.parse(line))
        .filter(entry => entry.type === 'auditAdvisory');
      
      return {
        total: vulnerabilities.length,
        high: vulnerabilities.filter(v => v.data.severity === 'high').length,
        moderate: vulnerabilities.filter(v => v.data.severity === 'moderate').length,
        low: vulnerabilities.filter(v => v.data.severity === 'low').length
      };
    } catch (error) {
      return { total: 0, high: 0, moderate: 0, low: 0 };
    }
  },
  
  // Get workspaces
  getWorkspaces: () => {
    const workspaces = [];
    const workspaceDirs = ['apps', 'packages', 'tools'];
    
    for (const dir of workspaceDirs) {
      if (fs.existsSync(dir)) {
        const items = fs.readdirSync(dir);
        for (const item of items) {
          const workspacePath = path.join(dir, item);
          if (fs.statSync(workspacePath).isDirectory()) {
            workspaces.push({
              name: item,
              path: workspacePath
            });
          }
        }
      }
    }
    
    return workspaces;
  }
};

export default DependencyManager;
```


---

## 🎯 **Best Practices**

### **1. Monorepo Organization**
- Use clear naming conventions
- Implement proper workspace structure
- Maintain consistent tooling
- Document workspace policies

### **2. Build Optimization**
- Use incremental builds
- Implement proper caching
- Optimize bundle sizes
- Monitor build performance

### **3. Dependency Management**
- Keep dependencies up to date
- Use workspace dependencies
- Implement security checks
- Monitor dependency health

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What is a monorepo?**
2. **How do you manage dependencies in a monorepo?**
3. **What are the benefits of monorepo architecture?**

### **Advanced Questions**
1. **How would you set up a monorepo for React Native?**
2. **Explain build optimization strategies.**
3. **How do you handle workspace dependencies?**

### **Practical Questions**
1. **Set up a monorepo with Yarn workspaces.**
2. **Implement build optimization.**
3. **Create a dependency management system.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Feature-Based-Modules.md" class="nav-link prev">⬅️ Previous: Feature-Based Modules</a>
    <a href="../14-Expo-vs-Bare-Workflow/01-Expo-Overview.md" class="nav-link next">Next: Expo Overview ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
