//
//  ModalStack.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

public struct ModalStack<Root: View>: View {
	private let root: Root
    
    private var path: Binding<[ModalPathDestination]> {
        externalPath ?? $internalPath
    }
    
    private let externalPath: Binding<[ModalPathDestination]>?
    
	@State
    private var internalPath = [ModalPathDestination]()
    
	@State
    private var mapping = ModalMappingStorage()

	public init(path: Binding<[ModalPathDestination]>, @ViewBuilder _ root: () -> Root) {
		self.externalPath = path
		self.root = root()
	}

	public init(@ViewBuilder _ root: () -> Root) {
        self.externalPath = nil
		self.root = root()
	}
	
	private func presentSheet(_ destination: any NavigationDestination, type: ModalType) {
        path.wrappedValue.append(ModalPathDestination(destination, type: type))
	}
	
	private func dismissAll() {
		path.wrappedValue.removeAll()
	}
	
	public var body: some View {
		root
			.onPreferenceChange(ModalMappingPreferenceKey.self) { mapping in
				self.mapping = mapping
			}
			.modifier(SheetModifier(path: path, idx: 0, mapping: mapping))
        #if !os(macOS)
			.modifier(FullScreenCoverModifier(path: path, idx: 0, mapping: mapping))
        #endif
			.environment(\.presentSheet, presentSheet)
			.environment(\.dismissAllModals, dismissAll)
	}
}
