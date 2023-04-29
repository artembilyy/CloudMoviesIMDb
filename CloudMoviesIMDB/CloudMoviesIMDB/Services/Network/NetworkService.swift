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
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    func getTop250Movies(useCache: Bool) async throws -> Movies {
        do {
            return try await sendRequest(endpoint: MoviesEndpoint.top250, responseModel: Movies.self, useCache: useCache, decoder: decoder)
        } catch NetworkError.invalidURL {
            throw NetworkError.invalidURL
        } catch {
            throw NetworkError.noInternetConnection
        }
    }
    func getSearchedMovies(query: String) async throws -> Movies {
        return try await sendRequest(endpoint: MoviesEndpoint.search, responseModel: Movies.self, useCache: true, queryItem: query, decoder: decoder)
    }
    func getDetailScreen(movieID: String) async throws -> Movies.Movie {
        return try await sendRequest(endpoint: MoviesEndpoint.detail, responseModel: Movies.Movie.self, useCache: true, movieID: movieID, decoder: decoder)
    }
}
