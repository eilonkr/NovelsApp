//
//  BookShelfSpotlightView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

struct BookShelfSpotlightView: View {
    let shelf: BookShelf
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 8) {
                ForEach(shelf.books.prefix(shelf.style.maximumDisplayBooks).map { $0 }) { book in
                    BookSpotlightCardView(book: book)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 16)
        .scrollTargetBehavior(.viewAligned)
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }
}

struct BookSpotlightCardView: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 16) {
            BookImageView(book: book)
                .offset(y: -10)
            
            BookCardDetailsView(book: book)
        }
        .containerRelativeFrame(.horizontal) { width, _ in
            return width * 0.8
        }
        .padding(.horizontal, 12)
        .background {
            Color(.systemBackground)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

