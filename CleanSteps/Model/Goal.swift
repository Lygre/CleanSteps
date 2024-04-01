//
//  Goal.swift
//  CleanSteps
//
//  Created by Hugh on 3/31/24.
//

import Foundation

// Define a protocol that all goals must conform to
protocol Goal {
    // Define the required properties and methods
    var id: UUID { get }
    var title: String { get set }
    var isCompleted: Bool { get set }
    var creationDate: Date { get }
    mutating func complete()
}

extension Goal {
    // Default implementation of the complete function
    mutating func complete() {
        self.isCompleted = true
    }
}

// Define a CleanTimeGoal struct that conforms to the Goal protocol
struct CleanTimeGoal: Goal {
    
    // Define the required properties and methods
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
    var creationDate: Date = Date()
    
    // Additional properties specific to CleanTimeGoal
    var targetCleanTime: TimeInterval
    
    /// Mark as complete if the current clean time reaches the target
    /// - Parameter currentCleanTime: The current clean time
    mutating func checkIfGoalReached(currentCleanTime: TimeInterval) {
        if currentCleanTime >= targetCleanTime {
            complete()
        }
    }
    
}

// Define a MeetingsGoal struct that conforms to the Goal protocol
struct MeetingsGoal: Goal {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var creationDate = Date()
    
    // Additional properties specific to MeetingsGoal
    var targetMeetingsCount: Int
    var currentMeetingsCount: Int = 0
    
    /// Mark as complete if the current meetings count reaches the target
    /// - Parameter newCount: The new meetings count
    mutating func updateMeetingsCount(newCount: Int) {
        currentMeetingsCount = newCount
        if currentMeetingsCount >= targetMeetingsCount {
            complete()
        }
    }
}


// Define a TaskGoal struct that conforms to the Goal protocol
struct TaskGoal: Goal {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var creationDate = Date()
    
    // Additional properties specific to TaskGoal
    /// Detailed task description
    var description: String
    /// List of steps to complete the task
    var steps: [TaskStep]
    
    // Implementation can remain simple, using the default `complete` method
}


struct TaskStep: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
}
