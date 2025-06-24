//
//  ModalMapping.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

struct ModalMappingPreferenceKey: PreferenceKey {
	static let defaultValue = ModalMappingStorage()
	
	static func reduce(value: inout ModalMappingStorage, nextValue: () -> ModalMappingStorage) {
		value.mapping.merge(nextValue().mapping, uniquingKeysWith: { _, new in new })
	}
}

struct ModalMappingStorage: Equatable {
	var mapping: [ObjectIdentifier: @MainActor (ModalPathDestination) -> any View] = [:]
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.mapping.keys == rhs.mapping.keys
	}
}
