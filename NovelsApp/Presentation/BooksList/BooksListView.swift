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
            VStack(alignment: .leading, spacing: 24) {
                Text(shelf.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                
                BookVerticalListView(books: shelf.books)
            }
            .padding(.top, 16)
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}
