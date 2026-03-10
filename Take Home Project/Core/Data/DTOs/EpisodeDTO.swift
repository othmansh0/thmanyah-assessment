//
//  EpisodeDTO.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct EpisodeDTO: Decodable {
    let episodeId: String
    let name: String
    let avatarUrl: String?
    let duration: Int
    let audioUrl: String?
    let releaseDate: String?
    let podcastName: String
    let podcastId: String
}
