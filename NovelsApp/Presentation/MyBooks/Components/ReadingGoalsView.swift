//
//  ReadingGoalsView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct ReadingGoalsView: View {
    @Environment(ReadingGoalsModel.self) private var readingGoals
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Reading Goals")
                .font(.system(.largeTitle, design: .serif, weight: .bold))
            
            Text("Find a great book, set a goals and make reading a daily habit.")
                .font(.callout)
            
            
        }
    }
}
