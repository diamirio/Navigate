---
name: navigate
description: Integrate and use the Navigate SwiftUI navigation library (diamirio/Navigate) — NavigationDestination enums, ModalStack for stacked sheets and full-screen covers, SheetLink / FullScreenCoverLink, modalDestination registration, programmatic modal paths, onDismiss and dismissAllModals. Use when adding Navigate to an app or package, defining destinations, presenting or dismissing sheets/covers, wiring a router, testing navigation state, or debugging a modal that shows nothing or won't stack. Triggers on "Navigate", "ModalStack", "SheetLink", "FullScreenCoverLink", "ModalPathDestination", "modalDestination", "NavigationDestination".
---

# Navigate — integration & usage

Navigate is a small SwiftUI library that (1) lets you navigate by **values** from a shared
`NavigationDestination` enum, so feature modules never import each other, and (2) adds
`ModalStack`, which works like `NavigationStack` but for **sheets and full-screen covers
stacked on top of each other**, driven by a bindable path.

Source of truth: `Sources/Navigate/`. Working sample app: `NavigateTesting/` (see
`MainView.swift`, `Router.swift`, `Navigation/Destinations.swift`, `ResolvedDestinationView.swift`).

## 1. Add the dependency

Requirements: Swift tools 5.9+, Xcode 16+ (library uses `@Entry`), iOS 16 / macOS 13 / tvOS 16 /
watchOS 9 / visionOS 1.

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/diamirio/Navigate", from: "2.0.5"),
],
targets: [
    .target(name: "AppNavigation", dependencies: [
        .product(name: "Navigate", package: "Navigate"),
    ]),
]
```

In Xcode: File ▸ Add Package Dependencies… ▸ `https://github.com/diamirio/Navigate`.

Check the latest tag with `git ls-remote --tags https://github.com/diamirio/Navigate` before pinning.

## 2. Define destinations

Put the enum in a high-level module (e.g. `AppNavigation`) that every feature module can import.
Feature modules reference `.settings`, never `SettingsView` directly.

```swift
import Navigate

enum AppDestination: NavigationDestination {   // NavigationDestination = Hashable & Identifiable
    case home
    case settings
    case profile(userID: String)               // associated values are fine if Hashable

    var id: Self { self }
}
```

Rules:
- `id` must be `Hashable` (`Self` is the easy choice). Navigate force-casts `id` to `AnyHashable`.
- Modal path equality is based on the destination's hash, so two identical values are "the same" modal.
- You may have several destination enums (e.g. one per domain); each must be registered separately (step 4).

## 3. Add convenience initializers (copy per destination enum)

The library initializers take `any NavigationDestination`, which blocks dot-syntax (`.settings`).
Add these once per enum so call sites can write `SheetLink(destination: .settings)`:

```swift
import Navigate
import SwiftUI

extension NavigationLink where Destination == Never {
    init(destination: AppDestination, @ViewBuilder label: @escaping () -> Label) {
        self.init(value: destination, label: label)
    }
}

extension SheetLink {
    init(destination: AppDestination, @ViewBuilder label: @escaping () -> Label, onDismiss: (() -> Void)? = nil) {
        self.init(destination: destination as any NavigationDestination, label: label, onDismiss: onDismiss)
    }
}

#if !os(macOS)
extension FullScreenCoverLink {
    init(destination: AppDestination, @ViewBuilder label: @escaping () -> Label, onDismiss: (() -> Void)? = nil) {
        self.init(destination: destination as any NavigationDestination, label: label, onDismiss: onDismiss)
    }
}
#endif
```

`FullScreenCoverLink` and `ModalType.fullScreen` do not exist on macOS — guard with `#if !os(macOS)`.

## 4. Resolve and register destinations

One view maps destination → screen; two `View` extensions register it for push and modal navigation.

```swift
import Navigate
import SwiftUI

struct ResolvedDestinationView: View {
    let destination: AppDestination

    var body: some View {
        switch destination {
        case .home: HomeView()
        case .settings: SettingsView()
        case .profile(let id): ProfileView(userID: id)
        }
    }
}

extension View {
    /// Push navigation inside a NavigationStack
    func appNavigationDestinations() -> some View {
        navigationDestination(for: AppDestination.self) { ResolvedDestinationView(destination: $0) }
    }

    /// Modal navigation inside a ModalStack. Wrap in NavigationStack so modals get
    /// a toolbar and can push further.
    func appModalDestinations() -> some View {
        modalDestination(for: AppDestination.self) { destination in
            NavigationStack {
                ResolvedDestinationView(destination: destination)
                    .appNavigationDestinations()
            }
        }
    }
}
```

## 5. Install the ModalStack at the root

```swift
struct RootView: View {
    @State private var modalPath: [ModalPathDestination] = []

    var body: some View {
        ModalStack(path: $modalPath) {          // or ModalStack { ... } for internal state
            TabView {
                NavigationStack {
                    HomeView().appNavigationDestinations()
                }
                .tabItem { Label("Home", systemImage: "house") }
            }
            .appModalDestinations()             // register ALL modal destinations here
        }
    }
}
```

Critical rules:
- **Register `modalDestination(for:)` on the ModalStack's root content**, not inside presented
  modals. Registrations travel up via a preference key and are only read at the ModalStack
  root; registrations inside a sheet are never seen.
- Use **one** `ModalStack` near the app root. Every sheet/cover presented through it can present
  further sheets/covers; nesting is handled internally.
- `.navigationDestination(for:)` still must be applied inside each `NavigationStack`
  (including the one wrapping each modal, as shown in step 4).

## 6. Navigate

```swift
List {
    NavigationLink(destination: .settings) { Text("Push settings") }

    SheetLink(destination: .settings) {
        Text("Settings as sheet")
    } onDismiss: {
        print("settings sheet dismissed")
    }

    FullScreenCoverLink(destination: .profile(userID: "42")) {
        Text("Profile full screen")
    }
}
```

`SheetLink` / `FullScreenCoverLink` render as a `Button`; style them like one. They only work
inside a `ModalStack` (otherwise the tap does nothing).

### Programmatic presentation & dismissal (bound path)

Keep the path in a router and mutate it:

```swift
@Observable final class Router {
    var modalPath: [ModalPathDestination] = []
    var homePath: [AppDestination] = []
}

router.modalPath.append(ModalPathDestination(AppDestination.settings, type: .sheet))
router.modalPath.append(ModalPathDestination(AppDestination.home, type: .fullScreen, onDismiss: { … }))
router.modalPath.removeLast()   // dismiss topmost modal
router.modalPath = []           // dismiss everything (animated cascade)
```

Read what is on the stack: `router.modalPath.last?.unwrap(AppDestination.self)`, `.type`.

### Dismissal from inside a modal
- Top modal only: `@Environment(\.dismiss) private var dismiss` → `dismiss()`.
- All modals: `@Environment(\.dismissAllModals) private var dismissAllModals` → `dismissAllModals()`.
- `onDismiss` passed to a link / `ModalPathDestination` runs after that modal is dismissed
  (swipe, `dismiss()`, or path change).

## Testing

Navigation is state: test the router (or the reactor / view model) that changes `modalPath` and the navigation paths, with Swift Testing. Do not unit-test the SwiftUI presentation itself; cover that with UI tests if the flow is business-critical.

**Pitfall: `ModalPathDestination ==` ignores `type` and `onDismiss`.** Two entries with the same destination are equal whether one is a sheet and the other a full-screen cover. Never assert `modalPath == [ModalPathDestination(...)]`; unwrap the destination and check `type` separately:

```swift
import Navigate
import Testing
@testable import MyApp

@MainActor
struct RouterTests {
    @Test("Showing the profile presents it full screen")
    func showProfile() {
        // Given
        let sut = Router()

        // When
        sut.showProfile(userID: "42")

        // Then
        #expect(sut.modalPath.count == 1)
        #expect(sut.modalPath.last?.unwrap(AppDestination.self) == .profile(userID: "42"))
        #expect(sut.modalPath.last?.type == .fullScreen)
    }

    @Test("Logout dismisses all modals")
    func logoutDismissesAll() {
        // Given
        let sut = Router()
        sut.modalPath = [ModalPathDestination(AppDestination.settings, type: .sheet)]

        // When
        sut.logout()

        // Then
        #expect(sut.modalPath.isEmpty)
    }
}
```

- `onDismiss` runs only when SwiftUI dismisses the modal; removing an entry from the path in a unit test does not call it. Test the closure's effect by calling the handler the router passes in directly.
- `ModalType.fullScreen` is unavailable on macOS; guard full-screen tests with `#if !os(macOS)` in multi-platform packages.

## Troubleshooting

| Symptom | Cause / fix |
|---|---|
| Empty sheet, console prints `missing sheet destination modifier` | No `modalDestination(for: ThatEnum.self)` on the ModalStack root content. Register every destination enum there. |
| Tapping `SheetLink` does nothing | View isn't inside a `ModalStack`. |
| `SheetLink(destination: .foo)` doesn't compile ("cannot infer contextual base") | Missing convenience initializer for that enum (step 3). |
| `NavigationLink` inside a modal doesn't push | Modal content isn't wrapped in `NavigationStack` with `.navigationDestination` applied (step 4). |
| `FullScreenCoverLink` unavailable | Building for macOS — use `SheetLink` or `#if !os(macOS)`. |
| Second identical sheet not shown / odd identity | Path entries with equal destination values are equal; use associated values to distinguish. |

## Deprecated API

`topSheet(isPresented:presentOn:content:)` and `topFullScreenCover(...)` are deprecated UIKit-based
helpers. Migrate them to `ModalStack` + `SheetLink` / `FullScreenCoverLink` (or a path append).
