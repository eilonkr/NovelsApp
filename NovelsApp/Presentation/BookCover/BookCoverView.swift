//
//  BookCoverView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 28/08/2025.
//

import SwiftUI

struct BookCoverView: View {
    let book: Book
    
    @Environment(BookTransition.self) private var bookTransition
    @Environment(BooksNavigation.self) private var navigation
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                Image(book.coverImageName)
                    .frame(width: 238, height: 284)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 8))
                
                VStack(spacing: 4) {
                    Text(book.title)
                        .font(.system(.body, weight: .semibold))
                    
                    Text(book.author)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 24) {
                    attributeView(icon: "eye", text: book.views.formatted(.number.notation(.compactName).precision(.significantDigits(3))))
                    
                    attributeView(icon: "star", text: book.rating.formatted(.number
                        .precision(.fractionLength(1))))
                    
                    attributeView(icon: "book", text: String(book.views))
                }
                .padding(EdgeInsets(top: 8, leading: 32, bottom: 8, trailing: 32))
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(20)
            .maxWidth()
            .background(Color.activeBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 16)
            
            readButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.screenBackground.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Todo share")
                } label: {
                    Label("More", systemImage: "square.and.arrow.up")
                }
            }
        }
        .toolbarVisibility(.hidden, for: .tabBar)
        .navigationTransition(.zoom(sourceID: book.id, in: bookTransition.namespace))
    }
    
    private func readButton() -> some View {
        Button {
            navigation.path.append(.reading(book))
        } label: {
            Text("Read Book")
                .font(.headline)
                .maxWidth()
                .frame(height: 50)
                .background(.activeBackground)
                .clipShape(.capsule)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 32)
    }
    
    private func attributeView(icon: String, text: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
    }
}
