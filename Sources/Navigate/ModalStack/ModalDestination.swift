//
//  ModalDestination.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

private struct ModalDestinationModifier<D: NavigationDestination, V: View>: ViewModifier {
	let destination: D.Type
	let mapping: @MainActor (D) -> V
	
	init(destination: D.Type, mapping: @MainActor @escaping (D) -> V) {
		self.destination = destination
		self.mapping = mapping
	}
	
	func body(content: Content) -> some View {
		let closure = { @MainActor (anyDestination: ModalPathDestination) -> any View in
			mapping(anyDestination.unwrap())
		}
		content.transformPreference(ModalMappingPreferenceKey.self) { mapping in
			mapping.mapping[ObjectIdentifier(destination)] = closure
		}
	}
}

extension View {
	public func modalDestination<D: NavigationDestination, V: View>(for data: D.Type, @ViewBuilder destination: @MainActor @escaping (D) -> V) -> some View {
		modifier(ModalDestinationModifier(destination: data, mapping: destination))
	}
}
