//
//  FeatureBView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct FeatureBView: View {
    var body: some View {
        List {
            NavigationLink(destination: .featureC) {
                Text("Go to feature C")
            }
            
            SheetLink(destination: .featureC) {
                Text("Sheet to feature C")
            } onDismiss: {
                print("Sheet to feature C dismissed")
            }
            
            FullScreenCoverLink(destination: .featureC) {
                Text("FullScreenCover to feature C")
            } onDismiss: {
                print("FullScreenCover to feature C dismissed")
            }
        }
        .navigationTitle("Feature B")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FeatureBView()
}
