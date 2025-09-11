//
//  ContinueReadingView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI
import CoreKit

struct ContinueReadingView: View {
    @Environment(ReadingLibrary.self) private var library
    @Environment(BooksNavigation.self) private var navigation
    
    private var progress: Double {
        guard let book else {
            return 0
        }
        
        return library.progress(for: book) ?? 0
    }
    
    private var book: Book? {
        return library.lastRead
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Continue Reading")
                .font(.headline)
                .fontDesign(.serif)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            if let book {
                componentView(book: book)
            } else {
                emptyStateView()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    private func componentView(book: Book) -> some View {
        HStack(spacing: 12) {
            BookImageView(book: book)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack {
                    Text(book.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(book.author)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    progressBar()
                    
                    Text("\(Int(progress * 100))%")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                navigation.path.append(.bookCover(book))
            } label: {
                Image(systemName: "book")
                    .frame(size: .square(40))
                    .clipShape(.circle)
            }
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private func progressBar() -> some View {
        GeometryReader { geometry in
            Capsule()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 4)
                .overlay(alignment: .leading) {
                    Capsule()
                        .fill(Color.accentColor)
                        .frame(width: geometry.size.width * CGFloat(progress), height: 4)
                }
        }
        .frame(height: 4)
    }
    
    private func emptyStateView() -> some View {
        Text("You haven't started reading any books yet.")
    }
}
