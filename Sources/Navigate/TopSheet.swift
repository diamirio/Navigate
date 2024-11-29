//
//  TopSheet.swift
//  Navigate
//
//  Created by Alexander Kauer on 29.11.24.
//

import SwiftUI

#if canImport(UIKit)
    import UIKit

    private struct TopSheet<SheetContent: View>: ViewModifier {
        @Binding
        var isPresented: Bool

        let presentOn: () -> UIViewController?
        let sheetContent: () -> SheetContent

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
                rootView: sheetContent()
                    .onDisappear {
                        isPresented = false
                    }
            )
            vc.modalPresentationStyle = .pageSheet
            presentedViewController = vc
        }
    }

    public extension View {
        @ViewBuilder
        func topSheet(
            isPresented: Binding<Bool>,
            presentOn: @escaping () -> UIViewController?,
            @ViewBuilder content: @escaping () -> some View
        ) -> some View {
            modifier(TopSheet(isPresented: isPresented, presentOn: presentOn, sheetContent: content))
        }
    }

    #if DEBUG

        private struct TopSheetPreviewView: View {
            @State
            private var presentCover = false

            var body: some View {
                Button("Present") {
                    presentCover = true
                }
                .topSheet(isPresented: $presentCover) {
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
            @Environment(\.presentationMode)
            private var presentationMode

            var body: some View {
                ZStack {
                    Color.orange

                    VStack {
                        Text("Cover")

                        Button("Dismiss") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }

        #Preview {
            TopSheetPreviewView()
        }

    #endif

#endif
