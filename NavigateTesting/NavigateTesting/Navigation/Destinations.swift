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
    case featureC
    case featureD
    case settings
    case profile
    
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
    /// SheetLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    ///   - onDismiss: Closure to be called when the SheetLink is dismissed
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label, onDismiss: (() -> Void)? = nil) {
        self.init(destination: destination as any NavigationDestination, label: label, onDismiss: onDismiss)
    }
}

extension FullScreenCoverLink {
    /// FullScreenCoverLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    ///   - onDismiss: Closure to be called when the FullScreenCoverLink is dismissed
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label, onDismiss: (() -> Void)? = nil) {
        self.init(destination: destination as any NavigationDestination, label: label, onDismiss: onDismiss)
    }
}

