//
//  UIViewController+Additions.swift
//  PaybackDemo
//
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSafariViewController(urlToOpen: URL, completion: (() -> Void)? = nil) {
        let safariViewController = PaybackSafariViewController(url: urlToOpen)
        safariViewController.preferredControlTintColor = .white
        safariViewController.preferredBarTintColor = PaybackColors.Background.primary
        self.present(safariViewController, animated: true, completion: completion)
    }
}

final class PaybackSafariViewController: SFSafariViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
