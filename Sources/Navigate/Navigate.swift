import SwiftUI

/// A type that represents a possible NavigationDestination in your app
public protocol NavigationDestination<Body>: Hashable, Identifiable {
    associatedtype Body: View

    @ViewBuilder
    var body: Body { get }
}
