//
//  ModalStack.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

public struct ModalStack<Root: View>: View {
	let root: Root
	
	@State
	private var path = [AnyNavigationDestination]()
	
	@State
	private var mapping = ModalMappingStorage()
	
	public init(@ViewBuilder _ root: () -> Root) {
		self.root = root()
	}
	
	private func presentSheet(_ destination: any NavigationDestination) {
		path.append(AnyNavigationDestination(destination))
	}
	
	public var body: some View {
		root
			.onPreferenceChange(ModalMappingPreferenceKey.self) { mapping in
				self.mapping = mapping
			}
			.modifier(SheetModifier(path: $path, idx: 0, mapping: mapping))
			.environment(\.presentSheet, presentSheet)
	}
}
