//
//  SettingsView.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 20/3/24.
//

import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
    var body: some View {
        VStack {
            Image(systemName: "gear")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Settings")
            LaunchAtLogin.Toggle {
                Text("Launch at login")
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
