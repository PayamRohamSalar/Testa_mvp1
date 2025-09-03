# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

The TESTA Innovation Platform is a single-page application (SPA) built with React that connects organizations with innovators to solve technology challenges. It's implemented as a self-contained HTML file with embedded React components, using localStorage for data persistence.

## Development Commands

### Starting the Application
```bash
# Method 1: Simple HTTP server (recommended)
python -m http.server 8000

# Method 2: Using scripts folder
scripts/serve.cmd

# Method 3: Direct file opening (may have CORS issues)
# Open index.html directly in browser
```

Access the application at: `http://localhost:8000/index.html`

### Running Tests
The project includes comprehensive test suites implemented as separate HTML files:

```bash
# Test localStorage functionality
http://localhost:8000/test_storage.html

# Test authentication system
http://localhost:8000/test_auth.html

# Test routing system
http://localhost:8000/test_routing.html

# Test challenge management
http://localhost:8000/test_challenges.html

# Test admin functionality
http://localhost:8000/test_admin.html
```

### Data Management
```javascript
// Reset all data and reseed (run in browser console)
localStorage.clear(); 
location.reload();

// Verify implementation (run in browser console)
// Load and run: verify_implementation.js
```

### Build Process
No build process required - this is a self-contained application.

## Architecture Overview

### Core Technology Stack
- **Frontend**: React 18 (via CDN) with Babel for JSX transformation
- **Styling**: Tailwind CSS (via CDN)
- **Routing**: Custom hash-based router (`useHashRouter`)
- **State**: React hooks with localStorage persistence
- **Data**: JSON objects stored in browser localStorage

### Data Architecture

#### Storage Layer
The application uses a centralized storage adapter pattern:

```javascript
const storage = {
  get(key, fallback),    // Retrieve with JSON parsing
  set(key, value),       // Store with JSON stringifying
  has(key),              // Check existence
  clear()                // Clear all data
};
```

#### Data Models
All data keys are centralized in the `KEYS` object:

- **users**: Platform users (ADMIN, SEEKER, SOLVER roles)
- **orgs**: Organizations seeking solutions
- **challenges**: Technology challenges with rewards
- **submissions**: Solution proposals from solvers
- **messages**: Communication between users
- **events**: TESTA conference events
- **exhibitors**: Exhibition participants
- **notifications**: User notifications
- **reputationEvents**: User scoring/reputation tracking
- **settings**: Application configuration
- **session**: Current user session data

#### Seed Data System
The application automatically populates demo data via `seedDataOnce()` function:
- 4 demo users (1 admin, 1 seeker, 2 solvers)
- 2 organizations with different domains
- 2 technology challenges with detailed requirements
- Sample submissions, messages, events, and exhibitors

### Component Architecture

#### Page Components
- **HomePage**: Dashboard with statistics and platform overview
- **ChallengesPage**: Challenge catalog with search and filtering
- **TESTAPage**: Exhibition events and exhibitor directory
- **LoginForm**: Authentication with pre-filled demo accounts
- **RegistrationForm**: User and organization registration

#### User Role System
Three distinct user roles with different capabilities:
- **ADMIN**: System management, user approval, full access
- **SEEKER**: Organizations that post challenges and manage submissions
- **SOLVER**: Individuals/teams that submit solutions to challenges

#### Authentication Flow
1. Login with demo accounts or registered credentials
2. Session stored in localStorage with user details and role
3. Navigation and features adapt based on user role
4. Persistent session across page refreshes

### Routing System

Custom hash-based router implementation (`useHashRouter`):
- No dependencies on external routing libraries
- Browser back/forward button support
- Deep linking support
- Route protection based on user roles

#### Available Routes
**Public Routes:**
- `#home` - Platform dashboard
- `#challenges` - Public challenge catalog
- `#testa-*` - TESTA exhibition pages
- `#login` - User authentication
- `#register` - User registration

**Protected Routes:**
- `#admin` - Admin dashboard (ADMIN only)
- `#create-challenge` - Challenge creation (SEEKER only)
- `#my-challenges` - Challenge management (SEEKER only)
- `#my-submissions` - Submission tracking (SOLVER only)
- `#profile` - User/organization profile

### Form and State Management

#### Form Components
All forms use controlled components with real-time validation:
- **Challenge Creation**: Multi-step form with rich text fields
- **User Registration**: Role-specific fields and validation
- **Search and Filters**: Real-time filtering of challenge catalog

#### State Patterns
- React hooks for component state (`useState`, `useEffect`)
- Custom `useLocalStorage` hook for persistent state
- Optimistic updates with localStorage as source of truth

## Development Guidelines

### Working with the Single-File Architecture

This application is intentionally built as a single HTML file with embedded React. When making changes:

1. **All JavaScript code** is within `<script type="text/babel">` tags
2. **Component definitions** are at the global scope
3. **CSS styles** are in the `<style>` section with Tailwind classes
4. **No external dependencies** except CDN-loaded libraries

### Data Operations

#### Adding New Features
1. Add new data keys to the `KEYS` object
2. Update `seedDataOnce()` to initialize sample data
3. Create corresponding React components
4. Add routes to the navigation system

#### User Management
```javascript
// Get current user session
const session = storage.get(KEYS.session);

// Check user role
if (session?.role === 'ADMIN') {
  // Admin-specific functionality
}

// Update user data
const users = storage.get(KEYS.users, []);
// ... modify users array
storage.set(KEYS.users, users);
```

#### Challenge Management
```javascript
// Get challenges with filtering
const challenges = storage.get(KEYS.challenges, [])
  .filter(c => c.status === 'published')
  .filter(c => c.category === selectedCategory);

// Create new challenge
const newChallenge = {
  id: `c-${Date.now()}`,
  orgId: session.orgId,
  title: formData.title,
  // ... other fields
  createdAt: new Date().toISOString()
};
```

### Testing Strategy

The project includes comprehensive test suites for each major component:

1. **Storage Tests**: Verify localStorage operations and data persistence
2. **Auth Tests**: Test login/logout flow and role-based access
3. **Routing Tests**: Verify hash routing and navigation
4. **Challenge Tests**: Test CRUD operations for challenges
5. **Admin Tests**: Test approval workflows and management features

### Persian/RTL Support

The application is built for Persian (Farsi) users:
- `dir="rtl"` on HTML element
- Persian labels and content throughout
- Tailwind RTL utilities (`space-x-reverse`, etc.)
- Persian number formatting using `toLocaleString('fa-IR')`

### Demo Accounts

For development and testing, use these pre-configured accounts:

| Role | Email | Password | Features |
|------|-------|----------|----------|
| **ADMIN** | admin@platform.ir | 123456 | System management, user approval |
| **SEEKER** | info@parstech.ir | 123456 | Publish challenges, manage submissions |
| **SOLVER** | a.mohammadi@university.ac.ir | 123456 | Submit solutions, track progress |
| **SOLVER** | sara.ahmadi@tech.ir | 123456 | Submit solutions, track progress |

## Common Development Tasks

### Adding a New Page/Route
1. Create the component function
2. Add route to `getNavItems()` in Navigation component
3. Add case to main App component's route switching
4. Update any role-based access controls

### Modifying Data Schema
1. Update the relevant section in `seedDataOnce()`
2. Consider data migration for existing localStorage data
3. Update any dependent components
4. Test with the existing test suites

### Debugging Data Issues
1. Open browser developer tools
2. Check localStorage in Application tab
3. Run `verify_implementation.js` in console
4. Use the dedicated test pages for specific subsystems

## File Structure Context

```
├── index.html                 # Main SPA application
├── test_*.html               # Test suites for different components
├── verify_implementation.js  # Console verification script
├── create_project.py         # Project setup script
├── scripts/serve.cmd         # Simple server start script
└── docs/Global Spec.docx     # Detailed specifications
```

The main application logic, components, styles, and data management are all contained within `index.html`. The test files are standalone applications that verify specific functionality.
