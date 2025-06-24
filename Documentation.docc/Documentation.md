# ``Navigate``

Navigate is a Swift navigation library that enables high-level modularization using `NavigationDestination` protocol. It introduces `ModalStack`, which works exactly like SwiftUI `NavigationStack` and allows you to display multiple **Sheets** and **FullScreenCovers** on top of each other.

## Overview

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

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- ``NavigationDestination``
