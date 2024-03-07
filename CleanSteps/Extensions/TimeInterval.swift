//
//  TimeInterval.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import Foundation

extension TimeInterval {
    /// Converts the time interval into a formatted string representing clean time.
    ///
    /// - Returns: A string representing the clean time in a human-readable format.
    func cleanTimeFormatted() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2 // Show up to two units
        
        return formatter.string(from: self) ?? ""
    }
}

