//
//  ShoppingListItemCell.swift
//  PaybackDemo
//
//

import UIKit

class ShoppingListItemCell: UITableViewCell {
    static let identifier = "ShoppingListItemCell"

    @IBOutlet weak var shoppingListItem: UILabel!

    override func awakeFromNib() {
        self.backgroundColor = PaybackColors.Background.quaternary
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        shoppingListItem.text = nil
    }

    func configure(text: String) {
        shoppingListItem.text = text
    }
}
