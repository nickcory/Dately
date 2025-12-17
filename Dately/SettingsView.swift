//
//  SettingsView.swift
//  Dately
//
//  Created by Nick Cory on 2/10/25.
//

import SwiftUI
import ServiceManagement

struct SettingsView: View {
    
    @ObservedObject var settings = SettingsStore.shared

    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)

            Toggle("Launch at Login", isOn: Binding(get: {settings.launchAtLogin}, set: {newValue in settings.setLaunchAtLogin(newValue)}))
                .padding(.bottom, 10)

            
            Toggle("Compact Display", isOn: $settings.compactDisplay)
            
            

            Spacer()

            
            // Footer - App Version and Copyright Info
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
        .frame(width: 350, height: 320) // Adjusted height to fit the new info
        .onAppear {
            let appService = SMAppService.mainApp
            settings.launchAtLogin = (appService.status == .enabled)
        }
    }
}

#Preview {
    SettingsView()
}
