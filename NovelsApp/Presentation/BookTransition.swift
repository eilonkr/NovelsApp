//
//  BookTransition.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 11/09/2025.
//

import SwiftUI

@Observable class BookTransition {
    let namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
}

struct BookTransitionRootViewModifier: ViewModifier {
    @Namespace private var bookTransition
    
    func body(content: Content) -> some View {
        content
            .environment(BookTransition(namespace: bookTransition))
    }
}

extension View {
    public func bookTransitionRoot() -> some View {
        modifier(BookTransitionRootViewModifier())
    }
}
