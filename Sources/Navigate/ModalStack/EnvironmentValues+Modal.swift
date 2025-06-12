//
//  EnvironmentValues+Modal.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

extension EnvironmentValues {
	@Entry
	var presentSheet: (any NavigationDestination) -> Void = { _ in }
}
