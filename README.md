<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/c629b97b-ca4b-428f-8147-e6846a30bc40">
  <img alt="DIAMIR Logo" src="https://github.com/user-attachments/assets/d41a2076-fc04-4e1b-a260-9832025bf69d ">
</picture>

# Navigate

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

Navigate is a Swift navigation library that enables high-level modularization using `NavigationDestination` protocol. It introduces `ModalStack`, which works exactly like SwiftUI `NavigationStack` and allows you to display multiple **Sheets** and **FullScreenCovers** on top of each other.

## Usage

Define your possible destinations in a higher level package in one or more enums.

```swift
import Navigate

public enum MainNavigationDestination: NavigationDestination {
    case home
    case detailCard(id: Int)
    case settings

    public var id: Self { self }
}
```

Those `MainNavigationDestination` need to be applied to the first element within a `NavigationStack`.

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

### Convenience



### TopSheet and TopFullScreenCover

As there is no out-of-the-box way for SwiftUI to display sheets or fullScreenCovers globally without dismissing current presented sheets we added `TopSheet` and `TopFullScreenCover` to the Navigate API.

Usage: 

```swift
view.topSheet(
    destination: $destination, 
    presentOn: { UIViewController() }
)
```