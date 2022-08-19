//
//  FeedModel.swift
//  PaybackDemo
//
//

import Foundation

struct FeedModel: Codable {
    let tiles: [TileModel]

    enum CodingKeys: String, CodingKey {
        case tiles
    }
}

struct FeedAPIModel: Codable {
    let feedModel: FeedModel
    let feedExpiryDate: Date
}
