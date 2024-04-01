//
//  Goal.swift
//  CleanSteps
//
//  Created by Hugh on 3/31/24.
//

import Foundation

// Define a GoalType enum that represents the type of goal
enum GoalType: String, Codable {
    case cleanTimeGoal
    case meetingsGoal
    case taskGoal
    // Add other types as necessary
}

/// Represents a goal with identifiable, mutable, and time-tracked properties.
protocol Goal: Codable {
    /// Unique identifier for the goal.
    var id: UUID { get }
    
    /// Title or name of the goal.
    var title: String { get set }
    
    /// Indicates whether the goal has been completed.
    var isCompleted: Bool { get set }
    
    /// The date when the goal was created.
    var creationDate: Date { get }
    
    /// Marks the goal as completed.
    mutating func complete()
}


extension Goal {
    /// Default implementation that marks the goal as completed.
    mutating func complete() {
        self.isCompleted = true
    }
}

/// A factory class responsible for creating `Goal` instances from serialized data.
/// It utilizes the type information encoded during serialization to instantiate
/// the correct `Goal` type during deserialization.
class GoalFactory {
    
    /// Creates a `Goal` instance from serialized data.
    ///
    /// This method decodes the `goalType` from the provided data first to determine
    /// the type of `Goal` to instantiate. It then uses the specific `goalType` to
    /// decode and return an instance of the corresponding `Goal` subclass.
    ///
    /// - Parameter data: The serialized data representing a `Goal` instance, including its type information.
    /// - Returns: An instance of a class conforming to the `Goal` protocol, or `nil` if deserialization fails.
    static func createGoal(from data: Data) -> Goal? {
        let decoder = JSONDecoder()
        
        // Attempt to decode the type information (goalType) first.
        guard let goalType = try? decoder.decode(GoalType.self, from: data) else { return nil }
        
        switch goalType {
        case .cleanTimeGoal:
            // Deserialize a CleanTimeGoal if the type matches.
            return try? decoder.decode(CleanTimeGoal.self, from: data)
        case .meetingsGoal:
            // Deserialize a MeetingsGoal if the type matches.
            return try? decoder.decode(MeetingsGoal.self, from: data)
        case .taskGoal:
            // Deserialize a TaskGoal if the type matches.
            return try? decoder.decode(TaskGoal.self, from: data)
            // Extend with additional cases as necessary for other goal types.
        }
    }
}

/// A wrapper class to hold a `Goal` reference.
/// This allows for mutating function calls on the contained `Goal` instance
/// by leveraging reference semantics.
final class AnyGoalWrapper: Codable {
    /// The `Goal` instance being wrapped.
    var goal: Goal
    var goalType: GoalType
    
    /// Initializes a new wrapper with the given `Goal`.
    /// - Parameter goal: The `Goal` instance to wrap.
    init(goal: Goal, goalType: GoalType) {
        self.goal = goal
        self.goalType = goalType
    }
    
    private enum CodingKeys: CodingKey {
        case goal, goalType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        goalType = try container.decode(GoalType.self, forKey: .goalType)
        
        // Based on goalType, decode the specific Goal
        switch goalType {
        case .cleanTimeGoal:
            goal = try container.decode(CleanTimeGoal.self, forKey: .goal)
        case .meetingsGoal:
            goal = try container.decode(MeetingsGoal.self, forKey: .goal)
        case .taskGoal:
            goal = try container.decode(TaskGoal.self, forKey: .goal)
            // Add additional cases as necessary
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(goalType, forKey: .goalType)
        
        // Encode the goal based on its actual type
        switch goalType {
        case .cleanTimeGoal:
            try container.encode(goal as? CleanTimeGoal, forKey: .goal)
        case .meetingsGoal:
            try container.encode(goal as? MeetingsGoal, forKey: .goal)
        case .taskGoal:
            try container.encode(goal as? TaskGoal, forKey: .goal)
            // Add additional cases as necessary
        }
    }
}


/// A type-erased wrapper for the `Goal` protocol.
/// It enables handling any `Goal` conforming type in a type-agnostic way,
/// allowing for the inclusion of various goal types in collections or APIs
/// that require a concrete type.
struct AnyGoal: Goal {
    /// The wrapper that holds the actual `Goal` instance, enabling reference semantics for mutation.
    private var wrapper: AnyGoalWrapper
    
    var id: UUID { wrapper.goal.id }
    var title: String {
        get { wrapper.goal.title }
        set { wrapper.goal.title = newValue }
    }
    var isCompleted: Bool {
        get { wrapper.goal.isCompleted }
        set { wrapper.goal.isCompleted = newValue }
    }
    var creationDate: Date { wrapper.goal.creationDate }
    var goalType: GoalType { wrapper.goalType }
    
    /// Initializes a new `AnyGoal` with a given `Goal` conforming instance.
    /// This initializer wraps the given `Goal` in a `AnyGoalWrapper` to enable mutations.
    /// - Parameter goal: The `Goal` conforming instance to wrap and type-erase.
    init<G: Goal>(_ goal: G, goalType: GoalType) {
        self.wrapper = AnyGoalWrapper(goal: goal, goalType: goalType)
    }
    
    /// Marks the wrapped `Goal` as completed.
    /// This function calls the `complete` method on the wrapped `Goal` instance.
    mutating func complete() {
        wrapper.goal.complete()
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
