//
//  FeedViewModel.swift
//  PaybackDemo
//
//

import UIKit
import AVFoundation

final class FeedViewModel: NSObject {
    weak var delegate: FeedViewModelDelegate?
    var feedModel: FeedModel?

    private let networkClient: FeedAPIClient

    private var cellViewModels: [CellViewModel] = []
    private var tableView: UITableView?
    private var numberOfItems: Int {
        return  cellViewModels.count
    }

    override init() {
        networkClient = FeedAPIClient()
        super.init()
    }

    func cellViewModel(at index: Int) -> CellViewModel? {
        guard cellViewModels.indices.contains(index) else {
            return nil
        }
        return cellViewModels[index]
    }
}

// MARK: UITableView
extension FeedViewModel {
    func configure(with tableView: UITableView) {
        tableView.register(UINib(nibName: "TilesCell", bundle: nil), forCellReuseIdentifier: TilesCell.identifier)
        tableView.register(UINib(nibName: "ShoppingListCell", bundle: nil), forCellReuseIdentifier: ShoppingListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView = tableView
        fetchTiles()
    }
}

// MARK: Networking
extension FeedViewModel {
    func fetchTiles(showLoadingIndicator: Bool = true) {
        if showLoadingIndicator {
            delegate?.showLoadingIndicator()
        }
        networkClient.fetchFeed { [weak self] result in
            if showLoadingIndicator {
                self?.delegate?.removeLoadingIndicator()
            }
            switch result {
            case.failure(let error):
                self?.cellViewModels = []
                self?.delegate?.reloadTableView()
                self?.delegate?.showErrorView(with: error)
                return
            case .success(let data):
                self?.feedModel = data
                let items = data.tiles.sorted { $0.score > $1.score }
                self?.cellViewModels = []

                for item in items {
                    if item.type == .shoppingList {
                        let cvm = ShoppingListCellViewModel(item: item)
                        self?.cellViewModels.append(.shoppingCell(cvm))
                    } else {
                        let cvm = TileCellViewModel(item: item)
                        self?.cellViewModels.append(.tileCell(cvm))
                    }
                }
                self?.delegate?.reloadTableView()
            }
        }
    }

    func handlePullToRefresh() {
        feedModel = nil
        fetchTiles(showLoadingIndicator: false)
    }
}

// MARK: UITableViewDataSource, UITableViewDataSource
extension FeedViewModel: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfItems
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = cellViewModel(at: indexPath.section) else {
            fatalError("Unknown index passed")
        }

        switch cellViewModel {
        case .tileCell(let tileCellViewModel):
            delegate?.textFieldShouldReturn()
            let cell = tableView.dequeueReusableCell(withIdentifier: "TilesCell", for: indexPath) as! TilesCell
            tileCellViewModel.configure(cell: cell)
            return cell
        case .shoppingCell(let shoppingListCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as! ShoppingListCell
            cell.shoppingItemTextField.delegate = self
            shoppingListCellViewModel.configure(cell: cell)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cellViewModel = cellViewModel(at: indexPath.section) else {
            fatalError("Unknown index passed")
        }

        switch cellViewModel {
        case .tileCell(let tileCellViewModel):
            if case .website = tileCellViewModel.item.type {
                guard let data = tileCellViewModel.item.data, let tempURL = URL(string: data) else {
                    return
                }
                delegate?.presentWebView(urlToOpen: tempURL)
            }
            if case .video = tileCellViewModel.item.type {
                if let data = tileCellViewModel.item.data, let url = URL(string: data) {
                        delegate?.playVideo(url: url)
                } else {
                    showVideoPlaybackAlert()
                }
            }
            if case .image = tileCellViewModel.item.type {
                let vm = FeedImageDetailViewModel(item: tileCellViewModel.item)
                let vc = FeedImageDetailViewController(viewModel: vm)
                delegate?.pushViewController(vc, animated: true)
            }
        case .shoppingCell(_):
            return
        }
    }
}

// MARK: UITextFieldDelegate
extension FeedViewModel: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView?.reloadData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn()
        return false
    }
}

// MARK: VideoPlaybackError
extension FeedViewModel {
    private func showVideoPlaybackAlert() {
        let title = "Uh oh!"
        let message = "Sorry something went wrong, please try again"
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(cancelAction)
        delegate?.presentViewController(alertVC, animated: true)
    }
}
