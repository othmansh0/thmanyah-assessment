//
//  AudioArticleDTO.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct AudioArticleDTO: Decodable {
    let articleId: String
    let name: String
    let avatarUrl: String?
    let authorName: String
    let duration: Int
    let releaseDate: String?
}
