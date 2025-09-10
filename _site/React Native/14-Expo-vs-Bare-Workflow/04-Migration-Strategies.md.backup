# 🔄 **Migration Strategies**

> **Master migration strategies between Expo and Bare React Native workflows, tools, and best practices**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Migration Overview](#-migration-overview)
- [Expo to Bare Migration](#-expo-to-bare-migration)
- [Bare to Expo Migration](#-bare-to-expo-migration)
- [Migration Tools](#-migration-tools)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 🔄 **Migration Overview**

### **Migration Types**


```mermaid
graph TD
    A[Migration Types] --> B[Expo to Bare]
    A --> C[Bare to Expo]
    A --> D[Hybrid Approach]
    
    B --> E[Eject Process]
    B --> F[Custom Native Modules]
    C --> G[Expo SDK Adoption]
    C --> H[Service Migration]
    D --> I[Expo Development]
    D --> J[Bare Production]
```


### **Migration Considerations**
- **Project Complexity**: Size and complexity of existing code
- **Team Expertise**: Native development capabilities
- **Timeline**: Available time for migration
- **Risk Tolerance**: Willingness to accept migration risks

---

## 📱 **Expo to Bare Migration**

### **Eject Process**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Expo to Bare migration process
const ExpoToBareMigration = {
  // Pre-migration checklist
  preMigrationChecklist: [
    'Backup current project',
    'Document current dependencies',
    'Test all existing functionality',
    'Identify Expo-specific code',
    'Plan native module replacements',
    'Set up development environment'
  ],

  // Migration steps
  migrationSteps: [
    {
      step: 1,
      title: 'Prepare for Ejection',
      description: 'Clean up Expo-specific code and dependencies',
      commands: [
        'npm audit fix',
        'npx expo install --fix',
        'git add . && git commit -m "Pre-ejection cleanup"'
      ]
    },
    {
      step: 2,
      title: 'Eject from Expo',
      description: 'Run the eject command to generate native projects',
      commands: [
        'npx expo eject',
        'Choose "Bare workflow" when prompted'
      ]
    },
    {
      step: 3,
      title: 'Install Native Dependencies',
      description: 'Install iOS and Android dependencies',
      commands: [
        'cd ios && pod install',
        'cd android && ./gradlew clean'
      ]
    },
    {
      step: 4,
      title: 'Replace Expo Modules',
      description: 'Replace Expo SDK modules with React Native equivalents',
      commands: [
        'npm uninstall expo-camera',
        'npm install react-native-camera',
        'npm uninstall expo-location',
        'npm install @react-native-community/geolocation'
      ]
    },
    {
      step: 5,
      title: 'Update Code',
      description: 'Update import statements and API calls',
      commands: [
        'Update import statements',
        'Update API calls',
        'Test functionality'
      ]
    },
    {
      step: 6,
      title: 'Test and Debug',
      description: 'Test on both platforms and fix issues',
      commands: [
        'npx react-native run-android',
        'npx react-native run-ios',
        'Fix any build or runtime errors'
      ]
    }
  ],

  // Common issues and solutions
  commonIssues: {
    'Build errors': {
      description: 'Native build failures after ejection',
      solutions: [
        'Clean and rebuild projects',
        'Update native dependencies',
        'Check platform-specific configurations'
      ]
    },
    'Module not found': {
      description: 'Expo modules not available in bare workflow',
      solutions: [
        'Install React Native equivalents',
        'Update import statements',
        'Implement custom native modules'
      ]
    },
    'Permission issues': {
      description: 'Permissions not working after migration',
      solutions: [
        'Update permission handling code',
        'Check platform-specific permission configurations',
        'Test on physical devices'
      ]
    }
  }
};

// Migration helper functions
const MigrationHelpers = {
  // Check if project is ready for ejection
  checkEjectionReadiness: (projectPath) => {
    const packageJson = require(`${projectPath}/package.json`);
    const expoDependencies = Object.keys(packageJson.dependencies || {})
      .filter(dep => dep.startsWith('expo-'));
    
    return {
      ready: expoDependencies.length === 0,
      expoDependencies,
      recommendations: expoDependencies.length > 0 ? 
        'Remove or replace Expo dependencies before ejection' : 
        'Project is ready for ejection'
    };
  },

  // Generate migration plan
  generateMigrationPlan: (projectPath) => {
    const packageJson = require(`${projectPath}/package.json`);
    const expoDependencies = Object.keys(packageJson.dependencies || {})
      .filter(dep => dep.startsWith('expo-'));
    
    const migrationPlan = expoDependencies.map(dep => {
      const alternative = getReactNativeAlternative(dep);
      return {
        expoModule: dep,
        alternative: alternative?.package || 'Custom implementation needed',
        migrationSteps: alternative?.steps || ['Implement custom native module'],
        difficulty: alternative?.difficulty || 'High'
      };
    });
    
    return migrationPlan;
  },

  // Get React Native alternatives for Expo modules
  getReactNativeAlternative: (expoModule) => {
    const alternatives = {
      'expo-camera': {
        package: 'react-native-camera',
        steps: [
          'Remove expo-camera',
          'Install react-native-camera',
          'Update import statements',
          'Update API calls',
          'Configure native permissions'
        ],
        difficulty: 'Medium'
      },
      'expo-location': {
        package: '@react-native-community/geolocation',
        steps: [
          'Remove expo-location',
          'Install @react-native-community/geolocation',
          'Update import statements',
          'Update API calls',
          'Configure native permissions'
        ],
        difficulty: 'Low'
      },
      'expo-notifications': {
        package: 'react-native-push-notification',
        steps: [
          'Remove expo-notifications',
          'Install react-native-push-notification',
          'Update import statements',
          'Update API calls',
          'Configure push notification services'
        ],
        difficulty: 'High'
      }
    };
    
    return alternatives[expoModule] || null;
  }
};

export { ExpoToBareMigration, MigrationHelpers };
```


---

## 🔄 **Bare to Expo Migration**

### **Expo Adoption Process**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Bare to Expo migration process
const BareToExpoMigration = {
  // Pre-migration checklist
  preMigrationChecklist: [
    'Audit current dependencies',
    'Identify incompatible libraries',
    'Document custom native modules',
    'Plan Expo SDK adoption',
    'Set up Expo development environment',
    'Create migration timeline'
  ],

  // Migration steps
  migrationSteps: [
    {
      step: 1,
      title: 'Create New Expo Project',
      description: 'Set up a new Expo project as the target',
      commands: [
        'npx create-expo-app MyAppExpo',
        'cd MyAppExpo',
        'npx expo start'
      ]
    },
    {
      step: 2,
      title: 'Migrate Source Code',
      description: 'Copy and adapt source code to Expo project',
      commands: [
        'Copy src/ directory',
        'Copy assets/ directory',
        'Update import statements',
        'Remove React Native CLI specific code'
      ]
    },
    {
      step: 3,
      title: 'Replace Native Modules',
      description: 'Replace React Native modules with Expo equivalents',
      commands: [
        'npm uninstall react-native-camera',
        'npx expo install expo-camera',
        'npm uninstall @react-native-community/geolocation',
        'npx expo install expo-location'
      ]
    },
    {
      step: 4,
      title: 'Update Dependencies',
      description: 'Install Expo-compatible dependencies',
      commands: [
        'npx expo install --fix',
        'Update package.json',
        'Test dependency compatibility'
      ]
    },
    {
      step: 5,
      title: 'Configure Expo Services',
      description: 'Set up Expo services and configurations',
      commands: [
        'Configure app.json',
        'Set up Expo notifications',
        'Configure Expo updates',
        'Set up Expo analytics'
      ]
    },
    {
      step: 6,
      title: 'Test and Validate',
      description: 'Test functionality and fix issues',
      commands: [
        'npx expo start',
        'Test on Expo Go app',
        'Fix any compatibility issues',
        'Validate all features'
      ]
    }
  ],

  // Compatibility assessment
  compatibilityAssessment: {
    // Check if libraries are Expo compatible
    checkCompatibility: (packageJson) => {
      const dependencies = Object.keys(packageJson.dependencies || {});
      const incompatible = [];
      const compatible = [];
      
      dependencies.forEach(dep => {
        if (dep.startsWith('react-native-')) {
          const isCompatible = checkExpoCompatibility(dep);
          if (isCompatible) {
            compatible.push(dep);
          } else {
            incompatible.push(dep);
          }
        }
      });
      
      return { compatible, incompatible };
    },

    // Get Expo alternatives
    getExpoAlternatives: (incompatiblePackages) => {
      const alternatives = {};
      
      incompatiblePackages.forEach(packageName => {
        const alternative = getExpoAlternative(packageName);
        if (alternative) {
          alternatives[packageName] = alternative;
        }
      });
      
      return alternatives;
    }
  }
};

// Expo compatibility checker
const ExpoCompatibilityChecker = {
  // Check if a package is Expo compatible
  checkExpoCompatibility: (packageName) => {
    const expoCompatiblePackages = [
      'react-native-screens',
      'react-native-safe-area-context',
      'react-native-gesture-handler',
      'react-native-reanimated',
      'react-native-svg',
      'react-native-vector-icons'
    ];
    
    return expoCompatiblePackages.includes(packageName);
  },

  // Get Expo alternative for a package
  getExpoAlternative: (packageName) => {
    const alternatives = {
      'react-native-camera': {
        expoModule: 'expo-camera',
        migrationSteps: [
          'Remove react-native-camera',
          'Install expo-camera',
          'Update import statements',
          'Update API calls'
        ],
        apiChanges: {
          'RNCamera': 'Camera',
          'requestCameraPermission': 'requestCameraPermissionsAsync',
          'takePicture': 'takePictureAsync'
        }
      },
      'react-native-geolocation': {
        expoModule: 'expo-location',
        migrationSteps: [
          'Remove react-native-geolocation',
          'Install expo-location',
          'Update import statements',
          'Update API calls'
        ],
        apiChanges: {
          'getCurrentPosition': 'getCurrentPositionAsync',
          'watchPosition': 'watchPositionAsync',
          'clearWatch': 'stopLocationUpdatesAsync'
        }
      }
    };
    
    return alternatives[packageName] || null;
  }
};

export { BareToExpoMigration, ExpoCompatibilityChecker };
```


---

## 🛠️ **Migration Tools**

### **Automated Migration Tools**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

```javascript
// Migration automation tools
const MigrationTools = {
  // Automated dependency migration
  migrateDependencies: async (projectPath, targetType) => {
    const packageJson = require(`${projectPath}/package.json`);
    const dependencies = packageJson.dependencies || {};
    
    const migrationPlan = [];
    
    Object.keys(dependencies).forEach(dep => {
      if (targetType === 'expo' && dep.startsWith('react-native-')) {
        const alternative = ExpoCompatibilityChecker.getExpoAlternative(dep);
        if (alternative) {
          migrationPlan.push({
            action: 'replace',
            from: dep,
            to: alternative.expoModule,
            steps: alternative.migrationSteps
          });
        }
      } else if (targetType === 'bare' && dep.startsWith('expo-')) {
        const alternative = MigrationHelpers.getReactNativeAlternative(dep);
        if (alternative) {
          migrationPlan.push({
            action: 'replace',
            from: dep,
            to: alternative.package,
            steps: alternative.steps
          });
        }
      }
    });
    
    return migrationPlan;
  },

  // Code transformation tool
  transformCode: (code, transformations) => {
    let transformedCode = code;
    
    transformations.forEach(transformation => {
      const { from, to, type } = transformation;
      
      switch (type) {
        case 'import':
          transformedCode = transformedCode.replace(
            new RegExp(`import.*${from}.*from.*['"]${from}['"]`, 'g'),
            `import ${to} from '${to}'`
          );
          break;
        case 'api':
          transformedCode = transformedCode.replace(
            new RegExp(from, 'g'),
            to
          );
          break;
        case 'component':
          transformedCode = transformedCode.replace(
            new RegExp(`<${from}`, 'g'),
            `<${to}`
          );
          break;
      }
    });
    
    return transformedCode;
  },

  // Migration validation
  validateMigration: (projectPath, targetType) => {
    const validationResults = {
      success: true,
      errors: [],
      warnings: [],
      recommendations: []
    };
    
    // Check for incompatible dependencies
    const packageJson = require(`${projectPath}/package.json`);
    const dependencies = Object.keys(packageJson.dependencies || {});
    
    dependencies.forEach(dep => {
      if (targetType === 'expo' && dep.startsWith('react-native-')) {
        const isCompatible = ExpoCompatibilityChecker.checkExpoCompatibility(dep);
        if (!isCompatible) {
          validationResults.warnings.push({
            type: 'incompatible_dependency',
            package: dep,
            message: `Package ${dep} may not be compatible with Expo`
          });
        }
      }
    });
    
    // Check for custom native modules
    const hasCustomNativeModules = checkForCustomNativeModules(projectPath);
    if (hasCustomNativeModules && targetType === 'expo') {
      validationResults.warnings.push({
        type: 'custom_native_modules',
        message: 'Custom native modules detected. May need to be replaced with Expo modules.'
      });
    }
    
    return validationResults;
  }
};

// Custom native module checker
const checkForCustomNativeModules = (projectPath) => {
  const fs = require('fs');
  const path = require('path');
  
  // Check for native module files
  const androidPath = path.join(projectPath, 'android', 'app', 'src', 'main', 'java');
  const iosPath = path.join(projectPath, 'ios');
  
  const hasAndroidModules = fs.existsSync(androidPath) && 
    fs.readdirSync(androidPath).some(file => file.endsWith('.java') || file.endsWith('.kt'));
  
  const hasIOSModules = fs.existsSync(iosPath) && 
    fs.readdirSync(iosPath).some(file => file.endsWith('.m') || file.endsWith('.mm'));
  
  return hasAndroidModules || hasIOSModules;
};

// Migration progress tracker
const MigrationProgressTracker = {
  // Track migration progress
  trackProgress: (migrationPlan) => {
    const progress = {
      total: migrationPlan.length,
      completed: 0,
      failed: 0,
      inProgress: 0,
      steps: migrationPlan.map(step => ({
        ...step,
        status: 'pending',
        startTime: null,
        endTime: null,
        error: null
      }))
    };
    
    return progress;
  },

  // Update step status
  updateStepStatus: (progress, stepIndex, status, error = null) => {
    const step = progress.steps[stepIndex];
    if (step) {
      step.status = status;
      step.error = error;
      
      if (status === 'in_progress') {
        step.startTime = new Date();
      } else if (status === 'completed' || status === 'failed') {
        step.endTime = new Date();
      }
      
      // Update overall progress
      progress.completed = progress.steps.filter(s => s.status === 'completed').length;
      progress.failed = progress.steps.filter(s => s.status === 'failed').length;
      progress.inProgress = progress.steps.filter(s => s.status === 'in_progress').length;
    }
    
    return progress;
  },

  // Generate progress report
  generateProgressReport: (progress) => {
    const report = {
      summary: {
        total: progress.total,
        completed: progress.completed,
        failed: progress.failed,
        inProgress: progress.inProgress,
        successRate: (progress.completed / progress.total) * 100
      },
      steps: progress.steps.map(step => ({
        title: step.title,
        status: step.status,
        duration: step.endTime ? step.endTime - step.startTime : null,
        error: step.error
      }))
    };
    
    return report;
  }
};

export { MigrationTools, MigrationProgressTracker };
```


---

## 🎯 **Best Practices**

### **1. Migration Planning**
- Create detailed migration plan
- Test migration on small project first
- Backup existing projects
- Document all changes

### **2. Migration Execution**
- Follow migration steps carefully
- Test after each major step
- Fix issues immediately
- Keep team informed

### **3. Post-Migration**
- Thoroughly test all functionality
- Update documentation
- Train team on new workflow
- Monitor for issues

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **How do you migrate from Expo to Bare React Native?**
2. **What are the main challenges in migration?**
3. **How do you handle incompatible dependencies?**

### **Advanced Questions**
1. **Explain the Expo eject process.**
2. **How would you automate migration between workflows?**
3. **What tools would you use for migration validation?**

### **Practical Questions**
1. **Create a migration plan for a complex project.**
2. **Implement migration validation tools.**
3. **Design a migration progress tracking system.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-Expo-vs-Bare-Comparison.md" class="nav-link prev">⬅️ Previous: Expo vs Bare Comparison</a>
    <a href="../15-Error-Handling-Recovery/01-Error-Boundaries.md" class="nav-link next">Next: Error Boundaries ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
