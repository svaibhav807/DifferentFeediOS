//
//  ShoppingListCell.swift
//  PaybackDemo
//
//

import UIKit

class ShoppingListCell: UITableViewCell {
    static let identifier = "ShoppingListCell"

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var sublineLabel: UILabel!
    @IBOutlet weak var shoppingItemTextField: UITextField!
    @IBOutlet weak var shoppingItemsTableView: UITableView!

    private func configureViews() {
        self.layer.cornerRadius = 5
        self.backgroundColor = PaybackColors.Background.tertiary
        self.layer.masksToBounds = true

        shoppingItemTextField.layer.cornerRadius = 8
        shoppingItemTextField.backgroundColor = PaybackColors.Background.secondary

        shoppingItemsTableView.layer.cornerRadius = 8
        shoppingItemsTableView.layer.masksToBounds = true
        shoppingItemsTableView.backgroundColor = PaybackColors.Background.quaternary
        shoppingItemsTableView.register(UINib(nibName: "ShoppingListItemCell", bundle: nil),
                                        forCellReuseIdentifier: ShoppingListItemCell.identifier)
        shoppingItemsTableView.estimatedRowHeight = 200
        shoppingItemsTableView.rowHeight = UITableView.automaticDimension
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
}

extension ShoppingListCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        shoppingItemTextField.resignFirstResponder()
    }

    @IBAction func textFieldDidEndEditing(_ sender: Any) {
        guard let text = shoppingItemTextField.text, !text.isEmptyOrWhitespace() else {
            return
        }
        ShoppingCart.current.addToShoppingCart(ShoppingCartModel(text: text))
        shoppingItemTextField.text = nil
        shoppingItemTextField.placeholder = "Add another item"
        shoppingItemsTableView.reloadData()
    }
}
