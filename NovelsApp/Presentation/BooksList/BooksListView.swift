//
//  BooksListView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 28/08/2025.
//

import SwiftUI

struct BooksListView: View {
    let shelf: BookShelf
    
    var body: some View {
        ScrollView {
            Text("Books list")
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}
