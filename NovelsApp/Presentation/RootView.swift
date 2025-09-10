//
//  RootView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI

enum AppTab: Int, CaseIterable {
    case discover
    case myBooks
    
    var title: LocalizedStringResource {
        return switch self {
        case .discover:
            "Discover"
        case .myBooks:
            "My Books"
        }
    }
    
    var systemImage: String {
        return switch self {
        case .discover:
            "house"
        case .myBooks:
            "bookmark"
        }
    }
}

struct RootView: View {
    @State private var dataSource = BooksDataSource()
    @State private var bookmarksModel = BookmarksModel()
    @State private var readingLibrary = ReadingLibrary()
    @State private var readingGoals = ReadingGoalsModel()
    @AppStorage("currentTab") private var currentTab = AppTab.discover
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                tabView(for: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .environment(dataSource)
        .environment(bookmarksModel)
        .environment(readingLibrary)
        .environment(readingGoals)
    }
    
    @ViewBuilder private func tabView(for tab: AppTab) -> some View {
        switch tab {
        case .discover:
            DiscoverView()
        case .myBooks:
            MyBooksView()
        }
    }
}
