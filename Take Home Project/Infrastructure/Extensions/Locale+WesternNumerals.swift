//
//  Locale+WesternNumerals.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

extension Locale {
    /// Current locale with Western numerals. Keeps language for labels (e.g. "س" for hour in Arabic) but uses 0–9 for numbers.
    static var currentWithWesternNumerals: Locale {
        Locale(identifier: "\(Locale.current.identifier)-u-nu-latn")
    }
}
