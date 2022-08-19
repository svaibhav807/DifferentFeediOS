//
//  TileModel.swift
//  PaybackDemo
//
//

import Foundation

struct TileModel: Codable {
    let type: TileType
    let headline: String?
    let subline: String?
    let data: String?
    let score: Int

    enum CodingKeys: String, CodingKey {
        case type = "name"
        case headline
        case subline
        case data
        case score
    }
}

enum TileType: String, Codable {
    case image
    case video
    case website
    case shoppingList = "shopping_list"
}

