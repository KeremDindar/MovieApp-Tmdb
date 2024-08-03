//
//  GetTrending.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 8.07.2024.
//

import Foundation
import SwiftUI

class MovieTrendingViewModel: ObservableObject {
     let popularityThreshold: Double = 900

    
    @Published var trendingMovies: [TrendingItem] = [] {
        didSet {
             popularMovies = trendingMovies.filter { $0.popularity >= popularityThreshold }
            
        }
    }
    @Published var trendingSeries: [TrendingItem] = [] {
        didSet {
            popularSeries = trendingSeries.filter { $0.popularity >= popularityThreshold }
        }
    }
    @Published var castMembers: [CastMember] = []
    
    @Published var popularMovies: [TrendingItem] = []
    @Published var popularSeries: [TrendingItem] = []
    @Published var recMovie: [TrendingItem] = []
    @Published var recSeries: [TrendingItem] = []
    @Published var trailerURL: URL?
    
    
    static let apiKey = "bd32a4d3d0623da21911bbb801114767"
    
    @MainActor
    func loadTrendingMovies() async {
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieTrendingViewModel.apiKey)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
            trendingMovies = trendingResults.results
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func loadTrendingSeries() async {
        let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=\(MovieTrendingViewModel.apiKey)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
            trendingSeries = trendingResults.results
            print("Series: \(trendingResults.results.count)")
        } catch {
//            print(error.localizedDescription)
            print("Error loading trending series: \(error.localizedDescription)")

        }
    }
    
    @MainActor
      func loadMovieCredits(movieId: Int) async {
          let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(MovieTrendingViewModel.apiKey)&language=en-US")!
          do {
              let (data, _) = try await URLSession.shared.data(from: url)
              let creditsResults = try JSONDecoder().decode(CreditsResults.self, from: data)
              castMembers = creditsResults.cast
          } catch {
              print("Error loading movie credits: \(error.localizedDescription)")
          }
      }
    
    @MainActor
    func loadSeriesCredits(seriesId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(seriesId)/credits?api_key=\(MovieTrendingViewModel.apiKey)&language=en-US")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let creditsResults = try JSONDecoder().decode(CreditsResults.self, from: data)
            castMembers = creditsResults.cast
        } catch {
            print("Error loading series credits: \(error.localizedDescription)")
        }
    }
    

  @MainActor
    func loadMovieRec(movieId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?api_key=\(MovieTrendingViewModel.apiKey)&language=en-US")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recResults = try JSONDecoder().decode(TrendingResults.self, from: data)
            recMovie = recResults.results
        } catch {
            print("Error loading rec Movie: \(error.localizedDescription)")
        }
    }
    
    @MainActor
       func loadSeriesRecommendations(seriesId: Int) async {
           let url = URL(string: "https://api.themoviedb.org/3/tv/\(seriesId)/recommendations?api_key=\(MovieTrendingViewModel.apiKey)&language=en-US")!
           do {
               let (data, _) = try await URLSession.shared.data(from: url)
               let recResults = try JSONDecoder().decode(TrendingResults.self, from: data)
               recSeries = recResults.results
           } catch {
               print("Error loading rec Series: \(error.localizedDescription)")
           }
       }
    
    @MainActor
    func loadMoviesVideos(movieId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(MovieTrendingViewModel.apiKey)&language=en-US")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let videoResults = try JSONDecoder().decode(VideoResults.self, from: data)
            if let trailer = videoResults.results.first(where: { $0.type.lowercased() == "trailer" && $0.site.lowercased() == "youtube" }) {
                let trailerURLString = "https://www.youtube.com/watch?v=\(trailer.key)"
                trailerURL = URL(string: trailerURLString)
                print("Trailer URL: \(trailerURLString)")
            } else {
                print("No trailer found")
            }
        } catch {
            print("Error loading movie videos: \(error.localizedDescription)")
        }
    }

    @MainActor
    func loadSeriesVideos(seriesId: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/tv/\(seriesId)/videos?api_key=\(MovieTrendingViewModel.apiKey)&language=en-US")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let videoResults = try JSONDecoder().decode(VideoResults.self, from: data)
            if let trailer = videoResults.results.first(where: { $0.type.lowercased() == "trailer" && $0.site.lowercased() == "youtube" }) {
                let trailerURLString = "https://www.youtube.com/watch?v=\(trailer.key)"
                trailerURL = URL(string: trailerURLString)
                print("Trailer URL: \(trailerURLString)")
            } else {
                print("No trailer found")
            }
        } catch {
            print("Error loading series videos: \(error.localizedDescription)")
        }
    }
}





