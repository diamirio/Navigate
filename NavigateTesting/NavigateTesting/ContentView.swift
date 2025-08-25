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
    private var router = Router()
    
    var body: some View {
        ModalStack(path: $router.modalPath) {
            TabView(selection: $router.mainTab) {
                Tab("Home", systemImage: "house", value: .home) {
                    NavigationStack(path: $router.homeTabPath) {
                        FeatureAView()
                            .myNavigtationDestinations()
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    SheetLink(destination: .settings) {
                                        Image(systemName: "gearshape")
                                    }
                                }
                            }
                    }
                }
                
                Tab("Feature B", systemImage: "pencil", value: .tab) {
                    NavigationStack(path: $router.tabPath) {
                        FeatureBView()
                            .myNavigtationDestinations()
                    }
                }
            }
            .myModalDestinations()
        }
        .environment(router)
    }
}

extension View {
    
    /// SwiftUI navigation destination convenience
    func myNavigtationDestinations() -> some View {
        self.navigationDestination(for: MyDestination.self) { destination in
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
    
    /// All ModalDestinations wrapped in NavigationStack to support SwiftUI navigation and toolbar
    func myModalDestinations() -> some View {
        self.modalDestination(for: MyDestination.self) { destination in
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
            case .featureC:
                NavigationStack {
                    FeatureCView()
                        .myNavigtationDestinations()
                }
            case .featureD:
                NavigationStack {
                    FeatureDView()
                        .myNavigtationDestinations()
                }
            case .settings:
                NavigationStack {
                    SettingsView()
                        .myNavigtationDestinations()
                }
            case .profile:
                NavigationStack {
                    ProfileView()
                        .myNavigtationDestinations()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
