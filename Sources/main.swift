import Cocoa

// Create and run the menu bar app
let app = NSApplication.shared
let delegate = MenuBarApp()
app.delegate = delegate

// Run the app
app.run() 