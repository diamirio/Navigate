//
//  FeatureAView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct FeatureAView: View {
    var body: some View {
        List {
            NavigationLink(destination: .featureB) {
                Text("Go to feature B")
            }
            
            SheetLink(destination: .featureB) {
                Text("Sheet to feature B")
            }
            
            FullScreenCoverLink(destination: .featureB) {
                Text("FullScreenCover to feature B")
            }
        }
        .navigationTitle("Feature A")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FeatureAView()
}
