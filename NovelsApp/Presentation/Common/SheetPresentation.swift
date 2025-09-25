//
//  SheetPresentation.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 25/09/2025.
//

import SwiftUI

struct SheetAction {
    let action: (GlobalSheet) -> Void
    
    func callAsFunction(_ sheet: GlobalSheet) {
        action(sheet)
    }
}

extension EnvironmentValues {
    @Entry var showSheet = SheetAction { _ in }
}

enum GlobalSheet: String, Identifiable {
    case changeReadingGoals
    
    var id: String { rawValue }
}
