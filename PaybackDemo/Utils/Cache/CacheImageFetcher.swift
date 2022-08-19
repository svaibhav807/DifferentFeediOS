//
//  CacheImageFetcher.swift
//  PaybackDemo
//
//

import Foundation
import UIKit

final class CacheImageFetcher {
    static var cache = LRUCache<String>(100)

    static func fetchImages(url: String) -> UIImage? {
        if let image = cache.get(url) as? UIImage {
            return image
        }
        return nil
    }
}
