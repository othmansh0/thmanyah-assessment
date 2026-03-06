//
//  Int+Duration.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

extension Int {
    /// Formats a duration in seconds as Arabic hours/minutes, e.g. "١س ٣٠د".
    var formattedDuration: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60

        if hours > 0 && minutes > 0 {
            return "\(hours.arabicString)س \(minutes.arabicString)د"
        } else if hours > 0 {
            return "\(hours.arabicString)س"
        } else {
            return "\(minutes.arabicString)د"
        }
    }

    private var arabicString: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
