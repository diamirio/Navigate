//
//  AnyNavigationDestination.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

/// Helper for holding the `destination` with the modal presentation type
/// Needed for binding the path of the `ModalStack`
public struct ModalPathDestination: NavigationDestination {
	let destination: any NavigationDestination
	let type: ModalType
	
	public init<D: NavigationDestination>(_ destination: D, type: ModalType) {
		self.destination = destination
		self.type = type
	}
	
	func unwrap<D: NavigationDestination>() -> D {
		destination as! D
	}
	
	public var id: AnyHashable {
		destination.id as! AnyHashable
	}
	
	public static func == (lhs: ModalPathDestination, rhs: ModalPathDestination) -> Bool {
		lhs.destination.hashValue == rhs.destination.hashValue
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(destination)
	}
}
