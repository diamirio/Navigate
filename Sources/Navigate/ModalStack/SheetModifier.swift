//
//  SheetModifier.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

struct SheetModifier: ViewModifier {
	@Binding
	var path: [AnyNavigationDestination]
	
	let idx: Int
	
	let mapping: ModalMappingStorage
	
	private func sheetBinding(idx: Int) -> Binding<AnyNavigationDestination?> {
		Binding {
			guard path.count > idx else { return nil }
			return path[idx]
		} set: { newValue in
			guard path.count > idx else { return }
			if let newValue = newValue {
				path[idx] = newValue
			} else {
				path.remove(at: idx)
			}
		}
	}
	
	func body(content: Content) -> some View {
		content
			.sheet(item: sheetBinding(idx: idx)) { item in
				if let mapping = mapping.mapping[ObjectIdentifier(type(of: item.destination))] {
					AnyView(mapping(item))
						.modifier(SheetModifier(path: $path, idx: idx + 1, mapping: self.mapping))
				} else {
					let _ = print("missing sheet destination modifier")
					EmptyView()
				}
			}
	}
}
