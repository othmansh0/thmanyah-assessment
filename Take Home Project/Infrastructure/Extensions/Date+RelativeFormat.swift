//
//  Date+RelativeFormat.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

extension Date {
    var relativeFormatted: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale.currentWithWesternNumerals
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
