//
//  Int+Duration.swift
//  Thmanyah Assignment
//

import Foundation

extension Int {
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter.string(from: TimeInterval(self)) ?? ""
    }
}
