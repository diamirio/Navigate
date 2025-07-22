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
        Text("Feature A")
        
        NavigationLink(destination: .featureB) {
            Text("Go to feature b")
        }
        
        SheetLink(destination: .featureB) {
            Text("Sheet to feature b")
        }
        
        FullScreenCoverLink(destination: .settings) {
            Text("Go to settings :)")
        }
    }
}

#Preview {
    FeatureAView()
}
