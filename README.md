<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/c629b97b-ca4b-428f-8147-e6846a30bc40">
  <img alt="DIAMIR Logo" src="https://github.com/user-attachments/assets/d41a2076-fc04-4e1b-a260-9832025bf69d ">
</picture>

# Navigate

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

## Usage

Define your possible destinations in one or more enum (depending on the structure of your app) like follows:

```swift
enum MainNavigationDestination: NavigationDestination {
    case home
    case detailCard(id: Int)
    case settings

    var id: Self { self }

    @MainActor
    var body: some View {
        switch self {
        case .home:
            HomeView()

        case let .detailCard(id):
            DetailCardView(id: id)

        case .settings:
            SettingsView()
        }
    }
}
```

Those `MainNavigationDestination` need to be applied to the first element within a `NavigationStack`.

```swift
extension View {
    func navigationDestinationMain() -> some View {
        navigationDestination(for: MainNavigationDestination.self)
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
