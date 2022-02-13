//
//  HomePageResponse.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 9.02.2022.
//

import Foundation

// MARK: - HomePageResponse
struct HomePageResponse: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Results]?
}

// MARK: - Results

struct Results: Codable {
    var id: Int?
    var name: String?
    var slug: String?
    var games_count: String?
    var background_image: String?
    var rating: Double?
    var metacritic: Double?
    var released: String?
    var description: String?
    var ratings: [Ratings]?
}

// MARK: - Ratings

struct Ratings: Codable {
    var id: Int?
    var title: String?
    var count: Int?
    var percent: Double?
}
