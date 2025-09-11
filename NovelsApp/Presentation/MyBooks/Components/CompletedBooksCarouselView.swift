//
//  CompletedBooksCarouselView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct CompletedBooksCarouselView: View {
    @Environment(ReadingLibrary.self) private var library
    
    var body: some View {
        let books = library.completedBooks()
        if books.isEmpty == false {
            BookShelfView(style: .singleRow, title: "Completed", books: books)
        }
    }
}
