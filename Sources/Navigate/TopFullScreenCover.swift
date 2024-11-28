//
//  Navigate+TopFullScreenCover.swift
//  Navigate
//
//  Created by Alexander Kauer on 28.11.24.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

private struct TopFullScreenCoverNavigate<Destination: NavigationDestination>: ViewModifier {
    @Binding
    var destination: Destination?

    let presentOn: () -> UIViewController?

    @State
    private var presentedViewController: UIViewController?

    func body(content: Content) -> some View {
        content
            .onChange(of: destination) { _ in
                if let destination {
                    createCover(for: destination)
                } else {
                    presentedViewController = nil
                }
            }
            .onChange(of: presentedViewController) { [oldValue = presentedViewController] newValue in
                if let newValue {
                    presentOn()?.present(newValue, animated: true)
                } else {
                    oldValue?.dismiss(animated: true)
                }
            }
    }

    private func createCover(for destination: Destination) {
        let vc = UIHostingController(
            rootView: destination.body
                .onDisappear {
                    self.destination = nil
                }
        )
        vc.modalPresentationStyle = .fullScreen
        presentedViewController = vc
    }
}

public extension View {
    @ViewBuilder
    func topFullScreenCover<Destination: NavigationDestination>(
        destination: Binding<Destination?>,
        presentOn: @escaping () -> UIViewController?
    ) -> some View  {
        modifier(TopFullScreenCoverNavigate(destination: destination, presentOn: presentOn))
    }
}

#endif
