//
//  ShoppingListCellViewModel.swift
//  PaybackDemo
//
//

import UIKit

final class ShoppingListCellViewModel: NSObject {
    let item: TileModel
    private let headline: String?
    private let subline: String?
    private let type: TileType
    private var shoppingCartData: [ShoppingCartModel] = []

    init(item: TileModel) {
        self.item = item
        self.headline = item.headline
        self.subline = item.subline
        self.type = item.type
    }

    private func numberOfItems() -> Int {
        shoppingCartData = ShoppingCart.current.allShopingCartItems()
        return shoppingCartData.count
    }

    func configure(cell: ShoppingListCell) {
        addHeadline(cell: cell)
        addSubline(cell: cell)

        // configure table view
        cell.shoppingItemsTableView.dataSource = self
        cell.shoppingItemsTableView.delegate = self
        cell.shoppingItemsTableView.reloadData()
    }

    private func addHeadline(cell: ShoppingListCell) {
        if let headline = headline {
            cell.headlineLabel.text = headline
            cell.headlineLabel.isHidden = false
        } else {
            cell.headlineLabel.isHidden = true
        }
    }

    private func addSubline(cell: ShoppingListCell) {
        if let subline = subline {
            cell.sublineLabel.text = subline
            cell.sublineLabel.isHidden = false
        } else {
            cell.sublineLabel.isHidden = true
        }
    }
}

// MARK: UITableViewDataSource
extension ShoppingListCellViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if numberOfItems() == 0 {
           return "Your shopping List is empty."
        } else {
           return ""
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListItemCell", for: indexPath) as! ShoppingListItemCell
        cell.configure(text: shoppingCartData[indexPath.row].text)
        return cell
    }
}

// MARK: UITableViewDelegate
extension ShoppingListCellViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            let itemText = shoppingCartData[indexPath.row].text
            shoppingCartData.remove(at: indexPath.row)
            ShoppingCart.current.removeFromShoppingCart(ShoppingCartModel(text: itemText))
            tableView.endUpdates()
        }
    }
}
