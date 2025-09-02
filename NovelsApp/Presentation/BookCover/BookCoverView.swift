//
//  BookCoverView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 28/08/2025.
//

import SwiftUI

struct BookCoverView: View {
    let book: Book
    
    var body: some View {
        Text(book.title)
    }
}
