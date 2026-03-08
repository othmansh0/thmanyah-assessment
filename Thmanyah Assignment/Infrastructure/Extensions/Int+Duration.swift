//
//  Int+Duration.swift
//  Thmanyah Assignment
//

import Foundation

extension Int {
    var formattedDuration: String {
        var calendar = Calendar.current
        calendar.locale = Locale.currentWithWesternNumerals
        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter.string(from: TimeInterval(self)) ?? ""
    }
}
