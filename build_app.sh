#!/bin/bash

# Build script for Letter Clock macOS app

APP_NAME="Letter Clock"
APP_DIR="$APP_NAME.app"
BUNDLE_IDENTIFIER="com.letterdev.letter-clock"

echo "Building Letter Clock app..."

# Clean previous build
rm -rf "$APP_DIR"

# Build the Swift executable
swift build --configuration release

# Create app bundle structure
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"

# Copy executable
cp .build/release/letter-clock "$APP_DIR/Contents/MacOS/"

# Copy Info.plist
cp Info.plist "$APP_DIR/Contents/"

# Make executable
chmod +x "$APP_DIR/Contents/MacOS/letter-clock"

echo "✅ App built successfully: $APP_DIR"
echo ""
echo "To install:"
echo "1. Drag '$APP_DIR' to your Applications folder"
echo "2. Open System Preferences > Users & Groups > Login Items"
echo "3. Click '+' and add 'Letter Clock' from Applications"
echo ""
echo "Or run directly: open '$APP_DIR'" 