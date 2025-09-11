//
//  BookShelfSingleRowView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct BookShelfSingleRowView: View {
    let books: [Book]
    let maxDisplayBooks: Int
    
    init(books: [Book], maxDisplayBooks: Int = 10) {
        self.books = books
        self.maxDisplayBooks = maxDisplayBooks
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(books.prefix(maxDisplayBooks).map { $0 }) { book in
                    BookSingleRowCardView(book: book)
                }
            }
            .animation(.smooth(duration: 0.3), value: books)
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 16)
        .scrollTargetBehavior(.viewAligned)
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }
}

// MARK: - Components

private struct BookSingleRowCardView: View {
    let book: Book
    
    @Environment(BooksNavigation.self) private var navigation
    
    var body: some View {
        Button {
            navigation.path.append(.bookCover(book))
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                BookImageView(book: book)
                
                Text(book.title)
                    .font(.caption)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                    .padding(.leading, 2)
            }
            .frame(width: 94, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let sampleBooks = [
        Book(id: "1", title: "A Cat Named Bastion", author: "John Doe", genre: "Fantasy", rating: 4.5, storyDescription: "A sample story", views: 1234, coverImageName: "book-1"),
        Book(id: "2", title: "Book Title", author: "Jane Smith", genre: "Mystery", rating: 4.2, storyDescription: "A sample story", views: 5678, coverImageName: "book-2"),
        Book(id: "3", title: "Old Castle Mystery", author: "Bob Johnson", genre: "Thriller", rating: 4.8, storyDescription: "A sample story", views: 9012, coverImageName: "book-3")
    ]
    
    BookShelfSingleRowView(books: sampleBooks)
        .padding()
}
