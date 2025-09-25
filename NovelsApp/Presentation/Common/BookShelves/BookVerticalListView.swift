import SwiftUI

struct BookVerticalListView: View {
    let books: [Book]
    let maxDisplayBooks: Int?
    
    init(books: [Book], maxDisplayBooks: Int? = nil) {
        self.books = books
        self.maxDisplayBooks = maxDisplayBooks
    }
    
    private var displayBooks: [Book] {
        if let maxDisplayBooks {
            return Array(books.prefix(maxDisplayBooks))
        }
        
        return books
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(displayBooks) { book in
                BookVerticalCardView(book: book)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Components

struct BookVerticalCardView: View {
    let book: Book
    
    @Environment(BooksNavigation.self) private var navigation
    
    var body: some View {
        Button {
            navigation.path.append(.bookCover(book))
        } label: {
            HStack(spacing: 16) {
                BookImageView(book: book)
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(book.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(book.storyDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
} 
