//
//  Book.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import Foundation

struct Book: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let author: String
    let genre: String
    let rating: Double
    let storyDescription: String
    let views: Int
    let coverImageName: String
}
