//
//  AnyNavigationDestination.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

struct AnyNavigationDestination: NavigationDestination {
	let destination: any NavigationDestination
	
	init<D: NavigationDestination>(_ destination: D) {
		self.destination = destination
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
