//
//  SettingsView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            NavigationLink(destination: .subSettings) {
                Text("Sub-Settings")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
