//
//  FeedViewModelDelegate.swift
//  PaybackDemo
//
//

import UIKit

protocol FeedViewModelDelegate: AnyObject {
    func showLoadingIndicator()
    func removeLoadingIndicator()
    func showErrorView(with error: APIError)
    func removeErrorView()
    func presentWebView(urlToOpen: URL)
    func textFieldShouldReturn()
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func presentViewController(_ viewController: UIViewController, animated: Bool)
    func reloadTableView()
    func playVideo(url: URL)
}
