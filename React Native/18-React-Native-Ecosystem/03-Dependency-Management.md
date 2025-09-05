# 📦 **Dependency Management**

> **Master dependency management in React Native projects, including package management, version control, and best practices for maintaining healthy dependencies**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Dependency Management Overview](#dependency-management-overview)
- [Package Managers](#package-managers)
- [Version Management](#version-management)
- [Dependency Resolution](#dependency-resolution)
- [Security Management](#security-management)
- [Performance Optimization](#performance-optimization)
- [Dependency Auditing](#dependency-auditing)
- [Best Practices](#best-practices)
- [Interview Questions](#interview-questions)

---

## 🎯 **Dependency Management Overview**

Dependency management is crucial for maintaining healthy, secure, and performant React Native applications. Proper dependency management ensures project stability and reduces technical debt.

### **Dependency Management Framework**

```
┌─────────────────────────────────────┐
│        Dependency Management       │
│  ┌─────────────────────────────────┐│
│  │        Package Managers        ││
│  │  - npm                         ││
│  │  - yarn                        ││
│  │  - pnpm                        ││
│  │  - bun                         ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Version Control         ││
│  │  - Semantic Versioning         ││
│  │  - Lock Files                  ││
│  │  - Version Ranges              ││
│  │  - Dependency Updates          ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │        Security & Quality      ││
│  │  - Vulnerability Scanning      ││
│  │  - License Compliance          ││
│  │  - Code Quality                ││
│  │  - Dependency Auditing         ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

### **Key Management Areas**
- **Package Installation**: Choosing and installing dependencies
- **Version Control**: Managing dependency versions
- **Security**: Vulnerability scanning and patching
- **Performance**: Optimizing bundle size and performance
- **Maintenance**: Regular updates and cleanup

---

## 📦 **Package Managers**

### **npm (Node Package Manager)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# npm commands
npm install                    # Install all dependencies
npm install package-name       # Install specific package
npm install -D package-name    # Install as dev dependency
npm install -g package-name    # Install globally
npm uninstall package-name     # Remove package
npm update                     # Update all packages
npm audit                      # Security audit
npm audit fix                  # Fix security issues
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```json
// package.json configuration
{
  "name": "my-react-native-app",
  "version": "1.0.0",
  "dependencies": {
    "react": "18.2.0",
    "react-native": "0.71.0",
    "@react-navigation/native": "^6.1.0"
  },
  "devDependencies": {
    "@types/react": "^18.0.0",
    "typescript": "^4.9.0",
    "jest": "^29.0.0"
  },
  "scripts": {
    "start": "react-native start",
    "android": "react-native run-android",
    "ios": "react-native run-ios",
    "test": "jest"
  },
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  }
}
```

### **Yarn (Alternative Package Manager)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Yarn commands
yarn install                   # Install all dependencies
yarn add package-name          # Add package
yarn add -D package-name       # Add dev dependency
yarn remove package-name       # Remove package
yarn upgrade                   # Update packages
yarn audit                     # Security audit
yarn audit fix                 # Fix security issues
yarn why package-name          # Show why package is installed
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```yaml
# .yarnrc.yml configuration
nodeLinker: node-modules
npmRegistryServer: "https://registry.yarnpkg.com"
enableGlobalCache: false
compressionLevel: mixed
```

### **pnpm (Fast, Disk Space Efficient)**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# pnpm commands
pnpm install                   # Install dependencies
pnpm add package-name          # Add package
pnpm add -D package-name       # Add dev dependency
pnpm remove package-name       # Remove package
pnpm update                    # Update packages
pnpm audit                     # Security audit
pnpm why package-name          # Show dependency tree
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```yaml
# .npmrc configuration for pnpm
shamefully-hoist=true
strict-peer-dependencies=false
```

### **Package Manager Comparison**

| Feature | npm | Yarn | pnpm |
|---------|-----|------|------|
| **Speed** | Medium | Fast | Fastest |
| **Disk Usage** | High | Medium | Low |
| **Lock File** | package-lock.json | yarn.lock | pnpm-lock.yaml |
| **Workspaces** | Yes | Yes | Excellent |
| **Security** | Good | Good | Excellent |

---

## 🔢 **Version Management**

### **Semantic Versioning**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Semantic versioning examples
const versionExamples = {
  // Exact version
  exact: "1.2.3",
  
  // Caret range (compatible changes)
  caret: "^1.2.3", // >=1.2.3 <2.0.0
  
  // Tilde range (patch changes)
  tilde: "~1.2.3", // >=1.2.3 <1.3.0
  
  // Range
  range: ">=1.2.3 <2.0.0",
  
  // Latest
  latest: "latest",
  
  // Tag
  tag: "beta"
};
```

### **Version Range Strategies**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```json
// package.json with different version strategies
{
  "dependencies": {
    // Exact version for critical dependencies
    "react": "18.2.0",
    "react-native": "0.71.0",
    
    // Caret for minor updates
    "@react-navigation/native": "^6.1.0",
    
    // Tilde for patch updates only
    "lodash": "~4.17.21",
    
    // Range for specific requirements
    "typescript": ">=4.9.0 <5.0.0"
  },
  "devDependencies": {
    // Latest for dev tools
    "eslint": "latest",
    "prettier": "latest"
  }
}
```

### **Lock File Management**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Lock file commands
npm ci                         # Install from lock file
yarn install --frozen-lockfile # Install from lock file
pnpm install --frozen-lockfile # Install from lock file

# Update lock files
npm update                     # Update package-lock.json
yarn upgrade                   # Update yarn.lock
pnpm update                    # Update pnpm-lock.yaml
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Lock file validation
const LockFileValidator = {
  // Validate lock file integrity
  validateLockFile: () => {
    const packageJson = require('./package.json');
    const lockFile = require('./package-lock.json');
    
    // Check if all dependencies are locked
    const dependencies = { ...packageJson.dependencies, ...packageJson.devDependencies };
    
    Object.entries(dependencies).forEach(([name, version]) => {
      if (!lockFile.dependencies[name]) {
        console.warn(`Dependency ${name} not found in lock file`);
      }
    });
  },
  
  // Check for lock file conflicts
  checkConflicts: () => {
    // Check for merge conflicts in lock file
    const fs = require('fs');
    const lockContent = fs.readFileSync('./package-lock.json', 'utf8');
    
    if (lockContent.includes('<<<<<<<') || lockContent.includes('>>>>>>')) {
      console.error('Lock file has merge conflicts');
      return false;
    }
    
    return true;
  }
};
```

---

## 🔍 **Dependency Resolution**

### **Dependency Tree Analysis**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Analyze dependency tree
npm ls                         # List dependency tree
npm ls --depth=0              # List only direct dependencies
npm ls --depth=1              # List direct and first-level dependencies
yarn list                      # List dependencies
yarn list --depth=0           # List only direct dependencies
pnpm list                      # List dependencies
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Dependency tree analysis
const DependencyAnalyzer = {
  // Analyze dependency tree
  analyzeTree: () => {
    const { execSync } = require('child_process');
    
    try {
      const output = execSync('npm ls --json', { encoding: 'utf8' });
      const tree = JSON.parse(output);
      
      return this.processTree(tree);
    } catch (error) {
      console.error('Error analyzing dependency tree:', error);
      return null;
    }
  },
  
  // Process dependency tree
  processTree: (tree) => {
    const analysis = {
      totalDependencies: 0,
      directDependencies: 0,
      transitiveDependencies: 0,
      duplicateDependencies: [],
      outdatedDependencies: []
    };
    
    // Analyze tree structure
    this.analyzeNode(tree, analysis, 0);
    
    return analysis;
  },
  
  analyzeNode: (node, analysis, depth) => {
    if (depth === 0) {
      analysis.directDependencies = Object.keys(node.dependencies || {}).length;
    } else {
      analysis.transitiveDependencies++;
    }
    
    analysis.totalDependencies++;
    
    // Check for duplicates
    if (depth > 1) {
      analysis.duplicateDependencies.push(node.name);
    }
    
    // Recursively analyze children
    if (node.dependencies) {
      Object.values(node.dependencies).forEach(child => {
        this.analyzeNode(child, analysis, depth + 1);
      });
    }
  }
};
```

### **Peer Dependencies**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```json
// package.json with peer dependencies
{
  "name": "my-react-native-library",
  "version": "1.0.0",
  "peerDependencies": {
    "react": ">=16.8.0",
    "react-native": ">=0.60.0"
  },
  "peerDependenciesMeta": {
    "react": {
      "optional": false
    },
    "react-native": {
      "optional": false
    }
  }
}
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Peer dependency validation
const PeerDependencyValidator = {
  // Validate peer dependencies
  validatePeerDependencies: () => {
    const packageJson = require('./package.json');
    const peerDeps = packageJson.peerDependencies || {};
    
    const issues = [];
    
    Object.entries(peerDeps).forEach(([name, version]) => {
      try {
        const installedVersion = require(`${name}/package.json`).version;
        
        if (!this.satisfiesVersion(installedVersion, version)) {
          issues.push({
            package: name,
            required: version,
            installed: installedVersion,
            issue: 'Version mismatch'
          });
        }
      } catch (error) {
        issues.push({
          package: name,
          required: version,
          installed: 'Not installed',
          issue: 'Missing peer dependency'
        });
      }
    });
    
    return issues;
  },
  
  satisfiesVersion: (installed, required) => {
    // Simple version check (in real implementation, use semver)
    return true; // Placeholder
  }
};
```

---

## 🔒 **Security Management**

### **Vulnerability Scanning**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Security audit commands
npm audit                     # Run security audit
npm audit --audit-level=high # Audit with specific level
npm audit fix                 # Fix automatically fixable issues
npm audit fix --force        # Force fix (may break functionality)

# Alternative tools
npx audit-ci                  # CI-friendly audit tool
npx snyk test                 # Snyk security testing
npx retire                    # Retire.js vulnerability scanner
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Security audit automation
const SecurityAuditor = {
  // Run security audit
  runAudit: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout, stderr } = await execAsync('npm audit --json');
      
      if (stderr) {
        console.error('Audit error:', stderr);
        return { success: false, error: stderr };
      }
      
      const auditResult = JSON.parse(stdout);
      return this.processAuditResult(auditResult);
    } catch (error) {
      console.error('Security audit failed:', error);
      return { success: false, error: error.message };
    }
  },
  
  // Process audit results
  processAuditResult: (auditResult) => {
    const vulnerabilities = auditResult.vulnerabilities || {};
    const summary = auditResult.metadata?.vulnerabilities || {};
    
    return {
      success: true,
      summary: {
        total: summary.total || 0,
        high: summary.high || 0,
        moderate: summary.moderate || 0,
        low: summary.low || 0,
        info: summary.info || 0
      },
      vulnerabilities: Object.entries(vulnerabilities).map(([name, vuln]) => ({
        name,
        severity: vuln.severity,
        title: vuln.title,
        description: vuln.description,
        recommendation: vuln.recommendation
      }))
    };
  }
};
```

### **License Compliance**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# License checking tools
npm install -g license-checker
license-checker --summary     # Summary of licenses
license-checker --json        # JSON output
license-checker --exclude 'MIT,Apache-2.0' # Exclude specific licenses

# Alternative tools
npx license-report            # Generate license report
npx npm-license-crawler       # Crawl npm licenses
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// License compliance checker
const LicenseChecker = {
  // Check license compliance
  checkLicenses: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout } = await execAsync('license-checker --json');
      const licenses = JSON.parse(stdout);
      
      return this.processLicenses(licenses);
    } catch (error) {
      console.error('License check failed:', error);
      return { success: false, error: error.message };
    }
  },
  
  // Process license information
  processLicenses: (licenses) => {
    const allowedLicenses = ['MIT', 'Apache-2.0', 'BSD-3-Clause', 'ISC'];
    const issues = [];
    
    Object.entries(licenses).forEach(([packageName, info]) => {
      const license = info.licenses;
      
      if (!allowedLicenses.includes(license)) {
        issues.push({
          package: packageName,
          license: license,
          issue: 'License not in allowed list'
        });
      }
    });
    
    return {
      success: true,
      totalPackages: Object.keys(licenses).length,
      allowedLicenses,
      issues
    };
  }
};
```

---

## ⚡ **Performance Optimization**

### **Bundle Size Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```bash
# Bundle analysis tools
npm install -g react-native-bundle-visualizer
react-native-bundle-visualizer

# Alternative tools
npx webpack-bundle-analyzer
npx source-map-explorer
```

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Bundle size optimization
const BundleOptimizer = {
  // Analyze bundle size
  analyzeBundle: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      // Generate bundle
      await execAsync('npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android-bundle.js');
      
      // Get bundle size
      const fs = require('fs');
      const stats = fs.statSync('./android-bundle.js');
      const sizeInMB = stats.size / (1024 * 1024);
      
      return {
        size: sizeInMB,
        sizeInBytes: stats.size,
        timestamp: new Date().toISOString()
      };
    } catch (error) {
      console.error('Bundle analysis failed:', error);
      return { error: error.message };
    }
  },
  
  // Optimize dependencies
  optimizeDependencies: () => {
    const optimizations = [
      'Remove unused dependencies',
      'Use tree shaking',
      'Implement code splitting',
      'Use dynamic imports',
      'Optimize images and assets'
    ];
    
    console.log('Bundle optimization strategies:', optimizations);
    return optimizations;
  }
};
```

### **Dependency Optimization**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Dependency optimization strategies
const DependencyOptimizer = {
  // Remove unused dependencies
  removeUnusedDependencies: () => {
    const packageJson = require('./package.json');
    const dependencies = { ...packageJson.dependencies, ...packageJson.devDependencies };
    
    const unusedDeps = [];
    
    Object.keys(dependencies).forEach(dep => {
      if (!this.isDependencyUsed(dep)) {
        unusedDeps.push(dep);
      }
    });
    
    return unusedDeps;
  },
  
  // Check if dependency is used
  isDependencyUsed: (dependency) => {
    // Check if dependency is imported anywhere in the codebase
    const fs = require('fs');
    const path = require('path');
    
    try {
      const code = fs.readFileSync('./index.js', 'utf8');
      return code.includes(dependency);
    } catch (error) {
      return false;
    }
  },
  
  // Optimize dependency versions
  optimizeVersions: () => {
    const packageJson = require('./package.json');
    const dependencies = packageJson.dependencies || {};
    
    const optimizations = [];
    
    Object.entries(dependencies).forEach(([name, version]) => {
      if (version.includes('^') || version.includes('~')) {
        optimizations.push({
          package: name,
          current: version,
          suggestion: 'Consider using exact version for better reproducibility'
        });
      }
    });
    
    return optimizations;
  }
};
```

---

## 🔍 **Dependency Auditing**

### **Automated Auditing**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Automated dependency auditing
const DependencyAuditor = {
  // Run comprehensive audit
  runComprehensiveAudit: async () => {
    const results = {
      security: await this.runSecurityAudit(),
      licenses: await this.runLicenseAudit(),
      outdated: await this.runOutdatedAudit(),
      unused: await this.runUnusedAudit(),
      duplicates: await this.runDuplicateAudit()
    };
    
    return results;
  },
  
  // Security audit
  runSecurityAudit: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout } = await execAsync('npm audit --json');
      return JSON.parse(stdout);
    } catch (error) {
      return { error: error.message };
    }
  },
  
  // License audit
  runLicenseAudit: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout } = await execAsync('license-checker --json');
      return JSON.parse(stdout);
    } catch (error) {
      return { error: error.message };
    }
  },
  
  // Outdated dependencies audit
  runOutdatedAudit: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout } = await execAsync('npm outdated --json');
      return JSON.parse(stdout);
    } catch (error) {
      return { error: error.message };
    }
  },
  
  // Unused dependencies audit
  runUnusedAudit: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout } = await execAsync('npx depcheck --json');
      return JSON.parse(stdout);
    } catch (error) {
      return { error: error.message };
    }
  },
  
  // Duplicate dependencies audit
  runDuplicateAudit: async () => {
    const { exec } = require('child_process');
    const { promisify } = require('util');
    const execAsync = promisify(exec);
    
    try {
      const { stdout } = await execAsync('npx npm-check-duplicates');
      return { output: stdout };
    } catch (error) {
      return { error: error.message };
    }
  }
};
```

### **Audit Reporting**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Audit reporting
const AuditReporter = {
  // Generate audit report
  generateReport: (auditResults) => {
    const report = {
      timestamp: new Date().toISOString(),
      summary: this.generateSummary(auditResults),
      details: auditResults,
      recommendations: this.generateRecommendations(auditResults)
    };
    
    return report;
  },
  
  // Generate summary
  generateSummary: (results) => {
    const summary = {
      totalIssues: 0,
      criticalIssues: 0,
      highIssues: 0,
      mediumIssues: 0,
      lowIssues: 0
    };
    
    // Count issues from different audits
    if (results.security?.vulnerabilities) {
      const vulns = results.security.vulnerabilities;
      Object.values(vulns).forEach(vuln => {
        summary.totalIssues++;
        switch (vuln.severity) {
          case 'critical':
            summary.criticalIssues++;
            break;
          case 'high':
            summary.highIssues++;
            break;
          case 'moderate':
            summary.mediumIssues++;
            break;
          case 'low':
            summary.lowIssues++;
            break;
        }
      });
    }
    
    return summary;
  },
  
  // Generate recommendations
  generateRecommendations: (results) => {
    const recommendations = [];
    
    if (results.security?.vulnerabilities) {
      recommendations.push('Run npm audit fix to address security vulnerabilities');
    }
    
    if (results.outdated && Object.keys(results.outdated).length > 0) {
      recommendations.push('Update outdated dependencies to latest versions');
    }
    
    if (results.unused?.dependencies?.length > 0) {
      recommendations.push('Remove unused dependencies to reduce bundle size');
    }
    
    return recommendations;
  }
};
```

---

## ✅ **Best Practices**

### **1. Dependency Management Best Practices**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```javascript
// Dependency management best practices
const DependencyBestPractices = {
  // Use exact versions for critical dependencies
  useExactVersions: () => {
    const criticalDeps = ['react', 'react-native'];
    
    return {
      recommendation: 'Use exact versions for critical dependencies',
      example: {
        'react': '18.2.0',        // Exact version
        'react-native': '0.71.0'  // Exact version
      }
    };
  },
  
  // Regular dependency updates
  regularUpdates: () => {
    return {
      recommendation: 'Update dependencies regularly',
      schedule: 'Monthly',
      process: [
        'Check for updates',
        'Review changelog',
        'Test in development',
        'Update gradually',
        'Monitor for issues'
      ]
    };
  },
  
  // Security monitoring
  securityMonitoring: () => {
    return {
      recommendation: 'Monitor security vulnerabilities',
      tools: [
        'npm audit',
        'Snyk',
        'GitHub Dependabot',
        'Renovate'
      ],
      schedule: 'Weekly'
    };
  }
};
```

### **2. CI/CD Integration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>
```yaml
# .github/workflows/dependency-audit.yml
name: Dependency Audit

on:
  schedule:
    - cron: '0 0 * * 1'  # Weekly
  pull_request:
    branches: [main]

jobs:
  audit:
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
        
      - name: Run security audit
        run: npm audit --audit-level=moderate
        
      - name: Check for outdated dependencies
        run: npm outdated
        
      - name: Check licenses
        run: npx license-checker --summary
```

---

## 🎯 **Interview Questions**

### **Basic Questions**
1. **What are the different package managers for React Native?**
   - npm: Default Node.js package manager
   - Yarn: Fast, reliable alternative
   - pnpm: Disk space efficient
   - bun: Fast JavaScript runtime and package manager

2. **How do you manage dependency versions?**
   - Use semantic versioning
   - Choose appropriate version ranges
   - Use lock files for reproducibility
   - Regular updates and testing

3. **What's the difference between dependencies and devDependencies?**
   - dependencies: Required for production
   - devDependencies: Required only for development
   - peerDependencies: Expected to be provided by the consumer

### **Intermediate Questions**
4. **How do you handle security vulnerabilities in dependencies?**
   - Run regular security audits
   - Use automated vulnerability scanning
   - Update vulnerable dependencies
   - Implement security monitoring
   - Use tools like Snyk or Dependabot

5. **What's your approach to dependency updates?**
   - Regular update schedule
   - Test updates in development
   - Review changelog and breaking changes
   - Update gradually
   - Monitor for issues

6. **How do you optimize bundle size with dependencies?**
   - Remove unused dependencies
   - Use tree shaking
   - Implement code splitting
   - Use dynamic imports
   - Analyze bundle with tools

### **Advanced Questions**
7. **How do you implement dependency management in CI/CD?**
   - Automated security audits
   - Dependency update checks
   - License compliance verification
   - Bundle size monitoring
   - Automated testing

8. **What's your strategy for handling dependency conflicts?**
   - Use resolution strategies
   - Check peer dependencies
   - Use package manager features
   - Implement abstraction layers
   - Regular conflict resolution

9. **How do you manage dependencies in a monorepo?**
   - Use workspace features
   - Implement shared dependencies
   - Use hoisting strategies
   - Manage version consistency
   - Implement proper tooling

---

## 🔗 **Related Topics**

- [Popular Libraries](./01-Popular-Libraries.md)
- [Library Evaluation](./02-Library-Evaluation.md)
- [Creating Libraries](./04-Creating-Libraries.md)
- [Build Process](../10-Build-Release-CICD/01-Metro-Bundling.md)
- [Security Best Practices](../11-Security-Privacy/01-Secure-Storage.md)

---

## 🧭 Navigation

<div class="navigation">
    <a href="./02-Library-Evaluation.md" class="nav-link prev">⬅️ Previous: Library Evaluation</a>
    <a href="./04-Creating-Libraries.md" class="nav-link next">Next: Creating Libraries ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
