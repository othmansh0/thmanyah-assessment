//
//  ContentSectionDisplayModel.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

struct ContentSectionDisplayID: Hashable, Equatable {
    let feedIndex: Int
}

struct ContentSectionItemDisplayID: Hashable, Equatable {
    let sectionID: ContentSectionDisplayID
    let itemIndex: Int
}

struct ContentSectionDisplayModel: Identifiable, Equatable {
    let id: ContentSectionDisplayID
    let title: String
    let type: SectionType
    let contentType: ContentType?
    let entries: [ContentSectionItemDisplayModel]
}

struct ContentSectionItemDisplayModel: Identifiable, Equatable {
    let id: ContentSectionItemDisplayID
    let title: String
    let imageURL: URL?
    let durationText: String
    let releaseDateText: String?
    let credit: String
    let compactSubtitle: String
}
