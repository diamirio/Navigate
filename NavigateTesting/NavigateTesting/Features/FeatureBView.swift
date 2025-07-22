//
//  FeatureBView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct FeatureBView: View {
    
    @Environment(Router.self)
    var router: Router
    
    var body: some View {
        List {
            NavigationLink(destination: .featureC) {
                Text("Go to feature C")
            }
            
            SheetLink(destination: .featureC) {
                Text("Sheet to feature C")
            }
            
            FullScreenCoverLink(destination: .featureC) {
                Text("FullScreenCover to feature C")
            }
        }
        .navigationTitle("Feature B")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FeatureBView()
}
