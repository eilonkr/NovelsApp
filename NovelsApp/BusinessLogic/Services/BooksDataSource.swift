//
//  BooksDataSource.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import Foundation

@Observable class BooksDataSource {
    private(set) var bookshelves: [BookShelf] = []
    private(set) var isLoading = false
    private(set) var error: Error?
    
    init() {
        loadBooks()
    }
    
    // MARK: - Public
    func getAllBookshelves() -> [BookShelf] {
        return bookshelves
    }
    
    func getBookshelf(by title: String) -> BookShelf? {
        return bookshelves.first { $0.title == title }
    }
    
    func book(for id: String) -> Book? {
        return getAllBooks().first { $0.id == id }
    }
    
    func getAllBooks() -> [Book] {
        return bookshelves.flatMap { $0.books }
    }
    
    /// Search books by title, author, or genre
    func searchBooks(query: String) -> [Book] {
        let lowercaseQuery = query.lowercased()
        return getAllBooks().filter { book in
            book.title.lowercased().contains(lowercaseQuery) ||
            book.author.lowercased().contains(lowercaseQuery) ||
            book.genre.lowercased().contains(lowercaseQuery)
        }
    }
    
    func getBooks(for genre: String) -> [Book] {
        return getAllBooks().filter { $0.genre.lowercased() == genre.lowercased() }
    }
    
    func getTrendingBooks(limit: Int = 20) -> [Book] {
        return getAllBooks()
            .sorted { $0.views > $1.views }
            .prefix(limit)
            .map { $0 }
    }
    
    func getTopRatedBooks(limit: Int = 20) -> [Book] {
        return getAllBooks()
            .sorted { $0.rating > $1.rating }
            .prefix(limit)
            .map { $0 }
    }
    
    // MARK: - Private
    private func loadBooks() {
        isLoading = true
        error = nil
        
        Task { @MainActor in
            defer { isLoading = false }
            do {
                let loadedBookshelves = try await loadBooksFromJSON()
                self.bookshelves = loadedBookshelves
            } catch {
                self.error = error
                print("Failed to load books: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadBooksFromJSON() async throws -> [BookShelf] {
        guard let url = Bundle.main.url(forResource: "Books", withExtension: "json") else {
            throw BooksDataSourceError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let bookshelves = try decoder.decode([BookShelf].self, from: data)
        return bookshelves
    }
}

// MARK: - Error Types
enum BooksDataSourceError: LocalizedError {
    case fileNotFound
    case decodingFailed(Error)
    
    var errorDescription: String? {
        return switch self {
        case .fileNotFound:
            "Books.json file not found in app bundle"
        case .decodingFailed(let error):
            "Failed to decode books data: \(error.localizedDescription)"
        }
    }
}

// MARK: - Convenience Extensions
extension BooksDataSource {
    /// Get unique genres from all books
    var availableGenres: [String] {
        return Array(Set(getAllBooks().map { $0.genre })).sorted()
    }
    
    /// Get books count
    var totalBooksCount: Int {
        return getAllBooks().count
    }
    
    /// Get bookshelves count
    var bookshelvesCount: Int {
        return bookshelves.count
    }
}

