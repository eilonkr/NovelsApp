//
//  BookShelf.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import Foundation

struct BookShelf: Decodable, Hashable, Identifiable {
    enum Style: String, Decodable {
        case threeByThreeWide
        case threeByThree
        case spotlight
        case vertical
        case singleRow
        
        var maximumDisplayBooks: Int {
            return switch self {
            case .threeByThreeWide: 9
            case .threeByThree: 6
            case .spotlight: 8
            case .vertical: 4
            case .singleRow: 10
            }
        }
    }
    
    let style: Style
    let title: String
    let books: [Book]
    
    var id: String { title }
}
