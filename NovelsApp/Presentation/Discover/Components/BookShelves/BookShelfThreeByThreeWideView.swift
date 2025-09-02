//
//  BookShelfThreeByThreeWideView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

struct BookShelfThreeByThreeWideView: View {
    let shelf: BookShelf
    
    private let rows: [GridItem] = [
        GridItem(.flexible(minimum: 140), spacing: 8, alignment: .top),
        GridItem(.flexible(minimum: 140), spacing: 8, alignment: .top),
        GridItem(.flexible(minimum: 140), spacing: 8, alignment: .top),
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .top, spacing: 12) {
                ForEach(shelf.books.prefix(shelf.style.maximumDisplayBooks).map { $0 }) { book in
                    BookWideCardView(book: book)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16)
        .scrollTargetBehavior(.viewAligned)
    }
}

// MARK: - Components

private struct BookWideCardView: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 12) {
            BookImageView(book: book)
            
            BookCardDetailsView(book: book)
        }
    }
}
