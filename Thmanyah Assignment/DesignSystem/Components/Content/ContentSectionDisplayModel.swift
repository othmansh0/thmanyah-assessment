//
//  ContentSectionDisplayModel.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import Foundation

enum DisplayLayoutType: Equatable {
    case stackedCarousel
    case bigSquare
    case square
    case twoRowGrid
    case horizontalCarousel
}

struct ContentSectionDisplayID: Hashable, Equatable {
    let feedIndex: Int
}

struct ContentSectionItemDisplayID: Hashable, Equatable {
    let sectionID: ContentSectionDisplayID
    let itemIndex: Int
}

struct ContentSectionDisplayModel: Identifiable, Equatable {
    let id: ContentSectionDisplayID
    let sectionId: String
    let title: String
    let layoutType: DisplayLayoutType
    let entries: [ContentSectionItemDisplayModel]
}

enum DestinationType: Equatable {
    case podcast
    case episode
    case audioBook
    case article
}

struct ContentSectionItemDisplayModel: Identifiable, Equatable {
    let id: ContentSectionItemDisplayID
    let domainId: String
    let destinationType: DestinationType
    let title: String
    let imageURL: URL?
    let durationText: String
    let releaseDateText: String?
    let credit: String
    let compactSubtitle: String
    let description: String?
}
