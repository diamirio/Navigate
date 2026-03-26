//
//  FeatureCView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct FeatureCView: View {
    var body: some View {
        List {
            NavigationLink(destination: .featureD) {
                Text("Go to feature D")
            }
            
            SheetLink(destination: .featureD) {
                Text("Sheet to feature D")
            } onDismiss: {
                print("Sheet to feature D dismissed")
            }
            
            FullScreenCoverLink(destination: .featureD) {
                Text("FullScreenCover to feature D")
            } onDismiss: {
                print("FullScreenCover to feature D dismissed")
            }
        }
        .navigationTitle("Feature C")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FeatureCView()
}
