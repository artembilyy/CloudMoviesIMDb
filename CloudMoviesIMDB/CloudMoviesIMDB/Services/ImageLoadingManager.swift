//
//  ImageLoadingManager.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//
import UIKit

protocol ImageLoadingManagerProtocol {
    func getImage(from url: String) async throws -> UIImage?
}

final class ImageLoadingManager: ImageLoadingManagerProtocol {
    private var image: UIImage?
    private var imageUrlString: String = ""
    /// Prevent reusable
    func getImage(from url: String) async throws -> UIImage? {
        imageUrlString = url
        guard let url = getURL(resizeFactor: 3, url: url) else {
            throw NetworkError.invalidURL
        }
        /// returned from Cache
        if let cachedImage = getCachedImage(from: url) {
            let image = cachedImage
            self.image = image
            return image
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            saveDataToCache(with: data, response: response)
            self.image = image
            return image
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    // MARK: Method for get URL with scaled image
    private func getURL(resizeFactor: Int, url: String) -> URL? {
        /// Regex for pattern matching relevant parts of the URL
        let pattern = ".*UX([0-9]*)_CR0,([0-9]*),([0-9]*),([0-9]*).*"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let range = NSRange(location: 0, length: url.utf16.count)
        guard let match = regex.firstMatch(in: url, options: [], range: range) else { return nil }
        /// Get the image dimensions from the URL
        guard let range1 = Range(match.range(at: 1), in: url),
              let range3 = Range(match.range(at: 3), in: url),
              let range4 = Range(match.range(at: 4), in: url),
              let imgWidth = Int(String(url[range1])),
              let containerWidth = Int(String(url[range3])),
              let containerHeight = Int(String(url[range4])) else { return nil }
        /// Scaling
        let imgWidthScaled = imgWidth * resizeFactor
        let containerWidthScaled = containerWidth * resizeFactor
        let containerHeightScaled = containerHeight * resizeFactor
        /// Perform the image dimensions
        var result = url.replacingOccurrences(
            of: "(.*UX)([0-9]*)(.*)",
            with: "$1\(imgWidthScaled)$3",
            options: .regularExpression
        )
        result = result.replacingOccurrences(
            of: "(.*UX[0-9]*_CR0,[0-9]*,)([0-9]*)(.*)",
            with: "$1\(containerWidthScaled)$3",
            options: .regularExpression
        )
        result = result.replacingOccurrences(
            of: "(.*UX[0-9]*_CR0,[0-9]*,[0-9]*,)([0-9]*)(.*)",
            with: "$1\(containerHeightScaled)$3",
            options: .regularExpression
        )
        let finalURL = URL(string: result)
        return finalURL
    }
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    private func saveDataToCache(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
