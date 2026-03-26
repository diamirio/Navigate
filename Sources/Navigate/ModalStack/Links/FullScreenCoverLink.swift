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
    private let label: Label
    private let destination: any NavigationDestination
    private let onDismiss: (() -> Void)?
    
    @Environment(\.presentSheet)
    private var presentSheet
    
    public init(destination: any NavigationDestination, @ViewBuilder label: () -> Label, onDismiss: (() -> Void)? = nil) {
        self.destination = destination
        self.label = label()
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        Button {
            presentSheet(destination, .fullScreen, onDismiss)
        } label: {
            label
        }
    }
}
#endif
