//
//  TopFullScreenCover.swift
//  Navigate
//
//  Created by Alexander Kauer on 29.11.24.
//

import SwiftUI

#if canImport(UIKit)
    import UIKit

    private struct TopFullScreenCover<CoverContent: View>: ViewModifier {
        @Binding
        var isPresented: Bool

        let presentOn: () -> UIViewController?
        let coverContent: () -> CoverContent

        @State
        private var presentedViewController: UIViewController?

        func body(content: Content) -> some View {
            content
                .onChange(of: isPresented) { _ in
                    if isPresented {
                        createCover()
                    } else {
                        presentedViewController = nil
                    }
                }
                .onChange(of: presentedViewController) { [oldValue = presentedViewController] newValue in
                    if let newValue {
                        presentOn()?.present(newValue, animated: true)
                    } else {
                        oldValue?.dismiss(animated: true)
                    }
                }
        }

        private func createCover() {
            let vc = UIHostingController(
                rootView: coverContent()
                    .onDisappear {
                        isPresented = false
                    }
            )
            vc.modalPresentationStyle = .fullScreen
            presentedViewController = vc
        }
    }

    public extension View {
        @ViewBuilder
        func topFullScreenCover(
            isPresented: Binding<Bool>,
            presentOn: @escaping () -> UIViewController?,
            @ViewBuilder content: @escaping () -> some View
        ) -> some View {
            modifier(TopFullScreenCover(isPresented: isPresented, presentOn: presentOn, coverContent: content))
        }
    }

    #if DEBUG

        private struct TopFullScreenCoverPreviewView: View {
            @State
            private var presentCover = false

            var body: some View {
                Button("Present") {
                    presentCover = true
                }
                .topFullScreenCover(isPresented: $presentCover) {
                    topViewController()
                } content: {
                    CoverPreviewView()
                }
            }

            private func topViewController() -> UIViewController? {
                var topViewController = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
                    .first(where: { $0.activationState == .foregroundActive })?.windows
                    .first(where: { $0.isKeyWindow })?
                    .rootViewController

                while topViewController?.presentedViewController != nil {
                    topViewController = topViewController?.presentedViewController
                }
                return topViewController
            }
        }

        private struct CoverPreviewView: View {
            @Environment(\.dismiss)
            private var dismiss

            var body: some View {
                ZStack {
                    Color.orange

                    VStack {
                        Text("Cover")

                        Button("Dismiss") {
                            dismiss()
                        }
                    }
                }
            }
        }

        #Preview {
            TopFullScreenCoverPreviewView()
        }

    #endif

#endif
