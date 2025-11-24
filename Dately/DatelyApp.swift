//
//  DatelyApp.swift
//  Dately
//
//  Created by Nick Cory on 10/7/24.
//

import SwiftUI

@main
struct DatelyApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            SettingsView()
        }
        
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var settingsWindow: NSWindow?
    
    // Enum for display modes
    enum DisplayMode {
        case week
        case day
        case both
    }
    
    var displayMode: DisplayMode = .week // Default display mode is "week"

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the menu bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let statusButton = statusItem?.button {
            // Set the initial title based on the default display mode (week)
            statusButton.title = getCurrentDisplay()

            // Create the menu for selecting display modes and quitting
            let menu = NSMenu()
            menu.addItem(NSMenuItem(title: "Show Day", action: #selector(showDay), keyEquivalent: "1"))
            menu.addItem(NSMenuItem(title: "Show Week", action: #selector(showWeek), keyEquivalent: "2"))
            menu.addItem(NSMenuItem(title: "Show Day and Week", action: #selector(showDayAndWeek), keyEquivalent: "3"))
            menu.addItem(NSMenuItem.separator())
            menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: ","))
            menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
            statusItem?.menu = menu

            // Timer to update the status bar every minute in case the day/week changes
            Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                statusButton.title = self.getCurrentDisplay()
            }
        }
    }

    // Function to get the current display based on the mode
    func getCurrentDisplay() -> String {
        switch displayMode {
        case .week:
            return getCurrentWeekNumber()
        case .day:
            return getCurrentDayOfYear()
        case .both:
            return "\(getCurrentDayOfYear()), \(getCurrentWeekNumber())"
        }
    }

    // Function to get the current week number
    func getCurrentWeekNumber() -> String {
        let calendar = Calendar.current
        let today = Date()
        let weekOfYear = calendar.component(.weekOfYear, from: today)
        return "Week \(weekOfYear)"
    }

    // Function to get the current day of the year
    func getCurrentDayOfYear() -> String {
        let calendar = Calendar.current
        let today = Date()
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: today) ?? 0
        return "Day \(dayOfYear)"
    }

    // Functions to change the display mode
    @objc func showWeek() {
        displayMode = .week
        updateStatusBarTitle()
    }

    @objc func showDay() {
        displayMode = .day
        updateStatusBarTitle()
    }

    @objc func showDayAndWeek() {
        displayMode = .both
        updateStatusBarTitle()
    }

    // Update the status bar title based on the selected display mode
    func updateStatusBarTitle() {
        if let statusButton = statusItem?.button {
            statusButton.title = getCurrentDisplay()
        }
    }
    
    @objc func openSettings() {
            if settingsWindow == nil {
                let settingsView = SettingsView()
                let hostingController = NSHostingController(rootView: settingsView)

                settingsWindow = NSWindow(
                    contentRect: NSMakeRect(0, 0, 600, 450),
                    styleMask: [.titled, .closable, .resizable],
                    backing: .buffered,
                    defer: false
                )
                settingsWindow?.contentViewController = hostingController
                settingsWindow?.center()

                settingsWindow?.isReleasedWhenClosed = false  // Prevent auto-deallocation
                settingsWindow?.delegate = self  // Handle window close
            }

            settingsWindow?.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }

        @objc func quitApp() {
            NSApplication.shared.terminate(nil)
        }
    }

    // MARK: - NSWindowDelegate (Handles Window Closing)
    extension AppDelegate: NSWindowDelegate {
        func windowWillClose(_ notification: Notification) {
            settingsWindow = nil  // Allow new window creation next time
        }
    }
