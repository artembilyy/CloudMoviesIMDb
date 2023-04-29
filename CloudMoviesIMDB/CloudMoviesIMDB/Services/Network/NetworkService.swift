//
//  File.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol TopMoviesNetworkServiceProtocol {
    func getTop250Movies(useCache: Bool) async throws -> Movies
}
protocol SearchMoviesNetworkServiceProtocol {
    func getSearchedMovies(query: String) async throws -> Movies
}
protocol DetailMovieNetworkServiceProtocol {
    func getDetailScreen(movieID: String) async throws -> Movies.Movie
}

typealias MoviesServiceProtocol = TopMoviesNetworkServiceProtocol & SearchMoviesNetworkServiceProtocol & DetailMovieNetworkServiceProtocol

struct MoviesService: HTTPClient, MoviesServiceProtocol {
    func getTop250Movies(useCache: Bool) async throws -> Movies {
        return try await sendRequest(endpoint: MoviesEndpoint.top250, responseModel: Movies.self, useCache: useCache)
    }
    func getSearchedMovies(query: String) async throws -> Movies {
        return try await sendRequest(endpoint: MoviesEndpoint.search, responseModel: Movies.self, useCache: true, queryItem: query)
    }
    
    func getDetailScreen(movieID: String) async throws -> Movies.Movie {
        return try await sendRequest(endpoint: MoviesEndpoint.detail, responseModel: Movies.Movie.self, useCache: true, movieID: movieID)
    }
}
