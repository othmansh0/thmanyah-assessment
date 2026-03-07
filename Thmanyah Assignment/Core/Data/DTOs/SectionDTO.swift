//
//  SectionDTO.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

// ContentItemDTO holds a typed DTO per content type, produced by SectionDTO's custom decoder.
enum ContentItemDTO {
    case podcast(PodcastDTO)
    case episode(EpisodeDTO)
    case audioBook(AudioBookDTO)
    case audioArticle(AudioArticleDTO)
}

struct SectionDTO {
    let name: String
    let type: String
    let contentType: String?
    let order: Int
    let items: [ContentItemDTO]
}

extension SectionDTO: Decodable {
    // CodingKeys use camelCase names (no raw values) because keyDecodingStrategy
    // = .convertFromSnakeCase converts JSON snake_case before key lookup.
    enum CodingKeys: CodingKey {
        case name, type, contentType, order, content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        contentType = try container.decodeIfPresent(String.self, forKey: .contentType)
        order = try container.decode(Int.self, forKey: .order)

        switch contentType {
        case "podcast":
            let dtos = try container.decode([PodcastDTO].self, forKey: .content)
            items = dtos.map { .podcast($0) }
        case "episode":
            let dtos = try container.decode([EpisodeDTO].self, forKey: .content)
            items = dtos.map { .episode($0) }
        case "audio_book":
            let dtos = try container.decode([AudioBookDTO].self, forKey: .content)
            items = dtos.map { .audioBook($0) }
        case "audio_article":
            let dtos = try container.decode([AudioArticleDTO].self, forKey: .content)
            items = dtos.map { .audioArticle($0) }
        default:
            items = []
        }
    }
}
