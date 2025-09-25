//
//  ReadingGoalsModel.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/09/2025.
//

import Foundation
import ObservableDefaults

@ObservableDefaults(defaultIsolationIsMainActor: true)
class ReadingGoalsModel {
    var dailyGoalMinutes: Int = 5
    
    /// Dictionary to store completed reading sessions by date
    private var readingSessions: [String: [ReadingSession]] = [:]
    
    /// Current active reading session (if reading is in progress)
    private var currentSession: ReadingSession?
    
    // MARK: - Data Models
    
    /// Represents a single reading session
    struct ReadingSession: CodableUserDefaultsPropertyListValue {
        let startTime: Date
        var endTime: Date?
        
        init(startTime: Date = Date()) {
            self.startTime = startTime
        }
        
        /// Duration of the session in seconds
        var durationSeconds: TimeInterval {
            let end = endTime ?? Date()
            return end.timeIntervalSince(startTime)
        }
        
        /// Duration of the session in minutes (rounded)
        var durationMinutes: Int {
            return Int(durationSeconds / 60)
        }
        
        /// Whether this session is currently active (no end time)
        var isActive: Bool {
            return endTime == nil
        }
    }
    
    // MARK: - Computed Properties
    
    /// Returns whether currently reading
    var isReading: Bool {
        return currentSession?.isActive == true
    }
    
    /// Returns current session duration in seconds (0 if not reading)
    var currentSessionSeconds: TimeInterval {
        return currentSession?.durationSeconds ?? 0
    }
    
    /// Returns current session duration in minutes (0 if not reading)
    var currentSessionMinutes: Int {
        return currentSession?.durationMinutes ?? 0
    }
    
    /// Returns total completed reading time for today in minutes
    var todayCompletedReadingTime: Int {
        let today = dateFormatter.string(from: Date())
        return readingSessions[today]?.reduce(0) { $0 + $1.durationMinutes } ?? 0
    }
    
    /// Returns total reading time for today including current session in minutes
    var todayReadingTime: Int {
        return todayCompletedReadingTime + currentSessionMinutes
    }
    
    /// Returns whether today's goal has been achieved
    var isTodayGoalAchieved: Bool {
        return todayReadingTime >= dailyGoalMinutes
    }
    
    /// Returns remaining minutes to achieve today's goal
    var remainingMinutesToday: Int {
        return max(0, dailyGoalMinutes - todayReadingTime)
    }
    
    /// Returns daily progress as a value between 0.0 and 1.0
    var dailyProgress: Double {
        guard dailyGoalMinutes > 0 else { return 0.0 }
        return min(1.0, Double(todayReadingTime) / Double(dailyGoalMinutes))
    }
    
    // MARK: - Private Properties
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // MARK: - Public
    /// Starts a new reading session
    func startReading() {
        // Stop any existing session first
        if isReading {
            stopReading()
        }
        
        // Create new session
        currentSession = ReadingSession()
    }
    
    /// Stops the current reading session and saves it
    func stopReading() {
        guard var session = currentSession, session.isActive else {
            return
        }
        
        // End the session
        session.endTime = Date()
        
        // Save the completed session if it has meaningful duration (at least 1 second)
        if session.durationSeconds >= 1 {
            let dateString = dateFormatter.string(from: session.startTime)
            
            if readingSessions[dateString] != nil {
                readingSessions[dateString]?.append(session)
            } else {
                readingSessions[dateString] = [session]
            }
        }
        
        // Clear current session
        currentSession = nil
    }
    
    /// Gets total reading time for a specific date in minutes
    /// - Parameter date: The date to get reading time for
    /// - Returns: Total reading time in minutes for the specified date
    func getReadingTime(for date: Date) -> Int {
        let dateString = dateFormatter.string(from: date)
        return readingSessions[dateString]?.reduce(0) { $0 + $1.durationMinutes } ?? 0
    }
    
    /// Gets reading sessions for a specific date
    /// - Parameter date: The date to get sessions for
    /// - Returns: Array of reading sessions for the specified date
    func getReadingSessions(for date: Date) -> [ReadingSession] {
        let dateString = dateFormatter.string(from: date)
        return readingSessions[dateString] ?? []
    }
    
    /// Clears all reading data (useful for testing or reset)
    func clearAllData() {
        stopReading() // Stop any active session
        readingSessions.removeAll()
    }
}

extension Dictionary<String, [ReadingGoalsModel.ReadingSession]>: @retroactive CodableUserDefaultsPropertyListValue { }
