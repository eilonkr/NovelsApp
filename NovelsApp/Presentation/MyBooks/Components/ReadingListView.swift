//
//  ReadingListView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct ReadingListView: View {
    @Environment(ReadingLibrary.self) private var library
    @Environment(BooksDataSource.self) private var dataSource
    
    private var readingList: [Book] {
        let readingListIds = library.readingList()
        return readingListIds.compactMap { dataSource.book(for: $0) }
    }
    
    var body: some View {
        if library.reads.isEmpty == false {
            BookShelfView(style: .singleRow, title: "Reading List", books: readingList)
        } else {
            Text("You haven't read any books yet.")
        }
    }
}
