//
//  AnyNavigationDestination.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

struct AnyNavigationDestination: NavigationDestination {
	let destination: any NavigationDestination
	let type: ModalType
	
	init<D: NavigationDestination>(_ destination: D, type: ModalType) {
		self.destination = destination
		self.type = type
	}
	
	func unwrap<D: NavigationDestination>() -> D {
		destination as! D
	}
	
	var id: AnyHashable {
		destination.id as! AnyHashable
	}
	
	static func == (lhs: AnyNavigationDestination, rhs: AnyNavigationDestination) -> Bool {
		lhs.destination.hashValue == rhs.destination.hashValue
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(destination)
	}
}
