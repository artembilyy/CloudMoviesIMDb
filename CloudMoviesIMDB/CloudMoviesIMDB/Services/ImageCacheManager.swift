//
//  ImageCacheManager.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

protocol ImageCacheProtocol {
    subscript(key: String) -> UIImage? { get set }
    func clearCache()
}

final class ImageCacheManager: ImageCacheProtocol {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    // MARK: - Methods
    subscript(key: String) -> UIImage? {
        get {
            return cache.object(forKey: key as NSString)
        }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: key as NSString)
            } else {
                cache.removeObject(forKey: key as NSString)
            }
        }
    }
    func clearCache() {
        cache.removeAllObjects()
    }
}
