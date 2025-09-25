//
//  ReadingGoalsView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import SwiftUI

struct ReadingGoalsView: View {
    @Environment(\.showSheet) private var showSheet
    
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
            
            changeReadingGoalsButton()
        }
        .padding(EdgeInsets(top: 32, leading: 24, bottom: 32, trailing: 24))
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    private func changeReadingGoalsButton() -> some View {
        Button {
            showSheet(.changeReadingGoals)
        } label: {
            Text("Change reading goals")
                .font(.body.weight(.semibold))
                .frame(width: 300, height: 50)
                .background(Color.accentColor)
                .clipShape(.capsule)
        }
        .buttonStyle(.plain)
    }
}

struct TodaysReadingView: View {
    @Environment(ReadingGoalsModel.self) private var reading
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Today's Reading")
                .font(.system(.body, design: .serif, weight: .semibold))
            
            Text(Duration.seconds(reading.todayReadingTime).formatted(.time(pattern: .minuteSecond)))
                .font(.largeTitle.weight(.semibold))
                .fontWidth(.expanded)
            
            Text("Of your \(reading.dailyGoalMinutes)-minute reading goal")
        }
    }
}
