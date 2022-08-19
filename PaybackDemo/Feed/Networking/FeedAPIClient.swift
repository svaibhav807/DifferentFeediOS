//
//  FeedAPIClient.swift
//  PaybackDemo
//
//

import Foundation
import Alamofire

class FeedAPIClient {
    func fetchFeed(completion: @escaping (Result<FeedModel, APIError>) -> Void) {
        if let data = FeedAPIData.localFeedAPIData() {
            completion(.success(data))
            return
        }

        let URL = Constants.FeedAPI
        let request = AF.request(URL)
        request.responseDecodable(of: FeedModel.self) { (response) in
            if let error = response.error {
                switch error {
                case .createURLRequestFailed(_), .sessionTaskFailed(_):
                    completion(.failure(.requestFailed))
                case .invalidURL(_), .responseValidationFailed(_):
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.requestFailed))
                }
                return
            }
            guard let items = response.value else { return }
            if items.tiles.isEmpty {
                completion(.failure(.noData))
                return
            }
            FeedAPIData.saveLocalFeedAPIData(feedData: items)
            completion(.success(items))
        }
    }
}
