//
//  FullScreenCoverLink.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

#if !os(macOS)
/// A view that controls a navigation presentation as a FullScreenCover in a `ModalStack`
public struct FullScreenCoverLink<Label: View>: View {
    let label: Label
    let destination: any NavigationDestination
    
    @Environment(\.presentSheet)
    private var presentSheet
    
    public init(destination: any NavigationDestination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        Button {
            presentSheet(destination, .fullScreen)
        } label: {
            label
        }
    }
}
#endif
