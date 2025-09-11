//
//  BookContent.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 11/09/2025.
//

import Foundation

struct BookContent: Decodable {
    let id: String
    let chapters: [BookChapter]
}

struct BookChapter: Decodable {
    let pages: [String]
}

extension BookContent {
    /// Total number of pages across all chapters
    var totalPages: Int {
        chapters.reduce(0) { $0 + $1.pages.count }
    }
    
    /// Get the chapter index for a given page number (0-indexed)
    func chapterIndex(for pageNumber: Int) -> Int {
        var currentPageCount = 0
        for (chapterIndex, chapter) in chapters.enumerated() {
            if pageNumber < currentPageCount + chapter.pages.count {
                return chapterIndex
            }
            currentPageCount += chapter.pages.count
        }
        return chapters.count - 1
    }
    
    /// Get the starting page number for a given chapter (0-indexed)
    func startingPage(for chapterIndex: Int) -> Int {
        guard chapterIndex >= 0 && chapterIndex < chapters.count else { return 0 }
        
        var pageCount = 0
        for i in 0..<chapterIndex {
            pageCount += chapters[i].pages.count
        }
        return pageCount
    }
    
    /// Get the page content for a given page number (0-indexed)
    func pageContent(for pageNumber: Int) -> String? {
        var currentPageCount = 0
        for chapter in chapters {
            if pageNumber < currentPageCount + chapter.pages.count {
                let pageIndex = pageNumber - currentPageCount
                return chapter.pages[pageIndex]
            }
            currentPageCount += chapter.pages.count
        }
        return nil
    }
}
