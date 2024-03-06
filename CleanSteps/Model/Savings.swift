//
//  Savings.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import Foundation
import SwiftData
import CloudKit


/// Represents the savings tracked for an addiction.
@Model
final class Savings {
    /// The amount saved for the addiction.
    var amountSaved: Double
    
    /// The unit of measurement for the savings (e.g., money, time, calories).
    var unit: String
    
    /// The type of savings.
    var savingsType: SavingsType
    
    /// The periodicity at which savings are calculated (per day or per week).
    var periodicity: Periodicity
    
    /// The relationship to the addiction associated with this savings.
    @Relationship var addiction: Addiction?
    
    /// Initializes a Savings object with the specified parameters.
    ///
    /// - Parameters:
    ///   - amountSaved: The amount saved for the addiction.
    ///   - unit: The unit of measurement for the savings.
    ///   - savingsType: The type of savings.
    ///   - periodicity: The periodicity at which savings are calculated.
    init(
        amountSaved: Double,
        unit: String,
        savingsType: SavingsType,
        periodicity: Periodicity,
        addiction: Addiction?
    ) {
        self.amountSaved = amountSaved
        self.unit = unit
        self.savingsType = savingsType
        self.periodicity = periodicity
        self.addiction = addiction
    }
}


extension Savings {
    /// Enumeration representing the type of savings.
    enum SavingsType: String, Codable, CaseIterable {
        
        case money = "Money"
        case time = "Time"
        case calories = "Calories"
        case custom = "Custom"
        
    }
    
    
    /// Enumeration representing the periodicity at which savings are calculated.
    enum Periodicity: String, Codable, CaseIterable {
        case perDay = "Per Day"
        case perWeek = "Per Week"
    }
}
