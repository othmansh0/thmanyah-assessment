//
//  PodcastDTO.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct PodcastDTO: Decodable {
    let podcastId: String
    let name: String
    let avatarUrl: String?
    let episodeCount: Int
    let duration: Int
    let language: String?

    enum CodingKeys: CodingKey {
        case podcastId, name, avatarUrl, episodeCount, duration, language
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        podcastId = try container.decode(String.self, forKey: .podcastId)
        name = try container.decode(String.self, forKey: .name)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        episodeCount = try container.decodeIntOrString(forKey: .episodeCount)
        duration = try container.decodeIntOrString(forKey: .duration)
        language = try container.decodeIfPresent(String.self, forKey: .language)
    }
}
