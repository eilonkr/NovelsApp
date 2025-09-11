//
//  BookmarkedCarouselView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct BookmarkedCarouselView: View {
    @Environment(BookmarksModel.self) private var bookmarks
    
    var body: some View {
        if bookmarks.books.isEmpty == false {
            BookShelfView(style: .singleRow, title: "Bookmarked", books: bookmarks.books)
        }
    }
}
