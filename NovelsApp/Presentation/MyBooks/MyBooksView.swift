//
//  MyBooksView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 04/09/2025.
//

import SwiftUI

struct MyBooksView: View {
    enum Section: Hashable {
        case continueReading
        case readingList
        case bookmarked
        case readingGoals
        case completed
    }
    
    @State private var navigation = BooksNavigation()
    @State private var sections = [Section]()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(sections, id: \.self, content: sectionView)
                }
                .padding(.top)
            }
            .navigationTitle("My Books")
            .background(.screenBackground)
            .navigationBarTitleDisplayMode(.large)
            .withBooksNavigation()
            .environment(navigation)
        }
        .onAppear {
            buildSections()
        }
    }
    
    @ViewBuilder private func sectionView(_ section: Section) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            switch section {
            case .continueReading:
                ContinueReadingView()
            case .readingList:
                ReadingListView()
            case .bookmarked:
                BookmarkedCarouselView()
            case .readingGoals:
                ReadingGoalsView()
            case .completed:
                CompletedBooksCarouselView()
            }
        }
    }
    
    // MARK: - Private
    private func buildSections() {
        var sections = [Section]()
        sections.append(.continueReading)
        sections.append(.readingList)
        sections.append(.bookmarked)
        sections.append(.readingGoals)
        sections.append(.completed)
        
        self.sections = sections
    }
}
