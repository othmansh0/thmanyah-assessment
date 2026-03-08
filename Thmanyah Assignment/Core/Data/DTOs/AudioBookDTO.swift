//
//  AudioBookDTO.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

struct AudioBookDTO: Decodable {
    let audiobookId: String
    let name: String
    let avatarUrl: String?
    let authorName: String
    let description: String?
    let duration: Int
    let language: String?
    let releaseDate: String?
}
