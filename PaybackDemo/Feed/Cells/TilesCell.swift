//
//  TilesCell.swift
//  PaybackDemo
//
//

import UIKit
import AVKit

class TilesCell: UITableViewCell {
    static let identifier = "TilesCell"

    private lazy var contentStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.spacing = 5
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    lazy var headlineLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    lazy var sublineLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.numberOfLines = 0
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    lazy var contentImageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.layer.cornerRadius = 3
        i.heightAnchor.constraint(equalToConstant: 200).isActive = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()

    lazy var playImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "play")
        i.heightAnchor.constraint(equalToConstant: 30).isActive = true
        i.widthAnchor.constraint(equalTo: i.heightAnchor).isActive = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()

    func configureViews() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = PaybackColors.Background.tertiary
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        contentStackView.addArrangedSubview(headlineLabel)
        contentStackView.addArrangedSubview(contentImageView)
        contentStackView.addArrangedSubview(sublineLabel)
        contentImageView.addSubview(playImageView)

        let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentStackView.fillIn(container: self.contentView, withInsets: edgeInsets)
        
        playImageView.isHidden = true
        NSLayoutConstraint.activate([
            sublineLabel.heightAnchor.constraint(equalTo: headlineLabel.heightAnchor),
            playImageView.centerXAnchor.constraint(equalTo: contentImageView.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: contentImageView.centerYAnchor)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        headlineLabel.text = nil
        sublineLabel.text = nil
        contentImageView.image = nil
        playImageView.isHidden = true
        headlineLabel.textColor = PaybackColors.Text.primary
    }
}
