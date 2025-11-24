//
//  SettingsView.swift
//  Dately
//
//  Created by Nick Cory on 2/10/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var launchAtStartup = false
    @State private var shortcutKeys = "⌘ + 1"

    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)

            Toggle("Launch at Startup", isOn: $launchAtStartup)
                .padding(.bottom, 10)

            HStack {
                Text("Shortcut Keys:")
                Spacer()
                Text(shortcutKeys)
                    .font(.headline)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
            }

            Spacer()

            // App Version and Copyright Info
            VStack {
                Divider()
                Text("Dately Version \(appVersion) (Build \(appBuild))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                Text("© 2025 nickcory.dev")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
        }
        .padding(20)
        .frame(width: 350, height: 220) // Adjusted height to fit the new info
    }
}

#Preview {
    SettingsView()
}
