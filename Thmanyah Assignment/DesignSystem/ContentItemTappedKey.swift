//
//  ContentItemTappedKey.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 08/03/2026.
//

import SwiftUI

private struct ContentItemTappedKey: EnvironmentKey {
    static let defaultValue: ((ContentSectionItemDisplayModel) -> Void)? = nil
}

extension EnvironmentValues {
    var contentItemTapped: ((ContentSectionItemDisplayModel) -> Void)? {
        get { self[ContentItemTappedKey.self] }
        set { self[ContentItemTappedKey.self] = newValue }
    }
}
