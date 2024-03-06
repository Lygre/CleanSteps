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
/// The Addiction model stores information about an addictive substance, including its name, description,
/// reason for tracking, sobriety start date, clean time, milestone dates, and fellow users count.
///
/// - Note: This model is designed to be used with SwiftData for persistence and synchronization with CloudKit.
@Model
final class Addiction {
    /// The unique identifier of the Addiction record in CloudKit.
    let recordID: CKRecord.ID?
    
    /// The name of the addictive substance.
    var name: String
    
    /// A brief description of the addictive substance and its effects.
    var effects: String
    
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
    
    
    // Initialize with default values
    init(
        name: String,
        effects: String,
        reason: String,
        isEnabled: Bool = true,
        sobrietyDate: Date? = nil,
        lastMilestone: Date? = nil,
        nextMilestone: Date? = nil,
        fellowUsersCount: Int = 0
    ) {
            self.recordID = nil // Will be assigned by CloudKit
            self.name = name
            self.effects = effects
            self.reason = reason
            self.isEnabled = isEnabled
            self.sobrietyDate = sobrietyDate
            self.lastMilestone = lastMilestone
            self.nextMilestone = nextMilestone
            self.fellowUsersCount = fellowUsersCount
        }
    
    /// The duration of abstinence from the addictive substance, calculated based on `sobrietyDate`.
    var cleanTime: TimeInterval {
        guard let sobrietyDate = sobrietyDate else { return 0 }
        return Date().timeIntervalSince(sobrietyDate)
    }
}
