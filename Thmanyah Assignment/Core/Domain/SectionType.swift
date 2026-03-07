//
//  SectionType.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

enum SectionType: Equatable {
    case queue
    case bigSquare
    case square
    case twoLinesGrid

    init(apiValue: String) {
        switch apiValue {
        case "queue": self = .queue
        case "big_square", "big square": self = .bigSquare
        case "square": self = .square
        case "2_lines_grid": self = .twoLinesGrid
        default: self = .square
        }
    }
}
