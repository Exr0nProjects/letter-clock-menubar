import Cocoa

class MenuBarApp: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem?
    private var timer: Timer?
    private var currentMinute: Int = -1
    
    // Custom base64 character set (matching your bash script)
    private let base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status item in menu bar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Set the menu bar button properties
        if let button = statusItem?.button {
            button.toolTip = "Letter Clock"
            // We'll set the title instead of image for our custom format
            updateTimeDisplay()
        }
        
        // Start smart timer system
        startSmartTimer()
        
        // Create and set the menu
        let menu = NSMenu()
        
        // Add menu items
        menu.addItem(NSMenuItem(title: "Show Time", action: #selector(showTime), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "About Letter Clock", action: #selector(showAbout), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        
        // Set menu targets
        for item in menu.items {
            item.target = self
        }
        
        statusItem?.menu = menu
        
        // Keep the app running (don't show in dock)
        NSApp.setActivationPolicy(.accessory)
    }
    
    // Convert decimal to custom base64 (matching bash script logic)
    private func decimalToCustomBase64(_ num: Int) -> String {
        if num == 0 {
            return "A"  // First character for 0 (proper base64)
        }
        
        var result = ""
        var number = num
        
        while number > 0 {
            let remainder = number % 64
            let char = base64Chars[base64Chars.index(base64Chars.startIndex, offsetBy: remainder)]
            result = String(char) + result
            number /= 64
        }
        
        return result
    }
    
    // Smart timer system - schedule alarm for exact minute boundaries
    private func startSmartTimer() {
        let now = Date()
        let calendar = Calendar.current
        
        // Calculate the next minute boundary
        let nextMinute = calendar.nextDate(after: now, matching: DateComponents(second: 0), matchingPolicy: .nextTime)!
        
        // Update current minute tracking
        currentMinute = calendar.component(.minute, from: now)
        
        // Schedule timer to fire exactly at the next minute boundary
        timer = Timer(fire: nextMinute, interval: 0, repeats: false) { _ in
            self.updateTimeDisplay()
            self.startSmartTimer() // Schedule the next alarm
        }
        
        // Add to run loop
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // Update the time display in menu bar
    private func updateTimeDisplay() {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        
        // Get day abbreviation (Wed, Thu, etc.)
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEE"
        let dayAbbr = dayFormatter.string(from: now)
        
        // Get components (matching bash script logic)
        let year = (components.year! % 100)  // Last 2 digits
        let month = components.month!
        let day = components.day!
        let hour = components.hour!
        let minute = components.minute!
        
        // Convert to custom base64
        let monthB64 = decimalToCustomBase64(month)
        let dayB64 = decimalToCustomBase64(day)
        let hourB64 = decimalToCustomBase64(hour)
        let minuteB64 = decimalToCustomBase64(minute)
        
        // Create timestamp: Day YYMDHM.HM (with day abbreviation)
        let timestamp = String(format: "%@ %02d%@%@.%@%@", dayAbbr, year, monthB64, dayB64, hourB64, minuteB64)
        
        // Update menu bar title
        statusItem?.button?.title = timestamp
    }
    
    @objc func showTime() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        let alert = NSAlert()
        alert.messageText = "Current Time"
        alert.informativeText = formatter.string(from: Date())
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc func showAbout() {
        let alert = NSAlert()
        alert.messageText = "About Letter Clock"
        alert.informativeText = "A simple menu bar app for macOS\nBuilt with Swift and AppKit\n\nDisplays time in compact alphanumeric format"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc func quitApp() {
        timer?.invalidate()
        NSApplication.shared.terminate(nil)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        timer?.invalidate()
    }
} 