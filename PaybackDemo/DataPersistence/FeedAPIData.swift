//
//  FeedAPIData.swift
//  PaybackDemo
//
//

import Foundation

final class FeedAPIData {
    static let feedAPIData = "feedAPIData"
    static let userDefaults = UserDefaults.standard

    static func localFeedAPIData() -> FeedModel? {
        let dataType = FeedAPIModel.self
        guard let data = userDefaults.data(forKey: feedAPIData),
              let existingData = try? JSONDecoder().decode(dataType, from: data),
              isFeedAPIDataValid(data: existingData) else {
            return nil
        }
        return existingData.feedModel
    }

    private static func isFeedAPIDataValid(data: FeedAPIModel) -> Bool {
        return data.feedExpiryDate > Date.now
    }

    static func saveLocalFeedAPIData(feedData: FeedModel) {
        let feedAPIModel = FeedAPIModel(feedModel: feedData,
                                        feedExpiryDate: Date.now.addingTimeInterval(TimeInterval(Constants.feedExpiryDuration)))
        do {
            userDefaults.setValue(try JSONEncoder().encode(feedAPIModel), forKey: feedAPIData)
            userDefaults.synchronize()
        } catch(let exception) {
            print("ShoppingCart saving exception " + "\(exception)")
        }
    }
}
