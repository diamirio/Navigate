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

    /// FullScreenCover of `Navigate` framework with additional convenience options
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to show in fullscreen cover
    ///   - withNavigationStack: Boolean value indicating if the sheet should come with a `NavigationStack`
    ///   - navigationPath: Optional `NavigationPath` binding. Only applicable if `withNavigationStack` is true
    ///   - isPresented: Presentation binding
    ///   - onDismiss: dismiss callback
    /// - Returns: The view appended with the sheet
    func fullScreenCover<Destination: NavigationDestination>(
        destination: Destination,
        withNavigationStack: Bool = false,
        navigationPath: Binding<[Destination]>? = nil,
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        fullScreenCover(isPresented: isPresented, onDismiss: onDismiss) {
            if withNavigationStack, let navigationPath {
                NavigationStack(path: navigationPath) {
                    destination.body
                }
            } else if withNavigationStack {
                NavigationStack {
                    destination.body
                }
            } else {
                destination.body
            }
        }
    }
}
