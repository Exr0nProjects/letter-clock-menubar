# Letter Clock - macOS Menu Bar App

## Project Overview
(agent:init) A simple macOS menu bar application built with Swift and AppKit. The app appears as an icon in the menu bar and provides a dropdown menu with basic functionality.

## Architecture Decisions
(agent:init) Using Swift with AppKit for native macOS integration and robustness
(agent:init) NSStatusBar for menu bar integration - the standard, well-supported approach
(agent:init) Keeping the project structure simple with minimal dependencies

## How to Run
(agent:init) Build and run: `swift run` or open in Xcode and run directly
(agent:init) App displays custom alphanumeric timestamp format in menu bar: "Day YYMDHM.HM" (e.g., "Wed 25HJ.VD")
(agent:init) Uses proper base64 encoding for compact time representation with auto-updating display
(agent:init) Efficient alarm-based timer system schedules updates for exact minute boundaries (not polling)
(agent:init) Packaging: `./build_app.sh` creates proper .app bundle, `./install.sh` installs to Applications folder
(agent:init) Can be added to Login Items for automatic startup - includes proper Info.plist with LSUIElement=true

## Project Structure
(agent:init) `Sources/` - Main Swift source files
(agent:init) `Package.swift` - Swift package configuration
(agent:init) `Sources/main.swift` - Entry point and menu bar setup
(agent:init) `Sources/MenuBarApp.swift` - Main app class with menu bar logic
(agent:init) `Info.plist` - macOS app bundle configuration (LSUIElement=true for menu bar only)
(agent:init) `build_app.sh` - Script to build .app bundle for distribution
(agent:init) `install.sh` - Script to install app to Applications folder 