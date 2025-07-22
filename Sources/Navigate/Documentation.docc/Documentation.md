# ``Navigate``
Simple navigation for SwiftUI

## Overview
Navigate is a Swift navigation library that enables high-level modularization using `NavigationDestination` protocol. It introduces `ModalStack`, which works exactly like SwiftUI `NavigationStack` and allows you to display multiple **Sheets** and **FullScreenCovers** on top of each other.

@Image(source: dismiss-all, alt: "Dismiss all animation with path binding.")

### Define your destinations
Define your possible destinations in a higher level package in one or more enums.

```swift
import Navigate

enum MyDestination: NavigationDestination {
    case featureA
    case featureB
    case settings
    case subSettings
    
    var id: Self { self }
}
```
#### Convenience
To be able to write shortenings for your custom destinations, convenience initializers are necessary. These code can be copied from below and adopted accordingly.

```swift
extension NavigationLink where Destination == Never {
    
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(value: destination, label: label)
    }
}

extension SheetLink {
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(destination: destination as any NavigationDestination, label: label)
    }
}

extension FullScreenCoverLink {
    /// NavigationLink init for `Navigate` framework
    /// - Parameters:
    ///   - destination: The `NavigationDestination` to navigate to
    ///   - label: The label for the `NavigationLink`
    init(destination: MyDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(destination: destination as any NavigationDestination, label: label)
    }
}
```

#### NavigationStack & ModalStack
Those `MyDestination`s need to be applied to the first element within a `ModalStack` similar to SwiftUI's `NavigationStack`.


```swift
import Navigate

// Import your corresponding views if needed
import FeatureHome 
import FeatureCard
import FeatureSettings

extension View {
    func navigationDestinationMain() -> some View {
        navigationDestination(for: MainNavigationDestination.self) { destination in
            switch destination {
                case .home: HomeView()
                case .detailCard(let id): DetailCard(for: id)
                case .settings: SettingsView()
            }
        }
    }
}
```

Example View:

```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            MainView()
                .navigationDestinationMain()
        }
    }
}
```

Use it in NavigationLink and sheet

```swift
struct MainView: View {

    @State 
    var showSheet = false

    var body: some View {
        List {
            NavigationLink(
                destination: NewsNavigationDestination.detailCard(id: 1)
            ) {
                Text("Click me")
            }
        }
        .sheet(
            destination: MainNavigationDestination.settings, 
            isPresented: $showSheet
        )
    }
}
```

The `.sheet(...)` and `.fullScreenCover(...)` modifier also contain some convenience paramters like `withNavigationStack` or `onDismiss`.

## Components

- ``NavigationDestination``
- ``ModalStack``
- ``SheetLink``
- ``FullScreenCoverLink``
- ``ModalPathDestination``
