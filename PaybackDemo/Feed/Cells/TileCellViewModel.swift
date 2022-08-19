//
//  TileCellViewModel.swift
//  PaybackDemo
//
//

import Foundation
import Kingfisher
import AVKit

final class TileCellViewModel {
    let item: TileModel
    private let headline: String?
    private let subline: String?
    private let data: String?
    private let type: TileType

    init(item: TileModel) {
        self.item = item
        self.headline = item.headline
        self.subline = item.subline
        self.data = item.data
        self.type = item.type
    }

    func configure(cell: TilesCell) {
        addHeadline(cell: cell)
        addSubline(cell: cell)
        if case .image = type {
            guard let data = data else {
                cell.contentImageView.isHidden = true
                return
            }
            let url = URL(string: data)
            cell.contentImageView.kf.setImage(with: url,
                                              placeholder: UIImage(named: "placeholder"),
                                              options: nil, progressBlock: nil,
                                              completionHandler: nil)
            cell.contentImageView.isHidden = false
        } else {
            cell.contentImageView.isHidden = true
        }
        if case .video = type {
            cell.contentImageView.isHidden = false
            cell.playImageView.isHidden = false
            guard let data = data else { return }
            cell.contentImageView.isHidden = false
            cell.contentImageView.image = UIImage(named: "placeholder")
            setImageForVideo(data: data, cell: cell)
        }
    }

    func setImageForVideo(data: String, cell: TilesCell) {
        DispatchQueue.global().async {
            if let cacheImage = CacheImageFetcher.fetchImages(url: data) {
                DispatchQueue.main.async(execute: {
                    cell.contentImageView.image = cacheImage
                    return
                })
            }
            guard let url = URL(string: data) else {
                return
            }

            let asset = AVAsset(url: url)
            let assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 1, timescale: 2)
            let image = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if let image = image {
                let frameImage  = UIImage(cgImage: image)
                DispatchQueue.main.async(execute: {
                    CacheImageFetcher.cache.set(data, val: frameImage)
                    cell.contentImageView.image = frameImage
                })
            }
        }
    }

    private func addHeadline(cell: TilesCell) {
        if let headline = headline {
            if type == .website { cell.headlineLabel.textColor = PaybackColors.Text.link }
            cell.headlineLabel.text = headline
            cell.headlineLabel.isHidden = false
        } else {
            cell.headlineLabel.isHidden = true
        }
    }

    private func addSubline(cell: TilesCell) {
        if let subline = subline {
            cell.sublineLabel.text = subline
            cell.sublineLabel.isHidden = false
        } else {
            cell.sublineLabel.isHidden = true
        }
    }
}
