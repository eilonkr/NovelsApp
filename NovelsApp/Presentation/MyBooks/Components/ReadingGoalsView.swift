//
//  ReadingGoalsView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct ReadingGoalsView: View {
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 12) {
                Text("Reading Goals")
                    .font(.system(.title2, design: .serif, weight: .bold))
                
                Text("Find a great book, set a goals and make reading a daily habit.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            
            TodaysReadingView()
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 32, trailing: 24))
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct TodaysReadingView: View {
    @Environment(ReadingGoalsModel.self) private var readingGoals
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Today's Reading")
                .font(.system(.body, design: .serif, weight: .semibold))
            
            
            
            Text("Of your \(readingGoals.dailyGoalMinutes)-minute readin goal")
        }
    }
}
