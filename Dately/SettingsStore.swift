//
//  SettingsStore.swift
//  Dately
//
//  Created by Nick Cory on 11/23/25.
//

import Foundation
import Combine
import ServiceManagement

final class SettingsStore: ObservableObject {
    static let shared = SettingsStore()

    @Published var compactDisplay: Bool {
        didSet {
            UserDefaults.standard.set(compactDisplay, forKey: "compactDisplay")
        }
    }
    
    @Published var launchAtLogin: Bool = false

    private init() {
        // Restore compact display preference
        self.compactDisplay = UserDefaults.standard.bool(forKey: "compactDisplay")

        // Always safe to use on macOS 15+
        let appService = SMAppService.mainApp
        self.launchAtLogin = (appService.status == .enabled)
    }

    func setCompactDisplay(_ enabled: Bool) {
        compactDisplay = enabled
    }

    func setLaunchAtLogin(_ enabled: Bool) {
        let appService = SMAppService.mainApp

        do {
            if enabled {
                try appService.register()
            } else {
                try appService.unregister()
            }
            self.launchAtLogin = (appService.status == .enabled)
        } catch {
            print("Failed to \(enabled ? "enable" : "disable") launch at login: \(error)")
        }
    }
}
