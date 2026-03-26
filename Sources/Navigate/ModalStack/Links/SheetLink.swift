//
//  SheetLink.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

/// A view that controls a navigation presentation as a Sheet in a `ModalStack`
public struct SheetLink<Label: View>: View {
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
            presentSheet(destination, .sheet, onDismiss)
        } label: {
            label
        }
    }
}
