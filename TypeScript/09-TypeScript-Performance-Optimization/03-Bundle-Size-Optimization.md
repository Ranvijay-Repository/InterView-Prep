# 📦 **Bundle Size Optimization**

> **Complete guide to optimizing TypeScript bundle sizes, tree shaking, and code splitting strategies**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Bundle Size Overview](#bundle-size-overview)
- [Tree Shaking](#tree-shaking)
- [Code Splitting](#code-splitting)
- [Import Optimization](#import-optimization)
- [Build Tool Configuration](#build-tool-configuration)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Bundle Size Overview**

Bundle size optimization is crucial for web performance, affecting load times, user experience, and SEO rankings.

### **Bundle Size Factors**

```typescript
// Factors affecting bundle size
const bundleSizeFactors = {
  dependencies: "Third-party library size",
  codeDuplication: "Duplicate code across modules",
  unusedCode: "Dead code that's not used",
  polyfills: "Polyfills for older browsers",
  sourceMaps: "Source map files",
  assets: "Images, fonts, and other assets"
};

// Bundle size metrics
const bundleSizeMetrics = {
  totalSize: "Total bundle size in bytes",
  gzippedSize: "Gzipped bundle size",
  chunkSize: "Individual chunk sizes",
  assetSize: "Asset file sizes",
  loadTime: "Time to load and parse bundle"
};

// Bundle size goals
const bundleSizeGoals = {
  smallInitial: "Small initial bundle size",
  efficientSplitting: "Efficient code splitting",
  lazyLoading: "Lazy load non-critical code",
  compression: "Effective compression",
  caching: "Optimal caching strategies"
};
```

### **Bundle Analysis**

```typescript
// Bundle analysis tools
const bundleAnalysisTools = {
  webpackBundleAnalyzer: "Webpack bundle analyzer",
  rollupPluginAnalyzer: "Rollup bundle analyzer",
  esbuildAnalyzer: "esbuild bundle analyzer",
  sourceMapExplorer: "Source map explorer",
  bundlephobia: "Online bundle size checker"
};

// Bundle analysis configuration
const bundleAnalysisConfig = {
  webpack: {
    plugins: [
      new BundleAnalyzerPlugin({
        analyzerMode: 'static',
        openAnalyzer: false,
        reportFilename: 'bundle-report.html'
      })
    ]
  },
  rollup: {
    plugins: [
      analyzer({
        summaryOnly: true,
        limit: 10
      })
    ]
  }
};

// Bundle size monitoring
function monitorBundleSize() {
  const fs = require('fs');
  const path = require('path');
  const gzipSize = require('gzip-size');
  
  const bundlePath = path.join(__dirname, 'dist', 'bundle.js');
  const bundle = fs.readFileSync(bundlePath);
  const size = bundle.length;
  const gzipped = gzipSize.sync(bundle);
  
  console.log(`Bundle size: ${(size / 1024).toFixed(2)} KB`);
  console.log(`Gzipped size: ${(gzipped / 1024).toFixed(2)} KB`);
  
  return { size, gzipped };
}
```

---

## 🌳 **Tree Shaking**

### **Tree Shaking Configuration**

```typescript
// Tree shaking configuration
const treeShakingConfig = {
  esModules: "Use ES modules for tree shaking",
  sideEffects: "Configure side effects in package.json",
  optimization: "Enable optimization in build tools",
  imports: "Use specific imports instead of wildcard imports"
};

// ES modules for tree shaking
// ✅ Good: ES modules
export const add = (a: number, b: number) => a + b;
export const subtract = (a: number, b: number) => a - b;
export const multiply = (a: number, b: number) => a * b;

// ❌ Avoid: CommonJS modules
module.exports = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b,
  multiply: (a, b) => a * b
};

// Side effects configuration
const packageJson = {
  "name": "my-package",
  "sideEffects": false, // No side effects
  "sideEffects": ["./src/polyfills.js"], // Specific files with side effects
  "sideEffects": ["*.css"] // CSS files have side effects
};

// Import optimization
// ✅ Good: Specific imports
import { add, subtract } from './math';

// ❌ Avoid: Wildcard imports
import * as math from './math';

// ✅ Good: Destructured imports
import { debounce, throttle } from 'lodash-es';

// ❌ Avoid: Default imports for utilities
import _ from 'lodash';
```

### **Tree Shaking Best Practices**

```typescript
// Tree shaking best practices
const treeShakingBestPractices = {
  esModules: "Use ES modules instead of CommonJS",
  specificImports: "Use specific imports instead of wildcard imports",
  sideEffects: "Configure side effects properly",
  optimization: "Enable optimization in build tools",
  testing: "Test tree shaking effectiveness"
};

// Library design for tree shaking
// ✅ Good: Tree-shakeable library
export const utils = {
  add: (a: number, b: number) => a + b,
  subtract: (a: number, b: number) => a - b,
  multiply: (a: number, b: number) => a * b
};

// Individual exports
export const add = (a: number, b: number) => a + b;
export const subtract = (a: number, b: number) => a - b;
export const multiply = (a: number, b: number) => a * b;

// ❌ Avoid: Non-tree-shakeable library
const utils = {
  add: (a: number, b: number) => a + b,
  subtract: (a: number, b: number) => a - b,
  multiply: (a: number, b: number) => a * b
};

export default utils;

// Tree shaking testing
function testTreeShaking() {
  // Import only what you need
  import('./math').then(module => {
    console.log(module.add(1, 2)); // Only add function should be included
  });
}
```

### **Tree Shaking with Lodash**

```typescript
// Tree shaking with Lodash
const lodashTreeShaking = {
  lodashEs: "Use lodash-es for ES modules",
  specificImports: "Import specific functions",
  babelPlugin: "Use babel-plugin-lodash",
  webpackPlugin: "Use lodash-webpack-plugin"
};

// ✅ Good: Tree-shakeable Lodash imports
import { debounce, throttle, cloneDeep } from 'lodash-es';

// ❌ Avoid: Non-tree-shakeable imports
import _ from 'lodash';

// Babel plugin configuration
const babelConfig = {
  plugins: [
    ['lodash'],
    ['import', {
      libraryName: 'lodash',
      libraryDirectory: '',
      camel2DashComponentName: false
    }]
  ]
};

// Webpack plugin configuration
const webpackConfig = {
  plugins: [
    new LodashModuleReplacementPlugin({
      paths: true,
      flattening: true
    })
  ]
};
```

---

## 🔀 **Code Splitting**

### **Dynamic Imports**

```typescript
// Dynamic imports for code splitting
const dynamicImports = {
  lazyLoading: "Lazy load components and modules",
  routeBased: "Split code by routes",
  featureBased: "Split code by features",
  vendorSplitting: "Split vendor libraries"
};

// Lazy loading components
const LazyComponent = lazy(() => import('./LazyComponent'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <LazyComponent />
    </Suspense>
  );
}

// Route-based code splitting
const routes = [
  {
    path: '/',
    component: lazy(() => import('./Home'))
  },
  {
    path: '/about',
    component: lazy(() => import('./About'))
  },
  {
    path: '/contact',
    component: lazy(() => import('./Contact'))
  }
];

// Feature-based code splitting
const loadFeature = async (featureName: string) => {
  switch (featureName) {
    case 'dashboard':
      return import('./features/dashboard');
    case 'analytics':
      return import('./features/analytics');
    case 'reports':
      return import('./features/reports');
    default:
      throw new Error(`Unknown feature: ${featureName}`);
  }
};

// Vendor splitting
const vendorSplitting = {
  react: "Split React and React DOM",
  lodash: "Split Lodash utilities",
  moment: "Split date libraries",
  charts: "Split chart libraries"
};
```

### **Webpack Code Splitting**

```typescript
// Webpack code splitting configuration
const webpackCodeSplitting = {
  entry: {
    main: './src/index.ts',
    vendor: './src/vendor.ts'
  },
  optimization: {
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all'
        },
        common: {
          name: 'common',
          minChunks: 2,
          chunks: 'all',
          enforce: true
        }
      }
    }
  }
};

// Split chunks configuration
const splitChunksConfig = {
  chunks: 'all',
  minSize: 20000,
  maxSize: 244000,
  cacheGroups: {
    default: {
      minChunks: 2,
      priority: -20,
      reuseExistingChunk: true
    },
    vendor: {
      test: /[\\/]node_modules[\\/]/,
      name: 'vendors',
      priority: -10,
      chunks: 'all'
    },
    react: {
      test: /[\\/]node_modules[\\/](react|react-dom)[\\/]/,
      name: 'react',
      priority: 20,
      chunks: 'all'
    }
  }
};
```

### **Rollup Code Splitting**

```typescript
// Rollup code splitting configuration
const rollupCodeSplitting = {
  input: {
    main: 'src/index.ts',
    vendor: 'src/vendor.ts'
  },
  output: {
    dir: 'dist',
    format: 'es',
    chunkFileNames: '[name]-[hash].js'
  },
  plugins: [
    resolve(),
    commonjs(),
    typescript()
  ]
};

// Dynamic imports with Rollup
const dynamicImportsRollup = {
  input: 'src/index.ts',
  output: {
    dir: 'dist',
    format: 'es',
    chunkFileNames: '[name]-[hash].js'
  },
  plugins: [
    resolve(),
    commonjs(),
    typescript()
  ]
};
```

---

## 📥 **Import Optimization**

### **Import Strategies**

```typescript
// Import optimization strategies
const importStrategies = {
  specificImports: "Import only what you need",
  dynamicImports: "Use dynamic imports for large modules",
  reExports: "Use re-exports for better tree shaking",
  barrelExports: "Optimize barrel exports"
};

// Specific imports
// ✅ Good: Specific imports
import { debounce, throttle } from 'lodash-es';
import { useState, useEffect } from 'react';

// ❌ Avoid: Wildcard imports
import * as _ from 'lodash';
import * as React from 'react';

// Dynamic imports
const loadUtility = async () => {
  const { debounce, throttle } = await import('lodash-es');
  return { debounce, throttle };
};

// Re-exports for better tree shaking
// ✅ Good: Re-exports
export { add, subtract, multiply } from './math';
export { debounce, throttle } from 'lodash-es';

// ❌ Avoid: Default re-exports
export { default as math } from './math';
export { default as _ } from 'lodash';
```

### **Barrel Export Optimization**

```typescript
// Barrel export optimization
const barrelExportOptimization = {
  specificExports: "Export specific functions",
  avoidDefault: "Avoid default exports in barrels",
  conditionalExports: "Use conditional exports",
  sideEffects: "Configure side effects properly"
};

// ✅ Good: Specific barrel exports
export { add, subtract, multiply } from './math';
export { debounce, throttle } from './utils';
export { formatDate, parseDate } from './date';

// ❌ Avoid: Default barrel exports
export { default as math } from './math';
export { default as utils } from './utils';
export { default as date } from './date';

// Conditional exports
const conditionalExports = {
  "exports": {
    ".": {
      "import": "./dist/index.esm.js",
      "require": "./dist/index.cjs.js"
    },
    "./utils": {
      "import": "./dist/utils.esm.js",
      "require": "./dist/utils.cjs.js"
    }
  }
};
```

### **Import Analysis**

```typescript
// Import analysis tools
const importAnalysis = {
  webpackBundleAnalyzer: "Analyze bundle imports",
  rollupPluginAnalyzer: "Analyze Rollup imports",
  esbuildAnalyzer: "Analyze esbuild imports",
  sourceMapExplorer: "Explore source maps"
};

// Import analysis configuration
const importAnalysisConfig = {
  webpack: {
    plugins: [
      new BundleAnalyzerPlugin({
        analyzerMode: 'static',
        openAnalyzer: false,
        reportFilename: 'bundle-report.html'
      })
    ]
  },
  rollup: {
    plugins: [
      analyzer({
        summaryOnly: true,
        limit: 10
      })
    ]
  }
};

// Import monitoring
function monitorImports() {
  const fs = require('fs');
  const path = require('path');
  
  const bundlePath = path.join(__dirname, 'dist', 'bundle.js');
  const bundle = fs.readFileSync(bundlePath, 'utf8');
  
  // Analyze imports
  const importRegex = /import\s+.*?\s+from\s+['"](.*?)['"]/g;
  const imports = [];
  let match;
  
  while ((match = importRegex.exec(bundle)) !== null) {
    imports.push(match[1]);
  }
  
  console.log('Imports found:', imports);
  return imports;
}
```

---

## 🛠️ **Build Tool Configuration**

### **Webpack Configuration**

```typescript
// Webpack bundle optimization
const webpackOptimization = {
  mode: 'production',
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        terserOptions: {
          compress: {
            drop_console: true,
            drop_debugger: true
          }
        }
      })
    ],
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all'
        }
      }
    }
  }
};

// Webpack tree shaking
const webpackTreeShaking = {
  mode: 'production',
  optimization: {
    usedExports: true,
    sideEffects: false
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  }
};
```

### **Rollup Configuration**

```typescript
// Rollup bundle optimization
const rollupOptimization = {
  input: 'src/index.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'es',
    sourcemap: true
  },
  plugins: [
    resolve(),
    commonjs(),
    typescript(),
    terser({
      compress: {
        drop_console: true,
        drop_debugger: true
      }
    })
  ]
};

// Rollup tree shaking
const rollupTreeShaking = {
  input: 'src/index.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },
  plugins: [
    resolve(),
    commonjs(),
    typescript()
  ],
  treeshake: {
    moduleSideEffects: false
  }
};
```

### **esbuild Configuration**

```typescript
// esbuild bundle optimization
const esbuildOptimization = {
  entryPoints: ['src/index.ts'],
  bundle: true,
  outfile: 'dist/bundle.js',
  minify: true,
  sourcemap: true,
  target: 'es2020',
  format: 'esm',
  treeShaking: true,
  drop: ['console', 'debugger']
};

// esbuild code splitting
const esbuildCodeSplitting = {
  entryPoints: ['src/index.ts'],
  bundle: true,
  outdir: 'dist',
  format: 'esm',
  splitting: true,
  chunkNames: '[name]-[hash]'
};
```

---

## ✅ **Best Practices**

### **1. Use Tree Shaking**

```typescript
// ✅ Good: Tree-shakeable imports
import { debounce, throttle } from 'lodash-es';

// ❌ Avoid: Non-tree-shakeable imports
import _ from 'lodash';
```

### **2. Implement Code Splitting**

```typescript
// ✅ Good: Code splitting
const LazyComponent = lazy(() => import('./LazyComponent'));

// ❌ Avoid: No code splitting
import LazyComponent from './LazyComponent';
```

### **3. Optimize Imports**

```typescript
// ✅ Good: Specific imports
import { useState, useEffect } from 'react';

// ❌ Avoid: Wildcard imports
import * as React from 'react';
```

### **4. Configure Build Tools**

```typescript
// ✅ Good: Optimized build configuration
const config = {
  optimization: {
    minimize: true,
    splitChunks: {
      chunks: 'all'
    }
  }
};

// ❌ Avoid: No optimization
const config = {
  optimization: {}
};
```

---

## ❓ **Common Interview Questions**

### **1. How do you optimize bundle size in TypeScript?**

**Answer:**
- **Tree Shaking**: Use ES modules and specific imports
- **Code Splitting**: Split code by routes, features, or vendors
- **Import Optimization**: Import only what you need
- **Build Tool Configuration**: Configure Webpack, Rollup, or esbuild
- **Compression**: Use gzip and minification

### **2. What is tree shaking and how does it work?**

**Answer:**
Tree shaking is a dead code elimination technique that removes unused code from bundles. It works by:
- **ES Modules**: Using ES modules instead of CommonJS
- **Static Analysis**: Analyzing imports and exports at build time
- **Dead Code Elimination**: Removing unused code
- **Side Effects**: Configuring side effects properly

### **3. How do you implement code splitting?**

**Answer:**
- **Dynamic Imports**: Use `import()` for lazy loading
- **Route-based**: Split code by routes
- **Feature-based**: Split code by features
- **Vendor Splitting**: Split third-party libraries
- **Build Tool Configuration**: Configure Webpack or Rollup

### **4. What are the benefits of code splitting?**

**Answer:**
- **Faster Initial Load**: Smaller initial bundle size
- **Better Caching**: Cache individual chunks
- **Lazy Loading**: Load code when needed
- **Parallel Loading**: Load multiple chunks in parallel
- **Better Performance**: Improved user experience

### **5. How do you analyze bundle size?**

**Answer:**
- **Webpack Bundle Analyzer**: Analyze Webpack bundles
- **Rollup Plugin Analyzer**: Analyze Rollup bundles
- **esbuild Analyzer**: Analyze esbuild bundles
- **Source Map Explorer**: Explore source maps
- **Bundlephobia**: Online bundle size checker

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Runtime-Performance.md" class="nav-button">← Previous: Runtime Performance</a>
  <a href="04-Memory-Management.md" class="nav-button">Next: Memory Management →</a>
</div>

*Last updated: December 2024*
