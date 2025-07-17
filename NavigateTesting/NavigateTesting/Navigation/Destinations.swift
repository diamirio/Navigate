//
//  Destinations.swift
//  NavigateTesting
//
//  Created by Alexander Kauer on 17.07.25.
//

import Navigate
import SwiftUI

enum MyDestination: NavigationDestination {
    case featureA
    case featureB
    case settings
    case subSettings
    
    var id: Self { self }
}
    
extension NavigationLink where Destination == Never {
    
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(value: destination, label: label)
    }
}

extension SheetLink {
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(destination: destination as any NavigationDestination, label: label)
    }
}
