//
//  BookmarksModel.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import Foundation

@Observable class BookmarksModel {
    var books = [Book]()
    
    func bookmark(_ book: Book, ) {
        books.append(book)
    }
    
    func unbookmark(_ book: Book) {
        books.removeAll { $0.id == book.id }
    }
}
