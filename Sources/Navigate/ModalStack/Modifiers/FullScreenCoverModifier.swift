//
//  FullScreenCoverModifier.swift
//  Navigate
//
//  Created by Dominik Arnhof on 12.06.25.
//

import SwiftUI

#if !os(macOS)
struct FullScreenCoverModifier: ViewModifier {
    @Binding
    var path: [ModalPathDestination]
    
    let idx: Int
    
    let mapping: ModalMappingStorage
    
    private func sheetBinding(idx: Int) -> Binding<ModalPathDestination?> {
        Binding {
            guard path.count > idx && path[idx].type == .fullScreen else { return nil }
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
        let itemBinding = sheetBinding(idx: idx)
        let item = itemBinding.wrappedValue
        
        content
            .fullScreenCover(
                item: itemBinding,
                onDismiss: {
                    item?.onDismiss?()
                }
            ) { item in
                if let mapping = mapping.mapping[ObjectIdentifier(type(of: item.destination))] {
                    AnyView(mapping(item))
                        .modifier(FullScreenCoverModifier(path: $path, idx: idx + 1, mapping: self.mapping))
                        .modifier(SheetModifier(path: $path, idx: idx + 1, mapping: self.mapping))
                } else {
                    let _ = print("missing sheet destination modifier")
                    EmptyView()
                }
            }
    }
}

#endif
