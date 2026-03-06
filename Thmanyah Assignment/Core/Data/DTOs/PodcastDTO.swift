//
//  PodcastDTO.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct PodcastDTO: Decodable, Sendable {
    let podcastId: String
    let name: String
    let avatarUrl: String?
    let episodeCount: Int
    let duration: Int
    let language: String?
}
