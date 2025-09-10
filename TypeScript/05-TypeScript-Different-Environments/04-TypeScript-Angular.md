# 🔴 **TypeScript with Angular**

> **Complete guide to using TypeScript with Angular, including component typing, services, and advanced patterns**

<link rel="stylesheet" href="../../common-styles.css">

---

## 📚 **Table of Contents**

- [Angular TypeScript Setup](#angular-typescript-setup)
- [Component Typing](#component-typing)
- [Services and Dependency Injection](#services-and-dependency-injection)
- [Forms and Validation](#forms-and-validation)
- [Routing and Navigation](#routing-and-navigation)
- [Advanced Patterns](#advanced-patterns)
- [Best Practices](#best-practices)
- [Common Interview Questions](#common-interview-questions)

---

## 🎯 **Angular TypeScript Setup**

Angular is built with TypeScript from the ground up, providing excellent type safety and developer experience.

### **Basic Setup**


{% raw %}
```bash
# Install Angular CLI
npm install -g @angular/cli

# Create new Angular project
ng new my-app

# Or add TypeScript to existing project
ng add @angular/cli
```
{% endraw %}


### **Angular Configuration**


{% raw %}
```json
// tsconfig.json
{
  "compileOnSave": false,
  "compilerOptions": {
    "baseUrl": "./",
    "outDir": "./dist/out-tsc",
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "noImplicitOverride": true,
    "noPropertyAccessFromIndexSignature": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "sourceMap": true,
    "declaration": false,
    "downlevelIteration": true,
    "experimentalDecorators": true,
    "moduleResolution": "node",
    "importHelpers": true,
    "target": "ES2022",
    "module": "ES2022",
    "useDefineForClassFields": false,
    "lib": [
      "ES2022",
      "dom"
    ]
  },
  "angularCompilerOptions": {
    "enableI18nLegacyMessageIdFormat": false,
    "strictInjectionParameters": true,
    "strictInputAccessModifiers": true,
    "strictTemplates": true
  }
}
```
{% endraw %}


### **Angular CLI Configuration**


{% raw %}
```json
// angular.json
{
  "projects": {
    "my-app": {
      "projectType": "application",
      "schematics": {
        "@schematics/angular:component": {
          "style": "scss"
        }
      },
      "root": "",
      "sourceRoot": "src",
      "prefix": "app",
      "architect": {
        "build": {
          "builder": "@angular-devkit/build-angular:browser",
          "options": {
            "outputPath": "dist/my-app",
            "index": "src/index.html",
            "main": "src/main.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.app.json",
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.scss"
            ],
            "scripts": []
          }
        }
      }
    }
  }
}
```
{% endraw %}


---

## 🧩 **Component Typing**

### **Basic Component**


{% raw %}
```typescript
// user.component.ts
import { Component, Input, Output, EventEmitter } from '@angular/core';

interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

@Component({
  selector: 'app-user',
  template: `
    <div class="user-card">
      <h3>{{}}</h3>
      <p>{{}}</p>
      <p>Age: {{}}</p>
      <button (click)="onEdit()">Edit</button>
      <button (click)="onDelete()">Delete</button>
    </div>
  `,
  styleUrls: ['./user.component.scss']
})
export class UserComponent {
  @Input() user!: User;
  @Output() edit = new EventEmitter<User>();
  @Output() delete = new EventEmitter<number>();

  onEdit(): void {
    this.edit.emit(this.user);
  }

  onDelete(): void {
    this.delete.emit(this.user.id);
  }
}
```
{% endraw %}


### **Component with Lifecycle Hooks**


{% raw %}
```typescript
// user-list.component.ts
import { 
  Component, 
  OnInit, 
  OnDestroy, 
  OnChanges, 
  SimpleChanges,
  Input,
  Output,
  EventEmitter
} from '@angular/core';
import { Subject, takeUntil } from 'rxjs';

interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

@Component({
  selector: 'app-user-list',
  template: `
    <div class="user-list">
      <h2>Users</h2>
      <div *ngIf="loading" class="loading">Loading...</div>
      <div *ngIf="error" class="error">{{}}</div>
      <div *ngFor="let user of users" class="user-item">
        <app-user 
          [user]="user" 
          (edit)="onEdit($event)"
          (delete)="onDelete($event)">
        </app-user>
      </div>
    </div>
  `,
  styleUrls: ['./user-list.component.scss']
})
export class UserListComponent implements OnInit, OnDestroy, OnChanges {
  @Input() refreshTrigger: number = 0;
  @Output() userEdit = new EventEmitter<User>();
  @Output() userDelete = new EventEmitter<number>();

  users: User[] = [];
  loading: boolean = false;
  error: string | null = null;
  private destroy$ = new Subject<void>();

  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['refreshTrigger'] && !changes['refreshTrigger'].firstChange) {
      this.loadUsers();
    }
  }

  private loadUsers(): void {
    this.loading = true;
    this.error = null;

    this.userService.getUsers()
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (users) => {
          this.users = users;
          this.loading = false;
        },
        error: (error) => {
          this.error = error.message;
          this.loading = false;
        }
      });
  }

  onEdit(user: User): void {
    this.userEdit.emit(user);
  }

  onDelete(userId: number): void {
    this.userDelete.emit(userId);
  }
}
```
{% endraw %}


### **Generic Component**


{% raw %}
```typescript
// data-table.component.ts
import { Component, Input, Output, EventEmitter } from '@angular/core';

interface Column<T> {
  key: keyof T;
  title: string;
  sortable?: boolean;
  width?: string;
}

@Component({
  selector: 'app-data-table',
  template: `
    <table class="data-table">
      <thead>
        <tr>
          <th 
            *ngFor="let column of columns" 
            [style.width]="column.width"
            [class.sortable]="column.sortable"
            (click)="onSort(column)">
            {{}}
            <span *ngIf="column.sortable" class="sort-indicator">
              {{}}
            </span>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr *ngFor="let item of data; trackBy: trackByFn">
          <td *ngFor="let column of columns">
            <ng-container [ngSwitch]="column.key">
              <ng-container *ngSwitchDefault>
                {{}}
              </ng-container>
              <ng-container *ngSwitchCase="'actions'">
                <ng-content [select]="'[slot=actions]'" [ngTemplateOutlet]="actionsTemplate" [ngTemplateOutletContext]="{ $implicit: item }"></ng-content>
              </ng-container>
            </ng-container>
          </td>
        </tr>
      </tbody>
    </table>
  `,
  styleUrls: ['./data-table.component.scss']
})
export class DataTableComponent<T> {
  @Input() data: T[] = [];
  @Input() columns: Column<T>[] = [];
  @Input() keyExtractor: (item: T) => any = (item: T) => item;
  @Output() sort = new EventEmitter<{ column: keyof T; direction: 'asc' | 'desc' }>();

  sortColumn: keyof T | null = null;
  sortDirection: 'asc' | 'desc' = 'asc';

  trackByFn(index: number, item: T): any {
    return this.keyExtractor(item);
  }

  onSort(column: Column<T>): void {
    if (!column.sortable) return;

    if (this.sortColumn === column.key) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortColumn = column.key;
      this.sortDirection = 'asc';
    }

    this.sort.emit({ column: column.key, direction: this.sortDirection });
  }

  getSortIndicator(column: Column<T>): string {
    if (this.sortColumn !== column.key) return '';
    return this.sortDirection === 'asc' ? '↑' : '↓';
  }
}
```
{% endraw %}


---

## 🔧 **Services and Dependency Injection**

### **Basic Service**


{% raw %}
```typescript
// user.service.ts
import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, BehaviorSubject, throwError } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';

interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

interface CreateUserRequest {
  name: string;
  email: string;
  age: number;
}

interface UpdateUserRequest {
  name?: string;
  email?: string;
  age?: number;
}

interface UserListResponse {
  users: User[];
  total: number;
  page: number;
  limit: number;
}

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private readonly apiUrl = '/api/users';
  private usersSubject = new BehaviorSubject<User[]>([]);
  public users$ = this.usersSubject.asObservable();

  constructor(private http: HttpClient) {}

  getUsers(page: number = 1, limit: number = 10): Observable<UserListResponse> {
    const params = new HttpParams()
      .set('page', page.toString())
      .set('limit', limit.toString());

    return this.http.get<UserListResponse>(this.apiUrl, { params })
      .pipe(
        tap(response => this.usersSubject.next(response.users)),
        catchError(this.handleError)
      );
  }

  getUserById(id: number): Observable<User> {
    return this.http.get<User>(`${this.apiUrl}/${id}`)
      .pipe(catchError(this.handleError));
  }

  createUser(userData: CreateUserRequest): Observable<User> {
    return this.http.post<User>(this.apiUrl, userData)
      .pipe(
        tap(user => {
          const currentUsers = this.usersSubject.value;
          this.usersSubject.next([...currentUsers, user]);
        }),
        catchError(this.handleError)
      );
  }

  updateUser(id: number, userData: UpdateUserRequest): Observable<User> {
    return this.http.put<User>(`${this.apiUrl}/${id}`, userData)
      .pipe(
        tap(updatedUser => {
          const currentUsers = this.usersSubject.value;
          const index = currentUsers.findIndex(user => user.id === id);
          if (index !== -1) {
            currentUsers[index] = updatedUser;
            this.usersSubject.next([...currentUsers]);
          }
        }),
        catchError(this.handleError)
      );
  }

  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`)
      .pipe(
        tap(() => {
          const currentUsers = this.usersSubject.value;
          const filteredUsers = currentUsers.filter(user => user.id !== id);
          this.usersSubject.next(filteredUsers);
        }),
        catchError(this.handleError)
      );
  }

  private handleError(error: any): Observable<never> {
    console.error('UserService error:', error);
    return throwError(() => new Error(error.message || 'An error occurred'));
  }
}
```
{% endraw %}


### **Custom Injection Token**


{% raw %}
```typescript
// config.service.ts
import { Injectable, InjectionToken } from '@angular/core';

export interface AppConfig {
  apiUrl: string;
  environment: 'development' | 'production' | 'test';
  version: string;
  features: {
    userManagement: boolean;
    reporting: boolean;
    analytics: boolean;
  };
}

export const APP_CONFIG = new InjectionToken<AppConfig>('app.config');

@Injectable({
  providedIn: 'root'
})
export class ConfigService {
  constructor(@Inject(APP_CONFIG) private config: AppConfig) {}

  get apiUrl(): string {
    return this.config.apiUrl;
  }

  get environment(): string {
    return this.config.environment;
  }

  get version(): string {
    return this.config.version;
  }

  isFeatureEnabled(feature: keyof AppConfig['features']): boolean {
    return this.config.features[feature];
  }
}

// app.module.ts
@NgModule({
  providers: [
    {
      provide: APP_CONFIG,
      useValue: {
        apiUrl: 'https://api.example.com',
        environment: 'production',
        version: '1.0.0',
        features: {
          userManagement: true,
          reporting: false,
          analytics: true
        }
      }
    }
  ]
})
export class AppModule {}
```
{% endraw %}


---

## 📝 **Forms and Validation**

### **Reactive Forms**


{% raw %}
```typescript
// user-form.component.ts
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup, Validators, AbstractControl } from '@angular/forms';

interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

@Component({
  selector: 'app-user-form',
  template: `
    <form [formGroup]="userForm" (ngSubmit)="onSubmit()">
      <div class="form-group">
        <label for="name">Name</label>
        <input 
          id="name"
          type="text" 
          formControlName="name"
          [class.error]="isFieldInvalid('name')">
        <div *ngIf="isFieldInvalid('name')" class="error-message">
          <span *ngIf="userForm.get('name')?.errors?.['required']">Name is required</span>
          <span *ngIf="userForm.get('name')?.errors?.['minlength']">Name must be at least 2 characters</span>
        </div>
      </div>

      <div class="form-group">
        <label for="email">Email</label>
        <input 
          id="email"
          type="email" 
          formControlName="email"
          [class.error]="isFieldInvalid('email')">
        <div *ngIf="isFieldInvalid('email')" class="error-message">
          <span *ngIf="userForm.get('email')?.errors?.['required']">Email is required</span>
          <span *ngIf="userForm.get('email')?.errors?.['email']">Invalid email format</span>
        </div>
      </div>

      <div class="form-group">
        <label for="age">Age</label>
        <input 
          id="age"
          type="number" 
          formControlName="age"
          [class.error]="isFieldInvalid('age')">
        <div *ngIf="isFieldInvalid('age')" class="error-message">
          <span *ngIf="userForm.get('age')?.errors?.['required']">Age is required</span>
          <span *ngIf="userForm.get('age')?.errors?.['min']">Age must be at least 18</span>
          <span *ngIf="userForm.get('age')?.errors?.['max']">Age must be at most 120</span>
        </div>
      </div>

      <div class="form-actions">
        <button type="submit" [disabled]="userForm.invalid">Save</button>
        <button type="button" (click)="onCancel()">Cancel</button>
      </div>
    </form>
  `,
  styleUrls: ['./user-form.component.scss']
})
export class UserFormComponent implements OnInit {
  @Input() user: User | null = null;
  @Output() save = new EventEmitter<User>();
  @Output() cancel = new EventEmitter<void>();

  userForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.userForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      email: ['', [Validators.required, Validators.email]],
      age: ['', [Validators.required, Validators.min(18), Validators.max(120)]]
    });
  }

  ngOnInit(): void {
    if (this.user) {
      this.userForm.patchValue(this.user);
    }
  }

  onSubmit(): void {
    if (this.userForm.valid) {
      const formValue = this.userForm.value;
      const user: User = {
        id: this.user?.id || 0,
        ...formValue
      };
      this.save.emit(user);
    }
  }

  onCancel(): void {
    this.cancel.emit();
  }

  isFieldInvalid(fieldName: string): boolean {
    const field = this.userForm.get(fieldName);
    return !!(field && field.invalid && (field.dirty || field.touched));
  }
}
```
{% endraw %}


### **Custom Validators**


{% raw %}
```typescript
// custom-validators.ts
import { AbstractControl, ValidationErrors, ValidatorFn } from '@angular/forms';

export class CustomValidators {
  static emailDomain(domain: string): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      if (!control.value) return null;
      
      const email = control.value as string;
      const emailDomain = email.split('@')[1];
      
      if (emailDomain !== domain) {
        return { emailDomain: { requiredDomain: domain, actualDomain: emailDomain } };
      }
      
      return null;
    };
  }

  static passwordStrength(): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      if (!control.value) return null;
      
      const password = control.value as string;
      const hasUpperCase = /[A-Z]/.test(password);
      const hasLowerCase = /[a-z]/.test(password);
      const hasNumbers = /\d/.test(password);
      const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
      
      if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChar) {
        return { 
          passwordStrength: { 
            hasUpperCase, 
            hasLowerCase, 
            hasNumbers, 
            hasSpecialChar 
          } 
        };
      }
      
      return null;
    };
  }

  static matchPassword(passwordField: string): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      if (!control.parent) return null;
      
      const password = control.parent.get(passwordField)?.value;
      const confirmPassword = control.value;
      
      if (password !== confirmPassword) {
        return { passwordMismatch: true };
      }
      
      return null;
    };
  }
}
```
{% endraw %}


---

## 🧭 **Routing and Navigation**

### **Route Configuration**


{% raw %}
```typescript
// app-routing.module.ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { UserListComponent } from './user-list/user-list.component';
import { UserDetailComponent } from './user-detail/user-detail.component';
import { UserFormComponent } from './user-form/user-form.component';
import { AuthGuard } from './guards/auth.guard';

const routes: Routes = [
  { path: '', redirectTo: '/users', pathMatch: 'full' },
  { 
    path: 'users', 
    component: UserListComponent,
    canActivate: [AuthGuard]
  },
  { 
    path: 'users/:id', 
    component: UserDetailComponent,
    canActivate: [AuthGuard]
  },
  { 
    path: 'users/:id/edit', 
    component: UserFormComponent,
    canActivate: [AuthGuard]
  },
  { 
    path: 'users/new', 
    component: UserFormComponent,
    canActivate: [AuthGuard]
  },
  { path: '**', redirectTo: '/users' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
```
{% endraw %}


### **Route Guards**


{% raw %}
```typescript
// auth.guard.ts
import { Injectable } from '@angular/core';
import { CanActivate, Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { map, take } from 'rxjs/operators';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> {
    return this.authService.isAuthenticated$.pipe(
      take(1),
      map(isAuthenticated => {
        if (isAuthenticated) {
          return true;
        } else {
          this.router.navigate(['/login'], { 
            queryParams: { returnUrl: state.url } 
          });
          return false;
        }
      })
    );
  }
}
```
{% endraw %}


### **Route Resolvers**


{% raw %}
```typescript
// user.resolver.ts
import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { UserService } from './user.service';
import { User } from './user.model';

@Injectable({
  providedIn: 'root'
})
export class UserResolver implements Resolve<User> {
  constructor(private userService: UserService) {}

  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<User> {
    const id = route.paramMap.get('id');
    if (id) {
      return this.userService.getUserById(+id);
    }
    return of({} as User);
  }
}
```
{% endraw %}


---

## 🚀 **Advanced Patterns**

### **State Management with NgRx**


{% raw %}
```typescript
// user.actions.ts
import { createAction, props } from '@ngrx/store';
import { User } from './user.model';

export const loadUsers = createAction('[User] Load Users');
export const loadUsersSuccess = createAction(
  '[User] Load Users Success',
  props<{ users: User[] }>()
);
export const loadUsersFailure = createAction(
  '[User] Load Users Failure',
  props<{ error: string }>()
);

export const createUser = createAction(
  '[User] Create User',
  props<{ user: Omit<User, 'id'> }>()
);
export const createUserSuccess = createAction(
  '[User] Create User Success',
  props<{ user: User }>()
);
export const createUserFailure = createAction(
  '[User] Create User Failure',
  props<{ error: string }>()
);
```
{% endraw %}



{% raw %}
```typescript
// user.reducer.ts
import { createReducer, on } from '@ngrx/store';
import { User } from './user.model';
import * as UserActions from './user.actions';

export interface UserState {
  users: User[];
  loading: boolean;
  error: string | null;
}

export const initialState: UserState = {
  users: [],
  loading: false,
  error: null
};

export const userReducer = createReducer(
  initialState,
  on(UserActions.loadUsers, (state) => ({
    ...state,
    loading: true,
    error: null
  })),
  on(UserActions.loadUsersSuccess, (state, { users }) => ({
    ...state,
    users,
    loading: false,
    error: null
  })),
  on(UserActions.loadUsersFailure, (state, { error }) => ({
    ...state,
    loading: false,
    error
  })),
  on(UserActions.createUserSuccess, (state, { user }) => ({
    ...state,
    users: [...state.users, user]
  }))
);
```
{% endraw %}


### **Interceptors**


{% raw %}
```typescript
// auth.interceptor.ts
import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor(private authService: AuthService) {}

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const token = this.authService.getToken();
    
    if (token) {
      const authReq = req.clone({
        headers: req.headers.set('Authorization', `Bearer ${token}`)
      });
      return next.handle(authReq);
    }
    
    return next.handle(req);
  }
}
```
{% endraw %}


---

## ✅ **Best Practices**

### **1. Use Strict Type Checking**


{% raw %}
```typescript
// ✅ Good: Strict typing
interface User {
  id: number;
  name: string;
  email: string;
}

@Input() user!: User;

// ❌ Avoid: Loose typing
@Input() user: any;
```
{% endraw %}


### **2. Use OnPush Change Detection**


{% raw %}
```typescript
// ✅ Good: OnPush change detection
@Component({
  selector: 'app-user',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `...`
})
export class UserComponent {
  // Component implementation
}

// ❌ Avoid: Default change detection
@Component({
  selector: 'app-user',
  template: `...`
})
export class UserComponent {
  // Component implementation
}
```
{% endraw %}


### **3. Use TrackBy Functions**


{% raw %}
```typescript
// ✅ Good: TrackBy function
trackByUserId(index: number, user: User): number {
  return user.id;
}

// ❌ Avoid: No trackBy function
*ngFor="let user of users"
```
{% endraw %}


### **4. Use Reactive Forms**


{% raw %}
```typescript
// ✅ Good: Reactive forms
userForm = this.fb.group({
  name: ['', Validators.required],
  email: ['', [Validators.required, Validators.email]]
});

// ❌ Avoid: Template-driven forms
<form #userForm="ngForm">
  <input name="name" ngModel required>
</form>
```
{% endraw %}


---

## ❓ **Common Interview Questions**

### **1. How do you set up TypeScript with Angular?**

**Answer:**
Angular is built with TypeScript by default. Just use `ng new my-app` and TypeScript is automatically configured.

### **2. What are the benefits of using TypeScript with Angular?**

**Answer:**
- **Type safety**: Catch errors at compile time
- **Better IDE support**: IntelliSense and autocomplete
- **Refactoring**: Safer code changes
- **Documentation**: Self-documenting code

### **3. How do you type Angular components?**

**Answer:**

{% raw %}
```typescript
@Component({
  selector: 'app-user',
  template: `...`
})
export class UserComponent {
  @Input() user!: User;
  @Output() edit = new EventEmitter<User>();
}
```
{% endraw %}


### **4. How do you handle forms in Angular with TypeScript?**

**Answer:**

{% raw %}
```typescript
userForm = this.fb.group({
  name: ['', Validators.required],
  email: ['', [Validators.required, Validators.email]]
});
```
{% endraw %}


### **5. How do you create services in Angular with TypeScript?**

**Answer:**

{% raw %}
```typescript
@Injectable({
  providedIn: 'root'
})
export class UserService {
  constructor(private http: HttpClient) {}
  
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>('/api/users');
  }
}
```
{% endraw %}


---

## 🧭 Navigation

<div class="navigation">
  <a href="03-TypeScript-Vuejs.md" class="nav-button">← Previous: TypeScript with Vue.js</a>
  <a href="../06-TypeScript-Testing-Quality/01-Unit-Testing-TypeScript.md" class="nav-button">Next: Unit Testing with TypeScript →</a>
</div>

*Last updated: December 2025*
