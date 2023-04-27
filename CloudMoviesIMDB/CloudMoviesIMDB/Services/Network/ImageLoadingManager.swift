//
//  ImageLoadingManager.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//
import UIKit

protocol ImageLoadingManagerProtocol {
    func getImage(from url: String) async throws -> UIImage?
    func getSearchImage(from url: URL) async throws -> UIImage?
}

final class ImageLoadingManager: ImageLoadingManagerProtocol {
    
    private var image: UIImage?
    private var imageUrlString: String = ""
    /// Prevent reusable
    @MainActor
    func getImage(from url: String) async throws -> UIImage? {
        imageUrlString = url
        guard let url = getURL(resizeFactor: 2, url: url) else {
            throw NetworkError.invalidURL
        }
        /// returned from Cache
        if let cachedImage = getCachedImage(from: url) {
            self.image = cachedImage
            return image
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            guard let compressedData = image.jpegData(compressionQuality: 0.5) else {
                throw NetworkError.invalidURL
            }
            let compressedImage = UIImage(data: compressedData)
            saveDataToCache(with: compressedData, response: response)
            self.image = compressedImage
            return compressedImage
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    @MainActor
    func getSearchImage(from url: URL) async throws -> UIImage? {
        imageUrlString = url.absoluteString
        if let cachedImage = getCachedImage(from: url) {
            self.image = cachedImage
            return image
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            guard let compressedData = image.jpegData(compressionQuality: 0.1) else {
                throw NetworkError.invalidURL
            }
            let compressedImage = UIImage(data: compressedData)
            saveDataToCache(with: compressedData, response: response)
            /// add if need
            self.image = compressedImage
            return compressedImage
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    // MARK: Method for get URL with scaled image
    /// simple solution -> Improve in future
    private func getURL(resizeFactor: Int, url: String) -> URL? {
        let width = 128
        let height = 176
        let scaledWidth = width * resizeFactor
        let scaledHeight = height * resizeFactor
        let originalString = url
        let replacedString = originalString
            .replacingOccurrences(of: String(width), with: String(scaledWidth))
            .replacingOccurrences(of: String(height), with: String(scaledHeight))
        let finalURL = URL(string: replacedString)
        return finalURL
    }
    private func saveDataToCache(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
}
