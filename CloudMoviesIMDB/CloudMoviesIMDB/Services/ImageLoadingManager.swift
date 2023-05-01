//
//  ImageLoadingManager.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//
import UIKit

protocol ImageLoadingManagerProtocol {
    func getImage(from source: String) async throws -> UIImage
}

final class ImageLoadingManager: ImageLoadingManagerProtocol {
    /// Prevent reusable
    private var image: UIImage?
    private var imageUrlString: String = ""
    var cache: ImageCacheProtocol
    // MARK: - Init
    init(cache: ImageCacheProtocol) {
        self.cache = ImageCacheManager.shared
    }
    func getImage(from source: String) async throws -> UIImage {
        imageUrlString = source
        let endpoint = MoviesEndpoint.resizeImage
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: Constants.apiKey),
            URLQueryItem(name: "size", value: "256x352"),
            URLQueryItem(name: "url", value: source) // check it
        ]
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        if let image = ImageCacheManager.shared[imageUrlString] {
            self.image = image
            return image
        }

        let request = URLRequest(url: url)
        if let cachedImage = cache[source] {
            return cachedImage
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            setImage(image, forKey: imageUrlString, compressionQuality: 0.7)
            return image
        } catch {
            throw error
        }
    }
    private func setImage(_ image: UIImage, forKey key: String, compressionQuality: CGFloat = 0.5) {
        guard let compressedImageData = image.jpegData(compressionQuality: compressionQuality) else {
            return
        }
        cache[key] = UIImage(data: compressedImageData)
    }
}
