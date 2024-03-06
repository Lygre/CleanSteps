//
//  Addiction.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import Foundation
import SwiftData
import CloudKit

/// Represents an addictive substance and its related data.
///
/// The Addiction class stores information about an addictive substance, including its name, description,
/// reason for tracking, sobriety start date, clean time, milestone dates, and fellow users count.
///
/// - Note: This class is designed to be used with SwiftData for persistence and synchronization with CloudKit.
@Model
final class Addiction {
    /// The addictive substance being tracked.
    var substance: Substance
    
    /// Additional information about the addictive substance.
    ///
    /// This property provides detailed information about the addictive substance, including its effects,
    /// risks, and usage patterns.
    var substanceInfo: String {
        return substance.description
    }
    
    /// The user's motivation or reason for tracking this addiction.
    var reason: String
    
    /// A boolean property to determine whether the addiction is enabled for tracking in the app.
    var isEnabled: Bool
    
    /// The date when the user started their sobriety journey for this addiction.
    var sobrietyDate: Date?
    
    /// The date of the user's last milestone achieved for this addiction.
    var lastMilestone: Date?
    
    /// The date of the user's next milestone for this addiction.
    var nextMilestone: Date?
    
    /// The number of fellow users who share the same milestone as their next milestone for this addiction.
    var fellowUsersCount: Int
    
    /// The duration of abstinence from the addictive substance, calculated based on `sobrietyDate`.
    var cleanTime: TimeInterval {
        guard let sobrietyDate = sobrietyDate else { return 0 }
        return Date().timeIntervalSince(sobrietyDate)
    }
    
    /// Initializes an Addiction object with the specified parameters.
    ///
    /// - Parameters:
    ///   - substance: The addictive substance being tracked.
    ///   - reason: The user's motivation or reason for tracking this addiction.
    ///   - isEnabled: A boolean value indicating whether the addiction is enabled for tracking.
    ///   - sobrietyDate: The date when the user started their sobriety journey for this addiction.
    ///   - lastMilestone: The date of the user's last milestone achieved for this addiction.
    ///   - nextMilestone: The date of the user's next milestone for this addiction.
    ///   - fellowUsersCount: The number of fellow users who share the same milestone as their next milestone for this addiction.
    init(substance: Substance, reason: String, isEnabled: Bool, sobrietyDate: Date?, lastMilestone: Date?, nextMilestone: Date?, fellowUsersCount: Int) {
        self.substance = substance
        self.reason = reason
        self.isEnabled = isEnabled
        self.sobrietyDate = sobrietyDate
        self.lastMilestone = lastMilestone
        self.nextMilestone = nextMilestone
        self.fellowUsersCount = fellowUsersCount
    }
}
