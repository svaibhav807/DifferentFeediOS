//
//  ShoppingCart.swift
//  PaybackDemo
//
//

import Foundation

final class ShoppingCart {
    // MARK: - Singleton
    static let current = ShoppingCart()
    let shoppingCartKey = "ShoppingCart"

    // MARK: - Init
    private init() {}

    // MARK: Vars
    let userDefaults = UserDefaults.standard

    var shoppingCartSet: LIFOSet<ShoppingCartModel> {
        get {
            return _shoppingCartSet
        }
        set {
            _shoppingCartSet = newValue
        }
    }

    private lazy var _shoppingCartSet: LIFOSet<ShoppingCartModel> = {
        let dataType = UserData<ShoppingCartModel>.self
        guard let data = userDefaults.data(forKey: shoppingCartKey),
              let existingData = try? JSONDecoder().decode(dataType, from: data) else {
            return LIFOSet<ShoppingCartModel>()
        }
        return existingData.value
    }()
}

extension ShoppingCart {
    func allShopingCartItems() -> [ShoppingCartModel] {
        return shoppingCartSet.content
    }

    /// impose limit of 100 items
    private func popLastIfNeeded() {
        if allShopingCartItems().count >= 100 {
            shoppingCartSet.popLast()
        }
    }

    func addToShoppingCart(_ item: ShoppingCartModel) {
        popLastIfNeeded()
        shoppingCartSet.push(item)
        saveShoppingCart()
    }

    func removeAllShoppingCartItems() {
        shoppingCartSet.clear()
        saveShoppingCart()
    }

    func removeFromShoppingCart(_ item: ShoppingCartModel) {
        shoppingCartSet.pop(item)
        saveShoppingCart()
    }

    private func saveShoppingCart() {
        let userData = UserData(key: "v0", value: shoppingCartSet)
        do {
            userDefaults.setValue(try JSONEncoder().encode(userData), forKey: shoppingCartKey)
            userDefaults.synchronize()
        } catch(let exception) {
            print("ShoppingCart saving exception " + "\(exception)")
        }
    }
}
