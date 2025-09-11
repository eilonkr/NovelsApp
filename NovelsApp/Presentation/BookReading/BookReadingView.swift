//
//  BookReadingView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 11/09/2025.
//

import SwiftUI
import UIKit

enum FontSize: String, CaseIterable {
    case small = "Small"
    case regular = "Regular"
    case large = "Large"
    case xLarge = "X-Large"
    
    var fontSize: CGFloat {
        switch self {
        case .small: return 14
        case .regular: return 16
        case .large: return 18
        case .xLarge: return 20
        }
    }
}

enum BookFont: String, CaseIterable {
    case systemDefault = "Regular"
    case serif = "Serif"
    case mono = "Mono"
    case rounded = "Round"
    
    var fontDesign: Font.Design? {
        switch self {
        case .systemDefault: return nil
        case .serif: return .serif
        case .mono: return .monospaced
        case .rounded: return .rounded
        }
    }
}

enum ReadingMode: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
}

struct BookReadingView: View {
    let book: Book
    
    @Environment(ReadingLibrary.self) private var readingLibrary
    @Environment(ReadingGoalsModel.self) private var reading
    @Environment(\.dismiss) private var dismiss
    
    @State private var bookContent: BookContent?
    @State private var currentPageIndex: Int = 0
    @State private var showChapterNavigation = false
    @State private var showCustomization = false
    
    // Customization settings
    @State private var brightness: Double = UIScreen.main.brightness
    @State private var selectedFontSize: FontSize = .regular
    @State private var selectedFont: BookFont = .systemDefault
    @State private var selectedMode: ReadingMode = .light
    
    var currentChapterIndex: Int {
        guard let content = bookContent else { return 0 }
        return content.chapterIndex(for: currentPageIndex)
    }
    
    var currentChapterTitle: String {
        "Chapter \(currentChapterIndex + 1)"
    }
    
    var body: some View {
        ZStack {
            Color("ScreenBackground")
                .ignoresSafeArea()
            
            if let content = bookContent {
                VStack(spacing: 0) {
                    // Header
                    header
                    
                    // Content
                    TabView(selection: $currentPageIndex) {
                        ForEach(0..<content.totalPages, id: \.self) { pageIndex in
                            BookPageView(
                                content: content.pageContent(for: pageIndex) ?? "",
                                pageNumber: pageIndex + 1,
                                totalPages: content.totalPages,
                                onPreviousPage: {
                                    if currentPageIndex > 0 {
                                        currentPageIndex -= 1
                                    }
                                },
                                onNextPage: {
                                    if currentPageIndex < content.totalPages - 1 {
                                        currentPageIndex += 1
                                    }
                                },
                                brightness: $brightness,
                                selectedFontSize: $selectedFontSize,
                                selectedFont: $selectedFont,
                                selectedMode: $selectedMode,
                                showChapterNavigation: $showChapterNavigation,
                                showCustomization: $showCustomization
                            )
                            .tag(pageIndex)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .onChange(of: currentPageIndex) { _, newValue in
                        updateReadingProgress(content: content)
                    }
                }
            } else {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            loadBookContent()
            reading.startReading()
            readingLibrary.lastRead = book
        }
        .onDisappear {
            reading.stopReading()
        }
        .sheet(isPresented: $showChapterNavigation) {
            if let content = bookContent {
                ChapterNavigationView(
                    bookContent: content,
                    currentChapterIndex: currentChapterIndex,
                    onChapterSelected: { chapterIndex in
                        currentPageIndex = content.startingPage(for: chapterIndex)
                        showChapterNavigation = false
                    }
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
        }
        .sheet(isPresented: $showCustomization) {
            BookCustomizationView(
                brightness: $brightness,
                selectedFontSize: $selectedFontSize,
                selectedFont: $selectedFont,
                selectedMode: $selectedMode
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
    
    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text(currentChapterTitle)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    private func loadBookContent() {
        // For testing purposes, always load book_001
        guard let url = Bundle.main.url(forResource: "book_001", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let content = try? JSONDecoder().decode(BookContent.self, from: data) else {
            print("Failed to load book_001.json")
            return
        }
        
        self.bookContent = content
    }
    
    private func updateReadingProgress(content: BookContent) {
        let progress = Double(currentPageIndex + 1) / Double(content.totalPages)
        readingLibrary.reads[book] = progress
    }
}

struct BookPageView: View {
    let content: String
    let pageNumber: Int
    let totalPages: Int
    let onPreviousPage: () -> Void
    let onNextPage: () -> Void
    
    // Customization bindings
    @Binding var brightness: Double
    @Binding var selectedFontSize: FontSize
    @Binding var selectedFont: BookFont
    @Binding var selectedMode: ReadingMode
    @Binding var showChapterNavigation: Bool
    @Binding var showCustomization: Bool
    
    var body: some View {
        VStack {
            ScrollView {
                Text(content)
                    .font(.system(size: selectedFontSize.fontSize, design: selectedFont.fontDesign))
                    .lineSpacing(8)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(selectedMode == .dark ? .white : .black)
            }
            
            Spacer()
            
            // Page indicator
            HStack {
                Button(action: { showChapterNavigation = true }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: onPreviousPage) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(pageNumber > 1 ? .primary : .secondary)
                    }
                    .disabled(pageNumber <= 1)
                    
                    Text("Page \(pageNumber)/\(totalPages)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Button(action: onNextPage) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(pageNumber < totalPages ? .primary : .secondary)
                    }
                    .disabled(pageNumber >= totalPages)
                }
                
                Spacer()
                
                Button(action: { showCustomization = true }) {
                    Image(systemName: "textformat")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .background(
            Color(selectedMode == .dark ? .black : .white)
                .ignoresSafeArea()
        )
    }
}

struct ChapterNavigationView: View {
    let bookContent: BookContent
    let currentChapterIndex: Int
    let onChapterSelected: (Int) -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<bookContent.chapters.count, id: \.self) { chapterIndex in
                    ChapterRowView(
                        chapterNumber: chapterIndex + 1,
                        isCurrentChapter: chapterIndex == currentChapterIndex,
                        onTap: { onChapterSelected(chapterIndex) }
                    )
                }
            }
            .navigationTitle("Chapters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChapterRowView: View {
    let chapterNumber: Int
    let isCurrentChapter: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Chapter \(chapterNumber)")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                                
                if isCurrentChapter {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BookCustomizationView: View {
    @Binding var brightness: Double
    @Binding var selectedFontSize: FontSize
    @Binding var selectedFont: BookFont
    @Binding var selectedMode: ReadingMode
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Brightness Slider
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "sun.min")
                            .foregroundColor(.secondary)
                        
                        Slider(value: $brightness, in: 0.0...1.0)
                            .accentColor(.blue)
                            .onChange(of: brightness) { _, newValue in
                                UIScreen.main.brightness = CGFloat(newValue)
                            }
                        
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Font Size
                VStack(alignment: .leading, spacing: 15) {
                    Text("Font Size")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        ForEach(FontSize.allCases, id: \.self) { fontSize in
                            Button(action: {
                                selectedFontSize = fontSize
                            }) {
                                Text(fontSize.rawValue)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedFontSize == fontSize ? .white : .primary)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(selectedFontSize == fontSize ? Color.blue : Color.gray.opacity(0.2))
                                    )
                            }
                        }
                    }
                }
                
                // Pick Font
                VStack(alignment: .leading, spacing: 15) {
                    Text("Pick Font")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        ForEach(BookFont.allCases, id: \.self) { font in
                            Button(action: {
                                selectedFont = font
                            }) {
                                Text(font.rawValue)
                                    .font(.system(size: 14, weight: .medium, design: font.fontDesign))
                                    .foregroundColor(selectedFont == font ? .white : .primary)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(selectedFont == font ? Color.blue : Color.gray.opacity(0.2))
                                    )
                            }
                        }
                    }
                }
                
                // Mode
                VStack(alignment: .leading, spacing: 15) {
                    Text("Mode")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        ForEach(ReadingMode.allCases, id: \.self) { mode in
                            Button(action: {
                                selectedMode = mode
                            }) {
                                HStack {
                                    Image(systemName: mode == .light ? "sun.max" : "moon")
                                        .foregroundColor(selectedMode == mode ? .white : .primary)
                                    Text(mode.rawValue)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedMode == mode ? .white : .primary)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(selectedMode == mode ? Color.blue : Color.gray.opacity(0.2))
                                )
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(20)
            .navigationTitle("Edit Book View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}
