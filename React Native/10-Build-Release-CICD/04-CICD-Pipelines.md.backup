# 🔄 **CI/CD Pipelines**

> **Master continuous integration and deployment pipelines for React Native applications using GitHub Actions, GitLab CI, and other platforms**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [CI/CD Overview](#-cicd-overview)
- [GitHub Actions](#-github-actions)
- [GitLab CI](#-gitlab-ci)
- [Jenkins](#-jenkins)
- [EAS Build](#-eas-build)
- [Pipeline Optimization](#-pipeline-optimization)
- [Best Practices](#-best-practices)
- [Interview Questions](#-interview-questions)

---

## 🏗️ **CI/CD Overview**

### **CI/CD Pipeline Flow**


{% raw %}
```mermaid
graph TD
    A[Code Push] --> B[Trigger Pipeline]
    B --> C[Install Dependencies]
    C --> D[Run Tests]
    D --> E[Lint & Format]
    E --> F[Build Android]
    F --> G[Build iOS]
    G --> H[Deploy to Staging]
    H --> I[Run E2E Tests]
    I --> J[Deploy to Production]
    J --> K[Notify Team]
```
{% endraw %}


### **Key Benefits**
- **Automated Testing**: Catch bugs early
- **Consistent Builds**: Reproducible environments
- **Faster Releases**: Automated deployment
- **Quality Assurance**: Multiple validation steps

---

## 🐙 **GitHub Actions**

### **Basic Workflow**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Run linting
      run: npm run lint
      
    - name: Run tests
      run: npm test
      
    - name: Run type checking
      run: npm run type-check
```
{% endraw %}


### **Android Build Workflow**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .github/workflows/android.yml
name: Android Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-android:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Setup Java
      uses: actions/setup-java@v3
      with:
        distribution: 'temurin'
        java-version: '11'
        
    - name: Setup Android SDK
      uses: android-actions/setup-android@v2
      
    - name: Install dependencies
      run: npm ci
      
    - name: Cache Gradle dependencies
      uses: actions/cache@v3
      with:
        path: |
          ~/.gradle/caches
          ~/.gradle/wrapper
        key: ${{#123;{{#123; runner.os }}#125;}}#125;-gradle-${{#123;{{#123; hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}#125;}}#125;
        restore-keys: |
          ${{#123;{{#123; runner.os }}#125;}}#125;-gradle-
          
    - name: Build Android APK
      run: |
        cd android
        ./gradlew assembleRelease
        
    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: android-apk
        path: android/app/build/outputs/apk/release/app-release.apk
```
{% endraw %}


### **iOS Build Workflow**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .github/workflows/ios.yml
name: iOS Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-ios:
    runs-on: macos-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Install CocoaPods
      run: |
        cd ios
        pod install
        
    - name: Build iOS
      run: |
        cd ios
        xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -configuration Release -destination 'generic/platform=iOS' build
        
    - name: Archive iOS
      run: |
        cd ios
        xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -configuration Release -destination 'generic/platform=iOS' archive -archivePath build/YourApp.xcarchive
        
    - name: Export IPA
      run: |
        cd ios
        xcodebuild -exportArchive -archivePath build/YourApp.xcarchive -exportPath build -exportOptionsPlist ExportOptions.plist
        
    - name: Upload IPA
      uses: actions/upload-artifact@v3
      with:
        name: ios-ipa
        path: ios/build/YourApp.ipa
```
{% endraw %}


---

## 🦊 **GitLab CI**

### **GitLab CI Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .gitlab-ci.yml
stages:
  - test
  - build
  - deploy

variables:
  NODE_VERSION: "18"
  ANDROID_COMPILE_SDK: "33"
  ANDROID_BUILD_TOOLS: "33.0.0"
  ANDROID_SDK_TOOLS: "33.0.0"

# Test stage
test:
  stage: test
  image: node:18
  script:
    - npm ci
    - npm run lint
    - npm test
    - npm run type-check
  artifacts:
    reports:
      junit: test-results.xml
    paths:
      - coverage/
    expire_in: 1 week

# Android build
build-android:
  stage: build
  image: jangrewe/gitlab-ci-android
  script:
    - npm ci
    - cd android
    - ./gradlew assembleRelease
  artifacts:
    paths:
      - android/app/build/outputs/apk/release/app-release.apk
    expire_in: 1 week
  only:
    - main
    - develop

# iOS build
build-ios:
  stage: build
  image: reactnativecommunity/react-native-android
  script:
    - npm ci
    - cd ios
    - pod install
    - xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -configuration Release -destination 'generic/platform=iOS' build
  artifacts:
    paths:
      - ios/build/
    expire_in: 1 week
  only:
    - main
    - develop

# Deploy to staging
deploy-staging:
  stage: deploy
  image: alpine:latest
  script:
    - echo "Deploying to staging environment"
    - # Add your deployment script here
  environment:
    name: staging
    url: https://staging.yourapp.com
  only:
    - develop

# Deploy to production
deploy-production:
  stage: deploy
  image: alpine:latest
  script:
    - echo "Deploying to production environment"
    - # Add your deployment script here
  environment:
    name: production
    url: https://yourapp.com
  only:
    - main
  when: manual
```
{% endraw %}


---

## 🏗️ **Jenkins**

### **Jenkinsfile**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```groovy
// Jenkinsfile
pipeline {
    agent any
    
    environment {
        NODE_VERSION = '18'
        ANDROID_HOME = '/opt/android-sdk'
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
            }
        }
        
        stage('Lint & Test') {
            parallel {
                stage('Lint') {
                    steps {
                        sh 'npm run lint'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'npm test'
                    }
                }
                stage('Type Check') {
                    steps {
                        sh 'npm run type-check'
                    }
                }
            }
        }
        
        stage('Build Android') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                sh '''
                    cd android
                    ./gradlew assembleRelease
                '''
            }
            post {
                success {
                    archiveArtifacts artifacts: 'android/app/build/outputs/apk/release/app-release.apk', fingerprint: true
                }
            }
        }
        
        stage('Build iOS') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                sh '''
                    cd ios
                    pod install
                    xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -configuration Release -destination 'generic/platform=iOS' build
                '''
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Deploying to staging environment'
                // Add deployment script here
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                echo 'Deploying to production environment'
                // Add deployment script here
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            emailext (
                subject: "Build Success: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build successful!",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
        failure {
            emailext (
                subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build failed!",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}
```
{% endraw %}


---

## ⚡ **EAS Build**

### **EAS Configuration**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```json
// eas.json
{
  "cli": {
    "version": ">= 3.0.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal"
    },
    "preview": {
      "distribution": "internal",
      "android": {
        "buildType": "apk"
      }
    },
    "production": {
      "android": {
        "buildType": "aab"
      }
    }
  },
  "submit": {
    "production": {
      "android": {
        "serviceAccountKeyPath": "./google-service-account.json",
        "track": "internal"
      },
      "ios": {
        "appleId": "your-apple-id@example.com",
        "ascAppId": "1234567890",
        "appleTeamId": "ABCD123456"
      }
    }
  }
}
```
{% endraw %}


### **EAS Build Workflow**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .github/workflows/eas-build.yml
name: EAS Build

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Setup EAS
      uses: expo/expo-github-action@v8
      with:
        eas-version: latest
        token: ${{#123;{{#123; secrets.EXPO_TOKEN }}#125;}}#125;
        
    - name: Build with EAS
      run: |
        if [ "${{#123;{{#123; github.ref }}#125;}}#125;" = "refs/heads/main" ]; then
          eas build --platform all --profile production
        else
          eas build --platform all --profile preview
        fi
```
{% endraw %}


---

## 🚀 **Pipeline Optimization**

### **Caching Strategy**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .github/workflows/optimized.yml
name: Optimized CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Cache Metro
      uses: actions/cache@v3
      with:
        path: |
          .metro-cache
          node_modules/.cache
        key: ${{#123;{{#123; runner.os }}#125;}}#125;-metro-${{#123;{{#123; hashFiles('**/package-lock.json') }}#125;}}#125;
        restore-keys: |
          ${{#123;{{#123; runner.os }}#125;}}#125;-metro-
          
    - name: Cache Gradle
      uses: actions/cache@v3
      with:
        path: |
          ~/.gradle/caches
          ~/.gradle/wrapper
        key: ${{#123;{{#123; runner.os }}#125;}}#125;-gradle-${{#123;{{#123; hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}#125;}}#125;
        restore-keys: |
          ${{#123;{{#123; runner.os }}#125;}}#125;-gradle-
          
    - name: Install dependencies
      run: npm ci
      
    - name: Run tests
      run: npm test
```
{% endraw %}


### **Parallel Builds**

<button onclick="copyCode(this)" class="copy-btn">📋 Copy</button>

{% raw %}
```yaml
# .github/workflows/parallel.yml
name: Parallel Builds

on:
  push:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    - name: Install dependencies
      run: npm ci
    - name: Run tests
      run: npm test

  build-android:
    runs-on: ubuntu-latest
    needs: test
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    - name: Install dependencies
      run: npm ci
    - name: Build Android
      run: |
        cd android
        ./gradlew assembleRelease

  build-ios:
    runs-on: macos-latest
    needs: test
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    - name: Install dependencies
      run: npm ci
    - name: Build iOS
      run: |
        cd ios
        pod install
        xcodebuild -workspace YourApp.xcworkspace -scheme YourApp -configuration Release -destination 'generic/platform=iOS' build

  deploy:
    runs-on: ubuntu-latest
    needs: [build-android, build-ios]
    steps:
    - name: Deploy
      run: echo "Deploying to production"
```
{% endraw %}


---

## 🎯 **Best Practices**

### **1. Pipeline Design**
- Use parallel jobs when possible
- Implement proper caching
- Use matrix builds for multiple platforms
- Set up proper notifications

### **2. Security**
- Use secrets for sensitive data
- Implement proper access controls
- Scan for vulnerabilities
- Use signed builds

### **3. Monitoring**
- Track build times
- Monitor success rates
- Set up alerts for failures
- Use build analytics

---

## ❓ **Interview Questions**

### **Basic Questions**
1. **What is CI/CD and why is it important?**
2. **How do you set up a basic CI/CD pipeline?**
3. **What are the benefits of automated testing?**

### **Advanced Questions**
1. **How would you optimize a CI/CD pipeline for performance?**
2. **Explain the difference between CI and CD.**
3. **How do you handle secrets in CI/CD pipelines?**

### **Practical Questions**
1. **Set up a GitHub Actions workflow for React Native.**
2. **Configure automated deployment to staging and production.**
3. **Implement caching and optimization strategies.**

---

## 🧭 Navigation

<div class="navigation">
    <a href="./03-iOS-Build-Process.md" class="nav-link prev">⬅️ Previous: iOS Build Process</a>
    <a href="../11-Security-Privacy/01-Secure-Storage.md" class="nav-link next">Next: Secure Storage ➡️</a>
</div>

---

<script src="../../common-scripts.js"></script>

*Last updated: December 2024*
