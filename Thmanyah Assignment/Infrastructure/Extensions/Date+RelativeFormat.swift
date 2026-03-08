//
//  Date+RelativeFormat.swift
//  Thmanyah Assignment
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
