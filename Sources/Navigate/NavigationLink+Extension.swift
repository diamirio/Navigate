import SwiftUI

public extension NavigationLink where Destination == Never {
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: some NavigationDestination, @ViewBuilder label: () -> Label) {
        self.init(value: destination, label: label)
    }
}
