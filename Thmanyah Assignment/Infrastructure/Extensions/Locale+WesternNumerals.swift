//
//  Locale+WesternNumerals.swift
//  Thmanyah Assignment
//

import Foundation

extension Locale {
    /// Use for formatters when numbers must display as Western numerals (0–9) regardless of app language.
    /// Use for String(format:locale:) and NumberFormatter when the current locale uses non-Western numerals.
    static let westernNumerals = Locale(identifier: "en_US_POSIX")

    /// Current locale with Western numerals. Keeps language for labels (e.g. "س" for hour in Arabic) but uses 0–9 for numbers.
    static var currentWithWesternNumerals: Locale {
        Locale(identifier: "\(Locale.current.identifier)-u-nu-latn")
    }
}
