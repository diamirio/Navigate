//
//  EnvironmentValues+Modal.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

extension EnvironmentValues {
	@Entry
    var presentSheet: (any NavigationDestination, ModalType, (() -> Void)?) -> Void = { _, _, _ in }
	
	@Entry
	public var dismissAllModals: () -> Void = {}
}
