//
//  ShoppingCartModel.swift
//  PaybackDemo
//
//

import Foundation

struct ShoppingCartModel: Codable, Equatable {
    let text: String

    static func == (lhs: ShoppingCartModel, rhs: ShoppingCartModel) -> Bool {
        return (lhs.text == rhs.text)
    }
}
