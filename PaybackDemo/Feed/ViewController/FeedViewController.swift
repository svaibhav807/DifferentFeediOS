//
//  FeedViewController.swift
//  PaybackDemo
//
//

import UIKit
import AVKit

class FeedViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var feedTableView: UITableView!

    private let refreshControl = UIRefreshControl()

    private var errorView: ErrorView?
    private var viewModel: FeedViewModel
    private var playerViewController: AVPlayerViewController
    private var playerView: AVPlayer

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let l = UIActivityIndicatorView(style: .medium)
        return l
    }()

    init() {
        self.viewModel = FeedViewModel()
        playerViewController = AVPlayerViewController()
        playerView = AVPlayer()
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = FeedViewModel()
        playerViewController = AVPlayerViewController()
        playerView = AVPlayer()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Payback Feed"
        let edgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        feedTableView.fillInSafeArea(of: view, with: edgeInsets)
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.backgroundColor = PaybackColors.Background.primary
        self.view.backgroundColor = PaybackColors.Background.primary
        refreshControl.tintColor = .label
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        feedTableView.addSubview(refreshControl)
        viewModel.delegate = self
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
        viewModel.configure(with: feedTableView)
    }
}

// MARK: FeedViewModelDelegate
extension FeedViewController: FeedViewModelDelegate {
    func reloadTableView() {
        feedTableView.reloadData()
        refreshControl.endRefreshing()
    }

    func showLoadingIndicator() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.fillIn(container: self.view)
    }

    func removeLoadingIndicator() {
        activityIndicatorView.removeFromSuperview()
    }

    func showErrorView(with error: APIError) {
        hideContent()
        if errorView == nil {
            let e = ErrorView()
            e.setErrorMessage(error: error)
            e.retryButton.addTarget(self, action: #selector(errorViewRetryPressed(_:)), for: .touchUpInside)
            errorView = e
        }
        errorView?.fillInSafeArea(of: self.view)
    }

    func removeErrorView() {
        errorView?.removeFromSuperview()
    }

    func presentWebView(urlToOpen: URL) {
        presentSafariViewController(urlToOpen: urlToOpen)
    }

    func textFieldShouldReturn() {
        self.view.endEditing(true)
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func presentViewController(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated)
    }

    func playVideo(url: URL) {
        playerView = AVPlayer(url: url)
        playerViewController.player = playerView
        present(playerViewController, animated: true)
        playerViewController.player?.play()
    }
}

// Mark: CTAs and Related functions
extension FeedViewController {
    @objc
    func errorViewRetryPressed(_ sender: UIButton) {
        showContent()
        removeErrorView()
        viewModel.fetchTiles(showLoadingIndicator: true)
    }

    @objc
    func handlePullToRefresh() {
        viewModel.handlePullToRefresh()
    }

    private func showContent() {
        feedTableView.isHidden = false
    }

    private func hideContent() {
        feedTableView.isHidden = true
    }
}
