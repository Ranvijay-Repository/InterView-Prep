# 🔹 JavaScript Security

> **Comprehensive coverage of JavaScript security practices: Content Security Policy (CSP), Subresource Integrity (SRI), and Trusted Types API**

<link rel="stylesheet" href="../common-styles.css">

---

## 📚 Table of Contents

- [JavaScript Security Overview](#javascript-security-overview)
- [Content Security Policy (CSP)](#content-security-policy-csp)
- [Subresource Integrity (SRI)](#subresource-integrity-sri)
- [Trusted Types API](#trusted-types-api)
- [Detailed Examples](#detailed-examples)
- [Common Interview Questions](#common-interview-questions)
- [Practice Exercises](#practice-exercises)
- [Additional Resources](#additional-resources)

---

## 🎯 JavaScript Security Overview

**JavaScript Security** involves protecting web applications from various security vulnerabilities and attacks through proper coding practices, security headers, and modern security APIs.

### Why JavaScript Security Matters:
- **User Protection**: Prevent data theft and privacy violations
- **Application Integrity**: Maintain secure application behavior
- **Compliance**: Meet security standards and regulations
- **Trust**: Build user confidence in application security
- **Business Continuity**: Prevent security incidents and downtime

---

## 🛡️ Content Security Policy (CSP)

**Content Security Policy (CSP)** is a security standard that helps prevent cross-site scripting (XSS) attacks by controlling which resources can be loaded and executed.

### Why CSP Matters:
- **XSS Prevention**: Block malicious script execution
- **Resource Control**: Limit resource loading to trusted sources
- **Attack Mitigation**: Reduce impact of security vulnerabilities
- **Compliance**: Meet security standards and requirements
- **Monitoring**: Detect and report policy violations

### ASCII Diagram: CSP Enforcement Flow
```
CSP ENFORCEMENT FLOW
┌─────────────────────────────────┐
│        WEB PAGE REQUEST         │
│  ┌─────────────────────────────┐ │
│  │ GET /page.html              │ │
│  │ Host: example.com           │ │
│  │ User-Agent: Browser         │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  SERVER       │
        │  RESPONSE     │
        │               │
        │  HTTP/1.1 200 │
        │  CSP: default-src 'self'│
        │  Content-Type: text/html│
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  BROWSER      │
        │  CSP PARSING  │
        │               │
        │  Parse CSP    │
        │  Directives   │
        │  Build Policy │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  RESOURCE     │
        │  LOADING      │
        │               │
        │  Scripts      │
        │  Styles       │
        │  Images       │
        │  Fonts        │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  POLICY       │
        │  ENFORCEMENT  │
        │               │
        │  Allow/Deny   │
        │  Resources    │
        │  Based on     │
        │  CSP Rules    │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  VIOLATION    │
        │  REPORTING    │
        │               │
        │  Log          │
        │  Violations   │
        │  Send Reports │
        │  To Server    │
        └───────────────┘
```

### CSP Directives:
- **default-src**: Default source for all resource types
- **script-src**: Control JavaScript execution sources
- **style-src**: Control CSS loading sources
- **img-src**: Control image loading sources
- **connect-src**: Control AJAX and WebSocket connections

---

## 🔒 Subresource Integrity (SRI)

**Subresource Integrity (SRI)** allows browsers to verify that resources (scripts, stylesheets) haven't been tampered with by checking their cryptographic hash.

### Why SRI Matters:
- **Integrity Verification**: Ensure resources haven't been modified
- **CDN Security**: Trust external content delivery networks
- **Attack Prevention**: Block malicious resource modifications
- **Compliance**: Meet security requirements for external resources
- **Trust**: Verify resource authenticity and integrity

### ASCII Diagram: SRI Verification Process
```
SRI VERIFICATION PROCESS
┌─────────────────────────────────┐
│        HTML DOCUMENT            │
│  ┌─────────────────────────────┐ │
│  │ <script src="https://cdn.js │
│  │   integrity="sha384-..."    │
│  │   crossorigin="anonymous">  │
│  │ </script>                    │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  BROWSER      │
        │  RESOURCE     │
        │  REQUEST      │
        │               │
        │  GET /script.js│
        │  Host: cdn.js │
        │  Origin: example.com│
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  CDN          │
        │  RESPONSE     │
        │               │
        │  HTTP/1.1 200 │
        │  Content-Type: application/js│
        │  Body: [JavaScript Code]     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  BROWSER      │
        │  HASH         │
        │  CALCULATION  │
        │               │
        │  Calculate    │
        │  SHA-384      │
        │  Hash of      │
        │  Response     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  INTEGRITY    │
        │  VERIFICATION │
        │               │
        │  Compare      │
        │  Calculated   │
        │  Hash with    │
        │  Expected     │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  RESULT       │
        │               │
        │  Hash Match:  │
        │  Execute      │
        │  Hash Mismatch:│
        │  Block        │
        └───────────────┘
```

### SRI Implementation:
- **Hash Generation**: Create cryptographic hashes for resources
- **HTML Integration**: Add integrity attributes to resource tags
- **Cross-Origin**: Handle CORS for external resources
- **Fallback Handling**: Manage SRI failures gracefully
- **Monitoring**: Track SRI verification success/failure rates

---

## 🎭 Trusted Types API

**Trusted Types API** provides a way to prevent DOM-based XSS attacks by creating a secure API for DOM manipulation that enforces content sanitization.

### Why Trusted Types API Matters:
- **XSS Prevention**: Block unsafe DOM manipulation
- **Content Sanitization**: Ensure safe content insertion
- **Policy Enforcement**: Enforce security policies at runtime
- **Modern Security**: Use latest web security standards
- **Developer Safety**: Prevent accidental security vulnerabilities

### ASCII Diagram: Trusted Types Flow
```
TRUSTED TYPES FLOW
┌─────────────────────────────────┐
│        TRUSTED TYPES            │
│        POLICY                   │
│  ┌─────────────────────────────┐ │
│  │ TrustedTypePolicy           │
│  │ - createHTML()              │
│  │ - createScript()            │
│  │ - createScriptURL()         │
│  │ - createURL()               │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │  UNSAFE       │
        │  CONTENT      │
        │               │
        │  User Input   │
        │  API Response │
        │  External     │
        │  Data         │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  SANITIZATION │
        │  PROCESS      │
        │               │
        │  HTML         │
        │  Sanitization │
        │  Script       │
        │  Filtering    │
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  TRUSTED      │
        │  TYPE         │
        │               │
        │  TrustedHTML  │
        │  TrustedScript│
        │  TrustedURL   │
        │  TrustedScriptURL│
        └───────────────┘
                │
                ▼
        ┌───────────────┐
        │  DOM          │
        │  INSERTION    │
        │               │
        │  Safe         │
        │  Content      │
        │  Insertion    │
        │  No XSS       │
        └───────────────┘
```

### Trusted Types Features:
- **Policy Creation**: Define security policies for content
- **Content Sanitization**: Clean and validate input content
- **Type Safety**: Ensure only trusted content reaches DOM
- **Policy Enforcement**: Block unsafe DOM operations
- **Monitoring**: Track policy violations and security events

---

## 📋 Copy Code Functionality

<script src="../common-scripts.js"></script>

---

## 🧭 Navigation

<div class="navigation">
    <a href="../06-Testing-Quality-Assurance/02-Code-Quality.md" class="nav-link prev">← Previous: Code Quality</a>
    <a href="02-Code-Security.md" class="nav-link next">Next: Code Security →</a>
</div>

*Last updated: December 2024*
