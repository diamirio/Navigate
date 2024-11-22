<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/c629b97b-ca4b-428f-8147-e6846a30bc40">
  <img alt="DIAMIR Logo" src="https://github.com/user-attachments/assets/d41a2076-fc04-4e1b-a260-9832025bf69d ">
</picture>

# Navigate

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

## Usage

First of all you define your possible in one or more enums (depending on the structure of your app) like follows:

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
