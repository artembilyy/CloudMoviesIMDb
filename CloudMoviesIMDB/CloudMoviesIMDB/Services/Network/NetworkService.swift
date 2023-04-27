//
//  File.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol NetworkMainServiceProtocol {
    func getTop250Movies(useCache: Bool) async throws -> Movies
}
protocol NetworkSearchServiceProtocol {
    func getSearchedMovies(query: String) async throws -> SearchResult
}
protocol NetworkCustomDetailServiceProtocol {
    func getDetailScreen(movieID: String) async throws -> Movies.Movie
}

final class NetworkService {
    fileprivate let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    
    fileprivate func saveDataToCache(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}

extension NetworkService: NetworkMainServiceProtocol {
    func getTop250Movies(useCache: Bool) async throws -> Movies {
        var components = URLComponents(string: Endpoints.top250MoviesURL)!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: Endpoints.apiKey)
        ]
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        /// get from cache
        if useCache {
            if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest),
               let movies = try? decoder.decode(Movies.self, from: cachedResponse.data) {
                return movies
            }
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        do {
            let result = try decoder.decode(Movies.self, from: data)
            saveDataToCache(with: data, response: response)
            return result
        } catch {
            /// add Error
            throw NetworkError.noImage
        }
    }
}

extension NetworkService: NetworkSearchServiceProtocol {    
    func getSearchedMovies(query: String) async throws -> SearchResult {
        guard let queryPathComponent = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw NetworkError.invalidURL
        }
        let urlString = Endpoints.searchMovies + "/" + Endpoints.apiKey + "/" + queryPathComponent
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest),
           let movies = try? decoder.decode(SearchResult.self, from: cachedResponse.data) {
            return movies
        }
        /// for cache if needed?
        let (data, response) = try await URLSession.shared.data(from: url)
        do {
            let result = try decoder.decode(SearchResult.self, from: data)
            saveDataToCache(with: data, response: response)
            return result
        } catch {
            /// add Errors
            print(error.localizedDescription)
            throw NetworkError.noImage
        }
    }
}

extension NetworkService: NetworkCustomDetailServiceProtocol {
    func getDetailScreen(movieID: String) async throws -> Movies.Movie {
        let urlString = Endpoints.detail + "/" + Endpoints.apiKey + "/" + movieID + "/" + Endpoints.query
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        do {
            let result = try decoder.decode(Movies.Movie.self, from: data)
            guard let items = result.items else {
                throw NetworkError.invalidURL
            }
            return items
        } catch {
            throw NetworkError.invalidURL
        }
    }
}
