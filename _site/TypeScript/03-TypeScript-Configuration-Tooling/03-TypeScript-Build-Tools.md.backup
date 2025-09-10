# 🛠️ **TypeScript with Build Tools**

> **Complete guide to integrating TypeScript with popular build tools like Webpack, Vite, Rollup, and Parcel**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Build Tools Overview](#build-tools-overview)
- [Webpack Integration](#webpack-integration)
- [Vite Integration](#vite-integration)
- [Rollup Integration](#rollup-integration)
- [Parcel Integration](#parcel-integration)
- [Custom Build Scripts](#custom-build-scripts)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Build Tools Overview**

Build tools help compile, bundle, and optimize TypeScript code for production deployment.

### **Popular Build Tools**


```typescript
// Build tool comparison
const buildTools = {
  webpack: {
    pros: ["Mature ecosystem", "Extensive plugins", "Code splitting"],
    cons: ["Complex configuration", "Slow builds"]
  },
  vite: {
    pros: ["Fast development", "ES modules", "Simple config"],
    cons: ["Newer tool", "Limited ecosystem"]
  },
  rollup: {
    pros: ["Tree shaking", "Small bundles", "Library focused"],
    cons: ["Limited for apps", "Complex setup"]
  },
  parcel: {
    pros: ["Zero config", "Fast builds", "Built-in optimizations"],
    cons: ["Less control", "Limited customization"]
  }
};
```


### **Build Tool Selection Criteria**


```typescript
// When to use each tool
const selectionCriteria = {
  webpack: "Large applications, complex requirements, extensive plugin needs",
  vite: "Modern applications, fast development, simple setup",
  rollup: "Libraries, small bundles, tree shaking important",
  parcel: "Quick prototyping, zero configuration, simple projects"
};
```


---

## 📦 **Webpack Integration**

Webpack is a powerful module bundler with extensive TypeScript support.

### **Basic Webpack Configuration**


```javascript
// webpack.config.js
const path = require('path');

module.exports = {
  entry: './src/index.ts',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
};
```


### **Advanced Webpack Configuration**


```javascript
// webpack.config.js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: './src/index.ts',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: [
          {
            loader: 'ts-loader',
            options: {
              transpileOnly: true,
              experimentalWatchApi: true,
            },
          },
        ],
        exclude: /node_modules/,
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader'],
      },
    ],
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
    alias: {
      '@': path.resolve(__dirname, 'src'),
    },
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
    }),
    new MiniCssExtractPlugin({
      filename: '[name].[contenthash].css',
    }),
  ],
  output: {
    filename: '[name].[contenthash].js',
    path: path.resolve(__dirname, 'dist'),
    clean: true,
  },
  optimization: {
    splitChunks: {
      chunks: 'all',
    },
  },
};
```


### **Webpack with TypeScript Loaders**


```javascript
// webpack.config.js
module.exports = {
  module: {
    rules: [
      // TypeScript loader
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      // Babel loader (alternative)
      {
        test: /\.tsx?$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              '@babel/preset-env',
              '@babel/preset-typescript',
            ],
          },
        },
        exclude: /node_modules/,
      },
    ],
  },
};
```


---

## ⚡ **Vite Integration**

Vite provides fast development and optimized production builds for TypeScript.

### **Basic Vite Configuration**


```typescript
// vite.config.ts
import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
  },
  server: {
    port: 3000,
    open: true,
  },
});
```


### **Advanced Vite Configuration**


```typescript
// vite.config.ts
import { defineConfig } from 'vite';
import { resolve } from 'path';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
      '@/components': resolve(__dirname, 'src/components'),
      '@/utils': resolve(__dirname, 'src/utils'),
    },
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          utils: ['lodash', 'date-fns'],
        },
      },
    },
  },
  server: {
    port: 3000,
    open: true,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
  define: {
    __APP_VERSION__: JSON.stringify(process.env.npm_package_version),
  },
});
```


### **Vite with TypeScript**


```typescript
// vite.config.ts
import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  esbuild: {
    target: 'es2020',
  },
  build: {
    target: 'es2020',
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
      },
    },
  },
});
```


---

## 📦 **Rollup Integration**

Rollup is excellent for building libraries and applications with tree shaking.

### **Basic Rollup Configuration**


```javascript
// rollup.config.js
import typescript from '@rollup/plugin-typescript';
import { resolve } from 'path';

export default {
  input: 'src/index.ts',
  output: [
    {
      file: 'dist/index.js',
      format: 'cjs',
    },
    {
      file: 'dist/index.esm.js',
      format: 'esm',
    },
  ],
  plugins: [
    typescript({
      tsconfig: './tsconfig.json',
    }),
  ],
  external: ['react', 'react-dom'],
};
```


### **Advanced Rollup Configuration**


```javascript
// rollup.config.js
import typescript from '@rollup/plugin-typescript';
import { nodeResolve } from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';
import { resolve } from 'path';

export default {
  input: 'src/index.ts',
  output: [
    {
      file: 'dist/index.js',
      format: 'cjs',
      sourcemap: true,
    },
    {
      file: 'dist/index.esm.js',
      format: 'esm',
      sourcemap: true,
    },
    {
      file: 'dist/index.umd.js',
      format: 'umd',
      name: 'MyLibrary',
      sourcemap: true,
    },
  ],
  plugins: [
    nodeResolve({
      preferBuiltins: false,
    }),
    commonjs(),
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: './dist',
    }),
    terser(),
  ],
  external: ['react', 'react-dom'],
};
```


---

## 📦 **Parcel Integration**

Parcel provides zero-configuration builds with built-in TypeScript support.

### **Basic Parcel Configuration**


```json
// package.json
{
  "scripts": {
    "dev": "parcel src/index.html",
    "build": "parcel build src/index.html"
  },
  "devDependencies": {
    "parcel": "^2.0.0",
    "typescript": "^4.0.0"
  }
}
```


### **Parcel with TypeScript**


```typescript
// src/index.ts
import './styles.css';

interface User {
  id: number;
  name: string;
  email: string;
}

const user: User = {
  id: 1,
  name: 'John Doe',
  email: 'john@example.com'
};

console.log(user);
```


### **Parcel Configuration File**


```javascript
// .parcelrc
{
  "extends": "@parcel/config-default",
  "transformers": {
    "*.{ts,tsx}": ["@parcel/transformer-typescript-tsc"]
  }
}
```


---

## 🔧 **Custom Build Scripts**

Custom build scripts provide fine-grained control over the build process.

### **Basic Build Script**


```typescript
// scripts/build.ts
import { execSync } from 'child_process';
import { readFileSync, writeFileSync } from 'fs';
import { resolve } from 'path';

const build = async () => {
  console.log('Building TypeScript...');
  
  // Compile TypeScript
  execSync('tsc', { stdio: 'inherit' });
  
  // Copy assets
  execSync('cp -r src/assets dist/', { stdio: 'inherit' });
  
  // Generate bundle info
  const packageJson = JSON.parse(readFileSync('package.json', 'utf8'));
  const bundleInfo = {
    version: packageJson.version,
    buildTime: new Date().toISOString(),
    buildId: Math.random().toString(36).substr(2, 9)
  };
  
  writeFileSync(
    resolve('dist', 'bundle-info.json'),
    JSON.stringify(bundleInfo, null, 2)
  );
  
  console.log('Build completed successfully!');
};

build().catch(console.error);
```


### **Advanced Build Script**


```typescript
// scripts/build.ts
import { execSync } from 'child_process';
import { readFileSync, writeFileSync, existsSync } from 'fs';
import { resolve } from 'path';
import { glob } from 'glob';

interface BuildConfig {
  entry: string;
  output: string;
  target: string;
  format: string;
}

const buildConfigs: BuildConfig[] = [
  {
    entry: 'src/index.ts',
    output: 'dist/index.js',
    target: 'es2020',
    format: 'cjs'
  },
  {
    entry: 'src/index.ts',
    output: 'dist/index.esm.js',
    target: 'es2020',
    format: 'esm'
  }
];

const build = async () => {
  console.log('Starting build process...');
  
  // Clean dist directory
  if (existsSync('dist')) {
    execSync('rm -rf dist', { stdio: 'inherit' });
  }
  
  // Create dist directory
  execSync('mkdir -p dist', { stdio: 'inherit' });
  
  // Build each configuration
  for (const config of buildConfigs) {
    console.log(`Building ${config.format}...`);
    
    const tscCommand = [
      'tsc',
      `--outDir ${config.output}`,
      `--target ${config.target}`,
      `--module ${config.format === 'esm' ? 'esnext' : 'commonjs'}`,
      '--declaration',
      '--sourceMap'
    ].join(' ');
    
    execSync(tscCommand, { stdio: 'inherit' });
  }
  
  // Copy type definitions
  execSync('cp -r dist/types/* dist/', { stdio: 'inherit' });
  
  // Generate build info
  const packageJson = JSON.parse(readFileSync('package.json', 'utf8'));
  const buildInfo = {
    version: packageJson.version,
    buildTime: new Date().toISOString(),
    buildId: Math.random().toString(36).substr(2, 9),
    configs: buildConfigs
  };
  
  writeFileSync(
    resolve('dist', 'build-info.json'),
    JSON.stringify(buildInfo, null, 2)
  );
  
  console.log('Build completed successfully!');
};

build().catch(console.error);
```


---

## ✅ **Best Practices**

### **1. Choose the Right Build Tool**


```typescript
// ✅ Good: Choose based on project needs
const buildToolSelection = {
  webpack: "Large apps, complex requirements",
  vite: "Modern apps, fast development",
  rollup: "Libraries, tree shaking",
  parcel: "Quick prototyping, zero config"
};

// ❌ Avoid: Using wrong tool for the job
const wrongChoice = {
  rollup: "Large applications with complex requirements",
  webpack: "Simple libraries with minimal dependencies"
};
```


### **2. Optimize Build Performance**


```javascript
// ✅ Good: Optimize build performance
module.exports = {
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: {
          loader: 'ts-loader',
          options: {
            transpileOnly: true, // Skip type checking during build
            experimentalWatchApi: true, // Use watch API for faster rebuilds
          },
        },
      },
    ],
  },
  optimization: {
    splitChunks: {
      chunks: 'all', // Enable code splitting
    },
  },
};

// ❌ Avoid: Slow build configurations
module.exports = {
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader', // No optimization options
      },
    ],
  },
};
```


### **3. Use Source Maps for Debugging**


```javascript
// ✅ Good: Enable source maps
module.exports = {
  devtool: 'source-map', // Generate source maps
  output: {
    sourceMapFilename: '[name].js.map',
  },
};

// ❌ Avoid: Disabling source maps
module.exports = {
  devtool: false, // No source maps
};
```


### **4. Configure Path Mapping**


```typescript
// ✅ Good: Configure path mapping
export default defineConfig({
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
      '@/components': resolve(__dirname, 'src/components'),
    },
  },
});

// ❌ Avoid: Relative imports
import { Button } from '../../../components/Button';
```


---

## ❓ **Common Interview Questions**

### **1. What are the main differences between Webpack and Vite?**

**Answer:**
- **Webpack**: Mature ecosystem, complex configuration, slower development builds
- **Vite**: Fast development, simple configuration, ES modules, newer tool

### **2. How do you optimize TypeScript builds?**

**Answer:**
- Use `transpileOnly: true` for faster builds
- Enable incremental compilation
- Use code splitting
- Optimize bundle size with tree shaking

### **3. What's the difference between Rollup and Webpack?**

**Answer:**
- **Rollup**: Better for libraries, excellent tree shaking, smaller bundles
- **Webpack**: Better for applications, extensive ecosystem, code splitting

### **4. How do you configure path mapping in build tools?**

**Answer:**

```typescript
// Vite
export default defineConfig({
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
});

// Webpack
module.exports = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
    },
  },
};
```


### **5. What are the benefits of using build tools with TypeScript?**

**Answer:**
- **Compilation**: Convert TypeScript to JavaScript
- **Bundling**: Combine multiple files into optimized bundles
- **Optimization**: Minification, tree shaking, code splitting
- **Development**: Hot reloading, source maps, dev server

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Compiler-Options-Strict-Mode.md" class="nav-button">← Previous: Compiler Options & Strict Mode</a>
  <a href="04-IDE-Integration-Debugging.md" class="nav-button">Next: IDE Integration & Debugging →</a>
</div>

*Last updated: December 2025*
