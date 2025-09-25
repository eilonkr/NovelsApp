//
//  ChangeReadingGoalsView.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 25/09/2025.
//

import SwiftUI

struct ChangeReadingGoalsView: View {
    @Environment(ReadingGoalsModel.self) private var readingGoals
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedHours = 0
    @State private var selectedMinutes = 15
    @State private var selectedSeconds = 0
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Change reading goals")
                .font(.system(.title2, design: .serif, weight: .medium))
            
            timePickerView
            
            setGoalButton
        }
        .padding(24)
        .onAppear {
            // Convert current daily goal minutes to hours, minutes, seconds
            let totalMinutes = readingGoals.dailyGoalMinutes
            selectedHours = totalMinutes / 60
            selectedMinutes = totalMinutes % 60
            selectedSeconds = 0
        }
    }
    
    private var timePickerView: some View {
        HStack(spacing: 20) {
            // Hours picker
            VStack {
                Text("\(selectedHours)")
                    .font(.system(size: 48, weight: .light, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("hours")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Picker("Hours", selection: $selectedHours) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(hour)")
                            .tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80, height: 120)
                .clipped()
            }
            
            // Minutes picker
            VStack {
                Text("\(selectedMinutes)")
                    .font(.system(size: 48, weight: .light, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("min")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)")
                            .tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80, height: 120)
                .clipped()
            }
            
            // Seconds picker
            VStack {
                Text("\(selectedSeconds)")
                    .font(.system(size: 48, weight: .light, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("sec")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Picker("Seconds", selection: $selectedSeconds) {
                    ForEach(0..<60, id: \.self) { second in
                        Text("\(second)")
                            .tag(second)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 80, height: 120)
                .clipped()
            }
        }
        .padding(.vertical, 20)
    }
    
    private var setGoalButton: some View {
        Button {
            // Convert to total minutes
            let totalMinutes = (selectedHours * 60) + selectedMinutes + (selectedSeconds > 0 ? 1 : 0)
            readingGoals.dailyGoalMinutes = max(1, totalMinutes) // Ensure at least 1 minute
            dismiss()
        } label: {
            Text("Set Goal")
                .font(.body.weight(.semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.accentColor)
                .clipShape(.capsule)
        }
    }
}
