//
//  Milestone.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import Foundation
import SwiftData
import CloudKit

/// Represents a milestone achieved by a user in their sobriety journey.
@Model
final class Milestone {
    /// The date when the milestone was achieved.
    var date: Date? = nil
    
    /// An array of goals associated with the milestone.
    ///
    /// Users can define multiple goals for each milestone to track their progress and targets.
    var goals: [Goal] = []
    
    /// The addiction associated with this milestone.
    @Relationship var addiction: Addiction?
    
    /// Initializes a Milestone object with the specified parameters.
    ///
    /// - Parameters:
    ///   - addiction: The addiction associated with this milestone.
    ///   - goals: The goals associated with this milestone.
    init(addiction: Addiction, goals: [Goal]) {
        self.addiction = addiction
        self.goals = goals
    }
}

extension Milestone {
    
    /// Represents a goal or target set by the user for a milestone.
    struct Goal: Codable {
        /// Enum representing the type of goal.
        enum GoalType: String, Codable, CaseIterable {
            case cleanDays = "Clean Days"
            case meetingCount = "Meeting Count"
            case task = "Task"
        }
        
        /// The type of goal.
        let type: GoalType
        
        /// The target value for the goal.
        ///
        /// This property specifies the desired target value associated with the goal.
        let target: Int?
        
        /// Additional description for task goals.
        ///
        /// This property provides an additional description for task goals, specifying the task to be completed.
        let taskDescription: String?
    }
    
    
    /// Class property representing recovery milestones in seconds.
    /// This is just a predefined set of milestones to start off with;
    /// Users can and are encouraged to add their own Milestones.
    static let milestonesInSeconds: [TimeInterval] = [
        86_400,      // 1 day
        259_200,     // 3 days
        604_800,     // 1 week
        2_592_000,   // 1 month
        5_184_000,   // 2 months
        7_776_000,   // 3 months
        15_552_000,  // 6 months
        23_328_000,  // 9 months
        31_536_000,  // 1 year
        47_304_000,  // 18 months
        63_072_000,  // 2 years
        157_680_000, // 5 years
        315_360_000, // 10 years
        630_720_000, // 20 years
        788_400_000  // 25 years
    ]
}
