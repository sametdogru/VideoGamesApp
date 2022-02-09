//
//  GameDetailsResponse.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation

// MARK: - GameDetailsResponse
struct GameDetailsResponse: Codable {
    var id: Int?
    var slug: String?
    var name: String?
    var description: String?
    var metacritic: Double?
    var released: String?
    var background_image: String?
    var ratings: [Ratings]?
    var esrb_rating: EsrbRating?
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    var id: Int?
    var name: String
    var slug: String?
}

