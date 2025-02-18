import SwiftUI

public extension View {
    /// Sheet of `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to show in sheet
    ///   - onDismiss: dismiss callback
    /// - Returns: Returns: The view appended with the sheet
    func sheet(
        destination: Binding<(some NavigationDestination)?>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        sheet(item: destination, onDismiss: onDismiss, content: { $0.body })
    }

    /// Sheet of `Navigate` framework with additional convenience options
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to show in sheet
    ///   - withNavigationStack: Boolean value indicating if the sheet should come with a `NavigationStack`
    ///   - navigationPath: Optional `NavigationPath` binding. Only applicable if `withNavigationStack` is true
    ///   - isPresented: Presentation binding
    ///   - onDismiss: dismiss callback
    /// - Returns: The view appended with the sheet
    func sheet<Destination: NavigationDestination>(
        destination: Destination,
        withNavigationStack: Bool = false,
        navigationPath: Binding<[Destination]>? = nil,
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        sheet(isPresented: isPresented, onDismiss: onDismiss) {
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
