//
//  ImageCacheManager.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

final class ImageCacheManager {
    // MARK: - Singleton
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    /// lock
    private init() { }
    // MARK: - Methods
    func saveImageToCache(image: UIImage, _ key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    func getImageFromCache(_ key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    func clearCache() {
        cache.removeAllObjects()
    }
}
