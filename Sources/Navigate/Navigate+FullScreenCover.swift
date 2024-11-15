import SwiftUI

@available(macOS, unavailable)
public extension View {
    /// FullScreenCover of `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to show in fullscreen cover
    ///   - onDismiss: dismiss callback
    /// - Returns: The view appended with the fullScreenCover
    func fullScreenCover(
        destination: Binding<(some NavigationDestination)?>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        fullScreenCover(item: destination, onDismiss: onDismiss, content: { $0.body })
    }
}
