# ⚠️ **Error Handling Strategies**

> **Complete guide to TypeScript error handling, exception management, and robust error recovery patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Error Handling Overview](#error-handling-overview)
- [Error Types and Classification](#error-types-and-classification)
- [Error Handling Patterns](#error-handling-patterns)
- [Error Recovery Strategies](#error-recovery-strategies)
- [Error Monitoring and Logging](#error-monitoring-and-logging)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Error Handling Overview**

Effective error handling is crucial for building robust, maintainable TypeScript applications.

### **Error Handling Principles**

```typescript
// Error handling principles
const errorHandlingPrinciples = {
  failFast: "Fail fast and fail clearly",
  gracefulDegradation: "Provide graceful degradation",
  userFriendly: "Show user-friendly error messages",
  logging: "Log errors for debugging",
  recovery: "Implement error recovery mechanisms",
  prevention: "Prevent errors when possible"
};

// Error handling benefits
const errorHandlingBenefits = {
  reliability: "Improved application reliability",
  userExperience: "Better user experience",
  debugging: "Easier debugging and troubleshooting",
  monitoring: "Better error monitoring and alerting",
  maintenance: "Easier maintenance and updates",
  security: "Improved security through proper error handling"
};

// Error handling challenges
const errorHandlingChallenges = {
  complexity: "Managing error handling complexity",
  consistency: "Maintaining consistent error handling",
  performance: "Error handling performance impact",
  testing: "Testing error scenarios",
  documentation: "Documenting error handling strategies",
  recovery: "Implementing effective recovery mechanisms"
};
```

### **Error Handling Goals**

```typescript
// Error handling goals
const errorHandlingGoals = {
  preventCrashes: "Prevent application crashes",
  provideFeedback: "Provide meaningful feedback to users",
  enableRecovery: "Enable error recovery when possible",
  facilitateDebugging: "Facilitate debugging and troubleshooting",
  maintainSecurity: "Maintain security through proper error handling",
  improveReliability: "Improve overall application reliability"
};

// Error handling metrics
const errorHandlingMetrics = {
  errorRate: "Percentage of operations that result in errors",
  recoveryRate: "Percentage of errors that are recovered from",
  meanTimeToRecovery: "Average time to recover from errors",
  userImpact: "Impact of errors on user experience",
  systemStability: "Overall system stability metrics"
};
```

---

## 🏷️ **Error Types and Classification**

### **Error Categories**

```typescript
// Error categories
const errorCategories = {
  validation: "Input validation errors",
  business: "Business logic errors",
  system: "System-level errors",
  network: "Network and communication errors",
  security: "Security-related errors",
  performance: "Performance-related errors"
};

// Error severity levels
const errorSeverity = {
  critical: "Critical errors that cause system failure",
  high: "High-priority errors that affect functionality",
  medium: "Medium-priority errors that affect user experience",
  low: "Low-priority errors that are minor issues",
  info: "Informational messages and warnings"
};

// Error classification
interface ErrorClassification {
  category: keyof typeof errorCategories;
  severity: keyof typeof errorSeverity;
  recoverable: boolean;
  userFacing: boolean;
  loggable: boolean;
}
```

### **Custom Error Classes**

```typescript
// Custom error classes
abstract class BaseError extends Error {
  abstract readonly code: string;
  abstract readonly statusCode: number;
  abstract readonly isOperational: boolean;
  
  constructor(
    message: string,
    public readonly context?: Record<string, any>
  ) {
    super(message);
    this.name = this.constructor.name;
    Error.captureStackTrace(this, this.constructor);
  }
}

// Validation errors
class ValidationError extends BaseError {
  readonly code = 'VALIDATION_ERROR';
  readonly statusCode = 400;
  readonly isOperational = true;
  
  constructor(
    message: string,
    public readonly field?: string,
    context?: Record<string, any>
  ) {
    super(message, context);
  }
}

// Business logic errors
class BusinessError extends BaseError {
  readonly code = 'BUSINESS_ERROR';
  readonly statusCode = 422;
  readonly isOperational = true;
  
  constructor(message: string, context?: Record<string, any>) {
    super(message, context);
  }
}

// System errors
class SystemError extends BaseError {
  readonly code = 'SYSTEM_ERROR';
  readonly statusCode = 500;
  readonly isOperational = false;
  
  constructor(message: string, context?: Record<string, any>) {
    super(message, context);
  }
}

// Network errors
class NetworkError extends BaseError {
  readonly code = 'NETWORK_ERROR';
  readonly statusCode = 503;
  readonly isOperational = true;
  
  constructor(
    message: string,
    public readonly originalError?: Error,
    context?: Record<string, any>
  ) {
    super(message, context);
  }
}

// Authentication errors
class AuthenticationError extends BaseError {
  readonly code = 'AUTHENTICATION_ERROR';
  readonly statusCode = 401;
  readonly isOperational = true;
  
  constructor(message: string = 'Authentication failed', context?: Record<string, any>) {
    super(message, context);
  }
}

// Authorization errors
class AuthorizationError extends BaseError {
  readonly code = 'AUTHORIZATION_ERROR';
  readonly statusCode = 403;
  readonly isOperational = true;
  
  constructor(message: string = 'Access denied', context?: Record<string, any>) {
    super(message, context);
  }
}

// Not found errors
class NotFoundError extends BaseError {
  readonly code = 'NOT_FOUND_ERROR';
  readonly statusCode = 404;
  readonly isOperational = true;
  
  constructor(resource: string, context?: Record<string, any>) {
    super(`${resource} not found`, context);
  }
}
```

### **Error Type Guards**

```typescript
// Error type guards
function isBaseError(error: unknown): error is BaseError {
  return error instanceof BaseError;
}

function isValidationError(error: unknown): error is ValidationError {
  return error instanceof ValidationError;
}

function isBusinessError(error: unknown): error is BusinessError {
  return error instanceof BusinessError;
}

function isSystemError(error: unknown): error is SystemError {
  return error instanceof SystemError;
}

function isNetworkError(error: unknown): error is NetworkError {
  return error instanceof NetworkError;
}

function isAuthenticationError(error: unknown): error is AuthenticationError {
  return error instanceof AuthenticationError;
}

function isAuthorizationError(error: unknown): error is AuthorizationError {
  return error instanceof AuthorizationError;
}

function isNotFoundError(error: unknown): error is NotFoundError {
  return error instanceof NotFoundError;
}

// Error classification utility
function classifyError(error: unknown): ErrorClassification {
  if (isValidationError(error)) {
    return {
      category: 'validation',
      severity: 'medium',
      recoverable: true,
      userFacing: true,
      loggable: true
    };
  }
  
  if (isBusinessError(error)) {
    return {
      category: 'business',
      severity: 'high',
      recoverable: false,
      userFacing: true,
      loggable: true
    };
  }
  
  if (isSystemError(error)) {
    return {
      category: 'system',
      severity: 'critical',
      recoverable: false,
      userFacing: false,
      loggable: true
    };
  }
  
  if (isNetworkError(error)) {
    return {
      category: 'network',
      severity: 'high',
      recoverable: true,
      userFacing: true,
      loggable: true
    };
  }
  
  // Default classification for unknown errors
  return {
    category: 'system',
    severity: 'critical',
    recoverable: false,
    userFacing: false,
    loggable: true
  };
}
```

---

## 🔄 **Error Handling Patterns**

### **Try-Catch Patterns**

```typescript
// Try-catch patterns
const tryCatchPatterns = {
  basic: "Basic try-catch for synchronous code",
  async: "Async-await with try-catch for asynchronous code",
  nested: "Nested try-catch for complex error handling",
  specific: "Specific error type handling",
  finally: "Using finally blocks for cleanup"
};

// Basic try-catch
function basicTryCatch() {
  try {
    // Potentially dangerous operation
    const result = JSON.parse(userInput);
    return result;
  } catch (error) {
    if (error instanceof SyntaxError) {
      throw new ValidationError('Invalid JSON format');
    }
    throw new SystemError('Unexpected error occurred', { originalError: error });
  }
}

// Async try-catch
async function asyncTryCatch() {
  try {
    const response = await fetch('/api/data');
    if (!response.ok) {
      throw new NetworkError(`HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    if (error instanceof NetworkError) {
      throw error;
    }
    throw new SystemError('Failed to fetch data', { originalError: error });
  }
}

// Nested try-catch
function nestedTryCatch() {
  try {
    try {
      const data = JSON.parse(userInput);
      return processData(data);
    } catch (parseError) {
      if (parseError instanceof SyntaxError) {
        throw new ValidationError('Invalid JSON format');
      }
      throw parseError;
    }
  } catch (error) {
    if (isValidationError(error)) {
      // Handle validation error
      console.error('Validation error:', error.message);
      throw error;
    }
    throw new SystemError('Unexpected error in data processing', { originalError: error });
  }
}

// Try-catch with finally
function tryCatchFinally() {
  let resource: any = null;
  
  try {
    resource = acquireResource();
    return useResource(resource);
  } catch (error) {
    throw new SystemError('Resource operation failed', { originalError: error });
  } finally {
    if (resource) {
      releaseResource(resource);
    }
  }
}
```

### **Result Pattern**

```typescript
// Result pattern for error handling
type Result<T, E = Error> = {
  success: true;
  data: T;
} | {
  success: false;
  error: E;
};

// Result utility functions
function success<T>(data: T): Result<T, never> {
  return { success: true, data };
}

function failure<E>(error: E): Result<never, E> {
  return { success: false, error };
}

function isSuccess<T, E>(result: Result<T, E>): result is { success: true; data: T } {
  return result.success;
}

function isFailure<T, E>(result: Result<T, E>): result is { success: false; error: E } {
  return !result.success;
}

// Result pattern usage
function parseUser(input: unknown): Result<User, ValidationError> {
  try {
    if (typeof input !== 'object' || input === null) {
      return failure(new ValidationError('Expected object'));
    }
    
    const obj = input as Record<string, unknown>;
    
    if (typeof obj.id !== 'number') {
      return failure(new ValidationError('id must be a number', 'id'));
    }
    
    if (typeof obj.name !== 'string') {
      return failure(new ValidationError('name must be a string', 'name'));
    }
    
    if (typeof obj.email !== 'string') {
      return failure(new ValidationError('email must be a string', 'email'));
    }
    
    const user = new User(obj.id, obj.name, obj.email);
    return success(user);
  } catch (error) {
    return failure(new ValidationError('Invalid user data', undefined, { originalError: error }));
  }
}

// Chaining results
function processUser(input: unknown): Result<ProcessedUser, ValidationError | BusinessError> {
  const parseResult = parseUser(input);
  if (isFailure(parseResult)) {
    return parseResult;
  }
  
  const user = parseResult.data;
  
  // Additional business logic validation
  if (user.email.includes('test')) {
    return failure(new BusinessError('Test emails are not allowed'));
  }
  
  const processedUser = new ProcessedUser(user);
  return success(processedUser);
}
```

### **Either Pattern**

```typescript
// Either pattern for error handling
type Either<L, R> = Left<L> | Right<R>;

interface Left<L> {
  readonly _tag: 'Left';
  readonly left: L;
}

interface Right<R> {
  readonly _tag: 'Right';
  readonly right: R;
}

// Either utility functions
function left<L>(value: L): Either<L, never> {
  return { _tag: 'Left', left: value };
}

function right<R>(value: R): Either<never, R> {
  return { _tag: 'Right', right: value };
}

function isLeft<L, R>(either: Either<L, R>): either is Left<L> {
  return either._tag === 'Left';
}

function isRight<L, R>(either: Either<L, R>): either is Right<R> {
  return either._tag === 'Right';
}

// Either pattern usage
function validateEmail(email: string): Either<ValidationError, string> {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return left(new ValidationError('Invalid email format', 'email'));
  }
  return right(email);
}

function validateAge(age: number): Either<ValidationError, number> {
  if (age < 0 || age > 150) {
    return left(new ValidationError('Age must be between 0 and 150', 'age'));
  }
  return right(age);
}

// Combining Either values
function validateUser(userData: { email: string; age: number }): Either<ValidationError, User> {
  const emailResult = validateEmail(userData.email);
  if (isLeft(emailResult)) {
    return emailResult;
  }
  
  const ageResult = validateAge(userData.age);
  if (isLeft(ageResult)) {
    return ageResult;
  }
  
  const user = new User(userData.email, ageResult.right);
  return right(user);
}
```

---

## 🔧 **Error Recovery Strategies**

### **Retry Mechanisms**

```typescript
// Retry mechanisms
const retryMechanisms = {
  simple: "Simple retry with fixed delay",
  exponential: "Exponential backoff retry",
  jitter: "Retry with jitter to avoid thundering herd",
  circuitBreaker: "Circuit breaker pattern",
  bulkhead: "Bulkhead pattern for isolation"
};

// Simple retry
async function retry<T>(
  operation: () => Promise<T>,
  maxRetries: number = 3,
  delay: number = 1000
): Promise<T> {
  let lastError: Error;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error as Error;
      
      if (attempt === maxRetries) {
        throw lastError;
      }
      
      console.warn(`Attempt ${attempt} failed, retrying in ${delay}ms:`, error);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
  
  throw lastError!;
}

// Exponential backoff retry
async function retryWithExponentialBackoff<T>(
  operation: () => Promise<T>,
  maxRetries: number = 3,
  baseDelay: number = 1000,
  maxDelay: number = 10000
): Promise<T> {
  let lastError: Error;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error as Error;
      
      if (attempt === maxRetries) {
        throw lastError;
      }
      
      const delay = Math.min(baseDelay * Math.pow(2, attempt - 1), maxDelay);
      console.warn(`Attempt ${attempt} failed, retrying in ${delay}ms:`, error);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
  
  throw lastError!;
}

// Retry with jitter
async function retryWithJitter<T>(
  operation: () => Promise<T>,
  maxRetries: number = 3,
  baseDelay: number = 1000
): Promise<T> {
  let lastError: Error;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error as Error;
      
      if (attempt === maxRetries) {
        throw lastError;
      }
      
      const jitter = Math.random() * 0.1 * baseDelay;
      const delay = baseDelay * Math.pow(2, attempt - 1) + jitter;
      console.warn(`Attempt ${attempt} failed, retrying in ${delay}ms:`, error);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
  
  throw lastError!;
}
```

### **Circuit Breaker Pattern**

```typescript
// Circuit breaker pattern
enum CircuitState {
  CLOSED = 'CLOSED',
  OPEN = 'OPEN',
  HALF_OPEN = 'HALF_OPEN'
}

class CircuitBreaker {
  private failureCount = 0;
  private lastFailureTime = 0;
  private state: CircuitState = CircuitState.CLOSED;
  
  constructor(
    private failureThreshold: number = 5,
    private timeout: number = 60000,
    private successThreshold: number = 3
  ) {}
  
  async execute<T>(operation: () => Promise<T>): Promise<T> {
    if (this.state === CircuitState.OPEN) {
      if (Date.now() - this.lastFailureTime > this.timeout) {
        this.state = CircuitState.HALF_OPEN;
      } else {
        throw new SystemError('Circuit breaker is OPEN');
      }
    }
    
    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }
  
  private onSuccess(): void {
    this.failureCount = 0;
    
    if (this.state === CircuitState.HALF_OPEN) {
      this.state = CircuitState.CLOSED;
    }
  }
  
  private onFailure(): void {
    this.failureCount++;
    this.lastFailureTime = Date.now();
    
    if (this.failureCount >= this.failureThreshold) {
      this.state = CircuitState.OPEN;
    }
  }
  
  getState(): CircuitState {
    return this.state;
  }
  
  getFailureCount(): number {
    return this.failureCount;
  }
}
```

### **Fallback Strategies**

```typescript
// Fallback strategies
const fallbackStrategies = {
  defaultValue: "Return default value on error",
  cachedValue: "Return cached value on error",
  alternativeService: "Use alternative service on error",
  degradedMode: "Operate in degraded mode",
  userNotification: "Notify user of error and suggest alternatives"
};

// Default value fallback
async function withDefaultValue<T>(
  operation: () => Promise<T>,
  defaultValue: T
): Promise<T> {
  try {
    return await operation();
  } catch (error) {
    console.warn('Operation failed, using default value:', error);
    return defaultValue;
  }
}

// Cached value fallback
class CachedFallback<T> {
  private cache: T | null = null;
  private cacheTimestamp: number = 0;
  private cacheTTL: number;
  
  constructor(cacheTTL: number = 300000) { // 5 minutes default
    this.cacheTTL = cacheTTL;
  }
  
  async execute(operation: () => Promise<T>): Promise<T> {
    try {
      const result = await operation();
      this.cache = result;
      this.cacheTimestamp = Date.now();
      return result;
    } catch (error) {
      if (this.cache && Date.now() - this.cacheTimestamp < this.cacheTTL) {
        console.warn('Operation failed, using cached value:', error);
        return this.cache;
      }
      throw error;
    }
  }
}

// Alternative service fallback
async function withAlternativeService<T>(
  primaryOperation: () => Promise<T>,
  alternativeOperation: () => Promise<T>
): Promise<T> {
  try {
    return await primaryOperation();
  } catch (error) {
    console.warn('Primary operation failed, trying alternative:', error);
    try {
      return await alternativeOperation();
    } catch (alternativeError) {
      throw new SystemError('Both primary and alternative operations failed', {
        primaryError: error,
        alternativeError
      });
    }
  }
}

// Degraded mode fallback
class DegradedModeService {
  private isDegraded = false;
  
  async execute<T>(
    normalOperation: () => Promise<T>,
    degradedOperation: () => Promise<T>
  ): Promise<T> {
    if (this.isDegraded) {
      return await degradedOperation();
    }
    
    try {
      return await normalOperation();
    } catch (error) {
      console.warn('Normal operation failed, switching to degraded mode:', error);
      this.isDegraded = true;
      return await degradedOperation();
    }
  }
  
  reset(): void {
    this.isDegraded = false;
  }
}
```

---

## 📊 **Error Monitoring and Logging**

### **Error Logging**

```typescript
// Error logging
const errorLogging = {
  structured: "Structured logging with consistent format",
  contextual: "Include context and metadata",
  levels: "Use appropriate log levels",
  sensitive: "Handle sensitive data appropriately",
  performance: "Minimize logging performance impact"
};

// Log levels
enum LogLevel {
  ERROR = 'ERROR',
  WARN = 'WARN',
  INFO = 'INFO',
  DEBUG = 'DEBUG'
}

// Structured error log
interface ErrorLog {
  timestamp: string;
  level: LogLevel;
  message: string;
  error: {
    name: string;
    message: string;
    stack?: string;
    code?: string;
    statusCode?: number;
  };
  context?: Record<string, any>;
  userId?: string;
  requestId?: string;
  correlationId?: string;
}

// Error logger
class ErrorLogger {
  private logLevel: LogLevel;
  
  constructor(logLevel: LogLevel = LogLevel.ERROR) {
    this.logLevel = logLevel;
  }
  
  logError(error: Error, context?: Record<string, any>): void {
    if (this.shouldLog(LogLevel.ERROR)) {
      const errorLog: ErrorLog = {
        timestamp: new Date().toISOString(),
        level: LogLevel.ERROR,
        message: error.message,
        error: {
          name: error.name,
          message: error.message,
          stack: error.stack,
          ...(isBaseError(error) && {
            code: error.code,
            statusCode: error.statusCode
          })
        },
        context: this.sanitizeContext(context)
      };
      
      this.writeLog(errorLog);
    }
  }
  
  logWarning(message: string, context?: Record<string, any>): void {
    if (this.shouldLog(LogLevel.WARN)) {
      this.writeLog({
        timestamp: new Date().toISOString(),
        level: LogLevel.WARN,
        message,
        error: { name: 'Warning', message },
        context: this.sanitizeContext(context)
      });
    }
  }
  
  private shouldLog(level: LogLevel): boolean {
    const levels = [LogLevel.ERROR, LogLevel.WARN, LogLevel.INFO, LogLevel.DEBUG];
    return levels.indexOf(level) <= levels.indexOf(this.logLevel);
  }
  
  private sanitizeContext(context?: Record<string, any>): Record<string, any> | undefined {
    if (!context) return undefined;
    
    const sensitiveFields = ['password', 'token', 'secret', 'key', 'auth'];
    const sanitized = { ...context };
    
    for (const field of sensitiveFields) {
      if (field in sanitized) {
        sanitized[field] = '[REDACTED]';
      }
    }
    
    return sanitized;
  }
  
  private writeLog(log: ErrorLog): void {
    // In production, this would send to a logging service
    console.error(JSON.stringify(log, null, 2));
  }
}
```

### **Error Monitoring**

```typescript
// Error monitoring
const errorMonitoring = {
  metrics: "Collect error metrics and statistics",
  alerting: "Set up alerts for critical errors",
  dashboards: "Create dashboards for error visualization",
  trends: "Track error trends over time",
  correlation: "Correlate errors with other system events"
};

// Error metrics
class ErrorMetrics {
  private errorCounts = new Map<string, number>();
  private errorRates = new Map<string, number>();
  private lastReset = Date.now();
  
  recordError(error: Error): void {
    const errorType = error.constructor.name;
    const count = this.errorCounts.get(errorType) || 0;
    this.errorCounts.set(errorType, count + 1);
    
    this.updateErrorRate(errorType);
  }
  
  private updateErrorRate(errorType: string): void {
    const count = this.errorCounts.get(errorType) || 0;
    const timeElapsed = Date.now() - this.lastReset;
    const rate = count / (timeElapsed / 1000); // errors per second
    this.errorRates.set(errorType, rate);
  }
  
  getErrorCount(errorType: string): number {
    return this.errorCounts.get(errorType) || 0;
  }
  
  getErrorRate(errorType: string): number {
    return this.errorRates.get(errorType) || 0;
  }
  
  getAllMetrics(): Record<string, { count: number; rate: number }> {
    const metrics: Record<string, { count: number; rate: number }> = {};
    
    for (const [errorType, count] of this.errorCounts) {
      metrics[errorType] = {
        count,
        rate: this.errorRates.get(errorType) || 0
      };
    }
    
    return metrics;
  }
  
  reset(): void {
    this.errorCounts.clear();
    this.errorRates.clear();
    this.lastReset = Date.now();
  }
}

// Error alerting
class ErrorAlerting {
  private thresholds = new Map<string, { count: number; rate: number }>();
  private alertCallbacks: Array<(alert: ErrorAlert) => void> = [];
  
  setThreshold(errorType: string, count: number, rate: number): void {
    this.thresholds.set(errorType, { count, rate });
  }
  
  addAlertCallback(callback: (alert: ErrorAlert) => void): void {
    this.alertCallbacks.push(callback);
  }
  
  checkThresholds(metrics: ErrorMetrics): void {
    for (const [errorType, threshold] of this.thresholds) {
      const count = metrics.getErrorCount(errorType);
      const rate = metrics.getErrorRate(errorType);
      
      if (count >= threshold.count || rate >= threshold.rate) {
        const alert: ErrorAlert = {
          errorType,
          count,
          rate,
          threshold,
          timestamp: new Date().toISOString()
        };
        
        this.triggerAlert(alert);
      }
    }
  }
  
  private triggerAlert(alert: ErrorAlert): void {
    for (const callback of this.alertCallbacks) {
      try {
        callback(alert);
      } catch (error) {
        console.error('Error in alert callback:', error);
      }
    }
  }
}

interface ErrorAlert {
  errorType: string;
  count: number;
  rate: number;
  threshold: { count: number; rate: number };
  timestamp: string;
}
```

---

## ✅ **Best Practices**

### **1. Use Specific Error Types**

```typescript
// ✅ Good: Specific error types
class ValidationError extends BaseError {
  readonly code = 'VALIDATION_ERROR';
  readonly statusCode = 400;
  readonly isOperational = true;
}

// ❌ Avoid: Generic Error
throw new Error('Something went wrong');
```

### **2. Handle Errors Gracefully**

```typescript
// ✅ Good: Graceful error handling
async function fetchUser(id: string): Promise<User | null> {
  try {
    const response = await fetch(`/api/users/${id}`);
    if (!response.ok) {
      throw new NetworkError(`HTTP ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    if (isNetworkError(error)) {
      console.error('Network error:', error.message);
      return null;
    }
    throw error;
  }
}

// ❌ Avoid: No error handling
async function fetchUserBad(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  return await response.json();
}
```

### **3. Implement Error Recovery**

```typescript
// ✅ Good: Error recovery
async function fetchDataWithFallback(): Promise<Data> {
  try {
    return await fetchFromPrimarySource();
  } catch (error) {
    console.warn('Primary source failed, trying fallback:', error);
    return await fetchFromFallbackSource();
  }
}

// ❌ Avoid: No recovery
async function fetchDataBad(): Promise<Data> {
  return await fetchFromPrimarySource();
}
```

### **4. Log Errors Appropriately**

```typescript
// ✅ Good: Structured error logging
const logger = new ErrorLogger();

try {
  await riskyOperation();
} catch (error) {
  logger.logError(error, {
    operation: 'riskyOperation',
    userId: 'user123',
    timestamp: Date.now()
  });
  throw error;
}

// ❌ Avoid: No logging
try {
  await riskyOperation();
} catch (error) {
  throw error;
}
```

---

## ❓ **Common Interview Questions**

### **1. How do you handle errors in TypeScript applications?**

**Answer:**
- **Custom Error Classes**: Create specific error types for different scenarios
- **Try-Catch Blocks**: Use try-catch for synchronous and async operations
- **Error Boundaries**: Implement error boundaries for React applications
- **Error Recovery**: Implement retry mechanisms and fallback strategies
- **Error Logging**: Log errors with context and metadata

### **2. What are the different types of errors you handle?**

**Answer:**
- **Validation Errors**: Input validation and data format errors
- **Business Logic Errors**: Domain-specific business rule violations
- **System Errors**: Infrastructure and system-level errors
- **Network Errors**: Communication and API errors
- **Authentication/Authorization Errors**: Security-related errors

### **3. How do you implement error recovery strategies?**

**Answer:**
- **Retry Mechanisms**: Simple retry, exponential backoff, and jitter
- **Circuit Breaker**: Prevent cascading failures
- **Fallback Strategies**: Default values, cached data, alternative services
- **Degraded Mode**: Operate with reduced functionality
- **Graceful Degradation**: Provide partial functionality when possible

### **4. How do you monitor and log errors?**

**Answer:**
- **Structured Logging**: Use consistent log format with context
- **Error Metrics**: Track error counts, rates, and trends
- **Alerting**: Set up alerts for critical errors
- **Dashboards**: Visualize error data and trends
- **Correlation**: Correlate errors with system events

### **5. What are the best practices for error handling?**

**Answer:**
- **Fail Fast**: Fail fast and fail clearly
- **User-Friendly Messages**: Provide meaningful error messages to users
- **Logging**: Log errors with sufficient context for debugging
- **Recovery**: Implement error recovery when possible
- **Prevention**: Prevent errors through validation and defensive programming

---

## 🧭 Navigation

<div class="navigation">
  <a href="02-Type-Safety-Best-Practices.md" class="nav-button">← Previous: Type Safety Best Practices</a>
  <a href="04-Migration-Strategies.md" class="nav-button">Next: Migration Strategies →</a>
</div>

*Last updated: December 2024*
