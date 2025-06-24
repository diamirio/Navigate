import Testing
import SwiftUI
@testable import Navigate

enum TestNavigationDestination: NavigationDestination {
    case home
    case detail(id: Int)

    var id: Self { self }
}

extension NavigationLink where Destination == Never {
    
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: TestNavigationDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(value: destination, label: label)
    }
}

extension SheetLink {
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: TestNavigationDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(destination: destination as any NavigationDestination, label: label)
    }
}

@MainActor
@Test func example() async throws {
    _ = SheetLink(destination: .detail(id: 1)) {
        Text("some detail")
    }
    
    _ = NavigationLink(destination: .detail(id: 1)) {
        Text("some detail")
    }
}
