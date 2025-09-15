# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
SharingGRDB is a lightweight, high-performance replacement for SwiftData, powered by SQLite. It provides modern Swift property wrappers for database operations with SwiftUI integration.

## Build Commands

### Standard Development
```bash
# Build the package
swift build

# Run tests
swift test

# Run tests with specific configuration
swift test -c debug
swift test -c release

# Build for release
swift build -c release

# Test on Linux
~/.swiftly/bin/swiftly run build --swift-sdk x86_64-swift-linux-musl
```

### Example Projects
```bash
# Build and test examples (default: Reminders app)
make xcodebuild

# Build specific example
xcodebuild -scheme CaseStudies -configuration Debug -skipMacroValidation

# Build with custom configuration
make SCHEME=SyncUps CONFIG=Release xcodebuild

# Available schemes: CaseStudies, SyncUps, Reminders
```

### Code Quality
```bash
# Lint code
swift format lint -s -p -r Sources Tests Package.swift

# Auto-format code
swift format format -p -r -i Sources Tests Package.swift
```

## Architecture

### Core Components
- **@FetchAll**: Observable property wrapper for fetching arrays of models (like SwiftData's @Query)
- **@FetchOne**: Observable property wrapper for single values or aggregates
- **@FetchKey**: Observable property wrapper for key-value queries
- **@Table**: Macro for defining database tables with type-safe columns

### Library Structure
- `SharingGRDB`: Main product combining all functionality with macros
- `SharingGRDBCore`: Core property wrappers without macros
- `SharingGRDBTestSupport`: Testing utilities and helpers
- `StructuredQueriesGRDB`: GRDB driver with SQL macro support
- `StructuredQueriesGRDBCore`: Database operations and query execution

### Key Patterns
1. **Dependency Injection**: Uses swift-dependencies for database access
2. **SQL-First**: Direct SQL queries via `#sql` macro with type safety
3. **Observable**: Automatic SwiftUI updates via swift-sharing
4. **Decodable Models**: Uses Swift's Codable for database mapping

### Testing Approach
- Unit tests use in-memory SQLite databases
- Integration tests verify query behavior and SwiftUI integration
- Example apps serve as comprehensive integration tests

## Important Notes
- This project uses a custom GRDB fork (doozMen/GRDB.swift) for Linux compatibility
- Swift 6 language mode is enabled - be careful with concurrency
- When adding features, maintain compatibility with iOS 13+
- The project prioritizes performance over convenience features