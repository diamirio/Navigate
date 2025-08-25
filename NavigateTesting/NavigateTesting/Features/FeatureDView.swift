//
//  FeatureDView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct FeatureDView: View {
    
    @Environment(Router.self)
    var router: Router
    
    var body: some View {
        List {
            Button("Dismiss modal path") {
                router.homeTabPath = []
                router.tabPath = []
                router.modalPath = []
            }
        }
        .navigationTitle("Feature D")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FeatureBView()
}
