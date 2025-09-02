//
//  BookImageView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

struct BookImageView: View {
    let book: Book
    
    @State private var isBookmarked = false
    
    var body: some View {
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
    
    private func bookmarkButton() -> some View {
        Button {
            isBookmarked.toggle()
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
