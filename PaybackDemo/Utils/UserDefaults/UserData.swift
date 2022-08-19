//
//  UserData.swift
//  PaybackDemo
//
//

import Foundation

struct UserData<T: Equatable & Codable> : Codable {
    let key: String
    let value: LIFOSet<T>

    enum CodingKeys: String, CodingKey {
        case key = "version"
        case value = "items"
    }

    init(key: String, value: LIFOSet<T>) {
        self.key = key
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        key = try container.decode(String.self, forKey: CodingKeys.key)
        let items = try container.decode([T].self, forKey: CodingKeys.value)
        value = LIFOSet<T>.init(from: items)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: CodingKeys.key)
        try container.encode(value.content, forKey: CodingKeys.value)
    }
}
