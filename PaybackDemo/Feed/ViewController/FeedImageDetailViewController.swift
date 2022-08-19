//
//  FeedImageDetailViewController.swift
//  PaybackDemo
//
//

import UIKit

class FeedImageDetailViewController: UIViewController {
    private lazy var contentStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.spacing = 5
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var headlineLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true

        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var sublineLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var contentImageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return i
    }()

    private var viewModel: FeedImageDetailViewModel

    init(viewModel: FeedImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedImageDetailViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = PaybackColors.Background.primary
        contentStackView.addArrangedSubview(headlineLabel)
        contentStackView.addArrangedSubview(contentImageView)
        contentStackView.addArrangedSubview(sublineLabel)
        contentStackView.fillInSafeArea(of: self.view)
        addHeadline()
        addSubline()
        addImage()
    }

    private func addImage() {
        guard let data = viewModel.data else {
            contentImageView.isHidden = true
            return
        }
        let url = URL(string: data)
        contentImageView.kf.setImage(with: url,
                                     placeholder: UIImage(named: "placeholder"),
                                     options: nil, progressBlock: nil,
                                     completionHandler: nil)
        contentImageView.isHidden = false
    }

    private func addHeadline() {
        if let headline = viewModel.headline {
            headlineLabel.text = headline
            headlineLabel.isHidden = false
        } else {
            headlineLabel.isHidden = true
        }
    }

    private func addSubline() {
        if let subline = viewModel.subline {
            sublineLabel.text = subline
            sublineLabel.isHidden = false
        } else {
            sublineLabel.isHidden = true
        }
    }
}
