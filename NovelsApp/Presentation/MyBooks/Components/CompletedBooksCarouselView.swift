//
//  CompletedBooksCarouselView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct CompletedBooksCarouselView: View {
    @Environment(ReadingLibrary.self) private var library
    @Environment(BooksDataSource.self) private var dataSource
    
    private var books: [Book] {
        let bookIds = library.completedBooks()
        return bookIds.compactMap { dataSource.book(for: $0) }
    }
    
    var body: some View {
        
        if books.isEmpty == false {
            BookShelfView(style: .singleRow, title: "Completed", books: books)
        }
    }
}
