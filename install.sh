#!/bin/bash

# Install Letter Clock to Applications folder

APP_NAME="Letter Clock"
APP_DIR="$APP_NAME.app"
APPLICATIONS_DIR="/Applications"

echo "Installing Letter Clock..."

# Check if app exists
if [ ! -d "$APP_DIR" ]; then
    echo "❌ Error: $APP_DIR not found. Run ./build_app.sh first."
    exit 1
fi

# Copy to Applications
echo "Copying to Applications folder..."
cp -r "$APP_DIR" "$APPLICATIONS_DIR/"

# Verify installation
if [ -d "$APPLICATIONS_DIR/$APP_DIR" ]; then
    echo "✅ Letter Clock installed successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Open System Preferences (or System Settings on macOS 13+)"
    echo "2. Go to Users & Groups > Login Items (or General > Login Items)"
    echo "3. Click '+' and add 'Letter Clock' from Applications"
    echo "4. The app will now start automatically when you log in"
    echo ""
    echo "To start now: open -a 'Letter Clock'"
else
    echo "❌ Installation failed"
    exit 1
fi 