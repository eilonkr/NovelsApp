//
//  BookImageView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

struct BookImageView: View {
    let book: Book
    
    @Environment(BookmarksModel.self) private var bookmarks
    @Environment(BookTransition.self) private var bookTransition
    
    private var isBookmarked: Bool {
        bookmarks.books.contains(book)
    }
    
    var body: some View {
        VStack {
            Image(book.coverImageName)
                .resizable()
                .frame(width: 94, height: 124)
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 8))
                .overlay(alignment: .topTrailing) {
                    bookmarkButton()
                        .padding(4)
                }
        }
        .matchedTransitionSource(id: book.id, in: bookTransition.namespace)
    }
    
    private func bookmarkButton() -> some View {
        Button {
            if isBookmarked {
                bookmarks.unbookmark(book)
            } else {
                bookmarks.bookmark(book)
            }
        } label: {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .font(.system(size: 12))
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
                .background(.ultraThinMaterial)
                .clipShape(.circle)
        }
        .buttonStyle(.plain)
    }
}
