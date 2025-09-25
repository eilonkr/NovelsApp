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
    @State private var presentedSheet: GlobalSheet?
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
        .sheet(item: $presentedSheet, content: view(for:))
        .environment(dataSource)
        .environment(bookmarksModel)
        .environment(readingLibrary)
        .environment(readingGoals)
        .environment(\.showSheet, SheetAction { sheet in
            presentedSheet = sheet
        })
    }
    
    @ViewBuilder private func tabView(for tab: AppTab) -> some View {
        switch tab {
        case .discover:
            DiscoverView()
                .bookTransitionRoot()
        case .myBooks:
            MyBooksView()
                .bookTransitionRoot()
        }
    }
    
    @ViewBuilder private func view(for sheet: GlobalSheet) -> some View {
        switch sheet {
        case .changeReadingGoals:
            ChangeReadingGoalsView()
                .presentationDetents([.medium])
        }
    }
}
