//
//  Substance.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import Foundation

/// Enumeration representing various addictive substances.
enum Substance: String, CaseIterable {
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
