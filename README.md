# TESTA Platform - Stage 3.1

## Challenge CRUD + Catalog + Detail Implementation

This stage implements comprehensive challenge management system with full CRUD operations, searchable catalog with filters, and detailed challenge pages for the TESTA innovation platform.

### Features Implemented

#### 1. Storage Adapters
- **`storage` object** with methods:
  - `get(key, fallback)` - Safe retrieval with fallback
  - `set(key, value)` - JSON stringified storage
  - `has(key)` - Check if key exists
  - `clear()` - Clear all localStorage

#### 2. Data Models & Keys
Centralized `KEYS` object for all data types:
- `users` - Platform users (ADMIN, SEEKER, SOLVER)
- `orgs` - Organizations/companies
- `challenges` - Innovation challenges
- `submissions` - Challenge submissions
- `messages` - Communication between parties
- `events` - TESTA conference events
- `exhibitors` - Exhibition participants
- `notifications` - User notifications
- `reputationEvents` - User reputation tracking
- `settings` - Application settings
- `session` - Current user session

#### 3. Comprehensive Seed Data
Rich sample data for all entities:

**Users (4):**
- Admin user (مدیر سیستم)
- Seeker user (پارس‌تک company)
- Two solver users (امیر محمدی, سارا احمدی)

**Organizations (2):**
- شرکت توسعه فناوری پارس
- شرکت انرژی سبز

**Challenges (2):**
- سامانه مدیریت هوشمند انرژی (50M تومان)
- پنل خورشیدی هوشمند (30M تومان)

**Submissions (2):**
- Submitted proposal for energy management
- Draft proposal for solar panel

**Messages (2):**
- Communication between seeker and solver

**Events (3):**
- TESTA opening ceremony
- Energy future conference
- IoT and smart city workshop

**Exhibitors (3):**
- Various companies with booth codes

**Notifications (3):**
- Challenge notifications
- Message notifications
- Event reminders

**Reputation Events (3):**
- Points for submissions and interactions

#### 4. Hash Router & Navigation
- **`useHashRouter` hook** - Tiny hash-based router
- **Navigation component** - Top navigation bar with icons
- **Route switching** - Changes view based on hash
- **Deep linking** - Direct access via URLs like `#challenges`
- **Browser history** - Back/forward button support

#### 5. Page Components
- **HomePage** - Dashboard with statistics and overview
- **ChallengesPage** - List of available challenges with details
- **TESTAPage** - Exhibition events and exhibitor information

#### 6. Authentication System
- **Login Form** - Pre-filled demo accounts for easy testing
- **Registration Forms** - Separate forms for Solver and Seeker roles
- **Session Management** - Persistent login state with localStorage
- **Role-aware Navigation** - Different menu items based on user role
- **Logout Functionality** - Clean session termination
- **Route Protection** - Role-based access to specific pages

#### 7. Admin Dashboard & Approval System
- **Approval Queue** - Pending users and organizations
- **Approve/Reject Actions** - One-click approval/rejection
- **Status Updates** - Automatic status changes after approval
- **Notification System** - Alerts for new organization requests
- **User/Organization Details** - View full profiles before approval
- **Statistics Dashboard** - System overview with counts

#### 8. Comprehensive User Profiles
- **Solver Profiles**:
  - Personal information (name, email, reputation)
  - Biography and self-description
  - Skills and expertise tags
  - Portfolio placeholder (ready for future expansion)
  - Status indicators (approved/pending/rejected)

- **Seeker Profiles**:
  - Organization information and domains
  - Contact details and website
  - Company description and about section
  - Logo upload placeholder
  - Team members placeholder (ready for future expansion)
  - Approval status tracking

#### 9. Challenge Management System
- **Challenge CRUD** - Complete Create, Read, Update operations for seekers
- **Rich Form Interface** - Comprehensive challenge creation with validation
- **Searchable Catalog** - Advanced filtering by category, reward, deadline, tags
- **Multiple View Modes** - Grid and list layouts for challenge browsing
- **Detailed Challenge Pages** - Full challenge information with action buttons
- **Role-Based Permissions** - Seekers can edit their challenges, solvers can view
- **"Solve Challenge" Action** - Call-to-action for interested solvers

#### 10. Advanced Search & Filtering
- **Multi-field Search** - Title, description, and tags search
- **Category Filtering** - Filter by Energy, IoT, AI, Robotics, etc.
- **Reward-based Sorting** - Sort by highest/lowest reward
- **Deadline Awareness** - Visual indicators for time remaining
- **Real-time Results** - Instant filtering as you type

#### 11. Challenge Form Features
- **Comprehensive Fields** - Title, problem, success criteria, deliverables
- **Rich Text Areas** - Detailed descriptions for all sections
- **Reward Setting** - Flexible reward amounts in Iranian Rials
- **Category Selection** - Pre-defined technology categories
- **Deadline Picker** - Date selection with future validation
- **Tag Management** - Comma-separated tags with visual display
- **Status Control** - Draft/Published status management
- **Form Validation** - Real-time error checking and user feedback

#### 12. User Experience Enhancements
- **Responsive Design** - Works seamlessly on mobile and desktop
- **Loading States** - Visual feedback during form submission
- **Error Handling** - Clear error messages and validation feedback
- **Success Notifications** - Confirmation messages for all actions
- **Navigation Integration** - Seamless flow between create, edit, and view modes

#### 8. React Integration
- **`useLocalStorage` hook** - Binds React state to localStorage
- **`seedDataOnce()`** - Runs once per user via useEffect
- **Reset functionality** - Temporary reset button for testing

### Testing

#### Manual Testing
1. **Basic Navigation**: Open `index.html` in browser
   - Test navigation between Home, Challenges, TESTA tabs
   - Check that URL changes with hash
   - Use browser back/forward buttons

2. **Authentication Flow**:
   - Click "ورود" (Login) button to access login form
   - Test pre-filled demo accounts
   - Verify role-specific navigation after login
   - Test logout functionality
   - Check session persistence on page refresh

3. **Registration**:
   - Test Solver registration form
   - Test Seeker organization request form
   - Verify validation and success states

4. **Role-based Features**:
   - Login as ADMIN → Should see "مدیریت" (Management) menu
   - Login as SEEKER → Should see "چالش‌های من" (My Challenges) + "ایجاد چالش" (Create Challenge) menu
   - Login as SOLVER → Should see "پیشنهادات من" (My Submissions) menu

5. **Challenge Management**:
   - Login as SEEKER → Create new challenge → Should appear in catalog
   - Test search functionality → Filter by category/reward/tags
   - Click challenge → View detailed page with "حل این چالش" button
   - Edit challenge → Changes should reflect in catalog
   - Test grid/list view toggles

#### Automated Testing
1. **Storage**: Open `test_storage.html` in browser
   - localStorage availability and data integrity

2. **Routing**: Open `test_routing.html` in browser
   - Hash route switching and deep linking

3. **Authentication**: Open `test_auth.html` in browser
   - Session management and role verification
   - Demo account functionality
   - Login state persistence

4. **Admin System**: Open `test_admin.html` in browser
   - Approval queue management
   - User and organization creation
   - Status tracking and updates
   - Profile viewing functionality

5. **Challenge System**: Open `test_challenges.html` in browser
   - Challenge creation and editing
   - Catalog search and filtering
   - Challenge detail viewing
   - Role-based permissions
   - CRUD operations testing

### Data Persistence
- All data stored in browser localStorage
- Survives page reloads
- Reset button clears and reseeds
- One-time seeding per user

### Next Steps
- Phase 2: Authentication system
- Phase 3: Challenge management UI
- Phase 4: Submission workflow
- Phase 5: TESTA event features

### File Structure
```
├── index.html            # Main application with admin & profiles
├── test_storage.html     # Storage testing page
├── test_routing.html     # Router testing page
├── test_auth.html        # Authentication testing page
├── test_admin.html       # Admin & approval testing page
├── test_challenges.html  # Challenge system testing page
├── verify_implementation.js # Console verification script
├── README.md            # This documentation
└── docs/
    └── Global Spec.docx # Detailed specifications
```

### Usage
```bash
# Start local server
python -m http.server 8000

# Open main application
http://localhost:8000/index.html

# Authentication routes
http://localhost:8000/index.html#login
http://localhost:8000/index.html#register
http://localhost:8000/index.html#register-seeker

# Public routes
http://localhost:8000/index.html#home
http://localhost:8000/index.html#challenges
http://localhost:8000/index.html#testa

# Protected routes (require login)
http://localhost:8000/index.html#admin          # ADMIN only
http://localhost:8000/index.html#create-challenge # SEEKER only
http://localhost:8000/index.html#my-challenges  # SEEKER only
http://localhost:8000/index.html#my-submissions # SOLVER only
http://localhost:8000/index.html#profile        # Personal/Organization profile

# Test utilities
http://localhost:8000/test_storage.html
http://localhost:8000/test_routing.html
http://localhost:8000/test_auth.html
http://localhost:8000/test_admin.html
http://localhost:8000/test_challenges.html
```

### Demo Accounts
| Role | Email | Password | Features |
|------|-------|----------|----------|
| **ADMIN** | admin@platform.ir | 123456 | System management, user approval |
| **SEEKER** | info@parstech.ir | 123456 | Publish challenges, manage submissions |
| **SOLVER** | a.mohammadi@university.ac.ir | 123456 | Submit solutions, track progress |
| **SOLVER** | sara.ahmadi@tech.ir | 123456 | Submit solutions, track progress |

### Routes Available
- **`#login`** - User authentication form
- **`#register`** - Solver registration
- **`#register-seeker`** - Organization registration request
- **`#home`** - Dashboard with platform overview
- **`#challenges`** - Browse available technology challenges
- **`#challenge-detail`** - Detailed challenge view page
- **`#create-challenge`** - Challenge creation form (SEEKER only)
- **`#testa`** - TESTA exhibition events and exhibitors
- **`#admin`** - Admin management panel (ADMIN only)
- **`#my-challenges`** - Challenge management (SEEKER only)
- **`#my-submissions`** - Submission tracking (SOLVER only)
- **`#profile`** - Personal/organization profile (all authenticated users)
