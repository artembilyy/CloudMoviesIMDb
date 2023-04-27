//
//  File.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol NetworkMainServiceProtocol {
    func getTop250Movies() async throws -> Movies?
}
protocol NetworkSearchServiceProtocol {
    func getSearchedMovies(query: String) async throws -> [SearchResult.Movie]?
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
    func getTop250Movies() async throws -> Movies? {
        var components = URLComponents(string: Endpoints.top250MoviesURL)!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: Endpoints.apiKey)
        ]
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest),
           let movies = try? decoder.decode(Movies.self, from: cachedResponse.data) {
            return movies
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
    func getSearchedMovies(query: String) async throws -> [SearchResult.Movie]? {
        let queryPathComponent = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = Endpoints.searchMovies + "/" + Endpoints.apiKey + "/" + queryPathComponent
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        /// for cache if needed?
//        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let result = try decoder.decode(SearchResult.self, from: data)
            return result.results
        } catch {
            /// add Error in future
            print(error.localizedDescription)
            throw NetworkError.noImage
        }
    }
}
