//
//  ContentView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct ContentView: View {
    
    @State
    var router = Router()
    
    var body: some View {
        ModalStack(path: $router.modalPath) {
            TabView(selection: $router.mainTab) {
                Tab("Home", systemImage: "house", value: .home) {
                    NavigationStack(path: $router.homeTabPath) {
                        FeatureAView()
                            .myNavigtationDestinations()
                    }
                }
                
                Tab("Tab", systemImage: "pencil", value: .tab) {
                    NavigationStack(path: $router.tabPath) {
                        FeatureAView()
                            .myNavigtationDestinations()
                    }
                }
            }
            .modalDestination(for: MyDestination.self) { destination in
                switch destination {
                case .featureA:
                    NavigationStack {
                        FeatureAView()
                            .myNavigtationDestinations()
                    }
                case .featureB:
                    NavigationStack {
                        FeatureBView()
                            .myNavigtationDestinations()
                    }
                case .settings:
                    NavigationStack {
                        SettingsView()
                            .myNavigtationDestinations()
                    }
                case .subSettings:
                    NavigationStack {
                        SubSettingsView()
                            .myNavigtationDestinations()
                    }
                }
            }
        }
        .environment(router)
    }
}

extension View {
    func myNavigtationDestinations() -> some View {
        self.navigationDestination(for: MyDestination.self) { destination in
            switch destination {
            case .featureA:
                FeatureAView()
            case .featureB:
                FeatureBView()
            case .settings:
                SettingsView()
            case .subSettings:
                SubSettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
