//
//  BooksNavigation.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

@Observable class BooksNavigation {
    enum Path: Hashable {
        case booksList(BookShelf)
        case bookCover(Book)
        case reading(Book)
    }
    
    var path = [Path]()
}

struct BooksNavigationDestinationViewModifier: ViewModifier {
    @Environment(BooksNavigation.self) private var navigation
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: BooksNavigation.Path.self, destination: destination)
    }
    
    @ViewBuilder private func destination(for path: BooksNavigation.Path) -> some View {
        switch path {
        case .booksList(let bookShelf):
            BooksListView(shelf: bookShelf)
        case .bookCover(let book):
            BookCoverView(book: book)
        case .reading(let book):
            BookReadingView(book: book)
        }
    }
}

extension View {
    func withBooksNavigation() -> some View {
        modifier(BooksNavigationDestinationViewModifier())
    }
}
