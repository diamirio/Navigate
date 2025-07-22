//
//  SettingsView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    var body: some View {
        List {
            NavigationLink(destination: .profile) {
                Text("Profile")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
