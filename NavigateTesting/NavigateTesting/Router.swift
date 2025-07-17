//
//  Router.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import Foundation

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
