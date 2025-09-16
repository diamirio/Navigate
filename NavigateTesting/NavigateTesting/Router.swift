//
//  Router.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import Foundation
import SwiftUI

@Observable
class Router {
    var mainTab: MainTab = .home
    
    var modalPath: [ModalPathDestination] = []
    
    var homeTabPath: [MyDestination] = []
    var tabPath: [MyDestination] = []
}

enum MainTab {
    case home
    case tab
}

extension View {
    
    /// View extension for convinient previews
    @ViewBuilder
    func previewRouter() -> some View {
        @State
        var router = Router()
        
        self.environment(router)
    }
}
