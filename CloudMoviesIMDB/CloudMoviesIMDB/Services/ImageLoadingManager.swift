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
    ///
    private var image: UIImage?
    private var imageUrlString: String = ""
    /// Prevent reusable
    @MainActor
    func getImage(from url: String) async throws -> UIImage? {
        imageUrlString = url
        guard let resizedImageURL = getURL(resizeFactor: 2, url: url) else {
            throw NetworkError.invalidURL
        }
        if let cachedImage = ImageCacheManager.shared.getImageFromCache(resizedImageURL.absoluteString) {
            self.image = cachedImage
            return image
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: resizedImageURL)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            guard let compressedData = image.jpegData(compressionQuality: 0.7) else {
                throw NetworkError.invalidURL
            }
            guard let compressedImage = UIImage(data: compressedData) else {
                throw NetworkError.noImage
            }
            ImageCacheManager.shared.saveImageToCache(image: compressedImage, resizedImageURL.absoluteString)
            self.image = compressedImage
            return compressedImage
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    @MainActor
    func getSearchImage(from url: URL) async throws -> UIImage? {
        imageUrlString = Endpoints.resizeImage + Endpoints.apiKey + Endpoints.size + Endpoints.url + url.absoluteString
        guard let finalURL = URL(string: imageUrlString) else {
            throw NetworkError.invalidURL
        }
        if let cachedImage = ImageCacheManager.shared.getImageFromCache(finalURL.absoluteString) {
            self.image = cachedImage
            return image
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: finalURL)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            ImageCacheManager.shared.saveImageToCache(image: image, finalURL.absoluteString)
            self.image = image
            return image
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    // MARK: Method for get URL with scaled image
    /// Missed scaling by Request Resizing Image by api IMDb on this request
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
}
