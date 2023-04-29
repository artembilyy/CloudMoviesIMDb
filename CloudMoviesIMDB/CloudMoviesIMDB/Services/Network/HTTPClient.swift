//
//  HTTPClient.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 29.04.2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, useCache: Bool, queryItem: String?, movieID: String?, decoder: JSONDecoder) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        useCache: Bool = true,
        queryItem: String? = nil,
        movieID: String? = nil,
        decoder: JSONDecoder
    ) async throws -> T {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        
        if let queryItem {
            urlComponents.path = "\(endpoint.path)/\(Constants.apiKey)/\(queryItem)"
        } else if let movieID {
            urlComponents.path = "\(endpoint.path)/\(Constants.apiKey)/\(movieID)/\(Constants.fullDetail)"
        } else {
            urlComponents.path = endpoint.path
            urlComponents.queryItems = [
                URLQueryItem(name: "apiKey", value: Constants.apiKey)
            ]
        }
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if useCache {
            if let cachedResponse = URLCache.shared.cachedResponse(for: request),
               let decodedData = try? decoder.decode(T.self, from: cachedResponse.data) {
                return decodedData
            }
        }
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.responseUnsuccessful(description: "")
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    throw NetworkError.jsonDecodingFailure(description: "")
                }
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                return decodedResponse
            case 400:
                throw NetworkError.noInternetConnection
            default:
                throw NetworkError.unexpectedStatusCode
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}
