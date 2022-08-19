//
//  ImageDetailViewModel.swift
//  PaybackDemo
//
//

import Foundation

final class FeedImageDetailViewModel {
    let item: TileModel
    let headline: String?
    let subline: String?
    let data: String?
    private let type: TileType

    init(item: TileModel) {
        self.item = item
        self.headline = item.headline
        self.subline = item.subline
        self.data = item.data
        self.type = item.type
    }
}
