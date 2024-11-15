import SwiftUI

public extension View {
    func navigationDestination<D: NavigationDestination>(for type: D.Type) -> some View {
        navigationDestination(for: type) { feature in
            feature.body
        }
    }
}
