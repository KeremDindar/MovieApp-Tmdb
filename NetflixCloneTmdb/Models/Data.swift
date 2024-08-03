//
//  Data.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 8.07.2024.
//

import Foundation

struct VideoResults: Decodable {
    let results: [Video]
}

struct Video: Identifiable, Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}




enum MediaType: String, Codable {
    case tv = "tv"
    case movie = "movie"
}

struct CreditsResults: Decodable {
    let id: Int
    let cast: [CastMember]
}

struct CastMember: Identifiable, Decodable {
    let id: Int
    let name: String
    let character: String
    let profile_path: String?

    var profileUrl: URL? {
        guard let profile_path = profile_path else { return nil }
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w200")!
        return baseUrl.appendingPathComponent(profile_path)
    }
}


struct TrendingResults: Decodable {
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
}

struct TrendingItem: Identifiable, Decodable {
    
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String?
    let vote_average: Float
    let backdrop_path: String
    let original_language: String
    let overview: String
    let release_date: String?
    let popularity: Double
    let media_type: MediaType
    let name: String? // Diziler için
    
    var backdropUrl: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w400")!
        return baseUrl.appendingPathComponent(backdrop_path)
    }
    
    var displayTitle: String {
        return title ?? name ?? "Unknown Title"
    }
    
    var displayReleaseDate: String {
        return release_date ?? ""
    }
    
    static var preview: TrendingItem {
        return TrendingItem(adult: false, id: 116135, poster_path: "/zszRKfzjM5jltiq8rk6rasKVpUv.jpg", title: "Vikings: Valhalla", vote_average: 7.032, backdrop_path: "/k47JEUTQsSMN532HRg6RCzZKBdB.jpg", original_language: "en", overview: "In this sequel to \"Vikings,\" a hundred years have passed and a new generation of legendary heroes arises to forge its own destiny — and make history.", release_date: "2022-02-25", popularity: 2365.896, media_type: .movie ,name: nil)
    }
}

