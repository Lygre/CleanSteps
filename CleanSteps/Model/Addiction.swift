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
    
    /// Additional information about the addictive substance.
    ///
    /// This property provides detailed information about the addictive substance, including its effects,
    /// risks, and usage patterns.
    var substanceInfo: String {
        return substance.description
    }
    
    
    /// The savings associated with this addiction.
    @Relationship(deleteRule: .cascade, inverse: \Savings.addiction)
    var savings = [Savings]()
    
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
    ///   - savings: The savings associated with this addiction.
    init(
        substance: Substance,
        reason: String,
        isEnabled: Bool,
        sobrietyDate: Date?,
        lastMilestone: Date?,
        nextMilestone: Date?,
        fellowUsersCount: Int
    ) {
        self.substance = substance
        self.reason = reason
        self.isEnabled = isEnabled
        self.sobrietyDate = sobrietyDate
        self.lastMilestone = lastMilestone
        self.nextMilestone = nextMilestone
        self.fellowUsersCount = fellowUsersCount
        
    }
}


extension Addiction {
    
    /// Enumeration representing various addictive substances.
    enum Substance: String, Codable, CaseIterable {
        // Addictive substances with descriptions
        case alcohol = "Alcohol"
        case nicotine = "Nicotine"
        case opioids = "Opioids"
        case benzodiazepines = "Benzodiazepines"
        case amphetamines = "Amphetamines"
        case cathinones = "Cathinones"
        case gabapentinoids = "Gabapentinoids"
        case barbiturates = "Barbiturates"
        case psychedelics = "Psychedelics"
        case dissociatives = "Dissociatives"
        case cannabis = "Cannabis"
        case cocaine = "Cocaine"
        case hallucinogens = "Hallucinogens"
        case inhalants = "Inhalants"
        case methamphetamine = "Methamphetamine"
        case prescriptionStimulants = "Prescription Stimulants"
        case steroids = "Steroids"
        case syntheticCannabinoids = "Synthetic Cannabinoids"
        case syntheticCathinones = "Synthetic Cathinones"
        case syntheticOpioids = "Synthetic Opioids"
        
        /// A brief description of the addictive substance.
        var description: String {
            switch self {
            case .alcohol:
                return "A psychoactive substance that is commonly consumed in beverages such as beer, wine, and spirits."
            case .nicotine:
                return "An addictive chemical found in tobacco products such as cigarettes, cigars, and e-cigarettes."
            case .opioids:
                return "A class of drugs that include prescription medications such as oxycodone, hydrocodone, and illicit substances like heroin."
            case .benzodiazepines:
                return "A type of sedative medication prescribed for anxiety disorders and insomnia, with the potential for dependence and addiction."
            case .amphetamines:
                return "A group of stimulant drugs that are commonly used to treat attention deficit hyperactivity disorder (ADHD) and narcolepsy."
            case .cathinones:
                return "Synthetic stimulant drugs that are chemically related to amphetamines, often sold as 'bath salts' or 'research chemicals.'"
            case .gabapentinoids:
                return "Medications used to treat epilepsy, neuropathic pain, and other conditions, with potential for abuse and dependence."
            case .barbiturates:
                return "Central nervous system depressants that are prescribed for anxiety, insomnia, and seizure disorders, but can be highly addictive."
            case .psychedelics:
                return "A class of hallucinogenic drugs that alter perception, mood, and cognitive processes, including substances like LSD, psilocybin, and MDMA."
            case .dissociatives:
                return "Substances that induce dissociative states, producing feelings of detachment from oneself and one's surroundings, including drugs like ketamine and PCP."
            case .cannabis:
                return "A psychoactive drug derived from the cannabis plant, commonly known as marijuana or weed."
            case .cocaine:
                return "A powerful stimulant drug derived from the coca plant, often snorted, smoked, or injected for its euphoric effects."
            case .hallucinogens:
                return "Substances that cause hallucinations and distortions in perception, including substances like peyote, DMT, and salvia."
            case .inhalants:
                return "Chemical vapors that produce mind-altering effects when inhaled, commonly found in household products like glue, paint, and gasoline."
            case .methamphetamine:
                return "A potent central nervous system stimulant that is highly addictive, commonly known as meth."
            case .prescriptionStimulants:
                return "Medications used to treat ADHD and narcolepsy, including drugs like Adderall, Ritalin, and Vyvanse."
            case .steroids:
                return "Synthetic drugs that mimic the effects of testosterone and other hormones, commonly used to enhance athletic performance."
            case .syntheticCannabinoids:
                return "Man-made chemicals that are sprayed on dried plant material and smoked for their psychoactive effects, marketed as 'synthetic marijuana' or 'spice.'"
            case .syntheticCathinones:
                return "Synthetic stimulant drugs that are similar to cathinones found in the khat plant, often sold as 'bath salts' or 'legal highs.'"
            case .syntheticOpioids:
                return "Lab-made drugs that mimic the effects of natural opioids, often more potent and dangerous than traditional opioids."
            }
        }
    }

    
}
