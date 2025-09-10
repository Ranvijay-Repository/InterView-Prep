# 🤖 **Android Build Process**

> **Master Android build configuration, Gradle optimization, and release processes for React Native applications**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Android Build Overview](#-android-build-overview)
- [Gradle Configuration](#-gradle-configuration)
- [Build Variants](#-build-variants)
- [Proguard & R8](#-proguard--r8)
- [APK & AAB Optimization](#-apk--aab-optimization)
- [Release Process](#-release-process)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 🏗️ **Android Build Overview**

### **Build Process Flow**


{% raw %}
```mermaid
graph TD
    A[Source Code] --> B[Metro Bundler]
    B --> C[JavaScript Bundle]
    C --> D[Gradle Build]
    D --> E[Resource Processing]
    E --> F[Code Compilation]
    F --> G[Proguard/R8]
    G --> H[APK/AAB Generation]
    H --> I[Signing]
    I --> J[Release]
```
{% endraw %}


### **Key Components**
- **Gradle**: Build automation tool
- **Proguard/R8**: Code obfuscation and optimization
- **Android SDK**: Platform tools and libraries
- **React Native CLI**: Build orchestration

---

## ⚙️ **Gradle Configuration**

### **Project Level Gradle**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```gradle
// android/build.gradle
buildscript {
    ext {
        buildToolsVersion = "33.0.0"
        minSdkVersion = 21
        compileSdkVersion = 33
        targetSdkVersion = 33
        ndkVersion = "23.1.7779620"
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.3.1")
        classpath("com.facebook.react:react-native-gradle-plugin")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url "https://www.jitpack.io" }
    }
}
```
{% endraw %}


### **App Level Gradle**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```gradle
// android/app/build.gradle
apply plugin: "com.android.application"
apply plugin: "com.facebook.react"

android {
    compileSdkVersion rootProject.ext.compileSdkVersion

    defaultConfig {
        applicationId "com.yourapp"
        minSdkVersion rootProject.ext.minSdkVersion
        targetSdkVersion rootProject.ext.targetSdkVersion
        versionCode 1
        versionName "1.0"
        
        // Enable multidex for large apps
        multiDexEnabled true
        
        // Vector drawable support
        vectorDrawables.useSupportLibrary = true
    }

    signingConfigs {
        debug {
            storeFile file('debug.keystore')
            storePassword 'android'
            keyAlias 'androiddebugkey'
            keyPassword 'android'
        }
        release {
            if (project.hasProperty('MYAPP_UPLOAD_STORE_FILE')) {
                storeFile file(MYAPP_UPLOAD_STORE_FILE)
                storePassword MYAPP_UPLOAD_STORE_PASSWORD
                keyAlias MYAPP_UPLOAD_KEY_ALIAS
                keyPassword MYAPP_UPLOAD_KEY_PASSWORD
            }
        }
    }

    buildTypes {
        debug {
            signingConfig signingConfigs.debug
            debuggable true
            minifyEnabled false
        }
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
            shrinkResources true
        }
    }
}
```
{% endraw %}


---

## 🎯 **Build Variants**

### **Flavor Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```gradle
// android/app/build.gradle
android {
    flavorDimensions "version"
    
    productFlavors {
        development {
            dimension "version"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
            resValue "string", "app_name", "MyApp Dev"
        }
        
        staging {
            dimension "version"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
            resValue "string", "app_name", "MyApp Staging"
        }
        
        production {
            dimension "version"
            resValue "string", "app_name", "MyApp"
        }
    }
}
```
{% endraw %}


### **Build Variant Scripts**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// scripts/build-android.js
const { execSync } = require('child_process');
const path = require('path');

const buildAndroid = (variant = 'debug', flavor = 'development') => {
  const startTime = Date.now();
  
  try {
    console.log(`Building Android ${flavor} ${variant}...`);
    
    // Clean previous build
    execSync('cd android && ./gradlew clean', { stdio: 'inherit' });
    
    // Build the app
    const buildCommand = `cd android && ./gradlew assemble${flavor.charAt(0).toUpperCase() + flavor.slice(1)}${variant.charAt(0).toUpperCase() + variant.slice(1)}`;
    execSync(buildCommand, { stdio: 'inherit' });
    
    const buildTime = Date.now() - startTime;
    console.log(`Build completed in ${buildTime}ms`);
    
    // Get APK path
    const apkPath = `android/app/build/outputs/apk/${flavor}/${variant}/app-${flavor}-${variant}.apk`;
    console.log(`APK generated at: ${apkPath}`);
    
  } catch (error) {
    console.error('Build failed:', error);
    process.exit(1);
  }
};

// Usage
const variant = process.argv[2] || 'debug';
const flavor = process.argv[3] || 'development';
buildAndroid(variant, flavor);
```
{% endraw %}


---

## 🔒 **Proguard & R8**

### **Proguard Rules**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```proguard
# android/app/proguard-rules.pro

# React Native
-keep class com.facebook.react.** { *; }
-keep class com.facebook.hermes.** { *; }
-keep class com.facebook.jni.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep React Native bridge
-keep class com.facebook.react.bridge.** { *; }
-keep class com.facebook.react.uimanager.** { *; }

# Keep your custom native modules
-keep class com.yourapp.** { *; }

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep Parcelable
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
```
{% endraw %}


### **R8 Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```gradle
// android/app/build.gradle
android {
    buildTypes {
        release {
            minifyEnabled true
            useProguard false // Use R8 instead of Proguard
            proguardFiles getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
            
            // R8 specific configuration
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            
            // Enable resource shrinking
            shrinkResources true
            
            // Enable code shrinking
            minifyEnabled true
        }
    }
}
```
{% endraw %}


---

## 📦 **APK & AAB Optimization**

### **APK Splitting**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```gradle
// android/app/build.gradle
android {
    splits {
        abi {
            enable true
            reset()
            include "armeabi-v7a", "x86", "arm64-v8a", "x86_64"
            universalApk true
        }
        
        density {
            enable true
            reset()
            include "ldpi", "mdpi", "hdpi", "xhdpi", "xxhdpi", "xxxhdpi"
        }
    }
}
```
{% endraw %}


### **AAB Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```gradle
// android/app/build.gradle
android {
    bundle {
        language {
            enableSplit = true
        }
        density {
            enableSplit = true
        }
        abi {
            enableSplit = true
        }
    }
    
    buildTypes {
        release {
            // Generate AAB instead of APK
            bundle {
                language {
                    enableSplit = true
                }
                density {
                    enableSplit = true
                }
                abi {
                    enableSplit = true
                }
            }
        }
    }
}
```
{% endraw %}


---

## 🚀 **Release Process**

### **Automated Release Script**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// scripts/release-android.js
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const releaseAndroid = async () => {
  try {
    console.log('Starting Android release process...');
    
    // 1. Clean and build
    console.log('Cleaning and building...');
    execSync('cd android && ./gradlew clean', { stdio: 'inherit' });
    execSync('cd android && ./gradlew bundleRelease', { stdio: 'inherit' });
    
    // 2. Generate APK for testing
    console.log('Generating APK for testing...');
    execSync('cd android && ./gradlew assembleRelease', { stdio: 'inherit' });
    
    // 3. Get version info
    const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    const version = packageJson.version;
    
    // 4. Copy files to release directory
    const releaseDir = `releases/android/v${version}`;
    fs.mkdirSync(releaseDir, { recursive: true });
    
    // Copy AAB
    const aabSource = 'android/app/build/outputs/bundle/release/app-release.aab';
    const aabDest = `${releaseDir}/app-release.aab`;
    fs.copyFileSync(aabSource, aabDest);
    
    // Copy APK
    const apkSource = 'android/app/build/outputs/apk/release/app-release.apk';
    const apkDest = `${releaseDir}/app-release.apk`;
    fs.copyFileSync(apkSource, apkDest);
    
    // 5. Generate release notes
    const releaseNotes = {
      version: version,
      timestamp: new Date().toISOString(),
      files: {
        aab: aabDest,
        apk: apkDest,
      },
      buildInfo: {
        buildToolsVersion: '33.0.0',
        compileSdkVersion: 33,
        targetSdkVersion: 33,
      },
    };
    
    fs.writeFileSync(`${releaseDir}/release-info.json`, JSON.stringify(releaseNotes, null, 2));
    
    console.log(`Release completed! Files available in ${releaseDir}`);
    
  } catch (error) {
    console.error('Release failed:', error);
    process.exit(1);
  }
};

// Run release
releaseAndroid();
```
{% endraw %}


### **Play Store Upload**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```javascript
// scripts/upload-playstore.js
const { execSync } = require('child_process');
const fs = require('fs');

const uploadToPlayStore = async () => {
  try {
    console.log('Uploading to Play Store...');
    
    // Check if fastlane is installed
    try {
      execSync('fastlane --version', { stdio: 'pipe' });
    } catch (error) {
      console.error('Fastlane not installed. Please install it first.');
      process.exit(1);
    }
    
    // Upload using fastlane
    execSync('cd android && fastlane supply --aab app-release.aab --track internal', { 
      stdio: 'inherit' 
    });
    
    console.log('Upload completed successfully!');
    
  } catch (error) {
    console.error('Upload failed:', error);
    process.exit(1);
  }
};

// Run upload
uploadToPlayStore();
```
{% endraw %}


---

## 🎯 **Best Practices**

### **1. Build Optimization**
- Use R8 instead of Proguard
- Enable resource shrinking
- Configure APK splitting
- Use AAB for Play Store

### **2. Security**
- Sign APKs properly
- Use different keys for debug/release
- Store keys securely
- Enable code obfuscation

### **3. Performance**
- Monitor build times
- Use Gradle daemon
- Configure parallel builds
- Cache dependencies

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What is the difference between APK and AAB?**
2. **How do you configure different build variants in Android?**
3. **What is Proguard and R8 used for?**

### **Advanced Questions**
1. **How would you optimize Android build performance?**
2. **Explain the Android build process for React Native apps.**
3. **How do you handle different environments in Android builds?**

### **Practical Questions**
1. **Configure build variants for development, staging, and production.**
2. **Set up automated release process for Android.**
3. **Optimize APK size using Proguard/R8 rules.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./01-Metro-Config-Bundling.md" class="nav-link prev">⬅️ Previous: Metro Config & Bundling</a>
    <a href="./03-iOS-Build-Process.md" class="nav-link next">Next: iOS Build Process ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
