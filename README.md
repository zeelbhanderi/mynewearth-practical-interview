# Wellness Hub - Technical Interview Assessment

A Flutter application built as a coding assessment for a freelance client position. This project demonstrates Clean Architecture implementation, state management, and local data persistence using modern Flutter development practices.

## Application Demo

### Video Walkthrough
<video src="showcase/app-walkthrough-video.mov" controls height="600">
   Your browser does not support the .mov video type.
</video>

## Architecture

The app follows **Clean Architecture** principles with a feature-first folder structure:

```
lib/
├── core/           # Shared utilities, constants, database
├── features/       # Feature modules (offerings)
│   └── offerings/
│       ├── data/       # Models, data sources, repositories
│       ├── domain/     # Entities, use cases, repository contracts
│       └── presentation/ # Controllers, pages, widgets
└── main.dart
```

### Why Clean Architecture?

- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Business logic is isolated from UI and data layers
- **Maintainability**: Easy to modify without affecting other components
- **Scalability**: New features can be added without restructuring

## App Workflow

### User Journey Flow

```
App Launch
    ↓
Offerings List Page
    ├── Empty State (No offerings)
    │   └── Tap FAB → Add Offering Page
    │
    └── Populated List
        ├── Tap Offering → Edit Offering Page
        ├── Tap Delete → Confirmation Dialog
        └── Tap FAB → Add Offering Page

Add/Edit Offering Page
    ├── Fill Form Fields
    │   ├── Practitioner Name
    │   ├── Title
    │   ├── Description
    │   ├── Category (Dropdown)
    │   ├── Duration (Dropdown)
    │   ├── Type (In-Person/Online)
    │   └── Price
    ├── Form Validation
    │   ├── Required field checks
    │   ├── Price format validation
    │   └── Error message display
    └── Save Action
        ├── Success → Return to List + Snackbar
        └── Error → Error message display
```

### Core Operations

**Create Offering:**
1. User taps floating action button
2. Navigate to Add Offering form
3. Fill required fields with validation
4. Save to SQLite database
5. Return to list with success feedback

**View Offerings:**
1. App loads all offerings from database
2. Display in scrollable card list
3. Show practitioner, title, description, tags, price
4. Pull-to-refresh functionality

**Update Offering:**
1. User taps on existing offering card
2. Navigate to Edit form with pre-filled data
3. Modify fields and save changes
4. Update database record
5. Refresh list view

**Delete Offering:**
1. User taps delete icon on offering card
2. Show confirmation dialog
3. On confirm, remove from database
4. Update UI with success message

### Data Flow Architecture

```
Presentation Layer (UI)
    ↓ User Actions
Controller (GetX)
    ↓ Business Logic
Use Cases
    ↓ Data Operations
Repository
    ↓ Data Access
Local Data Source
    ↓ Storage
SQLite Database
```

## Getting Started

Follow the steps below to set up and run this application:

### Prerequisites

- **Flutter**: Version 3.32.5
- **Dart**: Ensure Dart is installed (comes bundled with Flutter)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/zeelbhanderi/mynewearth-practical-interview.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd mynewearth-practical-interview
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## Dependencies

### Core Dependencies

```yaml
get: ^4.7.2        # State management & dependency injection
sqflite: ^2.4.2    # Local database
path: ^1.9.1       # File path utilities
```

### Package Choices

**GetX (`get`)**
- **Why**: Lightweight reactive state management with built-in dependency injection
- **Benefits**: Minimal boilerplate, excellent performance, integrated routing
- **Alternative**: Provider + Riverpod (more verbose but ecosystem standard)

**SQLite (`sqflite`)**
- **Why**: Reliable local storage for offline-first functionality
- **Benefits**: ACID compliance, mature ecosystem, no external dependencies
- **Use Case**: Perfect for storing practitioner offerings locally

**Path (`path`)**
- **Why**: Required companion for SQLite database file management
- **Benefits**: Cross-platform path handling, null-safe APIs

## Key Features

- **CRUD Operations**: Create, read, update, delete wellness offerings
- **Form Validation**: Robust input validation with user feedback
- **Offline Storage**: All data persisted locally with SQLite
- **Reactive UI**: Instant updates using GetX observables
- **Clean UI**: Wellness-themed design with calming colors


## Project Decisions

**State Management**: Chose GetX over Provider/Riverpod for rapid development and built-in DI container.

**Database**: SQLite provides reliable offline storage without external services or complex setup.

**Architecture**: Clean Architecture ensures long-term maintainability despite initial complexity.

**UI Approach**: Custom widgets over heavy UI libraries to maintain design consistency and app size.

## Development Notes

**Clean Code Implementation:**
- Modular, maintainable codebase following SOLID principles
- Consistent naming conventions and code organization
- Comprehensive error handling and user feedback

**Flutter Expertise:**
- Custom UI components with Material Design
- Reactive state management using GetX
- Form validation and input handling
- Responsive design implementation

**Database Integration:**
- SQLite implementation with proper schema design
- CRUD operations with transaction handling
- Data persistence and retrieval strategies

**Architecture Demonstration:**
- Clean Architecture with clear layer separation
- Repository pattern for data abstraction
- Use case implementation for business logic
- Dependency injection for testable code