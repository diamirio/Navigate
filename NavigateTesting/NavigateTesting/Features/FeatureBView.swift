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
        Text("Feature B")
        
        SheetLink(destination: .featureB) {
            Text("Feature B again ...")
        }
        
        Button("Dismiss all") {
            router.homeTabPath = []
            router.tabPath = []
            router.modalPath = []
        }
    }
}

#Preview {
    FeatureBView()
}
