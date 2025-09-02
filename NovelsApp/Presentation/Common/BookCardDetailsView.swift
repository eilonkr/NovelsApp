//
//  BookCardDetailsView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

struct BookCardDetailsView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(book.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 8) {
                Text(book.genre)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Color(.systemGray6)
                    .clipShape(.capsule))
                
                Text("\(Image(systemName: "star.fill")) \(book.rating == floor(book.rating) ? String(Int(book.rating)) : String(format: "%.1f", book.rating))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
