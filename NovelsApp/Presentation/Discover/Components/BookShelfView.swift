//
//  BookShelfView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

struct BookShelfView: View {
    let shelf: BookShelf
    
    @Environment(BooksNavigation.self) private var navigation
    
    init(shelf: BookShelf) {
        self.shelf = shelf
    }
    
    init(style: BookShelf.Style, title: String, books: [Book]) {
        self.shelf = BookShelf(style: style, title: title, books: books)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button {
                navigation.path.append(.booksList(shelf))
            } label: {
                HStack(spacing: 4) {
                    Text(shelf.title)
                    
                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .font(.system(.headline, design: .serif, weight: .bold))
            }
            .padding(.horizontal, 16)
            .buttonStyle(.plain)
            
            switch shelf.style {
            case .threeByThreeWide:
                BookShelfThreeByThreeWideView(shelf: shelf)
            case .spotlight:
                BookShelfSpotlightView(shelf: shelf)
            case .singleRow:
                BookShelfSingleRowView(books: shelf.books, maxDisplayBooks: shelf.style.maximumDisplayBooks)
            case .threeByThree, .vertical:
                #warning("Placeholder views for styles not yet implemented")
                BookShelfSpotlightView(shelf: shelf)
            }
        }
    }
}
