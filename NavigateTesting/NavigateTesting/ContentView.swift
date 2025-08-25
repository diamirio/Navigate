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




#Preview {
    ContentView()
}
