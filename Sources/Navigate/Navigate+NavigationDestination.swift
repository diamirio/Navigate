import SwiftUI

public extension View {
    func navigationDestination(for type: (some NavigationDestination).Type) -> some View {
        navigationDestination(for: type) { feature in
            feature.body
        }
    }
}
