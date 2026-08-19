//
//  MovieViewModel.swift
//  MovieSwiftUI
//
//  Created by Kelly Ruiz on 8/12/26.
//

import Foundation


@Observable
class MovieViewModel {
    
    enum FetchStatus {
        
        case notStarted
        case fetching
        case sucess
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    private(set) var upcomingStatus: FetchStatus = .notStarted
    
    
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    var upcomingMovies: [Title] = []
    var heroTitle = Title.previewTitles[0]
    var videoId = ""
    
    func getTitles () async {
        
        homeStatus = .fetching
        if trendingMovies.isEmpty {
            
            do {
                async let trendMovies = try await dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let trendTv = try await dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let topMovies = try await dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let topTv = try await dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovies = try await trendMovies
                trendingTV = try await trendTv
                topRatedMovies = try await topMovies
                topRatedTV = try await topTv
                if let title = trendMovies.randomElement() {
                    heroTitle = title
                }
                homeStatus = .sucess
            } catch {
                print(error)
                
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .sucess
        }
        
    }
    
    func getVideoId(for title: String) async {
        
        videoIdStatus = .fetching
        
        do {
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .sucess
            
        } catch {
            print(error)
            videoIdStatus = .failed(underlyingError: error)
        }
    }
    
    func getUpcomingMovies() async {
        upcomingStatus = .fetching
        
        do {
            upcomingMovies = try await dataFetcher.fetchTitles(for: "movie", by: "upcoming")
            upcomingStatus = .sucess
        } catch {
            print(error)
            upcomingStatus = .failed(underlyingError: error)
        }
    }
    
}
