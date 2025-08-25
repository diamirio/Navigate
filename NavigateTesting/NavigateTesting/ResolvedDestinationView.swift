//
//  ResolvedDestinationView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 25.08.25.
//

import Navigate
import SwiftUI

struct ResolvedDestinationView: View {
    
    let destination: MyDestination
    
    var body: some View {
        switch destination {
        case .featureA:
            FeatureAView()
        case .featureB:
            FeatureBView()
        case .featureC:
            FeatureCView()
        case .featureD:
            FeatureDView()
        case .settings:
            SettingsView()
        case .profile:
            ProfileView()
        }
    }
}

extension View {
    /// SwiftUI navigation destination convenience
    func myNavigtationDestinations() -> some View {
        self.navigationDestination(for: MyDestination.self) { destination in
            ResolvedDestinationView(destination: destination)
        }
    }
    
    /// All ModalDestinations wrapped in NavigationStack to support SwiftUI navigation and toolbar
    func myModalDestinations() -> some View {
        self.modalDestination(for: MyDestination.self) { destination in
            NavigationStack {
                ResolvedDestinationView(destination: destination)
                    .myNavigtationDestinations()
            }
        }
    }
}
