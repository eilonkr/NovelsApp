//
//  DiscoverView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

enum DiscoverSegment: String, CaseIterable {
    case home
    case genres
    case trending
    
    @ViewBuilder var label: some View {
        switch self {
        case .home:
            Label("Home", systemImage: "house")
        case .genres:
            Label("Genres", systemImage: "wand.and.sparkles.inverse")
        case .trending:
            Label("Trending", systemImage: "flame")
        }
    }
}

struct DiscoverView: View {
    @Environment(BooksDataSource.self) private var dataSource
    @AppStorage("activeSegment") private var activeSegment = DiscoverSegment.home
    @State private var navigation = BooksNavigation()
    
    init() {
        setNavigationBarFont()
    }
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            ScrollView {
                LazyVStack(spacing: 32, pinnedViews: .sectionHeaders) {
                    Section {
                        ForEach(dataSource.bookshelves) { bookshelf in
                            BookShelfView(shelf: bookshelf)
                        }
                    } header: {
                        DiscoverSegmentPicker(activeSegment: $activeSegment)
                            .padding(.horizontal, 16)
                    }

                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Discover")
            .background(.screenBackground)
            .navigationBarTitleDisplayMode(.large)
            .withBooksNavigation()
        }
        .environment(navigation)
    }
    
    // MARK: - Private
    private func setNavigationBarFont() {
        UINavigationBar.appearance().largeTitleTextAttributes =
        [.font: UIFont(descriptor:
                        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1)
            .withDesign(.serif)?.withSymbolicTraits(.traitBold) ?? UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1), size: 32)]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(descriptor:
                            UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3)
                .withDesign(.serif)?.withSymbolicTraits(.traitBold) ?? UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3), size: 24)
        ]
    }
}

