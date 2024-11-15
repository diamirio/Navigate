import SwiftUI

/// A type that represents a possible NavigationDestination in your app
public protocol NavigationDestination<Body>: Hashable, Identifiable {
    associatedtype Body: View

    @ViewBuilder
    var body: Body { get }
}

public extension View {
    
    /// FullScreenCover of `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to show in fullscreen cover
    ///   - onDismiss: dismiss callback
    /// - Returns: The view appended with the fullScreenCover
    func fullScreenCover<Destination: NavigationDestination>(
        destination: Binding<Destination?>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        fullScreenCover(item: destination, onDismiss: onDismiss, content: { $0.body })
    }
}
