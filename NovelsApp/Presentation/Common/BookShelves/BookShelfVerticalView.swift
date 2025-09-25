import SwiftUI

struct BookShelfVerticalView: View {
    let shelf: BookShelf
    
    var body: some View {
        BookVerticalListView(
            books: shelf.books,
            maxDisplayBooks: shelf.style.maximumDisplayBooks
        )
    }
} 