//
//  SettingsStore.swift
//  Dately
//
//  Created by Nick Cory on 11/23/25.
//

import Foundation
import Combine

class SettingsStore: ObservableObject {
    static let shared = SettingsStore()
    
    private init () {
        self.compactDisplay = UserDefaults.standard.bool(forKey: "compactDisplay")
    }
    
    @Published var compactDisplay: Bool {
        didSet {
            UserDefaults.standard.set(compactDisplay, forKey: "compactDisplay")
        }
    }
}
