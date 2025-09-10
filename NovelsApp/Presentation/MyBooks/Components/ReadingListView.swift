//
//  ReadingListView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct ReadingListView: View {
    @Environment(ReadingLibrary.self) private var library
    
    var body: some View {
        BookShelfSingleRowView(books: library.readingList()!)
    }
}
