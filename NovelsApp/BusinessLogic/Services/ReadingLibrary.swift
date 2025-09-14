//
//  PersonalLibrary.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI
import ObservableDefaults

@ObservableDefaults(defaultIsolationIsMainActor: true)
class ReadingLibrary {
    typealias Progress = Double
    
    var lastRead: Book?
    var reads = [Book.ID: Progress]()
    
    // MARK: - Public
    func progress(for book: Book) -> Progress? {
        return reads[book.id]
    }
    
    func readingList() -> [Book.ID] {
        return booksSortedByProgress()
    }
    
    func booksSortedByProgress() -> [Book.ID] {
        return reads.sorted { $0.value < $1.value }.map { $0.key }
    }
    
    func completedBooks() -> [Book.ID] {
        return reads.filter { $0.value == 1.0 }.map { $0.key }
    }
}

extension ReadingLibrary.Progress: @retroactive CodableUserDefaultsPropertyListValue { }
