//
//  File.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol NetworkServiceProtocol {
    func getTop250Movies() async throws -> Movies?
}

final class NetworkService: NetworkServiceProtocol {
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
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
            throw NetworkError.noImage
        }
    }
    private func saveDataToCache(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
