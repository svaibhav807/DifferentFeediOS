//
//  UIView+extensions.swift
//  PaybackDemo
//
//

import Foundation
import UIKit

extension UIView {
    func fillIn(container: UIView, withInsets insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: insets.left)
        ])
    }

    func fillInSafeArea(of container: UIView, with insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        let safeAreaGuide = container.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -insets.right),
            self.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
