//
//  FeatureCView.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

struct FeatureCView: View {
    
    @Environment(Router.self)
    var router: Router
    
    var body: some View {
        List {
            NavigationLink(destination: .featureD) {
                Text("Go to feature D")
            }
            
            SheetLink(destination: .featureD) {
                Text("Sheet to feature D")
            }
            
            FullScreenCoverLink(destination: .featureD) {
                Text("FullScreenCover to feature D")
            }
        }
        .navigationTitle("Feature C")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FeatureBView()
}
