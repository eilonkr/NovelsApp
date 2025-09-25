import SwiftUI

struct BookShelfThreeByThreeView: View {
    let shelf: BookShelf
    
    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 94), spacing: 12),
        GridItem(.flexible(minimum: 94), spacing: 12),
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(shelf.books.prefix(shelf.style.maximumDisplayBooks).map { $0 }) { book in
                    BookThreeByThreeCardView(book: book)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16)
        .scrollTargetBehavior(.viewAligned)
    }
}

// MARK: - Components

private struct BookThreeByThreeCardView: View {
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
